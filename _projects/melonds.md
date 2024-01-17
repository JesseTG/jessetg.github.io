---
title: melonDS
tagline: "\"DS emulator, sorta\""
number: 100
header:
  teaser: assets/image/melonds.png
  overlay_image: assets/image/melonds-header.jpg
  actions:
    - label: "Official Website"
      url: "https://melonds.kuribo64.net"
    - label: "My Contributions"
      url: "https://github.com/melonDS-emu/melonDS/pulls?q=is%3Apr+author%3AJesseTG+"
---

melonDS is a Nintendo DS emulator.
I've contributed dozens of bugfixes and refactorings, including:

- Refactored the entire emulator to be object-oriented,
  laying the groundwork for running multiple instances in a single process
  (a prerequisite for emulating the DS's local multiplayer features over the Internet).
- Refactored serialization code to work in-memory,
  rather than directly writing to disk.
  Not only is this required for emulating local wireless over netplay,
  but it enables various features when used in RetroArch.