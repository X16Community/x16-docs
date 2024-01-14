
# Chapter 1: Overview

The Commander X16 is a modern home computer in the philosophy of Commodore computers like the VIC-20 and the C64.

**Features:**

* 8-bit 65C02S CPU at 8 MHz ([*](#future-65c816-support))
* 512 KB banked RAM (upgradeable to 2 MB on the X16 Developer Edition)
* 512 KB ROM
* Expansion Cards (Gen 1) & Cartridges (Gen 1 and Gen 2)
	* Up to 3.5MB of RAM/ROM
	* 5 32-byte Memory-Mapped IO slots
* VERA video controller
	* Up to 640x480 resolution
	* 256 colors from a palette of 4096
	* 128 sprites
	* VGA, NTSC and RGB output
* three sound generators
	* Yamaha YM2151: 8 channels, FM synthesis
	* VERA PSG: 16 channels, 4 waveforms
	* VERA PCM: Up to 48 kHz, 16 bit, stereo
* Connectivity:
	* PS/2 keyboard and mouse
	* 4 NES/SNES controllers
	* SD card
	* Commodore Serial Bus ("IEC")
	* Many Free GPIOs ("user port")

As a modern sibling of the line of Commodore home computers, the Commander X16 is reasonably compatible with computers of that line.

* Pure BASIC programs are fully backwards compatible with the VIC-20 and the C64.
* POKEs for video and audio are not compatible with any Commodore computer. (There are no VIC or SID chips, for example.)
* Pure machine language programs ($FF81+ KERNAL API) are compatible with Commodore computers.

#### Future 65C816 Support

A future upgrade path for the X16 may involve the 65C816. It is almost fully
compatible with the 65C02 except for 4 instructions (`BBRx`, `BBSx`, `RMBx`, and `SMBx`).
It is advisable not to use these instructions when writing programs for the X16.

<!-- For PDF formatting -->
<div class="page-break"></div>

