---
title: "Range Sensor"
tags: [arduino, cse592]
---

Made another Arduino thing today, this time using a sonar rangefinder and an LED matrix.  It doesn't quite make for clever photography, but I still like it.

<iframe class="center-block" width="560" height="315" src="https://www.youtube-nocookie.com/embed/gJ0ZMuKOc-o?rel=0" frameborder="0" allowfullscreen></iframe>

The original assignment was to just use a simple set of resistors and LEDs, but I took it a step farther.  Thankfully I still didn't have to bother with computing voltages or resistances, because I believe the two parts I used are rated for 5V.

The first thing I did was set up the rangefinder, [for which there is a library that I used](https://github.com/Diaoul/arduino-Maxbotix).  I grabbed the reading from its analog voltage pin.  Unfortunately, that didn't save me from having to filter it.  The library I used does some filtering, but it isn't all that great.  So I used [this tool](http://www.schwietering.com/jayduino/filtuino/index.php?characteristic=bu&passmode=lp&order=2&alphalow=0.01&noteLow=&noteHigh=&pw=pw&calctype=float&run=Send) to generate one (not that I have any idea how it works or anything).

Next I broke out an LED matrix that I bought but never used.  The sensor readings run from right to left on the matrix, like a line graph.  I'm actually happy with how it came out; I basically used an array as a ring-buffer so that I didn't have to shift the data every iteration.  It flickers a lot, but I'm not sure there's much I can do about that since I'm looping once per millisecond.

If you want to see what I did, the Fritzing file is right [here](/files/sonar.fzz).  It's not useful in the slightest, but it's kinda fun.
