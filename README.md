
# ![Portalpelago icon](Portalpelago.png) Portal 2 Archipelago Mod

`version 0.2`

This is a Portal 2 mod designed for use with Archipelago, a multi-game collaborative randomiser.

This must be used with the [Portal 2 APWorld and Client](https://github.com/GlassToadstool/Archipelago/releases).


## Features

- [x]  Item Collection
- [x]  Check Making
- [x]  Randomized map order in each chapter
- [x]  Goal completing the final level
- [x]  Death Link
- [x]  Traps - Only 3 at the moment
- [x]  In game messages (reflecting client messages)
- [ ]  Additional locations - Wheatly monitors, achivements, item gains
- [ ]  Extra items not in vanilla game
- [ ]  More to come...
## Installation

To use this mod you must fist have a copy of Portal 2 downloaded on your steam library.

1. Download the files from this repository 

2. Place the contents in a folder named `Portal2Archipelago` in your steam `sourcemods` folder. On windows this may be found at
`C:\Program Files (x86)\Steam\steamapps\sourcemods` on Windows, or at `~/.local/share/Steam/steamapps/sourcemods/` on Linux
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

3. Go to steam and you should see the mod in your steam library. Run it as you would a normal steam game. If it doesn't show up simply restart steam (closing the app completely not just the steam window) and it should appear

4. Open the settings for the mod by right clicking the mod in your steam library and select `Properties...`. Then in the launch options box add `-netconport 3000`. This allows the Client to speak to the game which is essential for using the mod.

    > If you are on Linux you will need to set the option to `%command% -netconport 3000` and if you cannot ge the game to open normally you may need to run it with Proton.
    
## Acknowledgements

### Mod Creators

 - **Dyroha** - Lead Developer
 - **Proplayen** - Logic Design
 - **JD** - Graphics
 - **Kaito Kid** - Answering lots of questions about APWorld development
 - **studkid** - UT Support

### Testers

**22TwentyTwo, ahhh reptar, buzzman5001, ChaiMint, Default Miserable, Fewffwa, Fox, Grenhunterr, Kit Lemonfoot, Knux, MarioXTurn, miketizzle411, Pigmaster100, Rya, Scrungip, studkid**

