---
title: "Introducing melonDS DS"
tags: [projects, melonds, libretro]
redirect_from:
  - /libretropy
header:
  overlay_image: /assets/image/blog/melondsds-header.avif
  show_overlay_excerpt: false
---

<script type="module" src="https://cdn.jsdelivr.net/npm/@justinribeiro/lite-youtube@1.5.0/lite-youtube.js"></script>

It's been a long time coming 
but [RetroArch is now on the App Store][retroarch-appstore],
and one of my biggest contributions to it is included!

I recently posted about [a test framework I was working on for libretro cores]({% post_url 2024-07-22-libretropy %}).
This is the thing I was testing --
a port of a Nintendo DS emulator called [melonDS][melonds].[^1]

[^1]:
    The port itself is called "melonDS DS"
    because it's a remake of [an earlier melonDS port][melonds-libretro],
    and remakes on the DS often [added][sm64ds] ["DS"][biads] [to][dkrds] [the][mmbn5ds] [title][rrds].
    If I had remade the [DeSmuME core][desmume-libretro],
    I'd have called it DeSmuME DS.

Here are some ways melonDS DS improves upon the legacy core:

# Wi-fi

melonDS DS fully supports emulating legacy Wi-fi services!
By default, an open clone called [Kaeru WFC][kaeru] is configured in the settings,
so you can hop online immediately after installing.

{% include figure popup=true class="align-center"
    image_path="/assets/image/blog/melondsds-wfc.webp"
    alt="
        A screenshot of Mario Kart DS
        as it searches for other players
        on an emulated Nintendo Wi-fi server.
    "
    caption="Sorry, I don't mean to ragequit but right now I just want to take a screenshot..."
%}

# Screen Layouts

melonDS DS offers more options for arranging the two screens,
including the ability to rotate the display sideways
to accommodate games that were played in "book mode".

{% include figure popup=true class="align-center"
    image_path="/assets/image/blog/melondsds-sideways.webp"
    alt="
        Brain Age running in melonDS DS;
        the screens are rotated 90 degrees to the left,
        and a gap is configured.
    "
    caption="Welcome back, Dr. Kawashima!"
%}

I have plans to make this even more powerful without compromising usability; stay tuned!

# Better Error Messages

errors happen
its typically underrated

{% include figure popup=true class="align-center"
    image_path="/assets/image/blog/melondsds-errors.webp"
    alt="
        An error screen within melonDS DS,
        describing a missing BIOS image for DSi support as the cause of failure.
        Instructions for fixing this error are provided.
    "
    caption="The little melon dude wants to help."
%}

its helped people

# Streamlined DSi Support

It streamlines DSi support;
now instead of having to configure NAND images with the games you want to play,
just load it through RetroArch like any other.
A DSiWare game will be installed into the NAND for the duration of the session,
and uninstalled at the end.
Save data will be imported and exported at these points, too.


{% include figure popup=true class="align-center"
    image_path="/assets/image/blog/melondsds-dsi.webp"
    alt="A newly-installed game is shown on the DSi menu, portrayed as a gift-wrapped box."
    caption="What's inside? (Hint: you can't buy it anymore.)"
%}

# Easier to Update

It's architected in a way that's much easier to keep up to date.
Historically, most libretro cores are forks of their original emulator's codebase.
This makes it easier to get something running quickly,
but may complicate updates later
when merge conflicts start to crop up.
This was the case [when I tried to update the Dolphin core](https://github.com/libretro/dolphin/pull/296);
as it exists now, this work would've had to be done later again.

melonDS DS pulls in the original emulator as a dependency
via CMake's [`FetchContent`](https://cmake.org/cmake/help/latest/module/FetchContent.html) module.
The main advantage is that I can update to a newer revision at any time
just by changing [this line][melonds-fetch]. 
Since I don't fork or vendor melonDS,
most "growing pains" with updates are limited to API changes.
And I can still use a fork later on if necessary, heaven forbid.

[melonds-fetch]: https://github.com/JesseTG/melonds-ds/blob/6e48901ab9e54ff048a1bf6ea322372d7ae3ed29/cmake/FetchDependencies.cmake#L40

---

I even contributed some relevant features to RetroArch itself:

# Microphone Support

The biggest contribution I've made to RetroArch itself to date
has been a new API for microphone support.
I implemented it for the benefit of melonDS[^2],
but it can be used by any core that integrates support for it.

Check out this proof-of-concept I posted of mic support in action:

<lite-youtube videoid="t2EvaHfs6Vw"></lite-youtube>

[^2]:
    I hadn't even begun working on melonDS DS yet.
    This video was taken with a patched version
    of the legacy core.

# XDelta Softpatching

RetroArch supports applying patches to ROM images at runtime,
usually for things like game mods or fan translations.
Most such patches for DS games use the XDelta format,
which RetroArch didn't support...until I made it so!


{% include figure popup=true class="align-center"
    image_path="/assets/image/blog/melondsds-xdelta.webp"
    alt="A screenshot depicting the beginning of a melonDS DS session in RetroArch, playing Gyakuten Kenji 2. A notice in the corner states that a patch file in the XDelta format is being applied."
    caption="Oh boy, I can't wait to play Ace Attorney Investigations 2! (I submitted this patch well before the official English release was announced.)"
%}

# Power Status Support

Well, exposing it to cores at least.
Not _technically_ all that useful,
but since RetroArch itself had this capability
integrating it into cores was a low-hanging fruit.

---

This is the best thing I've ever made,
and it's important to me because
I had a Nintendo DS (and later, DSi) growing up.
So many of the games I used to play on it
may never see ports to other platforms.

At about the time I started developing melonDS DS,
I was having a crisis of confidence.[^3]
I needed to ship something that was polished and beloved,
just to prove to myself that I could.

[^3]: For reasons that deserve another post.

Not long after, I made it my mission to bring melonDS DS to version 1.0.[^4]
Crossing that finish line meant a few things:

[^4]:
    melonDS itself is at 0.9.5 as of this writing,
    but melonDS DS is versioned independently.

- Match the feature set of the unmaintained legacy melonDS core.
- No experience-ruining bugs.
  Perfection is impossible,
  but a pleasant gameplay session isn't.
  Any new or minor bugs would be fixed later
  (and I still am).
- Intentionally don't add too many extra features,
  at least not for 1.0.
  I didn't want to fall into rabbit holes again,
  so I held off on certain features (e.g. solar sensor, the DSi camera)
  with the intent to add them later.

For months I tested melonDS DS
in various emulation-related chat rooms,
gathering feedback about bugs and usability issues.
**It paid off.**
It was extremely well-received in the community,
and I was even invited on the RetroAchievements podcast to talk about what I did.

<lite-youtube videoid="al41axemkGk"></lite-youtube>

You can get melonDS DS
from within RetroArch's core downloader for most platforms,
or bundled with the app on iOS.

If you like what I'm doing,
[consider throwing a couple of bones my way](https://github.com/sponsors/JesseTG)!
The [libretro](https://www.retroarch.com/index.php?page=donate) and [melonDS](https://melonds.kuribo64.net/donate.php) teams
-- whose hard work made everything you just read about possible --
would appreciate some support, too.

---

This post is adapted from [one I published on LinkedIn][linkedin-post] in June 2024.

[biads]: https://www.mobygames.com/game/29865/brothers-in-arms-ds
[desmume-libretro]: https://github.com/libretro/desmume
[dkrds]: https://www.mobygames.com/game/26746/diddy-kong-racing-ds
[kaeru]: https://kaeru.world/projects/wfc
[linkedin-post]: https://www.linkedin.com/feed/update/urn:li:activity:7205973939716538370
[melonds]: https://melonds.kuribo64.net
[melonds-libretro]: https://github.com/libretro/melonDS
[mmbn5ds]: https://www.mobygames.com/game/23356/mega-man-battle-network-5-double-team-ds
[retroarch-appstore]: https://apps.apple.com/us/app/retroarch/id6499539433
[rrds]: https://www.mobygames.com/game/16054/ridge-racer-ds
[sm64ds]: https://www.mobygames.com/game/31024/super-mario-64-ds
