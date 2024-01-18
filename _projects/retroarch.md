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
I've contributed various features and bugfixes, such as:

- [Microphone support](https://github.com/libretro/RetroArch/pull/14731).
  I designed an API that RetroArch-compatible emulators can use
  to forward the host system's microphone to the emulated system.
  Other libretro frontends have added support for this API as well.
  I implemented microphone drivers for ALSA (Linux), WASAPI (Windows), and SDL2 (everything else).
- [Power status API support](https://github.com/libretro/RetroArch/pull/15387).
  Although RetroArch itself had support for querying and displaying the device's battery level,
  I exposed it to cores.
- [Extensive documentation](https://github.com/libretro/RetroArch/pull/15641)
  for the API that sits between frontends and cores.
- [XDelta softpatching support](https://github.com/libretro/RetroArch/pull/15915).
  This format is commonly used by the ROM hacking community
  to distribute translations and mods for retro games.
- GitHub Actions workflows
  for [MSVC-powered Windows](https://github.com/libretro/RetroArch/pull/15393)
  and [32-bit Linux builds](https://github.com/libretro/RetroArch/pull/15980),
  to reduce the risk of regressions.