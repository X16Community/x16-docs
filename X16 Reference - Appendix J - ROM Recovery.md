
# Appendix J: ROM Recovery

**WARNING: This is a draft that may contain errors or omissions that could damage your hardware.**

## Using a PC to upgrade or recover ROM using Relatively Universal ROM Programmer (RURP)

**Target Component:** ROM

**Programmer:** Relatively Universal ROM Programmer (RURP) + Arduino UNO

**Software:** Firestarter

**Host OS:** Windows (should also be compatible with Mac/Linux)


### Before you start: Read project page and watch instruction videos (optional)

https://github.com/AndersBNielsen/Relatively-Universal-ROM-Programmer

https://hackaday.io/project/192273-relatively-universal-rom-programmer

https://www.youtube.com/watch?v=SZQ50XZlk5o

https://www.youtube.com/watch?v=JDHOKbyNnrE

https://discord.com/invite/kmhbxAjQc3


### Warning: SST39SF040 only

These instructions are only intended for the SST39SF040 parallel flash chip, used by X16.

If you follow these instructions but have a different chip, make sure to adjust voltage and jumpers accordingly. You may also want to consult with the videos and/or the RURP discord server.

These instructions have only been tested with V2 hardware.


### Get the programmer

Follow instructions at https://github.com/AndersBNielsen/Relatively-Universal-ROM-Programmer . You also need an Arduino Uno.

(Pro tip: Buy one additional black ZIF socket. It can be placed directly into the ROM socket, no soldering needed. Makes it much easier to remove the ROM IC later.)


### Solder through-hole components

Instruction video: https://www.youtube.com/watch?v=SZQ50XZlk5o

For use with the x16 rom (SST39SF040), you only need to solder the Arduino headers and the socket. Jumper and OLED headers are not needed, assuming HW revision 2.


### Install Firestarter app

Instruction video: https://www.youtube.com/watch?v=JDHOKbyNnrE

Firestarter is a 3rd party software/firmware improvement to the ROM programmer, which includes a large database of chip definitions, including SST39SF040.

Install using `pip install firestarter`

Test version using `firestarter --version`. These instructions are tested with app version 1.3.39.

Firestarter commands are explained by adding `-h` to it. To get more detailed output, use `-v`.


### Install Firestarter firmware

Do not have anything connected to your Arduino UNO. Connect the UNO to the PC.

Use `firestarter fw -h` to get instructions for how to program and verify firmware.

Install the firmware using the command `firestarter fw -i`. You may need to specify path to avrdude, if it is not in path. On Windows, it may be here: `C:\Program Files (x86)\Arduino\hardware\tools\avr\bin`. You may also specify path to avrdude.conf, e.g `-c "C:\Program Files (x86)\Arduino\hardware\tools\avr\etc"`.

After install, confirm version using `firestarter fw`. These instructions are tested with firmware 1.4.2.

Disconnect UNO from PC. Connect RURP shield to Arduino, without any ROM chip. Connect UNO to PC.

Identify hardware revision using `firestarter hw`. These instructions are tested with Rev2.


### Disconnect ROM chip

Disconnect power from the Commander X16. Remove the ROM chip, which is a SST39SF040 parallel flash IC, inside the "SYSTEM ROM" socket in the lower left corner of the board.


### Warning: High voltage

EEPROM chips requires high voltage (12-24V) to program and to erase. The parallel flash chip used by X16 does not need high voltage for anything. However, RURP can output high voltage to some of the pins, based on the control register. During Arduino reset, this control register is uninitialized, and may be in a state where it causes high voltage to some pins, which may damage a flash IC. Because of this, it is NOT recommended to connect an IC to RURP while it is powered off. Instead, power on RURP first, and then connect your IC just before programming it.


### Insert ROM chip into programmer

Send the command `firestarter info SST39SF040` to view the IC details and jumper config, based on the database. For HW rev2, no jumper is needed.

Make sure RURP is powered.

Connect the IC. The notch should go toward the nearest PCB edge. (For the record: If connecting a 24 or 28 pin IC, connect it according to the drawing on the back of the PCB).

To test communcation with the flash chip, send `firestarter id SST39SF040`.

If you want to dump the contents of the chip, use the command `firestarter read SST39SF040`. This should dump to `SST39SF040.bin`, taking approx. 2 minutes.


### Program new rom file

Make sure the new rom file (e.g `rom.bin` for r48) is in the current folder.

To erase the chip and program this rom file, use the command `firestarter write SST39SF040 rom.bin`. This command will erase the chip, then verify that the entire chip is blank (0xFF), and then program the file.

Erase + blank check takes 45 seconds. Writing 256 kB, takes 1.5 additional minutes.

After write, you may want to verify that the contents of flash matches the contents of the `rom.bin` file. This can be done with `firestarter verify SST39SF040 rom.bin`. This takes a little over 1 minute.


### Insert ROM chip into X16

Make sure there are no blinkenlight activity on the RURP. There may be a few red stationary LEDs.

Remove the flash IC from RURP. If you have a ZIF socket on RURP, it is likely least risk of damaging anything if IC is disconnected while RURP is powered, since a sudden reconnect may give high voltage to a pin.

Insert the flash IC into X16, while X16 is disconnected from power. (You may optionally insert a ZIF socket into the ROM socket first, to make the ROM easier to remove next time.)

Power on your X16. Enjoy!


<!-- For PDF formatting -->
<div class="page-break"></div>
