


# Appendix H: How to update your X16 to latest release

These instructions will guide you how to update your X16 firmware from any previous version to the latest version. This guide will be updated once there are new releases. This guide is applicable for Gen 1 hardware, PRxxxxx boards.

## Table Of Contents

1. [Latest release](#latest-release)
2. [Requirements](#requirements)
3. [Update instructions](#update-instructions)
4. [Appendix: Release history](#appendix-release-history)
5. [Appendix: Stock version numbers](#appendix-stock-version-numbers)
6. [Appendix: How to downgrade from latest release to first release](#appendix-how-to-downgrade-from-latest-release-to-first-release)

## Latest release

| Firmware        | Version | Date       | Link                                                               |
|-----------------|---------|------------|--------------------------------------------------------------------|
| ROM             | R48     | 2024-09-06 | https://github.com/X16Community/x16-rom/releases/tag/r48           |
| SMC             | 47.2.3  | 2024-07-05 | https://github.com/X16Community/x16-smc/releases/tag/r47.2.3       |
| VERA            | 47.0.2  | 2024-03-30 | https://github.com/X16Community/vera-module/releases/tag/v47.0.2   |
| SMC bootloader  | 3       | 2024-09-13 | https://github.com/X16Community/x16-smc-bootloader/releases/tag/v3 |


## Requirements
| Property | Requirement            |
|----------|------------------------|
| Hardware | Gen 1 PRxxxxx board    |
| ROM      | Minimum version R43    |
| SMC      | Minimum version 43.0.0 |
| VERA     | No minimum version     |


## Update instructions


### Step 1: Note down your current ROM/SMC/VERA versions (recommended)

#### 1.1 ROM/SMC/VERA versions
Use the `HELP` command to see which versions you currently have.
You may want to take a picture of the screen or write it down, for future reference.

#### 1.2 SMC bootloader version
- Poll bootloader version with this command: `PRINT I2CPEEK($42,$8E)`
	- This should be 2 if you have a stock PR board. Note that if you have bootloader 3 it may incorrectly display as 255.
- If you have SMC version 47.2.3 or later, you can use the tool "SMCBLD7.PRG" inside [smc tools] (see step 3) to identify bootloader version based on its CRC-16 checksum, making this a more accurate bootloader test.
- Take a picture of the screen, for future reference.


### Step 2: Take a backup of what you have

#### 2.1 SD card (highly recommended)
- Plug SD card in your PC and make a backup of all files. In case SD card gets corrupted, damaged, or you loose your files otherwise.
- If needed, you can download the latest version of the SD card bundle here: https://github.com/cx16forum/sdcard

#### 2.2 ROM/SMC/VERA (optional)
- If you know your current version numbers (step 1), and do not care about rolling back, you can safely skip this step.
- If you like to preserve the history, you can optionally dump the existing versions of ROM/SMC/VERA, for your own archival purposes. In particular, if your version is not a released full version (e.g. ROM prerelease), you may want to make a backup of this one (and give a head's up on Discord, #kernel).
  - Dump tool for ROM/SMC/VERA/RTC: https://cx16forum.com/forum/viewtopic.php?p=34970
- Archive of official releases:
  - ROM: https://github.com/X16Community/x16-rom/releases/
  - SMC: https://github.com/X16Community/x16-smc/releases/
  - VERA: https://github.com/X16Community/vera-module/releases/
  - SMC bootloaders: https://github.com/X16Community/x16-smc-bootloader/releases
- Unofficial releases, known to have been delivered with some machines:
  - SMC 45.1.0: https://github.com/FlightControl-User/x16-flash/releases/download/r3.0.0/R45-BINS.zip
  - SMC bootloader v2(bad): Inside [bootloader tools] https://github.com/X16Community/x16-smc/pull/53#issuecomment-2362330198 / src: https://github.com/X16Community/x16-smc/pull/20
  - ROM R47 prerelease git 8929A57+: dump: https://cx16forum.com/forum/viewtopic.php?p=31112 / src: X16Community/x16-rom#213 (exact source is ambiguous due to the +)
  - ROM R47 prerelease git 33ACE3A4: dump: not archived, src: X16Community/x16-rom#241

### Step 3: Download files and place on SD card

- BIN files and their associated programming tool must stay in the same folder
- Note that the x16-flash tool (UPDATE.PRG) will attempt to program both ROM, SMC and VERA if it finds associated .BIN files in its folder, so make sure that its folder only contains ROM.BIN

#### Suggested folder structure:
- UPDATE
	- VERA
		- 47.0.2
			- FLASHVERA.PRG
			- VERA.BIN
	- ROM
		- R48
			- UPDATE.PRG
			- ROM.BIN
	- SMC
		- 47.2.3
			- SMCUPDATE.PRG
	- SMCTOOLS
		- SMCBLD7.PRG
		- SMCBLW19.PRG
		- BOOT3.BIN

#### Downloads:
- VERA 47.0.2
	- https://github.com/X16Community/vera-module/releases/tag/v47.0.2
		- Download Assets -> VERA_47.0.2.BIN and FLASHVERA.PRG
- ROM R48
	- https://github.com/X16Community/x16-rom/releases/tag/r48
		- Download Assets -> Release.R48.ROM.Image.zip
			- Extract "rom.bin"
	- https://github.com/FlightControl-User/x16-flash/releases/tag/r3.0.0
		- Download Assets -> CX16-UPDATE-R3.0.0.PRG
- SMC 47.2.3
	- https://github.com/X16Community/x16-smc/actions/runs/10988514867
		- Download Artifacts -> "SMC default firmware" (NOT the custom CommunityX16)
			- Extract "SMCUPDATE-47.2.3.PRG"
- SMC tools v6
	- https://github.com/X16Community/x16-smc/pull/53#issuecomment-2362330198
		- Download smc-flash-manipulation-6.zip
			- Extract files mentioned under SMCTOOLS above

#### Copy to SD card
- Prepare the folder structure on the SD card.
- Copy downloaded files to SD card, inside the folder structure mentioned above.
- Rename files as needed. Uppercase/lowercase is not important.

#### Navigating the file system on X16
- To list files in current folder, or change folder, you use the commands `DOS"$"` or `DOS"CD:folder"`.
- A shortcut is to use the `@` prefix, e.g. `@$` and `@CD:folder`
- To enter the VERA folder, you can e.g. use the command `@CD:/UPDATE/VERA/47.0.2`
- You can also navigate like this:

```
@CD:/UPDATE
@$
@CD:VERA
@$
@CD:47.0.2
@$
```

### Step 4: Update VERA to 47.0.2
VERA have best backward compatibility, and should be flashed first.
- 47.0.2 supports at least ROM 47 prerelease, and probably older ROMs as well.
- Release page: https://github.com/X16Community/vera-module/releases/tag/v47.0.2
- Follow instructions on release page to program VERA.

```
@CD:/UPDATE/VERA/47.0.2
LOAD "FLASHVERA.PRG"
RUN
```

- After programming, restart machine and type `HELP` to verify VERA version.

### Step 5: Update ROM to R48
- Minimum SMC version: 43.0.0
- Minimum VERA version: 0.3.1
- You may follow this guide: https://github.com/FlightControl-User/x16-flash

```
@CD:/UPDATE/ROM/R48
LOAD "UPDATE.PRG"
RUN
```

- Follow the instructions on screen.
- Note that the J1 jumper must be on, to allow ROM to be reprogrammed. Disconnect jumper after programming, to ensure ROM is write protected.
- Important: Only program ROM in this step, not VERA or SMC.


### Step 6: Update SMC to 47.2.3
- To update SMC, a little program on the SMC called "bootloader" is used to replace its main program.
- All PR boards up to ~900 seem to have been delivered with version 45.1.0, and with a bootloader which claims to be version 2, but, unfortunately, is a corrupt version of version 2 (also referred to as the "bad" bootloader). This have the consequence that, if you attempt to program, the x16 will hang at the end of programming. If you attempt to fix the hang problem by disconnecting power, and plug it back in, your SMC will be "bricked", and you cannot use your x16 until you disconnect the SMC and program it manually using an external programmer or Arduino [recovery-with-arduino].
- To update your SMC with bad bootloader, you have 2 options:
	- Option 1: Disconnect the SMC, connect to an external programmer, and install latest firmware https://github.com/X16Community/x16-smc/blob/main/doc/recovery-with-arduino.md
	- Option 2: Reset the SMC by shorting its reset pin to GND, using a jumper wire. Instruction: https://github.com/X16Community/x16-smc/blob/main/doc/update-with-bad-bootloader-v2.md
		- NB: If you plan to do option 2, ref the instructions, you should practice doing this reset while at the READY prompt. Once you get the hang of it, you can do it during programming. It is important that you get it correct at the critical moment when the SMC is hanging inside the bad bootloader.
- If you have a different SMC version than 45.1.0, you most likely do not have the bad bootloader.

#### Recommended install method, SMCUPDATE-47.2.3.PRG
- The recommended method to upgrade SMC to latest version 47.2.3, is to use an installer with version 47.2.3 bundled together with the installer.
- Note that this version is currently not inside an official release
- If there is a risk of having the bad v2 bootloader, have a jumper wire ready
- Load and run the installer
```
@CD:/UPDATE/SMC/47.2.3
LOAD "SMCUPDATE.PRG"
RUN
```
- Use the jumper wire if needed, ref the "update-with-bad-bootloader-v2.md" instructions

#### Alternative tools
- The tool SMCUPDATE 2.0 allows you to specify a .hex file to install
	- This tool works with bootloader 2, but not with bootloader 3
	- Tool: https://github.com/stefan-b-jakobsson/x16-smc-update/releases/tag/2.0
	- When prompted for file name, enter "x16-smc.ino.hex"
- The tool x16-flash allows you to program the .bin file from the release page
	- This tool ignores bootloader version, and works with both v2 and v3
	- If bootloader version is 2, you cannot reprogram with the same version
	- This tool gives bad recommendation in the case of bad bootloader
	- Tool: https://github.com/FlightControl-User/x16-flash/releases/tag/r3.0.0
- These tools can work with the .hex and .bin files found in the release page
	- https://github.com/X16Community/x16-smc/releases/tag/r47.2.3


### Step 7: Install bootloader v3
Follow instructions inside the text file in [smc tools] ("smc-flash-manipulation-6.zip")

- Run SMCBLD7.PRG to get bootloader checksum, version and failsafe status
```
@CD:/UPDATE/SMCTOOLS
LOAD "SMCBLD7.PRG"
RUN
```
- Run SMCBLW19.PRG to install BOOT3.BIN
```
@CD:/UPDATE/SMCTOOLS
LOAD "SMCBLW19.PRG"
RUN
```
- Run SMCBLD7.PRG to validate checksum again, confirm it BF63 (v3)
- To install "Boot v3 failsafe", you need to update SMC a second time (repeat step 6)
- Run SMCBLD7.PRG, to confirm that boot v3 failsafe is installed

With Boot V3 failsafe installed, you have a fallback mechanism in case SMC firmware gets corrupted.


## Appendix: Release history
| Date       | ROM               | SMC     | VERA   | SMC bootloader | Notes                           |
|------------|-------------------|---------|--------|----------------|---------------------------------|
| 2024-09-13 |                   |         |        | 3              | Boot v3, with failsafe          |
| 2024-09-06 | R48               |         |        |                | Release R48 ("Cadmium")         |
| 2024-07-05 |                   | 47.2.3  |        |                | Bootloader manipulation ++      |
| 2024-03-30 | R47               | 47.0.0  | 47.0.2 |                | Release R47 ("Roswell")         |
| 2023-12-24 | R47 pre 33ACE3A4* |         |        |                | Unreleased ROM version*         |
| 2023-11-20 |                   |         | 0.3.2  |                | Experimental FX                 |
| 2023-11-06 | R47 pre 8929A57+* |         |        |                | Unreleased ROM version*         |
| 2023-11-06 | R46               |         |        |                | Release R46 ("Winnipeg")        |
| 2023-10-18 |                   | 45.1.0* |        |                | Unreleased*, bootloader support |
| 2023-10-17 | R45               |         |        |                | Release R45 ("Nuuk")            |
| 2023-10-04 |                   |         |        | 2              | Boot v2, auto power off         |
| 2023-10-04 |                   |         |        | 2 (bad)*       | Bad version*                    |
| 2023-08-14 | R44               |         |        |                | Release R44 ("Milan")           |
| 2023-08-09 |                   |         | 0.3.1  |                | Experimental FX                 |
| 2023-05-17 | R43               | 43.0.0  |        |                | Release R43 ("Stockholm")       |
| 2023-04-19 |                   |         |        | 1              | Boot v1                         |
| 2023-03-23 |                   |         | 0.1.1  |                | VERA 0.1.1                      |
| 2023-03-07 | R42               | R42     |        |                | Release R42 ("Cambridge")       |

* A few releases are not official, but, these have been delivered with some of the machines, see below.


## Appendix: Stock version numbers
This is based on feedback from users on Discord, and is very approximate. If you have updated info, feel free to send a message on Discord.

### PR00001 to PR00300

| Firmware        | Version              | Date       | Link                                                                                                                                                                  |
|-----------------|----------------------|------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ROM             | R47pre git 8929A57+* | 2023-11-06 | Build: https://cx16forum.com/forum/viewtopic.php?p=31112 / src: https://github.com/X16Community/x16-rom/pull/213 (exact source is ambiguous due to the +)             |
| SMC             | 45.1.0*              | 2023-10-18 | Build: https://github.com/FlightControl-User/x16-flash/blob/main/arduino/x16-smc-r45.1-bootloader.hex / src: https://github.com/X16Community/x16-smc/pull/20          |
| VERA            | 0.3.2                | 2023-11-20 | https://github.com/X16Community/vera-module/releases/tag/v0.3.2                                                                                                       |
| SMC bootloader  | 2 (bad)*             | 2023-10-04 | Build: https://github.com/FlightControl-User/x16-flash/blob/main/arduino/x16-smc-r45.1-bootloader.hex / src: https://github.com/stople/x16-smc-bootloader/tree/bad_v2 |

### PR00301 to PR00900

| Firmware        | Version              | Date       | Link                                                                        |
|-----------------|----------------------|------------|-----------------------------------------------------------------------------|
| ROM             | R47pre git 33ACE3A4* | 2023-12-24 | Build: Not archived / src: https://github.com/X16Community/x16-rom/pull/241 |
| SMC             | 45.1.0*              | 2023-10-18 |                                                                             |
| VERA            | 0.3.2                | 2023-11-20 |                                                                             |
| SMC bootloader  | 2 (bad)*             | 2023-10-04 |                                                                             |

### PR00901 to PR?????

| Firmware        | Version | Date       | Link                                                               |
|-----------------|---------|------------|--------------------------------------------------------------------|
| ROM             | R47     | 2024-03-30 | https://github.com/X16Community/x16-rom/releases/tag/r47           |
| SMC             | 47.0.0  | 2024-03-30 | https://github.com/X16Community/x16-smc/releases/tag/r47.0.0       |
| VERA            | 47.0.2  | 2024-03-30 | https://github.com/X16Community/vera-module/releases/tag/v47.0.2   |
| SMC bootloader  | 2       | 2023-10-04 | https://github.com/X16Community/x16-smc-bootloader/releases/tag/v2 |

### Some stock versions
| Machine | ROM                  | SMC     | VERA  | SMC bootloader |
|---------|----------------------|---------|-------|----------------|
| PR00015 | R47pre git 8929A57+* |         |       |                |
| PR00102 | R47pre git 8929A57+* | 45.1.0* | 0.3.2 | 2 (bad)*       |
| PR00499 | R47pre git 33ACE3A4* |         |       |                |
| PR00831 | R47pre git 33ACE3A4* | 45.1.0* | 0.3.2 | 2 (bad)*       |
| PR00923 |                      | 47.0.0  |       |                |





## Appendix: How to downgrade from latest release to first release

### Step 1: Downgrade bootloader
This is optional, as all bootloaders are backward compatible. If you do not plan to downgrade bootloader, go to step 2.

Run SMCBLD7.PRG. Check if "Boot v3 failsafe" is installed. If it is, and you plan to downgrade to bootloader v2 or older, you must:
- Ensure [any working SMC programming tool and SMC version] is present on SD card
	- SMCUPDATE-47.2.3 can be used
	- NB: x16-flash with bootloader 2 rejects programming SMC to the same version!
- Downgrade bootloader, using SMCBLW19.PRG
- Computer is now in a critical state. If you power it off, it is bricked.
- In this state, you must perform a SMC programming, to any version, with any tool, to uninstall "boot v3 failsafe".
	- If you installed bad v2 bootloader, remember to reset it using jumper wire

### Step 2: Downgrade SMC
Downgrade SMC using any tool
- SMCUPDATE or x16-update
- Note that SMC 45.1.0* or newer is needed if you want to use the bootloader afterwards
- SMC older than R42 is indended for an incompatible hardware revision

### Step 3: Downgrade ROM
Downgrade ROM
- ROM older than R42 is intended for an incompatible hardware revision

### Step 4: Downgrade VERA
Downgrade VERA
- If using VERA.BIN from release page, use the associated FLASHVERA
- If using VERA.BIN released together with x16-flash, use x16-flash to program it

<!-- For PDF formatting -->
<div class="page-break"></div>
