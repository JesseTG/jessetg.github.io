---
title: melonDS DS
tagline: "A remake of the libretro melonDS core that prioritizes standalone parity, reliability, and usability."
number: 150
redirect_from:
  - /projects/melondsds
header:
  overlay_image: /assets/image/blog/melondsds-header.avif
  teaser: /assets/image/blog/melondsds-header.avif
  actions:
  - label: "GitHub"
    url: "https://github.com/JesseTG/melonds-ds"
---

melonDS DS is a libretro port of the melonDS emulator.
It supports (nearly) all features of the standalone emulator,
while prioritizing user-friendliness.

Here are some of the highlights:

- It has lots of user-friendly error messages that guide players to a solution
  should they encounter an unrecoverable problem, like missing firmware.
- I contributed numerous features and bugfixes
  to RetroArch and the standalone emulator
  to ensure that melonDS DS would provide a great experience.
- The screen layout can be adjusted on the fly,
  without having to go through RetroArch's core options menu.
- It fully supports emulating the DS's Wi-fi connectivity,
  by way of a set of community servers.
  I stubbed out libslirp's dependencies to simplify the build process,
  and the code I wrote for this is used by another melonDS port!