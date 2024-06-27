# Appendix G: SMC Firmware Recovery

## Using a Mac to Upgrade or Recover the SMC

**Target Component:** SMC (ATtiny861A)  
**Programmer:** TL866-3G/T48  
**Software:** minipro ver. 0.7  
**Host OS:** Mac OS  

### Installing the minipro Utility
To install minipro using Homebrew, run the following command:
```
brew install minipro
```

For a complete list of installation alternatives, visit the [minipro GitLab page](https://gitlab.com/DavidGriffith/minipro).

### Downloading Firmware

Use only the official releases of the SMC firmware, which can be found on the [X16 Community GitHub page](https://github.com/X16Community/x16-smc/releases).

Download the firmware in Intel hex file format, such as SMC-47.0.0-firmware_with_bootloader.hex. Note that the .bin file cannot be used for the update described here.

### Creating a Fuses Config File

Create a file named fuses.cfg with the following content:

```
lfuse = 0xf1
hfuse = 0xd4
efuse = 0xfe
lock = 0xff
```

Do not alter the content of this config file.

### Programming the SMC

1. Power Off the Board: Ensure that the board is disconnected from mains power.

2. Remove the SMC: The SMC (ATtiny861A) needs to be removed from the X16 board.
Note the orientation of the SMC, marked by a small notch near pin 1.
Carefully remove the SMC using a chip puller or a non-scratching prying tool.
It is recommended to use an anti-static wristband during the removal and reinstallation of the SMC.

3. Program the SMC: 

* Place the SMC in the TL866-3G/T48 programmer.

* Connect the programmer's USB cable to your computer.

* Run the following command to program the SMC:
```
minipro -p ATTINY861@DIP20 -c config -w fuses.cfg -c code -w firmware_with_bootloader.hex
```

4. Reinstall the SMC: Remove the SMC from the programmer and reinstall it on the X16 board, ensuring it is oriented the same way as before.

5. Test the SMC: Reconnect mains power to the board. Press the Power button to verify if the board works correctly.

These instructions should guide you through the process of upgrading or recovering the SMC firmware effectively.
