---
title: "Introducing libretro.py"
tags: [projects, python, libretro]
redirect_from:
  - /libretropy
header:
  overlay_image: /assets/image/libretropy.webp
  show_overlay_excerpt: false
---

Lately I've been working on something that's incredibly useful within a niche that's dear to me.
Introducing [libretro.py][libretro.py], a Python-based automated testing framework for "libretro cores",
essentially ports of emulators or games wrapped in shared libraries.
(Think of it like a game engine, but for emulators.)
If you're a fan of retro gaming (especially via [RetroArch][retroarch]),
I'm sure you know the frustration of losing game data
or having a long-standing bug slip through the cracks again.
This little beauty will make those a thing of the past
by giving core developers everything they need
to catch these bugs before players do!

I was inspired to work on libretro.py
while porting [melonDS][melonDS] to libretro.
Specifically, I was debugging [firmware images being unexpectedly clobbered](https://github.com/JesseTG/melonds-ds/issues/59);
this in itself wasn't too bad to find and fix...
but the effects were subtle and not noticeable until it was too late.
Gut instinct kicked in and told me that this bug would be easy to reintroduce,
unless I made _damn sure_ that it would be caught early.

Rather than living in fear of each commit reintroducing some old or obscure bug,
I decided to write a test suite for melonDS to prevent this.
I had initially used and contributed to an existing framework called [emutest](https://github.com/kivutar/emutest),
but I soon discovered that it couldn't meet all of my needs.
Some APIs I wanted to test weren't supported,
and the Lua implementation emutest uses lacked several features I needed.

Then I decided "screw it, I'll do it myself."
And thus libretro.py was born!
Its biggest selling points are:

- **A simple, Pythonic API.**
Test cases need to be easy to read, write, and execute;
Python's terse syntax and enormous standard library enables that.
The whole framework is written in pure Python,
with no dependencies outside of the standard library
except for a few optional features. 
- **Comprehensive support for the libretro API.**
The libretro API exposes all sorts of services (graphics, input, file systems, configuration, etc.) to emulators.
However, test cases don't always need full implementations of system services;
if you can write a `yield` statement, you can simulate any scenario you'd like. Which leads me to... 
- **A flexible design.**
Most functionality in comes as ordinary duck-typed Python objects.
There are reasonable defaults for all APIs and many common use cases,
but there's nothing stopping you from writing a driver for your own custom needs.
You want to ensure your core falls back to software rendering if OpenGL isn't available? No problem. 

Here's an example of a test script that verifies a core's ability to save and load its state:

```python
import prelude
# Includes a bunch of helper methods specific to my test suite

with prelude.session() as session:
    # Load the libretro core and set it up with common parameters
    for i in range(30):
        session.run() # Run for 30 frames

    size = session.core.serialize_size()
    # Get the size of the buffer needed to save the state
    assert size > 0

    buffer = bytearray(size)
    state_saved = session.core.serialize(buffer)
    # Actually save the state in the given buffer

    assert state_saved
    assert any(buffer)
    # ...and make sure it's not all zeros

    for i in range(30):
        session.run() # Run for 30 more frames

    new_size = session.core.serialize_size() 
    assert new_size == size

    state_loaded = session.core.unserialize(buffer)
    # Load the state we saved 30 frames ago

    assert state_loaded

```

I haven't yet written documentation,
but you can find example usage in the [melonDS DS test suite][melondsds-tests].
The package itself has lots of type annotations, too.

If this is something you'd like to see me spend more time on,
consider [throwing a couple of bones my way](https://github.com/sponsors/JesseTG)
with GitHub Sponsors.
I'll notice, promise!

---

This post is adapted from [one I published on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7188506943487946752) in May 2024.

[libretro.py]: https://pypi.org/project/libretro.py
[melonDS]: https://melonds.kuribo64.net
[retroarch]: https://www.retroarch.com
[melondsds-tests]: https://github.com/JesseTG/melonds-ds/tree/main/test