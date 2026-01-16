![Portal 2 Archipelago Mod](md-imgs/Portal2pelago-LOGO.png)

`version 0.3`
`Stable` `In Development`

This is a Portal 2 mod designed for use with Archipelago, a multi-game collaborative randomiser.

This must be used with the [Portal 2 APWorld and Client](https://github.com/GlassToadstool/Archipelago/releases).

> [!WARNING]
> This mod is not compatible with SteamOS.

## Features

- [x]  Item Collection
- [x]  Check Making
- [x]  Randomized map order in each chapter
- [x]  Goal completing the final level
- [x]  Death Link
- [x]  Traps
- [x]  In game messages (reflecting client messages)
- [ ]  Additional locations - Wheatley monitors, achievements, item gains
- [ ]  More to come...

## Installation

To use this mod you must first have a copy of Portal 2 downloaded in your Steam library.

1. Download and install [Steam](https://store.steampowered.com/about/), and download and install [Portal 2](https://store.steampowered.com/app/620/Portal_2/).
2. Download the [latest Zip archive release of the Portal 2 mod's source code from this repository](https://github.com/GlassToadstool/Portal2ArchipelagoMod/archive/refs/heads/main.zip)
3. Extract the top-level folder from the Zip file (named `Portal2ArchipelagoMod-main`)
4. Place the `Portal2ArchipelagoMod-main` folder in the `sourcemods` Steam folder.
    - On Windows, this may be found at:
        - `C:\Program Files (x86)\Steam\steamapps\sourcemods`
    - On Linux, this may be found at:
        - `~/.local/share/Steam/steamapps/sourcemods/`
5. Rename the folder from `Portal2ArchipelagoMod-main` to `Portal2Archipelago`.

The folder structure should look like this:

```
sourcemods
|   
└─── Portal2Archipelago
    |  GameInfo.txt
    |   ...
    └─── cfg
    └─── ...
```

6. Open Steam, and you should see a new game named "Portal 2 Archipelago Mod" in your game library.
    > [!NOTE] If the game does not appear in your Steam game library, please exit (completely closing) Steam and re-launch Steam.
7. We need to change the properties of the game in order to connect to the Archipelago Portal 2 APWorld client. Right-click the "Portal 2 Archipelago Mod" game in your Library, and select the "Properties..." menu option.
8. In the dialog that appears, navigate to the "General" menu item, then in the right pane of the dialog navigate to "Launch Options". In the text input:
    - On Windows, put:
        - `-netconport 3000`
    - On Linux, put: 
        - `%command% -netconport 3000`
            > [!TIP] If on Linux, and you cannot get the game to open as expected, you may need to run the game using Proton, following the Windows install steps.

## Acknowledgements

### Mod Creators

- **Dyroha** - Lead Developer
- **Proplayen** - Logic Design
- **JD** - Graphics
- **Kaito Kid** - Answering lots of questions about APWorld development
- **studkid** - UT Support
- **Clone Fighter** - Graphics
- **Charged_Neon** - Documentation

### Testers

**22TwentyTwo, ahhh reptar, Bfbfan26, buzzman5001, ChaiMint, Default Miserable, Fewffwa, Fox, Grenhunterr, Kit Lemonfoot, Knux, MarioXTurn, miketizzle411, Pigmaster100, Rya, Scrungip**