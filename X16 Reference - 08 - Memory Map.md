
# Chapter 8: Memory Map

The Commander X16 has 512 KB of ROM and 2,088 KB (2 MB[^1] + 40 KB) of RAM with up to 3.5MB of RAM or ROM available to cartridges.

Some of the ROM/RAM is always visible at certain address ranges, while the remaining ROM/RAM is banked into one of two address windows.

This is an overview of the X16 memory map:

|Addresses  |Description                                                                             |
|-----------|----------------------------------------------------------------------------------------|
|\$0000-\$9EFF|Fixed RAM (40 KB minus 256 bytes)                                                       |
|\$9F00-\$9FFF|I/O Area (256 bytes)                                                                    |
|\$A000-\$BFFF|Banked RAM (8 KB window into one of 256 banks for a total of 2 MB)                      |
|\$C000-\$FFFF|Banked System ROM and Cartridge ROM/RAM (16 KB window into one of 256 banks, see below) |

## Banked Memory

Writing to the following zero-page addresses sets the desired RAM or ROM bank:

|Address  |Description                                                   |
|---------|--------------------------------------------------------------|
|$0000    |Current RAM bank (0-255)                                      |
|$0001    |Current ROM/Cartridge bank (ROM is 0-31, Cartridge is 32-255) |

The currently set banks can also be read back from the respective memory locations. Both settings default to 0 on RESET.

## ROM Allocations

Here is the ROM/Cartridge bank allocation:

|Bank  |Name   |Description                                            |
|------|-------|-------------------------------------------------------|
|0     |KERNAL |KERNAL operating system and drivers                    |
|1     |KEYBD  |Keyboard layout tables                                 |
|2     |CMDRDOS|The computer-based CMDR-DOS for FAT32 SD cards         |
|3     |FAT32  |The FAT32 driver itself                                |
|4     |BASIC  |BASIC interpreter                                      |
|5     |MONITOR|Machine Language Monitor                               |
|6     |CHARSET|PETSCII and ISO character sets (uploaded into VRAM)    |
|7     |DIAG   |Memory diagnostic                                      |
|8     |GRAPH  |Kernal graph and font routines                         |
|9     |DEMO   |Demo routines                                          |
|10    |AUDIO  |Audio API routines                                     |
|11    |UTIL   |System Configuration (Date/Time, Display Preferences)  |
|12    |BANNEX |BASIC Annex (code for some added BASIC functions)      |
|13-14 |X16EDIT|The built-in text editor                               |
|15    |BASLOAD|A transpiler that converts BASLOAD dialect to BASIC V2 |
|16-31 |–      |_[Currently unused]_                                   |
|32-255|–      |Cartridge RAM/ROM                                      |

**Important**: The layout of the banks may still change.

### Cartridge Allocation

Cartridges can use the remaining 32-255 banks in any combination of ROM, RAM, Memory-Mapped IO, etc. See Kevin's reference cartridge design
for ideas on how this may be used. This provides up to 3.5MB of additional RAM or ROM.

Bootable cartridge: See [Hardware - Booting from Cartridges](X16%20Reference%20-%2014%20-%20Hardware.md#booting-from-cartridges)

**Important**: The layout of the banks is not yet final.

## RAM Contents

This is the allocation of fixed RAM in the KERNAL/BASIC environment.

|Addresses   |Description                                                      |
|------------|-----------------------------------------------------------------|
|\$0000-\$00FF|Zero page                                                       |
|\$0100-\$01FF|CPU stack                                                       |
|\$0200-\$03FF|KERNAL and BASIC variables, vectors                             |
|\$0400-\$07FF|Available for machine code programs or custom data storage      |
|\$0800-\$9EFF|BASIC program/variables; available to the user                  |

The `$0400-$07FF` can be seen as the equivalent of `$C000-$CFFF` on a C64. A typical use would be for helper machine code called by BASIC.

### Zero Page

|Addresses   |Description                             |
|------------|----------------------------------------|
|\$0000-\$0001|Banking registers                      |
|\$0002-\$0021|16 bit registers r0-r15 for KERNAL API |
|\$0022-\$007F|Available to the user                  |
|\$0080-\$009C|Used by KERNAL and DOS                 |
|\$009D-\$00A8|Reserved for DOS/BASIC                 |
|\$00A9-\$00D3|Used by the Math library (and BASIC)   |
|\$00D4-\$00FF|Used by BASIC                          |

Machine code applications are free to reuse the BASIC area, and if they don't use the Math library, also that area.

### Banking

This is the allocation of banked RAM in the KERNAL/BASIC environment.

|Bank |Description                                    |
|-----|-----------------------------------------------|
|0    |Used for KERNAL/CMDR-DOS variables and buffers |
|1-255|Available to the user                          |

(On systems with only 512 KB RAM, banks 64-255 are unavailable.)

During startup, the KERNAL activates RAM bank 1 as the default for the user.

### Bank 0

|Addresses   |Description                             |
|------------|----------------------------------------|
|\$A000-\$BEFF| System Reserved                       |
|\$BF00-\$BFFF| Parameter passing space               |

You can use the space at $0:BF00-0:$BFFF to pass parameters between programs.
This space is initialized to zeroes, so you may use it however you wish.

The suggested use is to store a PETSCII string in this space and use
semicolons to separate parameters. The string should be null terminated:

Example:

`FRANK;3;BLUE\x00`

A program that reads the parameters is responsible for resetting the data to
zeroes, so that another program does not see unexpected data and malfunction.

## I/O Area

This is the memory map of the I/O Area:

|Addresses    |Description                          |Speed|
|-------------|-------------------------------------|-----|
|\$9F00-\$9F0F|VIA I/O controller #1. [Details](X16%20Reference%20-%2012%20-%20IO%20Programming.md#chapter-12-io-programming) |8 MHz|
|\$9F10-\$9F1F|VIA I/O controller #2                |8 MHz|
|\$9F20-\$9F3F|VERA video controller. [Details](X16%20Reference%20-%2009%20-%20VERA%20Programmer's%20Reference.md#registers) |8 MHz|
|\$9F40-\$9F41|YM2151 audio controller. [Details](X16%20Reference%20-%2011%20-%20Sound%20Programming.md#ym2151-opm-fm-synthesis) |2 MHz|
|\$9F42-\$9F5F|Unavailable                          | --- |
|\$9F50-\$9F5F|Planned for X16GS. [Details](https://x16community.github.io/faq/gs-faq.html) | --- |
|\$9F60-\$9F7F|Expansion Card Memory Mapped IO3     |8 MHz|
|\$9F80-\$9F9F|Expansion Card Memory Mapped IO4     |8 MHz|
|\$9FA0-\$9FBF|Expansion Card Memory Mapped IO5     |2 MHz|
|\$9FB0-\$9FBF|Used by emulator. [Details](https://github.com/X16Community/x16-emulator?tab=readme-ov-file#emulator-io-registers) | --- |
|\$9FC0-\$9FDF|Expansion Card Memory Mapped IO6     |2 MHz|
|\$9FE0-\$9FFF|Cartidge/Expansion Memory Mapped IO7 |2 MHz|
|\$9FFF       |POST code. [Details](X16%20Reference%20-%20Appendix%20E%20-%20Diagnostic%20Bank.md#post) |2 MHz|

### Expansion Cards & Cartridges

Expansion cards can be accessed via memory-mapped I/O (MMIO), as well as I2C. Cartridges are
essentially expansion cards which are housed in an external enclosure and may contain RAM, ROM
and an I2C EEPOM (for save data). Internal expansion cards may also use the RAM/ROM space,
though this could cause conflicts.

While they may be uncommon, since cartridges are essentially external expansion cards in a
shell, that means they can also use MMIO. This is only necessary when a cartridge includes
some sort of hardware expansion and MMIO was desired (as opposed to using the I2C bus). In
that case, it is recommended cartridges use the IO7 range and that range should be the
last option used by expansion cards in the system.
**MMIO is unneeded for cartridges which simply have RAM/ROM.**

For more information, consult the
[Hardware](X16%20Reference%20-%2014%20-%20Hardware.md#chapter-14-hardware-pinouts) section of the manual.

---

[^1]: Current development systems have 2 MB of bankable RAM.
Actual hardware is currently planned to have an option of either 512 KB or 2 MB of RAM.

<!-- For PDF formatting -->
<div class="page-break"></div>
