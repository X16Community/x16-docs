
# Chapter 5: KERNAL

<!--
********************************************************************************
NOTICE: This file uses two trailing spaces on some lines to indicate line
breaks for GitHub's Markdown flavor. Do not remove!
********************************************************************************
-->

The Commander X16 contains a version of KERNAL as its operating system in ROM. It contains

* "Channel I/O" API for abstracting devices
* a variable size screen editor
* a color bitmap graphics API with proportional fonts
* simple memory management
* timekeeping
* drivers
  * PS/2 keyboard and mouse
  * NES/SNES controller
  * Commodore Serial Bus ("IEC")
  * I2C bus

## KERNAL Version

The KERNAL version can be read from location $FF80 in ROM. A value of $FF indicates a custom build. All other values encode the build number. Positive numbers are release versions ($02 = release version 2), two's complement negative numbers are prerelease versions ($FE = $100 - 2 = prerelease version 2).

## Compatibility Considerations

For applications to remain compatible between different versions of the ROM, they can rely upon:

* the KERNAL API calls at $FF81-$FFF3
* the KERNAL vectors at $0314-$0333

The following features must not be relied upon:

* the zero page and $0200+ memory layout
* direct function offsets in the ROM

## Commodore 64 API Compatibility

The KERNAL [fully supports](#kernal-api-functions) the C64 KERNAL API.

These routines have been stable ever since the C64 came out and are extensively documented
in various resources dedicated to the C64. Currently, they are not documented _here_ so if you
need to look them up, here is a very thorough [reference of these standard kernal routines](https://www.pagetable.com/c64ref/kernal/) (hosted on M. Steil's website).
It integrates a dozen or so different sources for documentation about these routines.

## Commodore 128 API Compatibility

In addition, the X16 [supports a subset](#kernal-api-functions) of the C128 API.

The following C128 APIs have equivalent functionality on the X16 but are not compatible:

| Address | C128 Name | X16 Name             |
|---------|-----------|----------------------|
| $FF5F   | `SWAPPER` | [`screen_mode`](#function-name-screen_mode) |
| $FF62   | `DLCHR`   | [`screen_set_charset`](#function-name-screen_set_charset) |
| $FF74   | `FETCH`   | [`fetch`](#function-name-fetch) |
| $FF77   | `STASH`   | [`stash`](#function-name-stash) |
<!---
*** undocumented - we might remove it
| $FF7A   | `CMPARE`  | `cmpare`             |
--->

## New API for the Commander X16

There are lots of new APIs. Please note that their addresses and their behavior is still preliminary and can change between revisions.

Some new APIs use the "16 bit" ABI, which uses virtual 16 bit registers r0 through r15, which are located in zero page locations $02 through $21: r0 = r0L = $02, r0H = $03, r1 = r1L = $04 etc.

The 16 bit ABI generally follows the following conventions:

* arguments
  * word-sized arguments: passed in r0-r5
  * byte-sized arguments: if three or less, passed in .A, .X, .Y; otherwise in 16 bit registers
  * boolean arguments: c, n
* return values
  * basic rules as above
  * function takes no arguments: r0-r5, else indirect through passed-in pointer
  * arguments in r0-r5 can be "inout", i.e. they can be updated
* saved/scratch registers
  * r0-r5: arguments (saved)
  * r6-r10: saved
  * r11-r15: scratch
  * .A, .X, .Y, c, n: scratch (unless used otherwise)

## KERNAL API functions

| Label | Address | Class | Description | Inputs | Affects | Origin |
|-|-|-|-|-|-|-|
| [`ACPTR`](#function-name-acptr) | `$FFA5` | [CPB](#commodore-peripheral-bus "Commodore Peripheral Bus") | Read byte from peripheral bus | | A X | C64 |
| `BASIN` | `$FFCF` | [ChIO](#channel-io "Channel I/O") | Get character | | A X | C64 |
| [`BSAVE`](#function-name-bsave) | `$FEBA` | ChIO | Like `SAVE` but omits the 2-byte header | A X Y | A X Y | X16 |
| [`BSOUT`](#function-name-bsout) | `$FFD2` | ChIO | Write byte in A to default output. | A | P | C64 |
| `CIOUT` | `$FFA8` | CPB | Send byte to peripheral bus | A | A X | C64 |  
| `CLALL` | `$FFE7` | ChIO | Close all channels | | A X | C64 |
| [`CLOSE`](#function-name-close) | `$FFC3` | ChIO | Close a channel | A | A X Y P | C64 |
| `CHKIN` | `$FFC6` | ChIO | Set channel for character input | X | A X | C64 |
| [`clock_get_date_time`](#function-name-clock_get_date_time) | `$FF50` | Time | Get the date and time | none | r0 r1 r2 r3 A X Y P | X16
| [`clock_set_date_time`](#function-name-clock_set_date_time) | `$FF4D` | Time | Set the date and time | r0 r1 r2 r3 | A X Y P | X16
| `CHRIN` | `$FFCF` | ChIO | Alias for `BASIN` | | A X | C64 |
| [`CHROUT`](#function-name-bsout) | `$FFD2` | ChIO | Alias for `BSOUT` | A | P | C64 |
| `CLOSE_ALL` | `$FF4A` | ChIO | Close all files on a device  | | | C128 |
| `CLRCHN` | `$FFCC` | ChIO | Restore character I/O to screen/keyboard | | A X | C64 |
| [`console_init`](#function-name-console_init) | `$FEDB` | Video | Initialize console mode | none | r0 A P | X16
| [`console_get_char`](#function-name-console_get_char) | `$FEE1` | Video | Get character from console | A | r0 r1 r2 r3 r4 r5 r6 r12 r13 r14 r15 A X Y P | X16
| [`console_put_char`](#function-name-console_put_char) | `$FEDE` | Video | Print character to console | A C | r0 r1 r2 r3 r4 r5 r6 r12 r13 r14 r15 A X Y P | X16
| [`console_put_image`](#function-name-console_put_image) | `$FED8` | Video | Draw image as if it was a character | r0 r1 r2 | r0 r1 r2 r3 r4 r5 r14 r15 A X Y P | X16
| [`console_set_paging_message`](#function-name-console_set_paging_message) | `$FED5` | Video | Set paging message or disable paging | r0 | A P | X16
| [`enter_basic`](#function-name-enter_basic) | `$FF47` | Misc | Enter BASIC | C | A X Y P | X16
| [`entropy_get`](#function-name-entropy_get) | `$FECF` | Misc | get 24 random bits | none | A X Y P | X16
| [`extapi`](#function-name-extapi) | `$FEAB` | Misc | Extended API | A X Y P | A X Y P | X16
| [`extapi16`](#function-name-extapi16) | `$FEA8` | Misc | Extended 65C816 API | A X Y P | A X Y P | X16
| [`fetch`](#function-name-fetch) | `$FF74` | Mem | Read a byte from any RAM or ROM bank | (A) X Y | A X P | X16
| [`FB_cursor_next_line`](#function-name-fb_cursor_next_line) &#8224; | `$FF02` | Video | Move direct-access cursor to next line | r0&#8224; | A P | X16
| [`FB_cursor_position`](#function-name-fb_cursor_position) | `$FEFF` | Video | Position the direct-access cursor | r0 r1 | A P | X16
| [`FB_fill_pixels`](#function-name-fb_fill_pixels) | `$FF17` | Video | Fill pixels with constant color, update cursor | r0 r1 A | A X Y P | X16
| [`FB_filter_pixels`](#function-name-fb_filter_pixels) | `$FF1A` | Video | Apply transform to pixels, update cursor | r0 r1 | r14H r15 A X Y P | X16
| [`FB_get_info`](#function-name-fb_get_info) | `$FEF9` | Video | Get screen size and color depth | none | r0 r1 A P | X16
| [`FB_get_pixel`](#function-name-fb_get_pixel) | `$FF05` | Video | Read one pixel, update cursor | none | A | X16
| [`FB_get_pixels`](#function-name-fb_get_pixels) | `$FF08` | Video | Copy pixels into RAM, update cursor | r0 r1 | (r0) A X Y P | X16
| [`FB_init`](#function-name-fb_init) | `$FEF6` | Video | Enable graphics mode | none | A P | X16
| [`FB_move_pixels`](#function-name-fb_move_pixels) | `$FF1D` | Video | Copy horizontally consecutive pixels to a different position | r0 r1 r2 r3 r4 | A X Y P | X16
| [`FB_set_8_pixels`](#function-name-fb_set_8_pixels) | `$FF11` | Video | Set 8 pixels from bit mask (transparent), update cursor | A X | A P | X16
| [`FB_set_8_pixels_opaque`](#function-name-fb_set_8_pixels_opaque) | `$FF14` | Video | Set 8 pixels from bit mask (opaque), update cursor | r0L A X Y| r0L A P | X16
| [`FB_set_palette`](#function-name-fb_set_palette) | `$FEFC` | Video | Set (parts of) the palette | A X r0 | A X Y P | X16
| [`FB_set_pixel`](#function-name-fb_set_pixel) | `$FF0B` | Video | Set one pixel, update cursor | A | none | X16
| [`FB_set_pixels`](#function-name-fb_set_pixels) | `$FF0E` | Video | Copy pixels from RAM, update cursor | r0 r1 | A X P | X16
| `GETIN` | `$FFE4` | Kbd | Get character from keyboard | | A X | C64 |
| [`GRAPH_clear`](#function-name-graph_clear) | `$FF23` | Video | Clear screen | none | r0 r1 r2 r3 A X Y P | X16
| [`GRAPH_draw_image`](#function-name-graph_draw_image) | `$FF38` | Video | Draw a rectangular image | r0 r1 r2 r3 r4 | A P | X16
| [`GRAPH_draw_line`](#function-name-graph_draw_line) | `$FF2C` | Video | Draw a line | r0 r1 r2 r3 | r0 r1 r2 r3 r7 r8 r9 r10 r12 r13 A X Y P | X16
| [`GRAPH_draw_oval`](#function-name-graph_draw_oval) | `$FF35` | Video | Draw an oval or circle (optionally filled) | r0 r1 r2 r3 r4 C | A X Y P | X16
| [`GRAPH_draw_rect`](#function-name-graph_draw_rect) &#8224; | `$FF2F` | Video | Draw a rectangle (optionally filled) | r0 r1 r2 r3 r4 C | A P | X16
| [`GRAPH_get_char_size`](#function-name-graph_get_char_size) | `$FF3E` | Video | Get size and baseline of a character | A X | A X Y P | X16
| [`GRAPH_init`](#function-name-graph_init) | `$FF20` | Video | Initialize graphics | r0 | r0 r1 r2 r3 A X Y P | X16
| [`GRAPH_move_rect`](#function-name-graph_move_rect) &#8224; | `$FF32` | Video | Move pixels | r0 r1 r2 r3 r4 r5 | r1 r3 r5 A X Y P | X16
| [`GRAPH_put_char`](#function-name-graph_put_char) &#8224;| `$FF41` | Video | Print a character | r0 r1 A | r0 r1 A X Y P | X16
| [`GRAPH_set_colors`](#function-name-graph_set_colors) | `$FF29` | Video | Set stroke, fill and background colors | A X Y | none | X16
| [`GRAPH_set_font`](#function-name-graph_set_font) | `$FF3B` | Video | Set the current font | r0 | r0 A Y P | X16
| [`GRAPH_set_window`](#function-name-graph_set_window) &#8224;| `$FF26` | Video | Set clipping region | r0 r1 r2 r3 | A P | X16
| [`i2c_batch_read`](#function-name-i2c_batch_read) | `$FEB4` | I2C | Read multiple bytes from an I2C device | X r0 r1 C | A Y C | X16
| [`i2c_batch_write`](#function-name-i2c_batch_write) | `$FEB7` | I2C | Write multiple bytes to an I2C device | X r0 r1 C | A Y r2 C | X16
| [`i2c_read_byte`](#function-name-i2c_read_byte) | `$FEC6` | I2C | Read a byte from an I2C device | A X Y | A C | X16
| [`i2c_write_byte`](#function-name-i2c_write_byte) | `$FEC9` | I2C | Write a byte to an I2C device | A X Y | A C | X16
| `IOBASE` | `$FFF3` | Misc | Return start of I/O area | | X Y | C64 |
| [`JSRFAR`](#function-name-jsrfar) | `$FF6E` | Misc | Execute a routine on another RAM or ROM bank | PC+3 PC+5 | none | X16
| [`joystick_get`](#function-name-joystick_get) | `$FF56` | Joy | Get one of the saved controller states | A | A X Y P | X16
| [`joystick_scan`](#function-name-joystick_scan) | `$FF53` | Joy | Poll controller states and save them | none | A X Y P | X16
| [`kbd_scan`](#function-name-kbd_scan) | `$FF9F` | Kbd | Process a keystroke and place it in the buffer | none | A X Y P | C64 |
| [`kbdbuf_get_modifiers`](#function-name-kbdbuf_get_modifiers) | `$FEC0` | Kbd | Get currently pressed modifiers | A | A X P | X16
| [`kbdbuf_peek`](#function-name-kbdbuf_peek) | `$FEBD` | Kbd | Get next char and keyboard queue length | A X | A X P | X16
| [`kbdbuf_put`](#function-name-kbdbuf_put) | `$FEC3` | Kbd | Append a character to the keyboard queue | A | X | X16
| [`keymap`](#function-name-keymap) | `$FED2` | Kbd | Set or get the current keyboard layout Call address | X Y C | A X Y C | X16
| `LISTEN` | `$FFB1` | CPB | Send LISTEN command | A | A X | C64 |
| `LKUPLA` | `$FF59` | ChIO | Search tables for given LA | | | C128 |
| `LKUPSA` | `$FF5C` | ChIO | Search tables for given SA | | | C128 |
| [`LOAD`](#function-name-load) | `$FFD5` | ChIO | Load a file into main memory or VRAM | A X Y | A X Y | C64 |
| [`MACPTR`](#function-name-macptr) | `$FF44` | CPB | Read multiple bytes from the peripheral bus | A X Y C | A X Y P | X16
| [`MCIOUT`](#function-name-mciout) | `$FEB1` | CPB | Write multiple bytes to the peripheral bus | A X Y C | A X Y P | X16
| `MEMBOT` | `$FF9C` | Mem | Get address of start of usable RAM | | | C64 |
| [`MEMTOP`](#function-name-memtop) | `$FF99` | Mem | Get/set number of banks and address of the end of usable RAM | | A X Y | C64 |
| [`memory_copy`](#function-name-memory_copy) | `$FEE7` | Mem | Copy a memory region to a different region | r0 r1 r2 | r2 A X Y P | X16
| [`memory_crc`](#function-name-memory_crc) | `$FEEA` | Mem | Calculate the CRC16 of a memory region | r0 r1 | r2 A X Y P | X16
| [`memory_decompress`](#function-name-memory_decompress) | `$FEED` | Mem | Decompress an LZSA2 block | r0 r1 | r1 A X Y P | X16
| [`memory_fill`](#function-name-memory_fill) | `$FEE4` | Mem | Fill a memory region with a byte value | A r0 r1 | r1 X Y P | X16
| [`monitor`](#function-name-monitor) | `$FECC` | Misc | Enter machine language monitor | none | A X Y P | X16
| [`mouse_config`](#function-name-mouse_config) | `$FF68` | Mouse | Configure mouse pointer | A X Y | A X Y P | X16
| [`mouse_get`](#function-name-mouse_get) | `$FF6B` | Mouse | Get saved mouse sate | X | A (X) P | X16
| [`mouse_scan`](#function-name-mouse_scan) | `$FF71` | Mouse | Poll mouse state and save it | none | A X Y P | X16
| [`OPEN`](#function-name-open) | `$FFC0` | ChIO | Open a channel/file.  | | A X Y | C64 |
| `PLOT` | `$FFF0` | Video | Read/write cursor position | A X Y | A X Y | C64 |
| `PRIMM` | `$FF7D` | Misc | Print string following the caller’s code | | | C128 |
| [`RDTIM`](#function-name-rdtim) | `$FFDE` | Time | Read system clock | | A X Y| C64 |
| `READST` | `$FFB7` | ChIO | Return status byte | | A | C64 |
| [`SAVE`](#function-name-save) | `$FFD8` | ChIO | Save a file from memory | A X Y | A X Y C | C64 |
| [`SCNKEY`](#function-name-kbd_scan) | `$FF9F` | Kbd | Alias for `kbd_scan` | none | A X Y P | C64 |
| [`SCREEN`](#function-name-screen) | `$FFED` | Video | Get the text resolution of the screen | | X Y | C64 |
| [`screen_mode`](#function-name-screen_mode) | `$FF5F` | Video | Get/set screen mode | A C | A X Y P | X16
| [`screen_set_charset`](#function-name-screen_set_charset) | `$FF62` | Video | Activate 8x8 text mode charset | A X Y | A X Y P | X16
| `SECOND` | `$FF93` | CPB | Send LISTEN secondary address | A | A | C64 |
| [`SETLFS`](#function-name-setlfs)| `$FFBA` | ChIO | Set file parameters (LA, FA, and SA). | A X Y | | C64 |
| `SETMSG` | `$FF90` | ChIO | Set verbosity | A | | C64 |
| [`SETNAM`](#function-name-setnam) | `$FFBD` | ChIO | Set file name. | A X Y | | C64 |
| `SETTIM` | `$FFDB` | Time | Write system clock | A X Y | A X Y | C64 |
| `SETTMO` | `$FFA2` | CPB | Set timeout | | | C64 |
| [`sprite_set_image`](#function-name-sprite_set_image) &#8224; | `$FEF0` | Video | Set the image of a sprite | r0 r1 r2L A X Y C | A P | X16
| [`sprite_set_position`](#function-name-sprite_set_position) | `$FEF3` | Video | Set the position of a sprite | r0 r1 A | A X P | X16
| [`stash`](#function-name-stash) | `$FF77` | Mem | Write a byte to any RAM bank | stavec A X Y | (stavec) X P | X16
| `STOP` | `$FFE1` | Kbd | Test for STOP key  | | A X P | C64 |
| `TALK` | `$FFB4` | CPB | Send TALK command  | A | A | C64 |
| `TKSA` | `$FF96` | CPB | Send TALK secondary address | A | A | C64 |
| `UDTIM` | `$FFEA` | Time | Increment the jiffies clock | | A X | C64 |
| `UNLSN` | `$FFAE` | CPB | Send UNLISTEN command | | A | C64 |
| `UNTLK` | `$FFAB` | CPB | Send UNTALK command | | A | C64 |

&#128683; = Currently unimplemented  
&#8224; = Partially implemented  

Some notes:

* For device #8, the Commodore Peripheral Bus calls first talk to the "Computer DOS" built into the ROM to detect an SD card, before falling back to the Commodore Serial Bus.
* The `IOBASE` call returns $9F00, the location of the first VIA controller.
* The `SETTMO` call has been a no-op since the Commodore VIC-20, and has no function on the X16 either.
* The layout of the zero page ($0000-$00FF) and the KERNAL/BASIC variable space ($0200+) are generally **not** compatible with the C64.

### KERNAL Vectors

The KERNAL indirect vectors ($0314-$0333) are fully compatible with the C64:

$0314-$0315: `CINV` – IRQ Interrupt Routine  
$0316-$0317: `CBINV` – BRK Instruction Interrupt  
$0318-$0319: `NMINV` – Non-Maskable Interrupt  
$031A-$031B: `IOPEN` – Kernal OPEN Routine  
$031C-$031D: `ICLOSE` – Kernal CLOSE Routine  
$031E-$031F: `ICHKIN` – Kernal CHKIN Routine  
$0320-$0321: `ICKOUT` – Kernal CKOUT Routine  
$0322-$0323: `ICLRCH` – Kernal CLRCHN Routine  
$0324-$0325: `IBASIN` – Kernal CHRIN Routine  
$0326-$0327: `IBSOUT` – Kernal CHROUT Routine  
$0328-$0329: `ISTOP` – Kernal STOP Routine  
$032A-$032B: `IGETIN` – Kernal GETIN Routine  
$032C-$032D: `ICLALL` – Kernal CLALL Routine  
$0330-$0331: `ILOAD` – Kernal LOAD Routine  
$0332-$0333: `ISAVE` – Kernal SAVE Routine  

Additional KERNAL indirect vectors have been added as part of the KERNAL's 65C816 support

$0334-$0335: `IECOP` - COP Instruction Interrupt Routine (emulation mode)  
$0336-$0337: `IEABORT` - ABORT Routine (emulation mode)  
$0338-$0339: `INIRQ` - IRQ Interrupt Routine (native mode)  
$033A-$033B: `INBRK` - BRK Instruction Interrupt Routine (native mode)  
$033C-$033D: `INNMI` - Non-Maskable Interrupt Routine (native mode)  
$033E-$033F: `INCOP` - COP Instruction Interrupt Routine (native mode)  
$0340-$0341: `INABORT` - ABORT Routine (native mode)  

#### Handling NMI

If the NMI vector is replaced with a user function and that function does not call 
back to the replaced NMI routine, some cleanup will need to be done. Before the user
NMI function is called, the KERNAL pushes `a` and the rom bank onto the stack. These
values will need to be popped before returning from the NMI:

```
.proc my_awesome_nmi
        ...

	pla
	sta $01
	pla
	rti
.endproc
```

---

### Commodore Peripheral Bus

The X16 adds two new functions for dealing with the Commodore Peripheral Bus ("IEEE"):

$FEB1: `MCIOUT` - write multiple bytes to peripheral bus
$FF44: `MACPTR` - read multiple bytes from peripheral bus

---

#### Function Name: ACPTR

Purpose: Read a byte from the peripheral bus  
Call address: $FFA5  
Communication registers: .A  
Preparatory routines: `SETNAM`, `SETLFS`, `OPEN`, `CHKIN`  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** This routine gets a byte of data off the peripheral bus. The data is returned in the accumulator.  Errors are returned in the status word which can be read via the `READST` API call.

---

#### Function Name: MACPTR

Purpose: Read multiple bytes from the peripheral bus  
Call address: $FF44  
Communication registers: .A .X .Y c  
Preparatory routines: `SETNAM`, `SETLFS`, `OPEN`, `CHKIN`  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `MACPTR` is the multi-byte variant of the `ACPTR` KERNAL routine. Instead of returning a single byte in .A, it can read multiple bytes in one call and write them directly to memory.

The number of bytes to be read is passed in the .A register; a value of 0 indicates that it is up to the KERNAL to decide how many bytes to read - up to a maximum of 512 bytes (this corresponds to 1 sector on the SD card). A pointer to where the data is supposed to be written is passed in the .X (lo) and .Y (hi) registers. If carry flag is clear, the destination address will advance with each byte read. If the carry flag is set, the destination address will not advance as data is read. This is useful for reading data directly into VRAM, PCM FIFO, etc.

For reading into Hi RAM, you must set the desired bank prior to calling `MACPTR`. During the read, `MACPTR` will automatically wrap to the next bank as required, leaving the new bank active when finished.

Upon return, a set c flag indicates that the device or file does not support `MACPTR`, and the program needs to read the data byte-by-byte using the `ACPTR` call instead.

If `MACPTR` is supported, c is clear and .X (lo) and .Y (hi) contain the number of bytes read.
*It is possible that this is less than the number of bytes requested to be read! (But is always greater than 0)*

Like with `ACPTR`, the status of the operation can be retrieved using the `READST` KERNAL call.

---

#### Function Name: MCIOUT

Purpose: Write multiple bytes to the peripheral bus  
Call address: $FEB1  
Communication registers: .A .X .Y c  
Preparatory routines: `SETNAM`, `SETLFS`, `OPEN`, `CHKOUT`  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `MCIOUT` is the multi-byte variant of the `CIOUT` KERNAL routine. Instead of writing a single byte, it can write multiple bytes from memory in one call.

The number of bytes to be written is passed in the .A register; a value of 0 indicates 256 bytes. A pointer to the data to be read from is passed in the .X (lo) and .Y (hi) registers. If carry flag is clear, the source address will advance with each byte read out. If the carry flag is set, the source address will not advance as data is read out. This is useful for saving data directly from VRAM.

For reading from Hi RAM, you must set the desired bank prior to calling `MCIOUT`. During the operation, `MCIOUT` will automatically wrap to the next bank as required, leaving the new bank active when finished.

Upon return, a set c flag indicates that the device or file does not support `MCIOUT`, and the program needs to write the data byte-by-byte using the `CIOUT` call instead.

If `MCIOUT` is supported, c is clear and .X (lo) and .Y (hi) contain the number of bytes written.
*It is possible that this is less than the number of bytes requested to be written! (But is always greater than 0)*

Like with `CIOUT`, the status of the operation can be retrieved using the `READST` KERNAL call.  If an error occurred, `READST` should return nonzero.

---

### Channel I/O

---

#### Function Name: `BSAVE`

Purpose: Save an area of memory to a file without writing an address header.  
Call Address: $FEBA  
Communication Registers: .A .X .Y  
Preparatory routines: SETNAM, SETLFS  
Error returns: c = 0 if no error, c = 1 in case of error and A will contain kernel error code  
Registers affected: .A .X .Y .P  

**Description:** Save the contents of a memory range to a file.  Unlike `SAVE`, this call does not write the start address to the beginning of the output file.

`SETLFS` and `SETNAM` must be called beforehand.  
A is address of zero page pointer to the start address.  
X and Y contain the _exclusive_ end address to save. That is, these should contain the address immediately after the final byte:  X = low byte, Y = high byte.  
Upon return, if C is clear, there were no errors.  C being set indicates an error in which case A will have the error number.  

---

#### Function Name: `BSOUT`

(This routine is also referred to as `CHROUT`)  

Purpose: Write a character to the default output device.  
Call Address: $FFD2  
Communication Register: .A  
Preparatory routines: OPEN, CHKOUT (Both are only needed when sending to files/other non-screen devices)  
Error returns: c = 0 if no error, c = 1 in case of error  
Registers affected: .P  

**Description:** Writes the character in A to the currently-selected output device. By default, this is the user's screen. By calling `CHKOUT`, however, the default device can be changed and characters can be sent to other devices - a file on an SD card, for example. In order to send output to a file, call `OPEN` first to open the file, then `CHKOUT` to set it as the default output device, then finally `BSOUT` to write the data.  

Upon return, if C is clear, there were no errors. Otherwise, C will be set.  

**Note:** Before returning, this routine uses a `CLI` processor instruction, which will allow IRQ interrupts to be triggered. This makes the `BSOUT` routine inappropriate for use within interrupt handler functions. One possible workaround could be to output text information directly, by writing to the appropriate VERA registers. Care must be taken to save and restore the VERA's state, however, in order to prevent affecting other software running on the system (to include BASIC or the KERNAL itself).  

---

#### Function Name: `CLOSE`

Purpose: Close a logical file  
Call address: $FFC3  
Communication registers: .A  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** `CLOSE` releases resources associated with a logical file number.  If the associated device is a serial device on the IEC bus or is a simulated serial device such as CMDR-DOS backed by the X16 SD card, and the file was opened with a secondary address, a close command is sent to the device or to CMDR-DOS.  

---

#### Function Name: `CHKIN`

Purpose: Set file to be used for character input
Call address: $FFC6
Communication registers: .X
Preparatory routines: OPEN  
Error returns: None  
Registers affected: .A .X

**Description:** `CHKIN` sets a file to be used as default input allowing for
subsequent calls to `CHRIN` or other file read functions. The `x` register
should contain the logical file number. `OPEN` will need to have been called prior to using `CHKIN`.

---

#### Function Name: `LOAD`

Purpose: Load the contents of a file from disk to memory  
Call address: $FFD5  
Communication registers: .A .X .Y  
Preparatory routines: SETNAM, SETLFS  
Error returns: Carry (Set on Error), .A  
Registers affected: .A .X .Y .P  

**Description:** Loads a file from disk to memory.

The behavior of `LOAD` can be modified by parameters passed to prior call to `SETLFS`.  In particular, the .Y register, which usually denotes the _secondary address_, has a specific meaning as follows:

* .Y = 0: load to the address given in .X/.Y to the `LOAD` call, skipping the first two bytes of the file. (like `LOAD "FILE",8` in BASIC)
* .Y = 1: load to the address given by the first two bytes of the file. The address in .X/.Y is ignored. (like `LOAD "FILE",8,1` in BASIC)
* .Y = 2: load the entire file to the address given in .X/.Y to the `LOAD` call. This is also known as a _headerless_ load. (like `BLOAD "FILE",8,1,$A000` in BASIC)

For the `LOAD` call itself, .X and .Y is the memory address to load
the file into. .A controls where the file is to be loaded. On the X16, `LOAD` has an
additional feature to load the contents of a file directly into VRAM.

* If the A register is zero, the kernal loads into system memory.
* If the A register is 1, the kernal performs a verify.
* If the A register is 2, the kernal loads into VRAM, starting from $00000 + the specified starting address.
* If the A register is 3, the kernal loads into VRAM, starting from $10000 + the specified starting address.

(On the C64, if A is greater than or equal to 1, the kernal performs a verify)

For loads into the banked RAM area. The current RAM bank (in location `$00`) is used as the start point for the load along with the supplied address. If the load is large enough to advance to the end of banked RAM (`$BFFF`), the RAM bank is automatically advanced, and the load continues into the next bank starting at `$A000`.

After the load, if c is set, an error occurred and .A will contain the error code. If c is clear, .X/.Y will point to the address of final byte loaded + 1.

Note: One does not need to call `CLOSE` after `LOAD`.

---

#### Function Name: `OPEN`

Purpose: Opens a channel/file  
Call address: $FFC0  
Communication registers: None  
Preparatory routines: SETNAM, SETLFS  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** Opens a file or channel.  
The most common pattern is to then redirect the standard input or output to the file using `CHKIN` or `CHKOUT` respectively. Afterwards, I/O from or to the file or channel is done using `BASIN` (`CHRIN`) and `BSOUT` (`CHROUT`) respectively.

For file I/O, the lower level calls `ACPTR` and `MACPTR` can be used in place of `CHRIN`, since `CHKIN` does the low-level setup for this.  Likewise `CIOUT` and `MCIOUT` can be used after `CHKOUT` for the same reason.

---

#### Function Name: `SAVE`

Purpose: Save an area of memory to a file.  
Call Address: $FFD8  
Communication Registers: .A .X .Y  
Preparatory routines: SETNAM, SETLFS  
Error returns: c = 0 if no error, c = 1 in case of error and A will contain kernel error code  
Registers affected: .A .X .Y .P  

**Description:** Save the contents of a memory range to a file. The (little-endian) start address is written to the file as the first two bytes of output, followed by the requested data.

`SETLFS` and `SETNAM` must be called beforehand.  
A is address of zero page pointer to start address.  
X = low byte of end address + 1, Y = high byte of end address.  
If C is zero there were no errors; 1 is an error in which case A will have the error  

---

#### Function Name: `SETLFS`

Purpose: Set file parameters  
Call Address: $FFBA  
Communication Registers: .A .X .Y  
Preparatory routines: SETNAM  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** Set file parameters typically after calling SETNAM

A is the logical file number, X is the device number, and Y is the secondary address.

Since multiple files can be open (with some exceptions), the value of A specifies the file
number. If only one file is being opened at a time, $01 can be used.

The device number corresponds to the hardware device where the file lives. On the X16,
$08 would be the SD card.

The secondary address has some special meanings:  

When used with `OPEN` on disk type devices, the following applies:  

* 0 = Load (open for read)
* 1 = Save (open for write)
* 2-14 = Read mode, by default. Write, Append, and Modify modes can be specified in the SETNAM filename string as the third argument, e.g. `"FILE.DAT,S,W"` for write mode. The seek command "P" is available in any mode.
* 15 = Command Channel (for sending special commands to CMDR-DOS or the disk device)

When used with `LOAD` the following applies:

* 0 = Load the data to address specified in the X and Y register of the LOAD call, regardless of the address header. The two-byte header itself is not loaded into RAM.
* 1 = Load to the address specified in the file's header. The two-byte header itself is not loaded into RAM.
* 2 = Load the data to address specified in the X and Y register of the LOAD call. The entire file is loaded ("headerless").

For more information see [Chapter 13: Working with CMDR-DOS](X16%20Reference%20-%2013%20-%20Working%20with%20CMDR-DOS.md#chapter-13-working-with-cmdr-dos)

---

#### Function Name: `SETNAM`

Purpose: Set file name  
Call Address: $FFBD  
Communication Registers: .A .X .Y  
Preparatory routines: SETLFS  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** Inform the kernal the name of the file that is to later be opened.
 A is filename length, X is low byte of filename pointer, Y is high byte of filename pointer.

For example:

```asm
  lda #$08
  ldx #<filename
  ldy #>filename
  jsr SETNAM
```

`SETLFS` and `SETNAM` both need to be called prior other file comamnds, such as `OPEN` or
`SAVE`.

---

### Memory

$FEE4: `memory_fill` - fill memory region with a byte value  
$FEE7: `memory_copy` - copy memory region  
$FEEA: `memory_crc` - calculate CRC16 of memory region  
$FEED: `memory_decompress` - decompress LZSA2 block  
$FF74: `fetch` - read a byte from any RAM or ROM bank  
$FF77: `stash` - write a byte to any RAM bank
$FF99: `MEMTOP` - get number of banks and address of end of usable RAM

<!---
*** undocumented - we might remove it
$FF7A: `cmpare` - compare a byte on any RAM or ROM bank
--->
---

#### Function Name: memory_fill

Signature: void memory_fill(word address: r0, word num_bytes: r1, byte value: .A);  
Purpose: Fill a memory region with a byte value.  
Call address: $FEE4

**Description:** This function fills the memory region specified by an address (r0) and a size in bytes (r1) with the constant byte value passed in .A. r0 and .A are preserved, r1 is destroyed.

If the target address is in the $9F00-$9FFF range, all bytes will be written to the same address (r0), i.e. the address will not be incremented. This is useful for filling VERA memory ($9F23 or $9F24), for example.

---

#### Function Name: memory_copy

Signature: void memory_copy(word source: r0, word target: r1, word num_bytes: r2);  
Purpose: Copy a memory region to a different region.  
Call address: $FEE7

**Description:** This function copies one memory region specified by an address (r0) and a size in bytes (r2) to a different region specified by its start address (r1). The two regions may overlap. r0 and r1 are preserved, r2 is destroyed.

Like with `memory_fill`, source and destination addresses in the $9F00-$9FFF range will not be incremented during the copy. This allows, for instance, uploading data from RAM to VERA (destination of $9F23 or $9F24), downloading data from VERA (source $9F23 or $9F24) or copying data inside VERA (source $9F23, destination $9F24). This functionality can also be used to upload, download or transfer data with other I/O devices that have an 8 bit data port.

---

#### Function Name: memory_crc

Signature: (word result: r2) memory_crc(word address: r0, word num_bytes: r1);  
Purpose: Calculate the CRC16 of a memory region.  
Call address: $FEEA

**Description:** This function calculates the CRC16 checksum of the memory region specified by an address (r0) and a size in bytes (r1). The result is returned in r2. r0 is preserved, r1 is destroyed.

Like `memory_fill`, this function does not increment the address if it is in the range of $9F00-$9FFF, which allows checksumming VERA memory or data streamed from any other I/O device.

---

#### Function Name: memory_decompress

Signature: void memory_decompress(word input: r0, inout word output: r1);  
Purpose: Decompress an LZSA2 block  
Call address: $FEED

**Description:** This function decompresses an LZSA2-compressed data block from the location passed in r0 and outputs the decompressed data at the location passed in r1. After the call, r1 will be updated with the location of the last output byte plus one.

If the target address is in the $9F00-$9FFF range, all bytes will be written to the same address (r0), i.e. the address will not be incremented. This is useful for decompressing directly into VERA memory ($9F23 or $9F24), for example. Note that decompressing _from_ I/O is not supported.

**Notes**:

* To create compressed data, use the `lzsa` tool[^1] like this:
`lzsa -r -f2 <original_file> <compressed_file>`
* If using the LZSA library to compress data, make sure to use format 2 and include the raw blocks flag, which is what the above command does.
* This function cannot be used to decompress data in-place, as the output data would overwrite the input data before it is consumed. Therefore, make sure to load the input data to a different location.
* It is possible to have the input data stored in banked RAM, with the obvious 8 KB size restriction.

---

#### Function Name: fetch

Purpose: Read a byte from any RAM or ROM bank  
Call address: $FF74  
Communication registers: .A .X .Y .P  

**Description:** This function performs an `LDA (ZP),Y` from any RAM or ROM bank. The the zero page address containing the base address is passed in .A, the bank in .X and the offset from the vector in .Y. The data byte is returned in .A. The flags are set according to .A, .X is destroyed, but .Y is preserved.

---

#### Function Name: stash

Purpose: Write a byte to any RAM bank  
Call address: $FF77  
Communication registers: .A .X .Y  

**Description:** This function performs an `STA (ZP),Y` to any RAM bank. The the zero page address containing the base address is passed in `stavec` ($03B2), the bank in .X and the offset from the vector in .Y. After the call, .X is destroyed, but .A and .Y are preserved.

---

#### Function Name: MEMTOP

Purpose: Get/Set top of RAM, number of usable RAM banks.  
Call address: $FF99  
Communication registers: .A .X .Y .P (Carry)  
Registers affected: .A .X .Y  

**Description:** Original C64 function which gets or
sets the top of the usable address in RAM. On the X16,
it additionally provides the number of RAM banks
available on the system and can even be used to set
this value after boot if desired.

To set the top of RAM, and the number of available banks, clear the carry flag.

To get the top of RAM and the number of available
banks, set carry flag.

Note that the number of RAM banks is for informational
purposes or for use by other programs. The KERNAL
does not use this value itself.

**Getting the number of usable RAM banks:**

On the X16, calling MEMTOP with the carry flag set
will return the number of available RAM banks on
the system in A. For example:

```asm
  sec
  jsr MEMTOP
  sta zp_NUM_BANKS
```

If the system has 512k of banked RAM, zp_NUM_BANKS
will contain $40 (64). For 1024k, $80; for 1536k, $C0.
For 2048k, the result will be $00 (which can be thought
of as $100, or 256). It is possible to have other
values (e.g. $42), such as if the system has bad
banked RAM.

**Setting the top of BASIC RAM**

This routine changes the top of memory, allowing you to save a small machine
language routine at the top of BASIC RAM, just below the I/O space:

```BASIC
10 POKE$30F,1:SYS$FF99
20 Y=$8C:X=$00
30 POKE$30D,X:POKE$30E,Y:POKE$30F,0:SYS$FF99
40 CLR
```

Analysis: 

The SYS command uses memory locations $30C-$30F to pre-load the CPU registers,
it then dumps the registers back to these locations after the SYS call is
complete. $30D is the X register, $30E is .Y, and $30F is the flags. The Carry
flag is bit 0, so setting $30F to 1 before calling MEMTOP indicates that this is
a _read_ of the values. 

1. Line 10 reads the current values. Do this to preserve the extended RAM bank
   count.
2. Line 20 uses the X and Y variables to make the code easier to read. Set Y to
   the high byte of the address and X to the low byte. 
3. Line 30 POKEs those values in, clears the Carry bit ($30F is now 0), and
   calls MEMTOP again.
4. Finally, use CLR to lock in the new values. Since this clears all the
   variables, you should _probably_ do this at the top of your program.

The address entered is actually the first byte of free space _after_
your BASIC program space, so if you set MEMTOP to $9C00, then you can start your
assembly program at $9C00 with `* = $9C00` or `org $9c00`.

To reserve 256 bytes, set X to $9E. To reserve 1KB, set X to $9C. To return to
the default values, set Y=$9F and X=0.

---

### Clock

$FF4D: `clock_set_date_time` - set date and time  
$FF50: `clock_get_date_time` - get date and time  

---

#### Function Name: clock_set_date_time

Purpose: Set the date and time  
Call address: $FF4D  
Communication registers: r0 r1 r2 r3  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `clock_set_date_time` sets the system's real-time-clock.

| Register | Contents          |
|----------|-------------------|
| r0L      | year (1900-based) |
| r0H      | month (1-12)      |
| r1L      | day (1-31)        |
| r1H      | hours (0-23)      |
| r2L      | minutes (0-59)    |
| r2H      | seconds (0-59)    |
| r3L      | jiffies (0-59)    |
| r3H      | weekday (1-7)     |

Jiffies are 1/60th seconds.

---

#### Function Name: clock_get_date_time

Purpose: Get the date and time  
Call address: $FF50  
Communication registers: r0 r1 r2 r3  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `clock_get_date_time` returns the state of the system's real-time-clock. The register assignment is identical to `clock_set_date_time`.

On the Commander X16, the _jiffies_ field is unsupported and will always read back as 0.

---

#### Function Name: RDTIM

Purpose: Read system clock  
Call address: $FFDE  
Communication registers: .A .X .Y  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** Original C64 function which reads the system clock.  The clock's resolution is a 60th of a second.  Three bytes are returned by the routine.  The accumulator contains the least significant byte, the X index register contains the next most significant byte, and the Y index register contains the the most significant byte.

The behavior of this Kernal routine is the same on the X16 and C64 despite errors in the _Commodore 64 Programmer's Reference Guide_ and some other period books which incorrectly describe the order/significance of the resulting bytes in the registers.

**EXAMPLE**:

```ASM
jsr RDTIM
sta STARTTIME    ; least significant byte
stx STARTTIME+1
sty STARTTIME+2  ; most significant byte
```

---

### Keyboard

$FEBD: `kbdbuf_peek` - get first char in keyboard queue and queue length  
$FEC0: `kbdbuf_get_modifiers` - get currently pressed modifiers  
$FEC3: `kbdbuf_put` - append a char to the keyboard queue  
$FED2: `keymap` - set or get the current keyboard layout

---

#### Function Name: kbdbuf_peek

Purpose: Get next char and keyboard queue length  
Call address: $FEBD  
Communication registers: .A .X  
Preparatory routines: None  
Error returns: None  
Registers affected: -  

**Description:** The routine `kbdbuf_peek` returns the next character in the keyboard queue in .A, without removing it from the queue, and the current length of the queue in .X. If .X is 0, the Z flag will be set, and the value of .A is undefined.

---

#### Function Name: kbdbuf_get_modifiers

Purpose: Get currently pressed modifiers  
Call address: $FEC0  
Communication registers: .A  
Preparatory routines: None  
Error returns: None  
Registers affected: -  

**Description:** The routine `kbdbuf_get_modifiers` returns a bitmask that represents the currently pressed modifier keys in .A:

| Bit | Value | Description  | Comment        |
|-----|-------|--------------|----------------|
| 0   | 1     | Shift        |                |
| 1   | 2     | Alt          | C64: Commodore |
| 2   | 4     | Control      |                |
| 3   | 8     | Logo/Windows | C128: Alt      |
| 4   | 16    | Caps         |                |

This allows detecting combinations of a regular key and a modifier key in cases where there is no dedicated PETSCII code for the combination, e.g. Ctrl+Esc or Alt+F1.

---

#### Function Name: kbdbuf_put

Purpose: Append a char to the keyboard queue  
Call address: $FEC3  
Communication registers: .A  
Preparatory routines: None  
Error returns: None  
Registers affected: .X  

**Description:** The routine `kbdbuf_put` appends the char in .A to the keyboard queue.

---

#### Function Name: keymap

Purpose: Set or get the current keyboard layout
Call address: $FED2  
Communication registers: .X .Y  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: -  

**Description:** If c is set, the routine `keymap` returns a pointer to a zero-terminated string with the current keyboard layout identifier in .X/.Y. If c is clear, it sets the keyboard layout to the zero-terminated identifier pointed to by .X/.Y. On return, c is set in case the keyboard layout is unsupported.

Keyboard layout identifiers are in the form "DE", "DE-CH" etc.

---

#### Function Name: kbd_scan

Also Known As: SCNKEY  
Purpose: Read a keycode previously fetched from the SMC, apply keymap localization, and add it to the X16's buffer.  
Call address: $FF9F  
Communication registers: None  
Preparatory routines: `ps2data_fetch`  
Error returns: None  
Registers affected: .A .X .Y  

**Description:**

This routine is called by the default KERNAL IRQ hancler in order to process a keystroke previously fetched by `ps2data_fetch`, translate it to the appropriate localized PETSCII or ISO code based on the configured layout, and place it in the KERNAL's keyboard buffer.

Unless the KERNAL IRQ handler is being bypassed or supplemented, it is not normally necessary to call this routine from user code, as both `ps2data_fetch` and `kbd_scan` are both run inside the default IRQ handler.  

---

### Mouse

$FF68: `mouse_config` - configure mouse pointer  
$FF71: `mouse_scan` - query mouse  
$FF6B: `mouse_get` - get state of mouse

---

#### Function Name: mouse_config

Purpose: Configure the mouse pointer  
Call address: $FF68  
Communication registers: .A .X .Y  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `mouse_config` configures the mouse pointer.

The argument in .A specifies whether the mouse pointer should be visible or not, and what shape it should have. For a list of possible values, see the basic statement `MOUSE`.

The arguments in .X and .Y specify the screen resolution in 8 pixel increments. The values .X = 0 and .Y = 0 keep the current resolution.

**EXAMPLE:**

 SEC
 JSR screen_mode ; get current screen size (in 8px) into .X and .Y
 LDA #1
 JSR mouse_config ; show the default mouse pointer

---

#### Function Name: mouse_scan

Purpose: Query the mouse and save its state  
Call address: $FF71  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `mouse_scan` retrieves all state from the mouse and saves it. It can then be retrieved using `mouse_get`. The default interrupt handler already takes care of this, so this routine should only be called if the interrupt handler has been completely replaced.

---

#### Function Name: mouse_get

Purpose: Get the mouse state  
Call address: $FF6B  
Communication registers: .X  
Preparatory routines: `mouse_config`  
Error returns: None  
Registers affected: .A .X  

**Description:** The routine `mouse_get` returns the state of the mouse. The caller passes the offset of a zero-page location in .X, which the routine will populate with the mouse position in 4 consecutive bytes:

| Offset | Size | Description |
|--------|------|-------------|
| 0      | 2    | X Position  |
| 2      | 2    | Y Position  |

The state of the mouse buttons is returned in the .A register:

| Bit | Description    |
|-----|----------------|
| 0   | Left Button    |
| 1   | Right Button   |
| 2   | Middle Button  |
| 3   | Unused         |
| 4   | Button 4       |
| 5   | Button 5       |

If a button is pressed, the corresponding bit is set. Buttons 4 and 5 are extended buttons not supported by all mice.

If available, the movement of the scroll wheel since the last call to this function is returned in the .X register as an 8-bit signed value. Moving the scroll wheel away from the user is represented
by a negative value, and moving it towards the user is represented by a positive value. If the connected mouse has no scroll wheel, the value 0 is returned in the .X register.

**EXAMPLE:**

```ASM
LDX #$70
JSR mouse_get ; get mouse position in $70/$71 (X) and $72/$73 (Y)
AND #1
BNE BUTTON_PRESSED
```

---

### Joystick

$FF53: `joystick_scan` - query joysticks  
$FF56: `joystick_get` - get state of one joystick

---

#### Function Name: joystick_scan

Purpose: Query the joysticks and save their state  
Call address: $FF53  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `joystick_scan` retrieves all state from the four joysticks and saves it. It can then be retrieved using `joystick_get`. The default interrupt handler already takes care of this, so this routine should only be called if the interrupt handler has been completely replaced.

---

#### Function Name: joystick_get

Purpose: Get the state of one of the joysticks  
Call address: $FF56  
Communication registers: .A  
Preparatory routines: `joystick_scan`  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** The routine `joystick_get` retrieves all state from one of the joysticks. The number of the joystick is passed in .A (0 for the keyboard joystick and 1 through 4 for SNES controllers), and the state is returned in .A, .X and .Y.

```ASM
      .A, byte 0:      | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
                  SNES | B | Y |SEL|STA|UP |DN |LT |RT |

      .X, byte 1:      | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
                  SNES | A | X | L | R | 1 | 1 | 1 | 1 |
      .Y, byte 2:
                  $00 = joystick present
                  $FF = joystick not present
```

If a button is pressed, the corresponding bit is zero.

(With a dedicated handler, the API can also be used for other devices with an SNES controller connector. The data returned in .A/.X/Y is just the raw 24 bits returned by the device.)

The keyboard joystick uses the standard SNES9X/ZSNES mapping:

| SNES Button    |Keyboard Key  | Alt. Keyboard Key |
|----------------|--------------|-------------------|
| A              | X            | Left Ctrl         |
| B              | Z            | Left Alt          |
| X              | S            |                   |
| Y              | A            |                   |
| L              | D            |                   |
| R              | C            |                   |
| START          | Enter        |                   |
| SELECT         | Left Shift   |                   |
| D-Pad          | Cursor Keys  |                   |

Note that the keyboard joystick will allow LEFT and RIGHT as well as UP and DOWN to be pressed at the same time, while controllers usually prevent this mechanically.

**How to Use:**

If the default interrupt handler is used:

1) Call this routine.

If the default interrupt handler is disabled or replaced:

1) Call `joystick_scan` to have the system query the joysticks.
2) Call this routine.

**EXAMPLE:**

```ASM
      JSR joystick_scan
      LDA #0
      JSR joystick_get
      TXA
      AND #128
      BEQ A_PRESSED
```

---

### I2C

$FEB4: `i2c_batch_read` - read multiple bytes from an I2C device  
$FEB7: `i2c_batch_write` - write multiple bytes to an I2C device  
$FEC6: `i2c_read_byte` - read a byte from an I2C device  
$FEC9: `i2c_write_byte` - write a byte to an I2C device

---

#### Function Name: i2c_batch_read

Purpose: Read bytes from a given I2C device into a RAM location  
Call address: $FEB4  
Communication registers: .X r0 r1 c  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: .A .Y .P  

**Description:** The routine `i2c_batch_read` reads a fixed number of bytes from an I2C device into RAM.  To call, put I2C device (address) in .X, the pointer to the RAM location to which to place the data into r0, and the number of bytes to read into r1.  If carry is set, the RAM location isn't advanced.  This might be useful if you're reading from an I2C device and writing directly into VRAM.

If the routine encountered an error, carry will be set upon return.

**EXAMPLE:**

```ASM
ldx #$50 ; One of the cartridge I2C flash devices
lda #<$0400
sta r0
lda #>$0400
sta r0+1
lda #<500
sta r1
lda #>500
sta r1+1
clc
jsr i2c_batch_read ; read 500 bytes from I2C device $50 into RAM starting at $0400
```

---

#### Function Name: i2c_batch_write

Purpose: Write bytes to a given I2C device with data in RAM  
Call address: $FEB7  
Communication registers: .X r0 r1 r2 c  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: .A .Y .P r2  

**Description:** The routine `i2c_batch_write` writes a fixed number of bytes from RAM to an I2C device.  To call, put I2C device (address) in .X, the pointer to the RAM location from which to read into r0, and the number of bytes to write into r1.  If carry is set, the RAM location isn't advanced.  This might be useful if you're reading from an I/O device and writing that data to an I2C device.

The number of bytes written is returned in r2. If the routine encountered an error, carry will be set upon return.

**EXAMPLE:**

```ASM
ldx #$50 ; One of the cartridge I2C flash devices
lda #<$0400
sta r0
lda #>$0400
sta r0+1
lda #<500
sta r1
lda #>500
sta r1+1
clc
jsr i2c_batch_write ; write 500 bytes to I2C device $50 from RAM
                    ; starting at $0400 
                    ; for this example, the first two bytes in
                    ; the $0400 buffer would be the target address
                    ; in the I2C flash. This, of course, varies
                    ; between various I2C device types.
```

---

#### Function Name: i2c_read_byte

Purpose: Read a byte at a given offset from a given I2C device  
Call address: $FEC6  
Communication registers: .A .X .Y  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: .A  

**Description:** The routine `i2c_read_byte` reads a single byte at offset .Y from I2C device .X and returns the result in .A. c is 0 if the read was successful, and 1 if no such device exists.

**EXAMPLE:**

```ASM
LDX #$6F ; RTC device
LDY #$20 ; start of NVRAM inside RTC
JSR i2c_read_byte ; read first byte of NVRAM
```

---

#### Function Name: i2c_write_byte

Purpose: Write a byte at a given offset to a given I2C device  
Call address: $FEC9  
Communication registers: .A .X .Y  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: .A .P  

**Description:** The routine `i2c_write_byte` writes the byte in .A at offset .Y of I2C device .X. c is 0 if the write was successful, and 1 if no such device exists.

**EXAMPLES:**

```ASM
LDX #$6F ; RTC device
LDY #$20 ; start of NVRAM inside RTC
LDA #'X'
JSR i2c_write_byte ; write first byte of NVRAM

LDX #$42 ; System Management Controller
LDY #$01 ; magic location for system poweroff
LDA #$00 ; magic value for system poweroff
JSR i2c_write_byte ; power off the system

; Reset system at the end of your program
LDX #$42  ; System Management Controller
LDY #$02  ; magic location for system reset
LDA #$00  ; magic value for system poweroff/reset
JSR $FEC9 ; reset the computer
```

---

### Sprites

$FEF0: `sprite_set_image` - set the image of a sprite  
$FEF3: `sprite_set_position` - set the position of a sprite

---

#### Function Name: sprite_set_image

Purpose: Set the image of a sprite  
Call address: $FEF0  
Signature: bool sprite_set_image(byte number: .A, width: .X, height: .Y, apply_mask: c, word pixels: r0, word mask: r1, byte bpp: r2L);  
Error returns: c = 1 in case of error

**Description:** This function sets the image of a sprite. The number of the sprite is given in .A, The bits per pixel (bpp) in r2L, and the width and height in .X and .Y. The pixel data at r0 is interpreted accordingly and converted into the graphics hardware's native format. If the c flag is set, the transparency mask pointed to by r1 is applied during the conversion. The function returns c = 0 if converting the data was successful, and c = 1 otherwise. Note that this does not change the visibility of the sprite.

**Note**: There are certain limitations on the possible values of width, height, bpp and apply_mask:

* width and height may not exceed the hardware's capabilities.
* Legal values for bpp are 1, 4 and 8. If the hardware only supports lower depths, the image data is converted down.
* apply_mask is only valid for 1 bpp data.

---

#### Function Name: sprite_set_position

Purpose: Set the position of a sprite or hide it.  
Call address: $FEF3  
Signature: void sprite_set_position(byte number: .A, word x: r0, word y: r1);  
Error returns: None

**Description:** This function shows a given sprite (.A) at a certain position or hides it. The position is passed in r0 and r1. If the x position is negative (&gt;$8000), the sprite will be hidden.

**Note**: This routine only supports setting the position for sprite numbers 0-31.

---

### Framebuffer

The framebuffer API is a low-level graphics API that completely abstracts the framebuffer by exposing a minimal set of high-performance functions. It is useful as an abstraction and as a convenience library for applications that need high performance framebuffer access.

```asm
$FEF6: `FB_init` - enable graphics mode  
$FEF9: `FB_get_info` - get screen size and color depth  
$FEFC: `FB_set_palette` - set (parts of) the palette  
$FEFF: `FB_cursor_position` - position the direct-access cursor  
$FF02: `FB_cursor_next_line` - move direct-access cursor to next line  
$FF05: `FB_get_pixel` - read one pixel, update cursor  
$FF08: `FB_get_pixels` - copy pixels into RAM, update cursor  
$FF0B: `FB_set_pixel` - set one pixel, update cursor  
$FF0E: `FB_set_pixels` - copy pixels from RAM, update cursor  
$FF11: `FB_set_8_pixels` - set 8 pixels from bit mask (transparent), update cursor  
$FF14: `FB_set_8_pixels_opaque` - set 8 pixels from bit mask (opaque), update cursor  
$FF17: `FB_fill_pixels` - fill pixels with constant color, update cursor  
$FF1A: `FB_filter_pixels` - apply transform to pixels, update cursor  
$FF1D: `FB_move_pixels` - copy horizontally consecutive pixels to a different position
```

All calls are vectored, which allows installing a replacement framebuffer driver.

```asm
$02E4: I_FB_init  
$02E6: I_FB_get_info  
$02E8: I_FB_set_palette  
$02EA: I_FB_cursor_position  
$02EC: I_FB_cursor_next_line  
$02EE: I_FB_get_pixel  
$02F0: I_FB_get_pixels  
$02F2: I_FB_set_pixel  
$02F4: I_FB_set_pixels  
$02F6: I_FB_set_8_pixels  
$02F8: I_FB_set_8_pixels_opaque  
$02FA: I_FB_fill_pixels  
$02FC: I_FB_filter_pixels  
$02FE: I_FB_move_pixels
```

The model of this API is based on the direct-access cursor. In order to read and write pixels, the cursor has to be set to a specific x/y-location, and all subsequent calls will access consecutive pixels at the cursor position and update the cursor.

The default driver supports the VERA framebuffer at a resolution of 320x200 pixels and 256 colors. Using `screen_mode` to set mode $80 will enable this driver.

---

#### Function Name: FB_init

Signature: void FB_init();  
Purpose: Enter graphics mode.

---

#### Function Name: FB_get_info

Signature: void FB_get_info(out word width: r0, out word height: r1, out byte color_depth: .A);  
Purpose: Return the resolution and color depth

---

#### Function Name: FB_set_palette

Signature: void FB_set_palette(word pointer: r0, index: .A, color count: .X);  
Purpose: Set (parts of) the palette

**Description:** `FB_set_palette` copies color data from the address pointed to by r0, updates the color in VERA palette RAM starting at the index A, with the length of the update (in words) in X.  If X is 0, all 256 colors are copied (512 bytes)

---

#### Function Name: FB_cursor_position

Signature: void FB_cursor_position(word x: r0, word y: r1);  
Purpose: Position the direct-access cursor

**Description:** `FB_cursor_position` sets the direct-access cursor to the given screen coordinate. Future operations will access pixels at the cursor location and update the cursor.

---

#### Function Name: FB_cursor_next_line

Signature: void FB_cursor_next_line(word x: r0);  
Purpose: Move the direct-access cursor to next line

**Description:** `FB_cursor_next_line` increments the y position of the direct-access cursor, and sets the x position to the same one that was passed to the previous `FB_cursor_position` call. This is useful for drawing rectangular shapes, and faster than explicitly positioning the cursor.

---

#### Function Name: FB_get_pixel

Signature: byte FB_get_pixel();  
Purpose: Read one pixel, update cursor

---

#### Function Name: FB_get_pixels

Signature: void FB_get_pixels(word ptr: r0, word count: r1);  
Purpose: Copy pixels into RAM, update cursor

**Description:** This function copies pixels into an array in RAM. The array consists of one byte per pixel.

---

#### Function Name: FB_set_pixel

Signature: void FB_set_pixel(byte color: .A);  
Purpose: Set one pixel, update cursor

---

#### Function Name: FB_set_pixels

Signature: void FB_set_pixels(word ptr: r0, word count: r1);  
Purpose: Copy pixels from RAM, update cursor

**Description:** This function sets pixels from an array of pixels in RAM. The array consists of one byte per pixel.

---

#### Function Name: FB_set_8_pixels

Signature: void FB_set_8_pixels(byte pattern: .A, byte color: .X);  
Purpose: Set 8 pixels from bit mask (transparent), update cursor

**Description:** This function sets all 1-bits of the pattern to a given color and skips a pixel for every 0 bit. The order is MSB to LSB. The cursor will be moved by 8 pixels.

---

#### Function Name: FB_set_8_pixels_opaque

Signature: void FB_set_8_pixels_opaque(byte pattern: .A, byte mask: r0L, byte color1: .X, byte color2: .Y);  
Purpose: Set 8 pixels from bit mask (opaque), update cursor

**Description:** For every 1-bit in the mask, this function sets the pixel to color1 if the corresponding bit in the pattern is 1, and to color2 otherwise. For every 0-bit in the mask, it skips a pixel. The order is MSB to LSB. The cursor will be moved by 8 pixels.

---

#### Function Name: FB_fill_pixels

Signature: void FB_fill_pixels(word count: r0, word step: r1, byte color: .A);  
Purpose: Fill pixels with constant color, update cursor

**Description:** `FB_fill_pixels` sets pixels with a constant color. The argument `step` specifies the increment between pixels. A value of 0 or 1 will cause consecutive pixels to be set. Passing a `step` value of the screen width will set vertically adjacent pixels going top down. Smaller values allow drawing dotted horizontal lines, and multiples of the screen width allow drawing dotted vertical lines.

---

#### Function Name: FB_filter_pixels

Signature: void FB_filter_pixels(word ptr: r0, word count: r1);  
Purpose: Apply transform to pixels, update cursor

**Description:** This function allows modifying consecutive pixels. The function pointer will be called for every pixel, with the color in .A, and it needs to return the new color in .A.

---

#### Function Name: FB_move_pixels

Signature: void FB_move_pixels(word sx: r0, word sy: r1, word tx: r2, word ty: r3, word count: r4);  
Purpose: Copy horizontally consecutive pixels to a different position

*[Note: Overlapping regions are not yet supported.]*

---

### Graphics

The high-level graphics API exposes a set of standard functions. It allows applications to easily perform some common high-level actions like drawing lines, rectangles and images, as well as moving parts of the screen. All commands are completely implemented on top of the framebuffer API, that is, they will continue working after replacing the framebuffer driver with one that supports a different resolution, color depth or even graphics device.

$FF20: `GRAPH_init` - initialize graphics  
$FF23: `GRAPH_clear` - clear screen  
$FF26: `GRAPH_set_window` - set clipping region  
$FF29: `GRAPH_set_colors` - set stroke, fill and background colors  
$FF2C: `GRAPH_draw_line` - draw a line  
$FF2F: `GRAPH_draw_rect` - draw a rectangle (optionally filled)  
$FF32: `GRAPH_move_rect` - move pixels  
$FF35: `GRAPH_draw_oval` - draw an oval or circle  
$FF38: `GRAPH_draw_image` - draw a rectangular image  
$FF3B: `GRAPH_set_font` - set the current font  
$FF3E: `GRAPH_get_char_size` - get size and baseline of a character  
$FF41: `GRAPH_put_char` - print a character

---

#### Function Name: GRAPH_init

Signature: void GRAPH_init(word vectors: r0);  
Purpose: Activate framebuffer driver, enter and initialize graphics mode

**Description**: This call activates the framebuffer driver whose vector table is passed in r0. If r0 is 0, the default driver is activated. It then switches the video hardware into graphics mode, sets the window to full screen, initializes the colors and activates the system font.

---

#### Function Name: GRAPH_clear

Signature: void GRAPH_clear();  
Purpose: Clear the current window with the current background color.

---

#### Function Name: GRAPH_set_window

Signature: void GRAPH_set_window(word x: r0, word y: r1, word width: r2, word height: r3);  
Purpose: Set the clipping region

**Description:** All graphics commands are clipped to the window. This function configures the origin and size of the window. All 0 arguments set the window to full screen.

*[Note: Only text output and GRAPH_clear currently respect the clipping region.]*

---

#### Function Name: GRAPH_set_colors

Signature: void GRAPH_set_colors(byte stroke: .A, byte fill: .X, byte background: .Y);  
Purpose: Set the three colors

**Description:** This function sets the three colors: The stroke color, the fill color and the background color.

---

#### Function Name: GRAPH_draw_line

Signature: void GRAPH_draw_line(word x1: r0, word y1: r1, word x2: r2, word y2: r3);  
Purpose: Draw a line using the stroke color

---

#### Function Name: GRAPH_draw_rect

Signature: void GRAPH_draw_rect(word x: r0, word y: r1, word width: r2, word height: r3, word corner_radius: r4, bool fill: c);  
Purpose: Draw a rectangle.

**Description:** This function will draw the frame of a rectangle using the stroke color. If `fill` is `true`, it will also fill the area using the fill color. To only fill a rectangle, set the stroke color to the same value as the fill color.

*[Note: The border radius is currently unimplemented.]*

---

#### Function Name: GRAPH_move_rect

Signature: void GRAPH_move_rect(word sx: r0, word sy: r1, word tx: r2, word ty: r3, word width: r4, word height: r5);  
Purpose: Copy a rectangular screen area to a different location

**Description:** `GRAPH_move_rect` coll copy a rectangular area of the screen to a different location. The two areas may overlap.

*[Note: Support for overlapping is not currently implemented.]*

---

#### Function Name: GRAPH_draw_oval

Signature: void GRAPH_draw_oval(word x: r0, word y: r1, word width: r2, word height: r3, bool fill: c);  
Purpose: Draw an oval or a circle

**Description:** This function draws an oval filling the given bounding box. If width equals height, the resulting shape is a circle. The oval will be outlined by the stroke color. If `fill` is `true`, it will be filled using the fill color. To only fill an oval, set the stroke color to the same value as the fill color.

---

#### Function Name: GRAPH_draw_image

Signature: void GRAPH_draw_image(word x: r0, word y: r1, word ptr: r2, word width: r3, word height: r4);  
Purpose: Draw a rectangular image from data in memory

**Description:** This function copies pixel data from memory onto the screen. The representation of the data in memory has to have one byte per pixel, with the pixels organized line by line top to bottom, and within the line left to right.

---

#### Function Name: GRAPH_set_font

Signature: void GRAPH_set_font(void ptr: r0);  
Purpose: Set the current font

**Description:** This function sets the current font to be used for the remaining font-related functions. The argument is a pointer to the font data structure in memory, which must be in the format of a single point size GEOS font (i.e. one GEOS font file VLIR chunk). An argument of 0 will activate the built-in system font.

---

#### Function Name: GRAPH_get_char_size

Signature: (byte baseline: .A, byte width: .X, byte height_or_style: .Y, bool is_control: c) GRAPH_get_char_size(byte c: .A, byte format: .X);  
Purpose: Get the size and baseline of a character, or interpret a control code

**Description:** This functionality of `GRAPH_get_char_size` depends on the type of code that is passed in: For a printable character, this function returns the metrics of the character in a given format. For a control code, it returns the resulting format. In either case, the current format is passed in .X, and the character in .A.

* The format is an opaque byte value whose value should not be relied upon, except for `0`, which is plain text.
* The resulting values are measured in pixels.
* The baseline is measured from the top.

---

#### Function Name: GRAPH_put_char

Signature: void GRAPH_put_char(inout word x: r0, inout word y: r1, byte c: .A);  
Purpose: Print a character onto the graphics screen

**Description:** This function prints a single character at a given location on the graphics screen. The location is then updated. The following control codes are supported:

* $01: SWAP COLORS
* $04: ATTRIBUTES: UNDERLINE
* $06: ATTRIBUTES: BOLD
* $07: BELL
* $08: BACKSPACE
* $09: TAB
* $0A: LF
* $0B: ATTRIBUTES: ITALICS
* $0C: ATTRIBUTES: OUTLINE
* $0D/$8D: REGULAR/SHIFTED RETURN
* $11/$91: CURSOR: DOWN/UP
* $12: ATTRIBUTES: REVERSE
* $13/$93: HOME/CLEAR
* $14 DEL
* $92: ATTRIBUTES: CLEAR ALL
* all color codes

Notes:

* CR ($0D) SHIFT+CR ($8D) and LF ($0A) all set the cursor to the beginning of the next line. The only difference is that CR and SHIFT+CR reset the attributes, and LF does not.
* BACKSPACE ($08) and DEL ($14) move the cursor to the beginning of the previous character but does not actually clear it. Multiple consecutive BACKSPACE/DEL characters are not supported.
* There is no way to individually disable attributes (underlined, bold, reversed, italics, outline). The only way to disable them is to reset the attributes using code $92, which switches to plain text.
* All 16 PETSCII color codes are supported. Code $01 to swap the colors will swap the stroke and fill colors.
* The stroke color is used to draw the characters, and the underline is drawn using the fill color. In reverse text mode, the text background is filled with the fill color.
* *[BELL ($07), TAB ($09) and SHIFT+TAB ($18) are not yet implemented.]*

---

### Console

$FEDB: `console_init` - initialize console mode  
$FEDE: `console_put_char` - print character to console  
$FED8: `console_put_image` - draw image as if it was a character  
$FEE1: `console_get_char` - get character from console  
$FED5: `console_set_paging_message` - set paging message or disable paging

The console is a screen mode that allows text output and input in proportional fonts that support the usual styles. It is useful for rich text-based interfaces.

---

#### Function Name: console_init

Signature: void console_init(word x: r0, word y: r1, word width: r2, word height: r3);  
Purpose: Initialize console mode.  
Call address: $FEDB

**Description:** This function initializes console mode. It sets up the window (text clipping area) passed into it, clears the window and positions the cursor at the top left. All 0 arguments create a full screen console. You have to switch to graphics mode using `screen_mode` beforehand.

---

#### Function Name: console_put_char

Signature: void console_put_char(byte char: .A, bool wrapping: c);  
Purpose: Print a character to the console.  
Call address: $FEDE

**Description:** This function prints a character to the console. The c flag specifies whether text should be wrapped at character (c=0) or word (c=1) boundaries. In the latter case, characters will be buffered until a SPACE, CR or LF character is sent, so make sure the text that is printed always ends in one of these characters.

**Note**: If the bottom of the screen is reached, this function will scroll its contents up to make extra room.

---

#### Function Name: console_put_image

Signature: void console_put_image(word ptr: r0, word width: r1, word height: r2);  
Purpose: Draw image as if it was a character.  
Call address: $FED8

**Description:** This function draws an image (in GRAPH_draw_image format) at the current cursor position and advances the cursor accordingly. This way, an image can be presented inline. A common example would be an emoji bitmap, but it is also possible to show full-width pictures if you print a newline before and after the image.

**Notes**:

* If the bottom of the screen is reached, this function will scroll its contents up to make extra room.
* Subsequent line breaks will take the image height into account, so that the new cursor position is below the image.

---

#### Function Name: console_get_char

Signature: (byte char: .A) console_get_char();  
Purpose: Get a character from the console.  
Call address: $FEE1

**Description:** This function gets a character to the console. It does this by collecting a whole line of character, i.e. until the user presses RETURN. Then, the line will be sent character by character.

This function allows editing the line using BACKSPACE/DEL, but does not allow moving the cursor within the line, write more than one line, or using control codes.

---

#### Function Name: console_set_paging_message

Signature: void console_set_paging_message(word message: r0);  
Purpose: Set the paging message or disable paging.  
Call address: $FED5

**Description:** The console can halt printing after a full screen height worth of text has been printed. It will then show a message, wait for any key, and continue printing. This function sets this message. A zero-terminated text is passed in r0. To turn off paging, call this function with r0 = 0 - this is the default.

**Note:** It is possible to use control codes to change the text style and color. Do not use codes that change the cursor position, like CR or LF. Also, the text must not overflow one line on the screen.

---

### Other

$FF47: `enter_basic` - enter BASIC  
$FECF: `entropy_get` - get 24 random bits  
$FEAB: `extapi` - extended API  
$FECC: `monitor` - enter machine language monitor  
$FF5F: `screen_mode` - get/set screen mode  
$FF62: `screen_set_charset` - activate 8x8 text mode charset  
$FFED: `SCREEN` - get the text resolution  

#### Function Name: enter_basic

Purpose: Enter BASIC  
Call address: $FF47  
Communication registers: .P  
Preparatory routines: None  
Error returns: Does not return  

**Description:** Call this to enter BASIC mode, either through a cold start (c=1) or a warm start (c=0).

**EXAMPLE:**

```ASM
CLC
JMP enter_basic ; returns to the "READY." prompt
```

---

#### Function Name: entropy_get

Purpose: Get 24 random bits  
Call address: $FECF  
Communication registers: .A .X .Y  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y  

**Description:** This routine returns 24 somewhat random bits in registers .A, .X, and .Y. In order to get higher-quality random numbers, this data should be used to seed a pseudo-random number generator, as this is not a proper high quality pseudo-random number generator in and of itself.

**How to Use:**

1) Call this routine.

**EXAMPLE:**

```ASM
    ; throw a die
    again:
      JSR entropy_get
      STX tmp   ; combine 24 bits
      EOR tmp   ; using exclusive-or
      STY tmp   ; to get a higher-quality
      EOR tmp   ; 8 bit random value
      STA tmp
      LSR
      LSR
      LSR
      LSR       ; combine resulting 8 bits
      EOR tmp   ; to get 4 bits
      AND #7    ; we're down to values 0-7
      CMP #0
      BEQ again ; 0 is illegal
      CMP #7
      BEQ again ; 7 is illegal
      ORA #$30  ; convert to ASCII
      JMP $FFD2 ; print character
```

---
#### Function Name: extapi
Purpose: Additional API functions  
Minimum ROM version: R47  
Call address: $FEAB  
Communication registers: .A .X .Y .P  
Preparatory routines: None  
Error returns: Varies, but usually c=1  
Registers affected: Varies  

**Description:** This API slot provides access to various extended calls. The call is selected by the .A register, and each call has its own register use and return behavior.

| Call # | Name                  | Description                          | Inputs     | Outputs  | Preserves |
| -------|-----------------------|--------------------------------------|------------|----------|-----------|
| `$01` | [`clear_status`](#extapi-function-name-clear_status) | resets the KERNAL IEC status to zero | none | none | - |
| `$02` | [`getlfs`](#extapi-function-name-getlfs) | getter counterpart to setlfs | none | .A .X .Y | - |
| `$03` | [`mouse_sprite_offset`](#extapi-function-name-mouse_sprite_offset) | get or set mouse sprite pixel offset | r0 r1 .P | r0 r1 | - |
| `$04` | [`joystick_ps2_keycodes`](#extapi-function-name-joystick_ps2_keycodes) | get or set joy0 keycode mappings | r0L-r6H .P | r0L-r6H  | - |
| `$05` | [`iso_cursor_char`](#extapi-function-name-iso_cursor_char) | get or set the ISO mode cursor char | .X .P | .X | - |
| `$06` | [`ps2kbd_typematic`](#extapi-function-name-ps2kbd_typematic) | set the keyboard repeat delay and rate | .X | - | - |
| `$07` | [`pfkey`](#extapi-function-name-pfkey) | program macros for F1-F8 and the RUN key | .X | - | - |
| `$08` | [`ps2data_fetch`](#extapi-function-name-ps2data_fetch) | Polls the SMC for PS/2 keyboard and mouse data | - | - | - |
| `$09` | [`ps2data_raw`](#extapi-function-name-ps2data_raw) | If the most recent `ps2data_fetch` received a mouse packet or keycode, returns its raw value | - | .A .Y .X .P r0L-r1H | - |
| `$0A` | [`cursor_blink`](#extapi-function-name-cursor_blink) | Blinks or un-blinks the KERNAL editor cursor if appropriate | - | - | - |
| `$0B` | [`led_update`](#extapi-function-name-led_update) | Illuminates or clears the SMC activity LED based on disk activity or error status | - | - | - |
| `$0C` | [`mouse_set_position`](#extapi-function-name-mouse_set_position) | Moves the mouse cursor to a specific X/Y location | .X (.X)-(.X+3) | - | - |
| `$0D` | [`scnsiz`](#extapi-function-name-scnsiz) | Directly sets the kernal editor text dimensions | .X .Y | - | - |
| `$0E` | [`kbd_leds`](#extapi-function-name-kbd_leds) | Set or get the state of the PS/2 keyboard LEDs | .X .Y | - | - |


---

####  extapi Function Name: clear_status

Purpose: Reset the IEC status byte to 0   
Minimum ROM version: R47  
Call address: $FEAB, .A=1  
Communication registers: none  
Preparatory routines: none  
Error returns: none  
Registers affected: .A  

**Description:** This function explicitly clears the IEC status byte. This is the value which is returned by calling `readst`.

---

####  extapi Function Name: getlfs

Purpose: Return the values from the last call to `setlfs`   
Minimum ROM version: R47  
Call address: $FEAB, .A=2  
Communication registers: .A .X .Y  
Preparatory routines: none  
Error returns: none  
Registers affected: .A .X .Y  

**Description:** This function returns the values from the most recent call to `setlfs`. This is most useful for fetching the most recently-used disk device.

**EXAMPLE:**

```ASM
LOADFILE:
    ; getlfs returns the most recently used disk device (`fa`) in .X
    ; Also returns `la` in .A and `sa` in .Y, but we ignore those
    LDA #2    ; extapi:getlfs
    JSR $FEAB ; extapi
    LDA #1
    LDY #2
    JSR $FFBA ; SETLFS
    LDA #FNEND-FN
    LDX #<FN
    LDY #>FN
    JSR $FFBD ; SETNAM
    LDA #1
    STA $00   ; ram_bank
    LDA #0
    LDX #<$A000
    LDY #>$A000
    JSR $FFD5 ; LOAD
    RTS
FN:
    .byte "MYFILENAME.EXT"
FNEND = *
```

---

#### extapi Function Name: mouse_sprite_offset

Purpose: Set the mouse sprite x/y offset  
Minimum ROM version: R47  
Call address: $FEAB, .A=3  
Communication registers: r0 r1  
Preparatory routines: `mouse_config`  
Error returns: none  
Registers affected: .A .X .Y .P r0 r1

**Description:** This function allows you to set or retrieve the display offset of the mouse sprite, relative to the calculated mouse position. Setting it negative can be useful for mouse sprites in which the locus is not the upper left corner. Combined with configuring a smaller X/Y with mouse_config, it can be set positive to confine the mouse pointer to a limited region of the screen.

* Set: If carry is clear when called, the X and Y sprite offsets are configured from the values in r0 and r1 respectively.
* Get: If carry is set when called, the X and Y sprite offsets are retrieved and placed in r0 and r1 respectively.

**How to Use:**

1) Set up your mouse sprite and call `mouse_config`. Any call to `mouse_config` resets this offset.
2) Load r0 with the 16-bit X offset and r1 with the 16-bit Y offset. Most of the time these values will be negative. For instance, a 16x16 sprite pointer in which the locus is near the center would have an offset of -8 ($FFF8) on both axes.
3) Clear carry and call `mouse_sprite_offset`

**EXAMPLE:**

```ASM
  ; configure your mouse sprite here

  ; configure mouse before setting offset
  LDA #$FF
  LDY #0
  LDX #0
  JSR $FF68 ; mouse_config (resets sprite offsets to zero)

  LDA #<(-8)
  STA r0L
  STA r1L
  LDA #>(-8)
  STA r0H
  STA r1H
  LDA #3    ; mouse_sprite_offset
  CLC
  JSR $FEAB ; extapi
```

---

#### extapi Function Name: joystick_ps2_keycodes

Purpose: Set or get the keyboard mapping for joystick 0  
Minimum ROM version: R47  
Call address: $FEAB, .A=4  
Communication registers: .P r0L-r6H  
Preparatory routines: none  
Error returns: none  
Registers affected: .A .X .Y .P r0L-r6H

**Description:** This function allows you to set or retrieve the list of keycodes that are mapped to joystick 0

* Set: If carry is clear when called, the current values are set based on the contents of the 14 registers r0L-r6H.
* Get: If carry is set when called, the current values are retrieved and placed in the 14 registers r0L-r6H.

| Register | Controller Input | Default                  |
|----------|------------------|--------------------------|
| r0L      | D-pad Right      | KEYCODE_RIGHTARROW ($59) |
| r0H      | D-pad Left       | KEYCODE_LEFTARROW ($4F)  |
| r1L      | D-pad Down       | KEYCODE_DOWNARROW ($54)  |
| r1H      | D-pad Up         | KEYCODE_UPARROW ($53)    |
| r2L      | Start            | KEYCODE_ENTER ($2B)      |
| r2H      | Select           | KEYCODE_LSHIFT ($2C)     |
| r3L      | Y                | KEYCODE_A ($1F)          |
| r3H      | B                | KEYCODE_Z ($2E)          |
| r4L      | B                | KEYCODE_LALT ($3C)       |
| r4H      | R                | KEYCODE_C ($30)          |
| r5L      | L                | KEYCODE_D ($21)          |
| r5H      | X                | KEYCODE_S ($20)          |
| r6L      | A                | KEYCODE_X ($2F)          |
| r6H      | A                | KEYCODE_LALT ($3C)       |

* Note that there are two mappings for the controller button B, and two mappings for the controller button A. Both mapped keys will activate the controller button.

**How to Use:**

1) Unless you're replacing the entire set of mappings, call `joystick_ps2_keycodes` first with carry set to fetch the existing values into r0L-r6H.
2) Load your desired changes into r0L-r6H. The keycodes are enumerated [here](https://github.com/X16Community/x16-rom/blob/master/inc/keycode.inc), and their names, similar to that of PS/2 codes, are based on their function in the ___US layout___.  You can also disable a mapping entirely with the value 0.

3) Clear carry and call `joystick_ps2_keycodes`

**EXAMPLE:**

```ASM
  ; first fetch the original values
  LDA #4    ; joystick_ps2_keycodes
  SEC       ; get values
  JSR $FEAB ; extapi
  LDA #$10  ; KEYCODE_TAB
  STA r2H   ; Tab is to be mapped to the select button
  STZ r4L   ; Disable the secondary B button mapping
  STZ r6H   ; Disable the secondary A button mapping
  LDA #4    ; joystick_ps2_keycodes
  CLC       ; set values
  JSR $FEAB ; extapi (brings the new mapping into effect)
```

---

#### extapi Function Name: iso_cursor_char

Purpose: get or set the ISO mode cursor character  
Minimum ROM version: R47  
Call address: $FEAB, .A=5  
Communication registers: .X .P  
Preparatory routines: none  
Error returns: none  
Registers affected: .A .X .Y .P  

**Description:** This function allows you to set or retrieve the cursor screen code which is used in ISO mode.

* Set: If carry is clear when called, the current value of .X is used as the blinking cursor character if the screen console is in ISO mode.
* Get: If carry is set when called, the current value of the blinking cursor character is returned in .X.

When entering ISO mode, such as by sending a `$0F` to the screen via `BSOUT` or pressing Ctrl+O, the cursor character is reset to the default of `$9F`.

---

#### extapi Function Name: ps2kbd_typematic

Purpose: set the PS/2 typematic delay and repeat rate  
Minimum ROM version: R47  
Call address: $FEAB, .A=6  
Communication registers: .X  
Preparatory routines: none  
Error returns: none  
Registers affected: .A .X .Y .P  

**Description:** This function allows you to set the delay and repeat rate of the PS/2 keyboard. Since the keyboard doesn't allow you to query the current value, there is no getter counterpart to this routine.

NOTE: Since the SMC communicates with the keyboard using PS/2 scancode set 2, there is no way to instruct the keyboard to turn off typematic repeat entirely. However, with a very simple custom KERNAL key handler, you can suppress processing repeated key down events without an intervening key up.

NOTE: **This routine does not work with the emulator**, as the key repeat rate is controlled by the operating system.

This function takes 7 bits of input in .X, a bitfield composed of two parameter options.

* .X = 0ddrrrrr

Where dd is the delay before repeating,

* dd = 00: 250 ms
* dd = 01: 500 ms
* dd = 10: 750 ms
* dd = 11: 1000 ms

and rrrrr is the repeat rate, given this conversion to Hz.

```
 $00 = 30.0 Hz, $01 = 26.7 Hz, $02 = 24.0 Hz, $03 = 21.8 Hz
 $04 = 20.7 Hz, $05 = 18.5 Hz, $06 = 17.1 Hz, $07 = 16.0 Hz
 $08 = 15.0 Hz, $09 = 13.3 Hz, $0a = 12.0 Hz, $0b = 10.9 Hz
 $0c = 10.0 Hz, $0d =  9.2 Hz, $0e =  8.6 Hz, $0f =  8.0 Hz
 $10 =  7.5 Hz, $11 =  6.7 Hz, $12 =  6.0 Hz, $13 =  5.5 Hz
 $14 =  5.0 Hz, $15 =  4.6 Hz, $16 =  4.3 Hz, $17 =  4.0 Hz
 $18 =  3.7 Hz, $19 =  3.3 Hz, $1a =  3.0 Hz, $1b =  2.7 Hz
 $1c =  2.5 Hz, $1d =  2.3 Hz, $1e =  2.1 Hz, $1f =  2.0 Hz
```

---

#### extapi Function Name: pfkey

Purpose: Reprogram a function key macro  
Minimum ROM version: R47  
Call address: $FEAB, .A=7  
Communication registers: .X .Y r0  
Preparatory routines: None  
Error returns: c=1  
Registers affected: .A .X .Y .P r0  

**Description:** This routine can be called to replace an F-key macro in the KERNAL editor with a user-defined string. The maximum length of each macro is 10 bytes, matching the size of the X16 KERNAL's keyboard buffer. It can also replace the action of SHIFT+RUN with a user-defined action.

These macros are only available in the KERNAL editor, which is usually while editing BASIC program, or during a BASIN from the screen. The BASIC statements INPUT and LINPUT also operate in this mode.

Inputs:
* r0 = pointer to string
* .X = key number (1-9)
* .Y = string length

**How to Use:**

1) Load r0L and r0H a pointer to the replacement macro string (ZP locations $02 and $03).
2) Load .X with the key number to replace. Values 1-8 correspond to F1-F8. A value of 9 corresponds to SHIFT+RUN.
3) Load .Y with the string length. This may be a range from 0-10 inclusive. A value of 0 disables the macro entirely.
4) Call `pfkey`. If carry is set when returning, an error occurred. The most likely reason is that one of the input parameters was out of range.

**EXAMPLE:**

Disable the SHIFT+RUN action, and replace the macro in F1 with "HELP" followed by a carriage return.

```ASM
EXTAPI = $FEAB

change_fkeys:
  lda #<string1
  sta $02
  lda #>string1
  sta $03
  lda #$02
  ldx #1
  ldy #<(string1_end-string1)
  jsr EXTAPI
  lda #<string9
  sta $02
  lda #>string9
  sta $03
  lda #7
  ldx #9
  ldy #<(string9_end-string9)
  jsr EXTAPI
  rts

string1: .byte "HELP",13
string1_end:
string9:
string9_end:
```

BASIC equivalent:

```BASIC
10 A$="HELP"+CHR$(13)
20 K=1
30 GOSUB 100
40 A$=""
50 K=9
60 GOSUB 100
70 END
100 AL=LEN(A$)
110 AP=STRPTR(A$)
120 POKE $02,(AP-(INT(AP/256)*256))
130 POKE $03,INT(AP/256)
140 POKE $30C,7
150 POKE $30D,K
160 POKE $30E,AL
170 SYS $FEAB
180 RETURN
```

---

#### extapi Function Name: ps2data_fetch

Purpose: Poll the SMC for PS/2 events  
Minimum ROM version: R47  
Call address: $FEAB, .A=8  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** This routine is called from the default KERNAL interrupt service handler to fetch a queued keycode, and if the mouse is enabled, a mouse packet. The values are stored inside internal KERNAL state used by subsequent calls to `mouse_scan`, `kbd_scan`, or `ps2data_raw`.

If the mouse has not been enabled via `mouse_config`, no mouse data is polled.

This call is mainly useful when overriding the default KERNAL IRQ handler, and since this function is not re-entrant safe, it is unsafe to call outside of an interrupt handler if interrupts are enabled and the default KERNAL IRQ handler is in place.

---

#### extapi Function Name: ps2data_raw

Purpose: Return the most recently-fetched PS/2 mouse packet and keycode  
Minimum ROM version: R47  
Call address: $FEAB, .A=9  
Communication registers: .A .Y .X .P r0L-r1H  
Preparatory routines: `mouse_config`, `ps2data_fetch`  
Error returns: None  
Registers affected: .A .X .Y .P r0L-r1H  

**Description:** This routine returns the most-recently fetched mouse data packet and keycode. If a mouse packet exists, it sets .X to the length of the packet, either 3 or 4 depending on mouse type, and stores the values into r0L-r1H. If there's no mouse packet to return, .X is set to zero. If there's a keycode to return, .A is set to the keycode, otherwise .A is set to zero. If there's an extended keycode, .A will equal $7F for key down or $FF for key up, and .Y will contain the extended code.

If .X = 0, no mouse packet was received, and r0L-r1H memory is unchanged.

If the zero flag is set, neither the keyboard nor mouse had pending events.

This call is mainly useful when overriding the default KERNAL ISR and implementing a fully custom mouse and keyboard routine.  It is also available when using the default ISR as these values are kept even after processing, until the next `ps2data_fetch` call.

Return values:

##### Keyboard

* .A = keycode

If .A == $7F or .A == $FF

* .Y = extended keycode

##### Mouse

* .X = number of mouse bytes

If .X == 0, memory is left unchanged.

If .X >= 3

* r0L = mouse byte 1
* r0H = mouse byte 2
* r1L = mouse byte 3

If .X == 4

* r1H = mouse byte 4

**How to Use:**

1) Call `mouse_config` with a non-zero value to enable the mouse.
2) If you're overriding the default KERNAL IRQ handler entirely, call `ps2data_fetch`. If not, this will be called for you.
3) Call `ps2data_raw`. If .X is nonzero upon return, memory starting at r0L will contain the raw mouse packet.

**EXAMPLE:**

```ASM
CHROUT = $FFD2
STOP = $FFE1
EXTAPI = $FEAB
MOUSE_CONFIG = $FF68
SCREEN_MODE = $FF5F

TMP1 = $22
r0 = $02

start:
        sec
        jsr SCREEN_MODE ; get the screen size to pass to MOUSE_CONFIG
        lda #1
        jsr MOUSE_CONFIG
loop:
        wai ; wait for interrupt
        lda #9 ; ps2data_raw
        jsr EXTAPI
        beq aftermouse
        stx TMP1
        ora #0
        beq afterkbd
        jsr print_hex_byte
        lda #13
        jsr CHROUT
afterkbd:
        ldx TMP1
        beq aftermouse
        ldx #0
printloop:
        lda r0,x
        phx
        jsr print_hex_byte
        plx
        inx
        cpx TMP1
        bne printloop
        lda #13
        jsr CHROUT
aftermouse:
        jsr STOP
        bne loop
done:
        rts

print_hex_byte:
        jsr byte_to_hex
        jsr CHROUT
        txa
        jsr CHROUT
        rts

byte_to_hex:
        pha
        and #$0f
        tax
        pla
        lsr
        lsr
        lsr
        lsr
        pha
        txa
        jsr @hexify
        tax
        pla
@hexify:
        cmp #10
        bcc @nothex
        adc #$66
@nothex:
        eor #%00110000
        rts

```

---
#### extapi Function Name: cursor_blink

Purpose: Blink or un-blink the cursor in the KERNAL editor  
Minimum ROM version: R47  
Call address: $FEAB, .A=10  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** This routine is called from the default KERNAL interrupt service handler to cause the text mode cursor to blink on or off as appropriate, depending on the number of times this function has been called since the last blink event. If the editor is not waiting for input, this function has no effect.

This call is mainly useful when overriding the default KERNAL IRQ handler.

---

#### extapi Function Name: led_update

Purpose: Set the illumination status of the SMC's activity LED based on disk status  
Minimum ROM version: R47  
Call address: $FEAB, .A=11  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** This routine is called from the default KERNAL IRQ handler to update the status of the SMC's activity LED based on CMDR-DOS's status flags. It is illuminated solid during DOS disk activity, and flashes when there was a disk error.

This call is mainly useful when overriding the default KERNAL IRQ handler.

---

#### extapi Function Name: mouse_set_position

Purpose: Move the mouse pointer to an absolute X/Y position  
Minimum ROM version: R47  
Call address: $FEAB, .A=12  
Communication registers: .X (.X)-(.X+3)  
Preparatory routines: `mouse_config`  
Error returns: None  
Registers affected: .A .X .Y .P  

**Description:** This routine set the absolute position of the mouse pointer and updates the pointer sprite.

Inputs:
* .X = the zeropage location from which to read the new values
* $00+X = X position low byte
* $01+X = X position high byte
* $02+X = Y position low byte
* $03+X = Y position high byte

For instance, if you want the function to read the values from memory locations $22 through $25, set .X to #$22.

**How to Use:**

1) Call `mouse_config` with a non-zero value to enable the mouse.
2) Store the new X/Y position in four contiguous zeropage locations as described above. Load .X with the starting zeropage location.
3) Call `mouse_set_position`

**EXAMPLE:**

This demo program causes the mouse pointer to slowly drift down and to the right.

```ASM
r0L = $02
r0H = $03
r1L = $04
r1H = $05

EXTAPI = $FEAB
MOUSE_CONFIG = $FF68
MOUSE_GET = $FF6B
SCREEN_MODE = $FF5F
STOP = $FFE1

start:
        sec
        jsr SCREEN_MODE
        lda #1
        jsr MOUSE_CONFIG
loop:
        ldx #r0L ; starting ZP location for mouse_get
        jsr MOUSE_GET
        inc r0L
        bne :+
        inc r0H
:       inc r1L
        bne :+
        inc r1H
:
        ldx #r0L ; starting ZP location for mouse_set_position
        lda #12 ; mouse_set_position
        jsr EXTAPI
        wai ; delay until next interrupt
        jsr STOP
        bne loop
done:
        rts

```
---

#### extapi Function Name: scnsiz

Purpose: Set the number of text rows and columns for the kernal screen editor  
Minimum ROM version: R48  
Call address: $FEAB, .A=13  
Communication registers: .X .Y  
Preparatory routines: None  
Error returns: c=1  
Registers affected: .A .X .Y .P  

**Description:** This routine is implicitly called by `screen_mode` to set the bounds of the kernal editor's screen, and can be used directly to change the row and column bounds of the screen editor. `scnsiz` does not change the screen scaling.

This call is mainly useful to set custom row and column counts not available from any built-in screen mode.

Due to limits within the KERNAL's editor and what screen sizes it expects to work with, this routine will error and return with carry set if:
* .X &lt; 20
* .X &gt; 80
* .Y &lt; 4
* .Y &gt; 60

If the requested size exceeds the allowed bounds (.X = 20-80, .Y = 4-60), the existing text resolution won't be changed.

**How to Use:**

1) Set .X to the number of desired columns and .Y to the desired number of rows.
2) Call `scnsiz`
3) The in-bounds area of the screen as defined by these new dimensions will be cleared and the cursor will be placed at the upper-left home position.

**EXAMPLE:**

This example assembly routine sets up an 80x25 region, also adding top and bottom border regions so that the viewable area only shows the 80x25 text region.

```ASM

SCREEN_MODE = $FF5F
EXTAPI = $FEAB
E_SCNSIZ = $0D
VERA_CTRL = $9F25
VERA_DC_VSTART = $9F2B
VERA_DC_VSTOP = $9F2C

TOP = 20 ; 20 rows from the top
BOTTOM = 480-20 ; 20 rows from the bottom

do_80x25:
        lda #1
        clc
        jsr SCREEN_MODE ; set screen mode to 80x30, which also clears the screen
        ldx #80
        ldy #25
        lda #E_SCNSIZ
        jsr EXTAPI ; reset to 80x25
        lda #(1 << 1) ; DCSEL = 1
        sta VERA_CTRL
        lda #(TOP >> 1) ; each step in DC_VSTART is 2 pixel rows
        sta VERA_DC_VSTART
        lda #(BOTTOM >> 1) ; each step in DC_VSTOP is 2 pixel rows
        sta VERA_DC_VSTOP
        stz VERA_CTRL
        rts
```

---

#### extapi Function Name: kbd_leds

Purpose: Set or retrieve the PS/2 keyboard LED state  
Minimum ROM version: R48  
Call address: $FEAB, .A=14  
Communication registers: .X .P  
Preparatory routines: None  
Error returns: (none)  
Registers affected: .A .X .Y .P  

**Description:** This routine is used to send a command to the keyboard to set the state of the Num Lock, Caps Lock, and Scroll Lock LEDs. You can also query the KERNAL for its idea of what the state of the LEDs is.

Note: This call does **not** change the state of the kernal's caps lock toggle.

**How to Use:**

1) To query the state of the LEDs, set carry, otherwise to set the LED state, clear carry and set .X to the desired value of the LED register. Bit 0 is Scroll Lock, bit 1 is Num Lock, and bit 2 is Caps Lock.
2) Call `kbd_leds`
3) If carry was set on the call to `kbd_leds`, the routine will return with .X set to the current state, otherwise the routine will send the updated LED state to the keyboard. In this case, there will be no confirmation on whether it was successful.

**EXAMPLE:**

This example toggles the state of the LEDs to the opposite state that they were initially.

```ASM

EXTAPI = $FEAB
E_KBD_LEDS = $0E

flip_leds:
        sec
        lda #E_KBD_LEDS
        jsr EXTAPI ; fetch state
        txa
        eor #7 ; invert the LED state
        tax
        set
        lda #E_KBD_LEDS
        jsr EXTAPI ; set state and send to keyboard
        rts
```

---


#### Function Name: monitor

Purpose: Enter the machine language monitor  
Call address: $FECC  
Communication registers: None  
Preparatory routines: None  
Error returns: Does not return  
Registers affected: Does not return

**Description:** This routine switches from BASIC to machine language monitor mode. It does not return to the caller. When the user quits the monitor, it will restart BASIC.

**How to Use:**

1) Call this routine.

**EXAMPLE:**

```ASM
      JMP monitor
```

---

#### Function Name: SCREEN

Purpose: Get the text resolution of the screen  
Call address: $FFED  
Communication registers: .X, .Y  
Preparatory routines: None  
Error returns: None  
Registers affected: .A, .X, .Y, .P

**Description:** This routine returns the KERNAL screen editor's view of the text resolution. The column count is returned in .X and the row count is returned in .Y.

In contrast to calling [`screen_mode`](#function-name-screen_mode) with carry set, this function returns the configured resolution if ever it is updated by [`scnsiz`](#extapi-function-name-scnsiz). `screen_mode` only returns the text dimensions the currently configured mode would have configured, ignoring any changes made by calls to `scnsiz`.


**EXAMPLE:**

```ASM
SCREEN = $FFED

get_res:
        jsr SCREEN
        sty my_rows
        stx my_columns
        rts
```

---

#### Function Name: screen_mode

Purpose: Get/Set the screen mode  
Call address: $FF5F  
Communication registers: .A, .X, .Y, .P  
Preparatory routines: None  
Error returns: c = 1 in case of error  
Registers affected: .A, .X, .Y

**Description:** If c is set, a call to this routine gets the current screen mode in .A, the width (in tiles) of the screen in .X, and the height (in tiles) of the screen in .Y. If c is clear, it sets the current screen mode to the value in .A. For a list of possible values, see the basic statement `SCREEN`. If the mode is unsupported, c will be set, otherwise cleared.

If you use this function to get the text resolution instead of calling [`SCREEN`](#function-name-screen), this function only returns the text dimensions the currently configured mode would have set, ignoring any changes made by calls to [`scnsiz`](#extapi-function-name-scnsiz). If you want to fetch the KERNAL editor's text resolution, call [`SCREEN`](#function-name-screen) instead.

**EXAMPLE:**

```ASM
LDA #$80
CLC
JSR screen_mode ; SET 320x200@256C MODE
BCS FAILURE
```

---

#### Function Name: screen_set_charset

Purpose: Activate a 8x8 text mode charset  
Call address: $FF62

Communication registers: .A, .X, .Y  
Preparatory routines: None  
Registers affected: .A, .X, .Y

**Description:** A call to this routine uploads a character set to the video hardware and activates it. The value of .A decides what charset to upload:

| Value | Description                     |
|-------|---------------------------------|
| 0     | use pointer in .X/.Y            |
| 1     | ISO                             |
| 2     | PET upper/graph                 |
| 3     | PET upper/lower                 |
| 4     | PET upper/graph (thin)          |
| 5     | PET upper/lower (thin)          |
| 6     | ISO (thin)                      |
| 7     | CP437 (since r47)               |
| 8     | Cyrillic ISO (since r47)        |
| 9     | Cyrillic ISO (thin) (since r47) |
| 10    | Eastern Latin ISO (since r47)   |
| 11    | Eastern ISO (thin) (since r47)  |
| 12    | Katakana (thin) (since r48)     |

If .A is zero, .X (lo) and .Y (hi) contain a pointer to a 2 KB RAM area that gets uploaded as the new 8x8 character set. The data has to consist of 256 characters of 8 bytes each, top to bottom, with the MSB on the left, set bits (1) represent the foreground colored pixels.

**EXAMPLE:**

```ASM
LDA #0
LDX #<MY_CHARSET
LDY #>MY_CHARSET
JSR screen_set_charset ; UPLOAD CUSTOM CHARSET "MY_CHARSET"
```

---

#### Function Name: JSRFAR

Purpose: Execute a routine on another RAM or ROM bank  
Call address: $FF6E  
Communication registers: None  
Preparatory routines: None  
Error returns: None  
Registers affected: None

**Description:** The routine `JSRFAR` enables code to execute some other code located on a specific RAM or ROM bank. This works independently of which RAM or ROM bank the currently executing code is residing in.
The 16 bit address and the 8 bit bank number have to follow the instruction stream. The `JSRFAR` routine will switch both the ROM and the RAM bank to the specified bank and restore it after the routine's `RTS`. Execution resumes after the 3 byte arguments.
**Note**: The C128 also has a `JSRFAR` function at $FF6E, but it is incompatible with the X16 version.

**How to Use:**

1) Call this routine.

**EXAMPLE:**

```ASM
      JSR JSRFAR
      .WORD $C000 ; ADDRESS
      .BYTE 1     ; BANK
```

### 65C816 support

When writing native 65C816 code for the Commander X16, extra care must be given when using the KERNAL API. With the exception of `extapi16`, documented below, the entire kernal API must be called:

* With m=1, x=1 (accumulator and index are 8 bits)
* SP set to the KERNAL stack ($01xx). see 
* DP=$0000 (must be set so that zeropage is the direct page)

$FEA8: `extapi16` - 16-bit extended API for 65C816 native mode  

---

#### Function Name: extapi16

Purpose: API functions for 65C816  
Minimum ROM version: R47  
Call address: $FEA8  
Communication registers: .C, .X, .Y, .P  
Preparatory routines: None  
Error returns: Varies, but usually c=1  
Registers affected: Varies

**Description:** This API slot provides access to various native mode 65C816 calls. The call is selected by the .C register (accumulator), and each call has its own register use and return behavior.

**IMPORTANT**  
* All of the calls behind this API __must__ be called in native 65C816 mode, with m=0, .DP=$0000.
* In addition, some of these __must__ be called with `rom_bank` (zp address $01) set to bank 0 (the KERNAL bank) and not via KERNAL support in other ROM banks. If your program is launched from BASIC, the default bank is usually 4 until explicitly changed by your program.

| Call # | Name           | Description                                 | Inputs | Outputs | Additional Prerequisites |
| -------|----------------|---------------------------------------------|--------|---------|--------------------------|
|  `$00` | [`test`](#65c816-extapi16-function-name-test) | Used by unit tests | .X .Y  | .C | -                       |
|  `$01` | [`stack_push`](#65c816-extapi16-function-name-stack_push) | Switches to a new stack context | .X | none | x=0, $01=0 |
|  `$02` | [`stack_pop`](#65c816-extapi16-function-name-stack_pop) | Returns to the previous stack context | none | none | x=0, $01=0 |
|  `$03` | [`stack_enter_kernal_stack`](#65c816-extapi16-function-name-stack_enter_kernal_stack) | Switches to the $01xx stack | none | none | x=0, $01=0 |
|  `$04` | [`stack_leave_kernal_stack`](#65c816-extapi16-function-name-stack_leave_kernal_stack) | Returns to the previous stack context after `stack_enter_kernal_stack` | none | none | x=0, $01=0 |

---

#### 65C816 extapi16 Function Name: test

Purpose: Used by unit tests for jsrfar  
Minimum ROM version: R47  
Call address: $FEA8, .C=0  
Communication registers: .C .X .Y  
Preparatory routines: none  
Error returns: none  
Registers affected: .C  

**Description:** This API is used by unit tests and is not useful for applications.

---

#### 65C816 extapi16 Function Name: stack_push

Purpose: Point the SP to a new stack  
Minimum ROM version: R47  
Call address: $FEA8, .C=1  
Communication registers: .X  
Preparatory routines: none  
Error returns: none  
Registers affected: .A .X .Y .P .SP  

**Description:** This function informs the KERNAL that you're moving the stack pointer to a new location so that it can preserve the previous SP, and then brings the new SP into effect. The main purpose of this call is to preserve the position of the $01xx stack pointer (AKA KERNAL stack), and to track the length of the chain of stacks in the case of multiple pushes. In order for the 65C02 code in the emulated mode IRQ handler to run properly, it must be able to temporarily switch to using the KERNAL stack, regardless of the SP in main code.

**How to Use:**

1) Ensure `rom_bank` (ZP $01) is set to `0`. This function will not work if it traverses through `jsrfar`.
2) Load .X with the new SP to switch to, then call the routine. Upon return, .SP will be set to the new stack value. If the stack chain depth is greater than 1, the new stack will also have the old stack's address pushed onto it.
3) To return to the previous stack context, call `stack_pop`.

**Notes:**

* If you wish to preserve your current SP while temporarily switching back to the $01xx stack, for instance, to use the KERNAL API, begin that section of code with a call to `stack_enter_kernal_stack` and end with a call to `stack_leave_kernal_stack`.

---

#### 65C816 extapi16 Function Name: stack_pop

Purpose: Point the SP to the previously-saved stack  
Minimum ROM version: R47  
Call address: $FEA8, .C=2  
Communication registers: none  
Preparatory routines: `stack_push`  
Error returns: none  
Registers affected: .A .X .Y .P .SP  

**Description:** This function informs the KERNAL that you're finished using the stack set previously by `stack_push`. It brings the previous SP into effect.

**How to Use:**

1) Ensure `rom_bank` (ZP $01) is set to `0`. This function will not work if it traverses through `jsrfar`.
2) Ensure the current SP is set to the same value that was set immediately after the return from `stack_push`. In other words, you cannot use this function to bail out early from a deep subroutine chain without taking care to reset the stack first. In addition, you cannot simply reset the stack to the value that _you_ called `stack_push` with since the new stack may have had state pushed by the call to `stack_push`.
3) Call `stack_pop`.  The call will return to the address immediately after, but with the previously-pushed SP.

---

#### 65C816 extapi16 Function Name: stack_enter_kernal_stack

Purpose: Point the SP to the previously-saved $01xx stack, preserving the current one  
Minimum ROM version: R47  
Call address: $FEA8, .C=3  
Communication registers: none  
Preparatory routines: `stack_push`  
Error returns: none  
Registers affected: .A .X .Y .P .SP  

**Description:** This function requests that the KERNAL temporarily bring the $01xx stack into effect during use a different stack. This is useful for applications which have moved the SP away from $01xx but need to call the KERNAL API or legacy code.

**How to Use:**

1) Ensure `rom_bank` (ZP $01) is set to `0`. This function will not work if it traverses through `jsrfar`.
2) A prior call to `stack_push` must be in effect that hasn't been undone by `stack_pop`, and the current SP must not be the default $01xx stack.
3) Call `stack_enter_kernal_stack`, call the legacy functions, then call `stack_leave_kernal_stack`.

---

#### 65C816 extapi16 Function Name: stack_leave_kernal_stack

Purpose: Point the SP to the previously-preserved stack  
Minimum ROM version: R47  
Call address: $FEA8, .C=4  
Communication registers: none  
Preparatory routines: `stack_enter_kernal_stack`  
Error returns: none  
Registers affected: .A .X .Y .P .SP  

**Description:** This function is the counterpart to `stack_enter_kernal_stack`, and restores the previously preserved stack.

**How to Use:**

1) Ensure `rom_bank` (ZP $01) is set to `0`. This function will not work if it traverses through `jsrfar`.
2) A prior call to `stack_enter_kernal_stack` must be in effect that hasn't been undone by this function.
3) Call `stack_leave_kernal_stack`.


---

[^1]: [https://github.com/emmanuel-marty/lzsa](https://github.com/emmanuel-marty/lzsa)
  
<!-- For PDF formatting -->
<div class="page-break"></div>
