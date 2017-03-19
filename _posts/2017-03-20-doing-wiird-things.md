---
title: "Doing Wiird Things"
tags: [cse592, projects, wii, qt]
---

I don't think anyone circa 2006 could have imagined how popular the Wii would be among hobbyists; I mean, what does the Wii provide?  Buttons, accelerometer, infrared sensor, a speaker?  And that's ignoring things like the Nunchuck or the Balance Board.  I have a Wii and a lot of hardware lying around for it that I haven't touched in years; now's as good a time as any to dust it off.

First things I tried were Processing and Unity.  Surprisingly, there's *no* good out-of-the-box Wii Remote library for Processing.  You'd think that a Java-scented prototyping environment and Wii Remotes would be a match made in heaven, but I guess not.  There's this [Wrj4P5](http://wrj4p5.osdn.jp) thing, but its documentation is sparse, disjointed, and hard to understand.

I couldn't be bothered to fix it, so I tried [Unity-Wiimote](https://github.com/Flafla2/Unity-Wiimote).  Apparently it works fine on Windows and macOS, but it's not tested on Linux.  I wanted to experiment with Wii controllers, not with making hidapi talk to Unity, so I moved on.

Then I came upon [WiiC](https://github.com/grandelli/WiiC); it's actually pretty good!  It's a C++ wrapper around (a modified version of) wiiuse, which seems to be dead in its tracks.  I didn't have to resort to any tricks; I literally just compiled WiiC, installed it, and successfully connected my Wii Remote to its example programs.

This all leads up to a team project for a human computer interaction class I'm taking.  C++ in itself is not great for prototyping, but Qt and QML are.  So my next step was to start wrapping WiiC and its classes in `QObject`s.  You can see what my team and I are doing with that [here](https://github.com/JesseTG/Wiirdo) -- I call it Wiirdo ("weirdo").  It's very early, but it works and supports QML.

Here, check it out:

<img class="center-block" src="/images/blog/wiimote-unfiltered.gif" alt="Wii Remote demonstration with unfiltered input"/>

...Oh, right, I have to filter it now.  Come to think of it, Nintendo probably provided some API for that.