---
title: "Neat, un-hacky tricks with Qt properties (1/2)"
tags: [projects, qt, tricks]
redirect_from:
  - /neat-qt-things
---

I've been working on [BALLS](https://github.com/JesseTG/BALLS) in my spare time this summer.  It's a shader editor designed with ease of use in mind.  I wanted to be able to support as many GLSL data types as I possibly can; yet to expose *every single type* to Qt's property system would have been extremely tedious and error-prone.  I'm not one to just grin and bear these sorts of things, however; I'm going to show you how I sidestepped this tedium.  *I'm using Qt 5.4; it may work with earlier versions, but I'm not sure.*

This is where I like C++; if you know how to wield it, you can do a *hell* of a lot of cool metaprogramming tricks.  Without macros!  (You can do cool stuff *with* macros, too, but let's not go there.)

For those of you who are just jumping in, Qt enables reflection by generating extra code via `qmake`, at least for any class derived from `QObject`.  The [full details can be found here](http://doc.qt.io/qt-5/properties.html#requirements-for-declaring-properties), but the most relevant bits to this discussion are right here;

{% highlight c++ %}
Q_PROPERTY(type name
           (READ getFunction [WRITE setFunction])
           [DESIGNABLE bool]
           )
{% endhighlight %}

You specify a type, a getter, and optionally a setter.  You can also declare whether or not the property should be exposed to the user in a manner that can be adjusted.

Here's the fun part.  Not only can you specify a `bool`ean variable, but you can even specify a member function!

    Q_PROPERTY(vec2 screenSize READ screenSize DESIGNABLE screenSizeVisible)

Where `shouldBeVisible` is a member function that returns whether or not the user should be able to see the `screenSize` on any hypothetical widget.

But I have lots of properties, and *all* of them are conditionally visible.  Does this mean I have to do this?

{% highlight c++ %}
class Uniforms : public QObject {
    Q_OBJECT

    Q_PROPERTY(vec2 screenSize READ screenSize DESIGNABLE screenSizeVisible)
    Q_PROPERTY(float elapsedTime READ elapsedTime DESIGNABLE elapsedTimeVisible)
    Q_PROPERTY(vec2 mouseCoords READ mouseCoords DESIGNABLE mouseCoordsVisible)
    // Believe me, there's more than 3 properties here

public /* designable queries */:
    bool screenSizeVisible() const;  // Definitions don't really matter right now
    bool elapsedTimeVisible() const;
    bool mouseCoordsVisible() const;
    // Don't forget, I have to implement all of these, too!

public /* property getters */:
    float elapsedTime() const;
    vec2 screenSize() const;
    vec2 mouseCoords() const;
};
{% endhighlight %}

**Nope.**  As it turns out, you can pass in parameters to the `DESIGNABLE` query, and the query will be called with said parameters.  Check this out.

{% highlight c++ %}
class Uniforms : public QObject {
    Q_OBJECT

    Q_PROPERTY(vec2 screenSize READ screenSize DESIGNABLE active("screenSize"))
    Q_PROPERTY(float elapsedTime READ elapsedTime DESIGNABLE active("elapsedTime"))
    Q_PROPERTY(vec2 mouseCoords READ mouseCoords DESIGNABLE active("mouseCoords"))
    // etc.

    bool active(const QString& name) const;
    // Determines if a property should be user-visible (it can vary at runtime).
    // Implementation doesn't matter, and is almost certainly specific to your program's needs.

public /* property getters */:
    // Omitted for brevity (they're unchanged, anyway)
};
{% endhighlight %}

**This is valid**, and **it's exactly as simple as it looks**.  No weird workarounds.  No macro or `qmake` or `moc` trickery.  Nothing.  The relevant `moc` output looks something like this:

{% highlight c++ %}
// etc.
if (_c == QMetaObject::QueryPropertyDesignable) {
    bool *_b = reinterpret_cast<bool*>(_a[0]);
    switch (_id) {
        case 0: *_b = active("screenSize"); break;
        case 1: *_b = active("elapsedTime"); break;
        case 2: *_b = active("mouseCoords"); break;
        // etc.
        default: break;
    }
}
// etc.
{% endhighlight %}

Why is this useful for me?  In BALLS, I provide a bunch of pre-cooked uniforms, ranging from things like the elapsed time to the window size to the model-view-projection matrix.  Some of these will be configurable, but all of these will be user facing...but only if they're actually being used in the currently-bound shader.  Why overload users with information that isn't relevant?

Next up, I'm going to show you how I did a similar thing, but with templates.