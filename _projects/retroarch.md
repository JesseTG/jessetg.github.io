---
title: RetroArch
tagline: "Your retro games, your way."
number: 1
header:
  teaser: assets/image/retroarch.png
  overlay_image: assets/image/retroarch-header.jpg
  actions:
    - label: "Official Website"
      url: "https://www.retroarch.com"
    - label: "My Contributions"
      url: "https://github.com/libretro/RetroArch/pulls?q=is%3Apr+author%3AJesseTG+"
---

RetroArch is a frontend for retro game emulators,
unifying the experience across platforms and providing features beyond what the original emulators offer.
I've provided numerous contributions to RetroArch, including:

- Microphone support.
  I designed an API that RetroArch-compatible emulators can use
  to forward the host system's microphone to the emulated system.
  Other libretro frontends have added support for this API as well.
  I implemented microphone drivers for ALSA (Linux), WASAPI (Windows), and SDL2 (everything else).
- Power status support for the libretro API.
  Although RetroArch itself already supports querying and displaying the device's battery level,
  I exposed it to cores for the benefit of emulators that employ that little bit of extra finesse.
- Documentation for the libretro API,
  which RetroArch and compatible emulators use to communicate with each other.
- Support for the XDelta patch format,
  which is commonly used by the ROM hacking community
  to distribute translations and mods for retro games.
- GitHub Actions workflows for MSVC-powered Windows and 32-bit Linux builds,
  to reduce the risk of regressions.