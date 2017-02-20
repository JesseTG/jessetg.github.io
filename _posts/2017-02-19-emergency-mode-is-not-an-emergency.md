---
title: "Emergency Mode is Not an Emergency"
tags: [technology, linux, error]
---

I can't seem to find anyone else who's had this problem and known how to deal with it, so I'll share my experience.

**TLDR:** If you dual-boot Linux and Windows, make sure that you *cleanly power off or reboot one* (i.e. not hibernate, forced shutdown, etc.) before logging into the other.

At the time I first ran into this problem, I primarily used a laptop that dual-boots Windows 8.1 and Kubuntu 15.10.  I re-partitioned it when upgrading, as I decided it would be a good idea to have a common partition to share data between the two OSes (code, music, schoolwork, etc.).  I wanted my common partition to be as easy to access as possible, which means no strange drivers or other software hackery.  I used NTFS.  So far, that's actually been working out beautifully; I'm not even getting the strange permission problems that people on various IRC channels warned me about (minus some stuff with Git repos I was easily able to fix with `git config --global core.filemode false`).

However, I'd simultaneously run into a perceived problem that inspired me to splurge about $330 on a solid-state drive I didn't really need.  I [posted about it](http://unix.stackexchange.com/questions/256371/cant-boot-into-my-linux-partition-disk-is-supposedly-at-fault-but-scans-show) on Unix Stack Exchange, to no avail.  Basically, I received an error when booting into Linux that looked something like this:

```
Welcome to emergency mode! After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or ^D to
try again to boot into default mode.
root@jtg-kubuntu:~#
```

"Fuck, not again," I had uttered.  Literally a year prior I had *just* bought a new hard drive because of a similar issue (though at the time there actually *was* a problem); I couldn't log into my Linux partition, but Windows seemed to work just fine.  In a panic, I went and bought a new solid-state drive, and backed up all of my data onto a spare external HDD I had lying around.

And it turned out the damned thing wasn't even broken in the first place.  The thing is that, *out of the box, Windows 8 and 8.1 don't "shut down"*; they really just do a form of hibernation that allows for the quick boot times.  You can turn this feature off, though I don't remember how off-hand.  At any rate, during the "shutdown" process Windows stores some information on the common partition, and removes it when booting up.  As far as I can tell Linux won't boot if this information is present.  It won't tell you that, however.

Man, I could have bought a Wii U for the money I spent on this drive.

I have no idea what I'm doing, even when it looks like I do.
