<!--
********************************************************************************
NOTICE: This file uses two trailing spaces on some lines to indicate line breaks
for GitHub's Markdown flavor. Do not remove!
********************************************************************************
-->

# Chapter 3: BASIC Programming

## Table of BASIC statements and functions

| Keyword | Type | Summary | Origin |
|-|-|-|-|
| `ABS` | function | Returns absolute value of a number | C64 |
| `AND` | operator | Returns boolean "AND" or bitwise intersection | C64 |
| [`ASC`](#asc) | function | Returns numeric PETSCII value from string | C64 |
| `ATN` | function | Returns arctangent of a number | C64 |
| [`BANK`](#bank) | command | Sets the RAM and ROM banks to use for PEEK, POKE, and SYS | C128 |
| [`BIN$`](#bin) | function | Converts numeric to a binary string | X16 |
| [`BLOAD`](#bload) | command | Loads a headerless binary file from disk to a memory address | X16 |
| [`BOOT`](#boot) | command | Loads and runs `AUTOBOOT.X16` | X16 |
| [`BSAVE`](#bsave) | command | Saves a headerless copy of a range of memory to a file | X16 |
| `BVERIFY` | command | Verifies that a file on disk matches RAM contents | X16 |
| [`BVLOAD`](#bvload) | command | Loads a headerless binary file from disk to VRAM | X16 |
| [`CHAR`](#char) | command | Draws a text string in graphics mode | X16 |
| `CHR$` | function | Returns PETSCII character from numeric value | X16 |
| `CLOSE` | command | Closes a logical file number | C64 |
| `CLR` | command | Clears BASIC variable state | C64 |
| [`CLS`](#cls) | command | Clears the screen | X16 |
| `CMD` | command | Redirects output to non-screen device | C64 |
| `CONT` | command | Resumes execution of a BASIC program | C64 |
| [`COLOR`](#color) | command | Sets text fg and bg color | X16 |
| `COS` | function | Returns cosine of an angle in radians | C64 |
| `DA$` | variable | Returns the date in YYYYMMDD format from the system clock | X16 |
| `DATA` | command | Declares one or more constants | C64 |
| `DEF` | command | Defines a function for use later in BASIC | C64 |
| `DIM` | command | Allocates storage for an array | C64 |
| [`DOS`](#dos) | command | Disk and SD card directory operations | X16 |
| `END` | command | Terminate program execution and return to `READY.` | C64 |
| `EXP` | function | Returns the inverse natural log of a number | C64 |
| [`FMCHORD`](#fmchord) | command | Start or stop simultaneous notes on YM2151 | X16 |
| [`FMDRUM`](#fmdrum) | command | Plays a drum sound on YM2151 | X16 |
| [`FMFREQ`](#fmfreq) | command | Plays a frequency in Hz on YM2151 | X16 |
| [`FMINIT`](#fminit) | command | Stops sound and reinitializes YM2151 | X16 |
| [`FMINST`](#fminst) | command | Loads a patch preset into a YM2151 channel | X16 |
| [`FMNOTE`](#fmnote) | command | Plays a musical note on YM2151 | X16 |
| [`FMPAN`](#fmpan) | command | Sets stereo panning on YM2151 | X16 |
| [`FMPLAY`](#fmplay) | command | Plays a series of notes on YM2151 | X16 |
| [`FMPOKE`](#fmpoke) | command | Writes a value into a YM2151 register | X16 |
| [`FMVIB`](#fmvib) | command | Controls vibrato and tremolo on YM2151 | X16 |
| [`FMVOL`](#fmvol) | command | Sets channel volume on YM2151 | X16 |
| `FN` | function | Calls a previously defined function | C64 |
| `FOR` | command | Declares the start of a loop construct | C64 |
| [`FRAME`](#frame) | command | Draws an unfilled rectangle in graphics mode | X16 |
| `FRE` | function | Returns the number of unused BASIC bytes free | C64 |
| [`GEOS`](#geos) | command | Enter the GEOS GUI | X16 |
| `GET` | command | Polls the keyboard cache for a single keystroke | C64 |
| `GET#` | command | Polls an open logical file for a single character | C64 |
| `GOSUB` | command | Jumps to a BASIC subroutine | C64 |
| `GOTO` | command | Branches immediately to a line number | C64 |
| [`HEX$`](#hex) | function | Converts numeric to a hexadecimal string | X16 |
| [`I2CPEEK`](#i2cpeek) | function | Reads a byte from a device on the I²C bus | X16 |
| [`I2CPOKE`](#i2cpoke) | command | Writes a byte to a device on the I²C bus | X16 |
| `IF` | command | Tests a boolean condition and branches on result | C64 |
| `INPUT` | command | Reads a line or values from the keyboard | C64 |
| `INPUT#` | command | Reads lines or values from a logical file | C64 |
| `INT` | function | Discards the fractional part of a number | C64 |
| [`JOY`](#joy) | function | Reads gamepad button state | X16 |
| [`KEYMAP`](#keymap) | command | Changes the keyboard layout | X16 |
| `LEFT$` | function | Returns a substring starting from the beginning of a string | C64 |
| `LEN` | function | Returns the length of a string | C64 |
| `LET` | command | Explicitly declares a variable | C64 |
| [`LINE`](#line) | command | Draws a line in graphics mode | X16 |
| `LIST` | command | Outputs the program listing to the screen | C64 |
| `LOAD` | command | Loads a program from disk into memory | C64 |
| [`LOCATE`](#locate) | command | Moves the text cursor to new location | X16 |
| `LOG` | function | Returns the natural logarithm of a number | C64 |
| [`MENU`](#menu) | command | Invokes the Commander X16 utility menu | X16 |
| `MID$` | function | Returns a substring from the middle of a string | C64 |
| [`MON`](#mon) | command | Enters the machine language monitor | X16 |
| [`MOUSE`](#mouse) | command | Hides or shows mouse pointer | X16 |
| [`MX/MY/MB`](#mxmymb) | variable | Reads the mouse position and button state | X16 |
| `NEW` | command | Resets the state of BASIC and clears program memory | C64 |
| `NEXT` | command | Declares the end of a loop construct | C64 |
| `NOT` | operator | Bitwise or boolean inverse | C64 |
| [`OLD`](#old) | command | Undoes a NEW command or warm reset | X16 |
| `ON` | command | A GOTO/GOSUB table based on a variable value | C64 |
| `OPEN` | command | Opens a logical file to disk or other device | C64 |
| `OR` | operator | Bitwise or boolean "OR" | C64 |
| `PEEK` | function | Returns a value from a memory address | C64 |
| `π` | function | Returns the constant for the value of pi | C64 |
| [`POINTER`](#pointer) | function | Returns the address of a BASIC variable | C128 |
| `POKE` | command | Assigns a value to a memory address | C64 |
| `POS` | function | Returns the column position of the text cursor | C64 |
| [`POWEROFF`](#poweroff) | command | Immediately powers down the Commander X16 | X16 |
| `PRINT` | command | Prints data to the screen or other output | C64 |
| `PRINT#` | command | Prints data to an open logical file | C64 |
| [`PSET`](#pset) | command | Changes a pixel's color in graphics mode | X16 |
| [`PSGCHORD`](#psgchord) | command | Starts or stops simultaneous notes on VERA PSG | X16 |
| [`PSGFREQ`](#psgfreq) | command | Plays a frequency in Hz on VERA PSG | X16 |
| [`PSGINIT`](#psginit) | command | Stops sound and reinitializes VERA PSG | X16 |
| [`PSGNOTE`](#psgnote) | command | Plays a musical note on VERA PSG | X16 |
| [`PSGPAN`](#psgpan) | command | Sets stereo panning on VERA PSG | X16 |
| [`PSGPLAY`](#psgplay) | command | Plays a series of notes on VERA PSG | X16 |
| [`PSGVOL`](#psgvol) | command | Sets voice volume on VERA PSG | X16 |
| [`PSGWAV`](#psgwav) | command | Sets waveform on VERA PSG | X16 |
| `READ` | command | Assigns the next `DATA` constant to one or more variables | C64 |
| [`REBOOT`](#reboot) | command | Performs a warm reboot of the system | X16 |
| [`RECT`](#rect) | command | Draws a filled rectangle in graphics mode | X16 |
| `REM` | command | Declares a comment | C64 |
| [`REN`](#ren) | command | Renumbers a BASIC program | X16 |
| [`RESET`](#reset) | command | Performs a hard reset of the system | X16 |
| [`RESTORE`](#restore) | command | Resets the `READ` pointer to a `DATA` constant | C64 |
| `RETURN` | command | Returns from a subroutine to the statement following a GOSUB | C64 |
| `RIGHT$` | function | Returns a substring from the end of a string | C64 |
| `RND` | function | Returns a floating point number 0 <= n < 1 | C64 |
| `RUN` | command | Clears the variable state and starts a BASIC program | C64 |
| `SAVE` | command | Saves a BASIC program from memory to disk | C64 |
| [`SCREEN`](#screen) | command | Selects a text or graphics mode | X16 |
| `SGN` | function | Returns the sign of a numeric value | C64 |
| `SIN` | function | Returns the sine of an angle in radians | C64 |
| [`SLEEP`](#sleep) | command | Introduces a delay in program execution | X16 |
| `SPC` | function | Returns a string with a set number of spaces | C64 |
| `SQR` | function | Returns the square root of a numeric value | C64 |
| `ST` | variable | Returns the status of certain DOS/peripheral operations | C64 |
| `STEP` | keyword | Used in a `FOR` declaration to declare the iterator step | C64 |
| `STOP` | command | Breaks out of a BASIC program | C64 |
| `STR$` | function | Converts a numeric value to a string | C64 |
| [`STRPTR`](#strptr) | function | Returns the address of a BASIC string | X16 |
| [`SYS`](#sys) | command | Transfers control to machine language at a memory address | C64 |
| `TAB` | function | Returns a string with spaces used for column alignment | C64 |
| `TAN` | function | Return the tangent for an angle in radians | C64 |
| `THEN` | keyword | Control structure as part of an `IF` statement | C64 |
| `TI` | variable | Returns the jiffy timer value | C64 |
| `TI$` | variable | Returns the time HHMMSS from the system clock | C64 |
| `TO` | keyword | Part of the `FOR` loop declaration syntax | C64 |
| `USR` | function | Call a user-defined function in machine language | C64 |
| `VAL` | function | Parse a string to return a numeric value | C64 |
| `VERIFY` | command | Verify that a BASIC program was written to disk correctly | C64 |
| [`VPEEK`](#vpeek) | function | Returns a value from VERA's VRAM | X16 |
| [`VPOKE`](#vpoke) | command | Sets a value in VERA's VRAM | X16 |
| [`VLOAD`](#vload) | command | Loads a file to VERA's VRAM | X16 |
| `WAIT` | command | Waits for a memory location to match a condition | C64 |

## Commodore 64 Compatibility

The Commander X16 BASIC interpreter is 100% backwards-compatible with the Commodore 64 one. This includes the following features:

* All statements and functions
* Strings, arrays, integers, floats
* Max. 80 character BASIC lines
* Printing control characters like cursor control and color codes, e.g.:
  * `CHR$(147)`: clear screen
  * `CHR$(5)`: white text
  * `CHR$(18)`: reverse
  * `CHR$(14)`: switch to upper/lowercase font
  * `CHR$(142)`: switch to uppercase/graphics font
* The BASIC vector table (\$0300-\$030B, \$0311/\$0312)
* [SYS](#sys) arguments in RAM

Because of the differences in hardware, the following functions and statements are incompatible between C64 and X16 BASIC programs.

* `POKE`: write to a memory address
* `PEEK`: read from a memory address
* `WAIT`: wait for memory contents
* `SYS`: execute machine language code (when used with ROM code)

The BASIC interpreter also currently shares all problems of the C64 version, like the slow garbage collector.

## Saving Files

By default, you cannot automatically overwrite a file with SAVE, BSAVE, or OPEN. To overwrite a file, you must prefix the filename with `@:`, like this: `SAVE "@:HELLO WORLD"`. (`"@0:filename"` is also acceptable.)

This follows the Commodore convention, which extended to all of their diskette drives and third party hard drives and flash drive readers.

Always confirm you have successfully saved a file by checking the DOS status. When you use the SAVE command from Immediate (or Direct) mode, the system does this for you. In Program mode, you have to do it yourself.

There are two ways to check the error channel from inside a program:

1. You can use the DOS command and make the user perform actions necessary to recover from an error (such as re-saving the file with an @: prefix).
2. You can read the error yourself, using the following BASIC code:

```BASIC
10 OPEN 15,8,15
20 INPUT#15,A,B$
30 PRINT A;B$
40 CLOSE 15
```

Refer to [Chapter 11](X16%20Reference%20-%2011%20-%20Working%20with%20CMDR-DOS.md) for more details on CMDR-DOS and the command channel.

## New Statements and Functions

There are several new statement and functions. Note that all BASIC keywords (such as `FOR`) get converted into tokens (such as `$81`), and the tokens for the new keywords have likely shifted from one ROM version to the next. Therefore, loading BASIC program saved from an old revision of BASIC may mix up keywords. As of ROM version R42, the keyword token positions should no longer shift and programs saved in R42 BASIC should be compatible with future versions.

### ASC

**TYPE: Integer Function**  
**FORMAT: ASC(&lt;string&gt;)**

**Action:** Returns an integer value representing the PETSCII code for the first character of `string`. If `string` is the empty string, `ASC()` returns 0.

**EXAMPLE of ASC Function:**

```BASIC
?ASC("A")
 65

?ASC("")
 0
```

### BIN$

**TYPE: String Function**  
**FORMAT: BIN\$(n)**

**Action:** Return a string representing the binary value of n. If n <= 255, 8 characters are returned and if 255 < n <= 65535, 16 characters are returned.

**EXAMPLE of BIN\$ Function:**

```BASIC
PRINT BIN$(200)   : REM PRINTS 11001000 AS BINARY REPRESENTATION OF 200
PRINT BIN$(45231) : REM PRINTS 1011000010101111 TO REPRESENT 16 BITS
```

### BANK

**TYPE: Command**  
**FORMAT: BANK m[,n]**

**Action:** Set the active RAM (m) and ROM bank (n) for the purposes of `PEEK`, `POKE`, and `SYS`.  Specifying the ROM bank is optional. If it is not specified, its previous value is retained.

**EXAMPLE of BANK Statement:**

```BASIC
BANK 1,10    : REM SETS THE RAM BANK TO 1 AND THE ROM BANK TO 10
?PEEK($A000) : REM PRINTS OUT THE VALUE STORED IN $A000 IN RAM BANK 1
SYS $C063    : REM CALLS ROUTINE AT $C09F IN ROM BANK 10 AUDIO (YM_INIT)
```

Note: In the above example, the `SYS $C063` in ROM bank 10 is a call to [ym_init](X16%20Reference%20-%2009%20-%20Sound%20Programming.md#audio-api-routines), which does the first half of what the BASIC command `FMINIT` does, without setting any default instruments. It is generally not recommended to call routines in ROM directly this way, and most BASIC programmers will never have a need to call `SYS` directly, but advanced users may find a good reason to do so.

Note: BANK uses its own register to store the the command's desired bank numbers; this will not always be the same as the value stored in `$00` or `$01`. In fact, `$01` is always going to read `4` when PEEKing from BASIC. If you need to know the currently selected RAM and/or RAM banks, you should explicitly set them and use variables to track your selected bank number(s).

Note: Memory address `$00`, which is the hardware RAM bank register, will usually report the bank set by the `BANK` command. The one exception is after a `BLOAD` or `BVERIFY` inside of a running BASIC program.  At this point you can check `PEEK(0)` to learn the bank that `BLOAD`, or `BVERIFY` stopped at.

### BOOT

**TYPE: Command**  
**FORMAT: BOOT**

**Action:** Load and run a PRG file named `AUTOBOOT.X16` from device 8. If the file is not found, nothing is done and no error is printed.

**EXAMPLE of BOOT Statement:**

```BASIC
BOOT
```

### BLOAD

**TYPE: Command**  
**FORMAT: BLOAD &lt;filename&gt;, &lt;device&gt;, &lt;bank&gt;, &lt;address&gt;**

**Action:** Loads a binary file directly into RAM, advancing the RAM bank if necessary. This does not change the active RAM bank as controlled by the `BANK` command, but after this command, the value in memory location `$00` will point to the bank in which the next byte would have been loaded.

**EXAMPLES of BLOAD:**

```BASIC
BLOAD "MYFILE.BIN",8,1,$A000:REM LOADS A FILE NAMED MYFILE.BIN FROM DEVICE 8 STARTING IN BANK 1 AT $A000.
BLOAD "WHO.PCX",8,10,$B000:REM LOADS A FILE NAMED WHO.PCX INTO RAM STARTING IN BANK 10 AT $B000.
```

### BSAVE

**TYPE: Command**  
**FORMAT: BSAVE &lt;filename&gt;, &lt;device&gt;, &lt;bank&gt;, &lt;start address&gt;, &lt;end address&gt;**

**Action:** Saves a region of memory to a binary file.

Note: The save will stop one byte before `end address`.

This command does not allow for automatic bank advancing, but you can achieve a similar result with successive BSAVE invocations to append additional memory locations to the same file.

**EXAMPLES of BSAVE:**

```BASIC
BSAVE "MYFILE.BIN",8,1,$A000,$C000
```

The above example saves a region of memory from \$A000 in bank 1 through and including \$BFFF, stopping before \$C000.

```BASIC
BSAVE "MYFILE.BIN,S,A",8,2,$A000,$B000
```

The above example appends a region of memory from \$A000 through and including \$AFFF, stopping before \$B000.  Running both of the above examples in succession will result in a file MYFILE.BIN 12KiB in size.

### BVLOAD

**TYPE: Command**  
**FORMAT: BVLOAD &lt;filename&gt;, &lt;device&gt;, &lt;VERA_high_address&gt;, &lt;VERA_low_address&gt;**

**Action:** Loads a binary file directly into VERA RAM.

**EXAMPLES of BVLOAD:**

```BASIC
BVLOAD "MYFILE.BIN", 8, 0, $4000  :REM LOADS MYFILE.BIN FROM DEVICE 8 TO VRAM $4000.
BVLOAD "MYFONT.BIN", 8, 1, $F000  :REM LOAD A FONT INTO THE DEFAULT FONT LOCATION ($1F000).
```

### CHAR

**TYPE: Command**  
**FORMAT: CHAR &lt;x&gt;,&lt;y&gt;,&lt;color&gt;,&lt;string&gt;**

**Action:** This command draws a text string on the graphics screen in a given color.

The string can contain printable ASCII characters (`CHR$($20)` to `CHR$($7E)`), as well most PETSCII control codes.

**EXAMPLE of CHAR Statement:**

```BASIC
10 SCREEN $80
20 A$="The quick brown fox jumps over the lazy dog."
24 CHAR 0,6,0,A$
30 CHAR 0,6+12,0,CHR$($04)+A$   :REM UNDERLINE
40 CHAR 0,6+12*2,0,CHR$($06)+A$ :REM BOLD
50 CHAR 0,6+12*3,0,CHR$($0B)+A$ :REM ITALICS
60 CHAR 0,6+12*4,0,CHR$($0C)+A$ :REM OUTLINE
70 CHAR 0,6+12*5,0,CHR$($12)+A$ :REM REVERSE
```

### CLS

**TYPE: Command**  
**FORMAT: CLS**

**Action:** Clears the screen. Same effect as `?CHR$(147);`.

**EXAMPLE of CLS Statement:**

```BASIC
CLS
```

### COLOR

**TYPE: Command**  
**FORMAT: COLOR &lt;fgcol&gt;[,&lt;bgcol&gt;]**

**Action:** This command works sets the text mode foreground color, and optionally the background color.

**EXAMPLES of COLOR Statement:**

```BASIC
COLOR 2   : REM SET FG COLOR TO RED, KEEP BG COLOR
COLOR 2,0 : REM SET FG COLOR TO RED, BG COLOR TO BLACK
```

### DOS

**TYPE: Command**  
**FORMAT: DOS &lt;string&gt;**

**Action:** This command works with the command/status channel or the directory of a Commodore DOS device and has different functionality depending on the type of argument.

* Without an argument, `DOS` prints the status string of the current device.
* With a string argument of `"8"` or `"9"`, it switches the current device to the given number.
* With an argument starting with `"$"`, it shows the directory of the device.
* Any other argument will be sent as a DOS command.

**EXAMPLES of DOS Statement:**

```BASIC
DOS"$"          : REM SHOWS DIRECTORY
DOS"S:BAD_FILE" : REM DELETES "BAD_FILE"
DOS             : REM PRINTS DOS STATUS, E.G. "01,FILES SCRATCHED,01,00"
```

### FMCHORD

**TYPE: Command**  
**FORMAT: FMCHORD &lt;first channel&gt;,&lt;string&gt;**

**Action:** This command uses the same syntax as `FMPLAY`, but instead of playing a series of notes, it will start all of the notes in the string simultaneously on one or more channels. The first parameter to `FMCHORD` is the first channel to use, and will be used for the first note in the string, and subsequent notes in the string will be started on subsequent channels, with the channel after 7 being channel 0.

All macros are supported, even the ones that only affect the behavior of `PSGPLAY` and `FMPLAY`.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of FMCHORD statement:**

```BASIC
10 FMINIT
20 FMVIB 195,10
30 FMINST 1,16:FMINST 2,16:FMINST 3,16 : REM ORGAN
40 FMVOL 1,50:FMVOL 2,50:FMVOL 3,50 : REM MAKE ORGAN QUIETER
50 FMINST 0,11 : REM VIBRAPHONE
60 FMCHORD 1,"O3CG>E T90" : REM START SOME ORGAN CHORDS (CHANNELS 1,2,3)
70 FMPLAY 0,"O4G4.A8G4E2." : REM PLAY MELODY (CHANNEL 0)
80 FMPLAY 0,"O4G4.A8G4E2."
90 FMCHORD 1,"O2G>DB" : REM SWITCH ORGAN CHORDS (CHANNELS 1,2,3)
100 FMPLAY 0,"O5D2D4<B2" : REM PLAY MORE MELODY
110 FMCHORD 1,"O2F" : REM SWITCH ONE OF THE ORGAN CHORD NOTES
120 FMPLAY 0,"R4" : REM PAUSE FOR THE LENGTH OF ONE QUARTER NOTE
130 FMCHORD 1,"O3CEG" : REM SWITCH ALL THREE CHORD NOTES
140 FMPLAY 0,"O5C2C4<G2." : REM PLAY THE REST OF THE MELODY
150 FMCHORD 1,"RRR" : REM RELEASE THE CHANNELS THAT ARE PLAYING THE CHORD
```

This will play the first few lines of *Silent Night* with a vibraphone lead and organ accompaniment.

### FMDRUM

**TYPE: Command**  
**FORMAT: FMDRUM &lt;channel&gt;,&lt;drum number&gt;**

**Action:** Loads a [drum preset](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#drum-presets "list of drum presets") onto the YM2151 and triggers it. Valid range is from 25 to 87, corresponding to the General MIDI percussion note values. FMDRUM will load a patch preset corresponding to the selected drum into the channel. If you then try to play notes on that same channel without loading an instrument patch, it will use the drum patch that was loaded for the drum sound instead, which may not sound particularly musical.

### FMFREQ

**TYPE: Command**  
**FORMAT: FMFREQ &lt;channel&gt;,&lt;frequency&gt;**

**Action:** Play a note by frequency on the YM2151. The accepted range is in Hz from 17 to 4434. FMFREQ also accepts a frequency of 0 to release the note.

**EXAMPLE of FMFREQ statement:**

```BASIC
0 FMINST 0,160 : REM LOAD PURE SINE PATCH
10 FMINST 1,160 : REM HERE TOO
20 FMFREQ 0,350 : REM PLAY A SINE WAVE AT 350 HZ
30 FMFREQ 1,440 : REM PLAY A SINE WAVE AT 440 HZ ON ANOTHER CHANNEL
40 FOR X=1 TO 10000 : NEXT X : REM DELAY A BIT
50 FMFREQ 0,0 : FMFREQ 1,0 : REM RELEASE BOTH CHANNELS
```

The above BASIC program plays a sound similar to a North American dial tone for a few seconds.

### FMINIT

**TYPE: Command**  
**FORMAT: FMINIT**

**Action:** Initialize YM2151, silence all channels, and load a set of default patches into all 8 channels.

### FMINST

**TYPE: Command**  
**FORMAT: FMINST &lt;channel&gt;,&lt;patch&gt;**

Load an instrument onto the YM2151 in the form of a [patch preset](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#fm-instrument-patch-presets) into a channel. Valid channels range from 0 to 7. Valid patches range from 0 to 162.

### FMNOTE

**TYPE: Command**  
**FORMAT: FMNOTE &lt;channel&gt;,&lt;note&gt;**

**Action:** Play a note on the YM2151. The note value is constructed as follows. Using hexadecimal notation, the first nybble is the octave, 0-7, and the second nybble is the note within the octave as follows:

| `$x0` | `$x1` | `$x2` | `$x3` | `$x4` | `$x5` | `$x6` | `$x7` | `$x8` | `$x9` | `$xA` | `$xB` | `$xC` | `$xD-$xF` |
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
| Release | C | C&#9839;/D&#9837; | D | D&#9839;/E&#9837; | E | F | F&#9839;/G&#9837; | G | G&#9839;/A&#9837; | A | A&#9839;/B&#9837; | B | no-op |

Notes can also be represented by negative numbers to skip retriggering, and will thus snap to another note without restarting the playback of the note.

**EXAMPLE of FMNOTE statement:**

```BASIC
0 FMINST 1,64 : REM LOAD SOPRANO SAX
10 FMNOTE 1,$4A : REM PLAYS CONCERT A
20 FOR X=1 TO 5000 : NEXT X : REM DELAYS FOR A BIT
30 FMNOTE 1,0 : REM RELEASES THE NOTE
40 FOR X=1 TO 1000 : NEXT X : REM DELAYS FOR A BIT
50 FMNOTE 1,$3A : REM PLAYS A IN THE 3RD OCTAVE
60 FOR X=1 TO 2500 : NEXT X : REM SHORT DELAY
70 FMNOTE 1,-$3B : REM UP A HALF STEP TO A# WITHOUT RETRIGGERING
80 FOR X=1 TO 2500 : NEXT X : REM SHORT DELAY
90 FMNOTE 1,0 : REM RELEASES THE NOTE
```

### FMPAN

**TYPE: Command**  
**FORMAT: FMPAN &lt;channel&gt;,&lt;panning&gt;**

**Action:** Sets the simple stereo panning on a YM2151 channel. Valid values are as follows:

* 1 = left
* 2 = right
* 3 = both

### FMPLAY

**TYPE: Command**  
**FORMAT: FMPLAY &lt;channel&gt;,&lt;string&gt;**

**Action:** This command is very similar to `PLAY` on other BASICs such as GWBASIC. It takes a string of notes, rests, tempo changes, note lengths, and other macros, and plays all of the notes synchronously.  That is, the FMPLAY command will not return control until all of the notes and rests in the string have been fully played.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of FMPLAY statement:**

```BASIC
10 FMINIT : REM INITIALIZE AND LOAD DEFAULT PATCHES, WILL USE E.PIANO
20 FMPLAY 1,"T90 O4 L4" : REM TEMPO 90 BPM, OCTAVE 4, NOTE LENGTH 4 (QUARTER)
30 FMPLAY 1,"CDECCDECEFGREFGR" : REM FIRST TWO LINES OF TUNE
40 FMPLAY 1,"G8A8G8F8EC G8A8G8F8EC" : REM THIRD LINE
50 FMPLAY 1,"C<G>CRC<G>CR" : REM FOURTH LINE
```

### FMPOKE

**TYPE: Command**  
**FORMAT: FMPOKE &lt;register&gt;,&lt;value&gt;**

**Action:** This command uses the AUDIO API to write a value to one of the the YM2151's registers at a low level.

**EXAMPLE of FMPOKE statement:**

```BASIC
10 FMINIT
20 FMPOKE $28,$4A : REM SET KC TO A4 (A-440) ON CHANNEL 0
30 FMPOKE $08,$00 : REM RELEASE CHANNEL 0
40 FMPOKE $08,$78 : REM START NOTE PLAYBACK ON CHANNEL 0 W/ ALL OPERATORS
```

### FMVIB

**TYPE: Command**  
**FORMAT: FMVIB &lt;speed&gt;,&lt;depth&gt;**

**Action:** This command sets the LFO speed and the phase and amplitude modulation depth values on the YM2151. The speed value ranges from 0 to 255, and corresponds to an LFO frequency from 0.008 Hz to 32.6 Hz.  The depth value ranges from 0-127 and affects both AMD and PMD.

Only some patch presets (instruments) are sensitive to the LFO. Those are marked in [this table](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#fm-instrument-patch-presets) with the &#8224; symbol.  The LFO affects all channels equally, and it depends on the instrument as to whether it is affected.

Good values for most instruments are speed somewhere between 190-220. A good light vibrato for most wind instruments would have a depth of 10-15, while tremolo instruments like the Vibraphone or Tremolo Strings are most realistic around 20-30.

**EXAMPLE of FMVIB statement:**

```BASIC
10 FMVIB 200,30
20 FMINST 0,11 : REM VIBRAPHONE
30 FMPLAY 0,"T60 O4 CDEFGAB>C"
40 FMVIB 0,0
50 FMPLAY 0,"C<BAGFEDC"
```

The above BASIC program plays a C major scale with a vibraphone patch, first with a vibrato/tremolo effect, and then plays the scale in reverse with the vibrato turned off.

### FMVOL

**TYPE: Command**  
**FORMAT: FMVOL &lt;channel&gt;,&lt;volume&gt;**

**Action:** This command sets the channel's volume. The volume remains at the requested level until another `FMVOL` command for that channel or `FMINIT` is called.  Valid range is from 0 (completely silent) to 63 (full volume)

### FRAME

**TYPE: Command**  
**FORMAT: FRAME &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This command draws a rectangle frame on the graphics screen in a given color.

**EXAMPLE of FRAME Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:FRAMERND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*128:NEXT
30 GOTO20
```

### GEOS

**TYPE: Command**  
**FORMAT: GEOS**

**Action:** Enter the GEOS UI.

### HEX\$

**TYPE: String Function**  
**FORMAT: HEX\$(n)**

**Action:** Return a string representing the hexadecimal value of n. If n <= 255, 2 characters are returned and if 255 < n <= 65535, 4 characters are returned.

**EXAMPLE of HEX\$ Function:**

```BASIC
PRINT HEX$(200)   : REM PRINTS C8 AS HEXADECIMAL REPRESENTATION OF 200
PRINT HEX$(45231) : REM PRINTS B0AF TO REPRESENT 16 BIT VALUE
```

### I2CPEEK

**TYPE: Integer Function**  
**FORMAT: I2CPEEK(&lt;device&gt;,&lt;register&gt;)**

**Action:** Returns the value from a register on an I²C device.

**EXAMPLE of I2CPEEK Function:**

```BASIC
PRINT HEX$(I2CPEEK($6F,0) AND $7F)
```

This command reports the seconds counter from the RTC by converting its internal BCD representation to a string.

### I2CPOKE

**TYPE: Command**  
**FORMAT: I2CPOKE &lt;device&gt;,&lt;register&gt;,&lt;value&gt;**

**Action:** Sets the value to a register on an I²C device.

**EXAMPLE of I2CPOKE Function:**

```BASIC
I2CPOKE $6F,$40,$80
```

This command sets a byte in NVRAM on the RTC to the value `$80`

### JOY

**TYPE: Integer Function**  
**FORMAT: JOY(n)**

**Action:** Return the state of a joystick.

`JOY(1)` through `JOY(4)` return the state of SNES controllers connected to the system, and `JOY(0)` returns the state of the "keyboard joystick", a set of keyboard keys that map to the SNES controller layout. See [`joystick_get`](X16%20Reference%20-%2004%20-%20KERNAL.md#function-name-joystick_get) for details.

If no controller is connected to the SNES port (or no keyboard is connected), the function returns -1. Otherwise, the result is a bit field, with pressed buttons `OR`ed together:

| Value  | Button |
|--------|--------|
| \$800   | A      |
| \$400   | X      |
| \$200   | L      |
| \$100   | R      |
| \$080   | B      |
| \$040   | Y      |
| \$020   | SELECT |
| \$010   | START  |
| \$008   | UP     |
| \$004   | DOWN   |
| \$002   | LEFT   |
| \$001   | RIGHT  |

Note that this bitfield is different from the `joystick_get` KERNEL API one. Also note that the keyboard joystick will allow LEFT and RIGHT as well as UP and DOWN to be pressed at the same time, while controllers usually prevent this mechanically.

**EXAMPLE of JOY Function:**

```BASIC
10 REM DETECT CONTROLLER, FALL BACK TO KEYBOARD
20 J = 0: FOR I=1 TO 4: IF JOY(I) >= 0 THEN J = I: GOTO40
30 NEXT
40 :
50 V=JOY(J)
60 PRINT CHR$(147);V;": ";
70 IF V = -1 THEN PRINT"DISCONNECTED ": GOTO50
80 IF V AND 8 THEN PRINT"UP ";
90 IF V AND 4 THEN PRINT"DOWN ";
100 IF V AND 2 THEN PRINT"LEFT ";
110 IF V AND 1 THEN PRINT"RIGHT ";
120 GOTO50
```

### KEYMAP

**TYPE: Command**  
**FORMAT: KEYMAP &lt;string&gt;**

**Action:** This command sets the current keyboard layout. It can be put into an AUTOBOOT file to always set the keyboard layout on boot.

**EXAMPLE of KEYMAP Statement:**

```BASIC
10 KEYMAP"SV-SE"    :REM SMALL BASIC PROGRAM TO SET LAYOUT TO SWEDISH/SWEDEN
SAVE"AUTOBOOT.X16"  :REM SAVE AS AUTOBOOT FILE
```

### LINE

**TYPE: Command**  
**FORMAT: LINE &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This command draws a line on the graphics screen in a given color.

**EXAMPLE of LINE Statement:**

```BASIC
10 SCREEN128
20 FORA=0TO2*πSTEP2*π/200
30 :  LINE100,100,100+SIN(A)*100,100+COS(A)*100
40 NEXT
```

**If you're pasting this example into the Commander X16 emulator, use this code block instead so that the &pi; symbol is properly received.**

```BASIC
10 SCREEN128
20 FORA=0TO2*\XFFSTEP2*\XFF/200
30 :  LINE100,100,100+SIN(A)*100,100+COS(A)*100
40 NEXT
```

### LOCATE

**TYPE: Command**  
**FORMAT: LOCATE &lt;line&gt;[,&lt;column&gt;]**

**Action:** This command positions the text mode cursor at the given location. The values are 1-based. If no column is given, only the line is changed.

**EXAMPLE of LOCATE Statement:**

```BASIC
100 REM DRAW CIRCLE ON TEXT SCREEN
110 SCREEN0
120 R=25
130 X0=40
140 Y0=30
150 FORT=0TO360STEP1
160 :  X=X0+R*COS(T)
170 :  Y=Y0+R*SIN(T)
180 :  LOCATEY,X:PRINTCHR$($12);" ";
190 NEXT
```

### MENU

**TYPE: Command**  
**FORMAT: MENU**

**Action:** This command currently invokes the Commander X16 Control Panel. In the future, the menu may instead present a menu of ROM-based applications and routines.

**EXAMPLE of MON Statement:**

```BASIC
MENU
```

### MON

**TYPE: Command**  
**FORMAT: MON (Alternative: MONITOR)**

**Action:** This command enters the machine language monitor. See the dedicated chapter for a  description.

**EXAMPLE of MON Statement:**

```BASIC
MON
MONITOR
```

### MOUSE

**TYPE: Command**  
**FORMAT: MOUSE &lt;mode&gt;**

**Action:** This command configures the mouse pointer.

| Mode | Description                              |
|------|------------------------------------------|
| 0    | Hide mouse                               |
| 1    | Show mouse, set default mouse pointer    |
| -1   | Show mouse, don't configure mouse cursor |

`MOUSE 1` turns on the mouse pointer and `MOUSE 0` turns it off. If the BASIC program has its own mouse pointer sprite configured, it can use `MOUSE -1`, which will turn the mouse pointer on, but not set the default pointer sprite.

The size of the mouse pointer's area will be configured according to the current screen mode. If the screen mode is changed, the MOUSE statement has to be repeated.

**EXAMPLES of MOUSE Statement:**

```BASIC
MOUSE 1 : REM ENABLE MOUSE
MOUSE 0 : REM DISABLE MOUSE
```

### MX/MY/MB

**TYPE: System variable**  
**FORMAT: MX**  
**FORMAT: MY**  
**FORMAT: MB**

**Action:** Return the horizontal (`MX`) or vertical (`MY`) position of the mouse pointer, or the mouse button state (`MB`).

`MB` returns the sum of the following values depending on the state of the buttons:

| Value | Button |
|-------|--------|
| 0     | none   |
| 1     | left   |
| 2     | right  |
| 4     | third  |

**EXAMPLE of MX/MY/MB variables:**

```BASIC
REM SIMPLE DRAWING PROGRAM
10 SCREEN$80
20 MOUSE1
25 OB=0
30 TX=MX:TY=MY:TB=MB
35 IFTB=0GOTO25
40 IFOBTHENLINEOX,OY,TX,TY,16
50 IFOB=0THENPSETTX,TY,16
60 OX=TX:OY=TY:OB=TB
70 GOTO30
```

### OLD

**TYPE: Command**  
**FORMAT: OLD**

**Action:** This command recovers the BASIC program in RAM that has been previously deleted using the `NEW` command or through a RESET.

**EXAMPLE of OLD Statement:**

```
OLD
```

### POINTER

**TYPE: Function**  
**FORMAT: POINTER(&lt;variable&gt;)**

**Action:** Returns the memory address of the internal structure representing a BASIC variable.

**EXAMPLE of POINTER function:**

```BASIC
10 A$="MOO"
20 PRINT HEX$(POINTER(A$))
RUN
0823
```


### POWEROFF

**TYPE: Command**  
**FORMAT: POWEROFF**

**Action:** This command instructs the SMC to power down the system. This is equivalent to pressing the physical power switch.

**EXAMPLE of POWEROFF Statement:**

```BASIC
POWEROFF
```

### PSET

**TYPE: Command**  
**FORMAT: PSET &lt;x&gt;,&lt;y&gt;,&lt;color&gt;**

**Action:** This command sets a pixel on the graphics screen to a given color.

**EXAMPLE of PSET Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:PSETRND(1)*320,RND(1)*200,RND(1)*256:NEXT
30 GOTO20
```

### PSGCHORD

**TYPE: Command**  
**FORMAT: PSGCHORD &lt;first voice&gt;,&lt;string&gt;**

**Action:** This command uses the same syntax as `PSGPLAY`, but instead of playing a series of notes, it will start all of the notes in the string simultaneously on one or more voices. The first parameter to `PSGCHORD` is the first voice to use, and will be used for the first note in the string, and subsequent notes in the string will be started on subsequent voices, with the voice after 15 being voice 0.

All macros are supported, even the ones that only affect `PSGPLAY` and `FMPLAY`.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of PSGCHORD statement:**

```BASIC
10 PSGINIT
20 PSGCHORD 15,"O3G>CE" : REM STARTS PLAYING A CHORD ON VOICES 15, 0, AND 1
30 PSGPLAY 14,">C<DGB>CDE" : REM PLAYS A SERIES OF NOTES ON VOICE 14
40 PSGCHORD 15,"RRR" : REM RELEASES CHORD ON VOICES 15, 0, AND 1
50 PSGPLAY 14,"O4CAG>C<A" : REM PLAYS A SERIES OF NOTES ON VOICE 14
60 PSGCHORD 0,"O3A>CF" : REM STARTS PLAYING A CHORD ON VOICES 0, 1, AND 2
70 PSGPLAY 14,"L16FGAB->CDEF4" : REM PLAYS A SERIES OF NOTES ON VOICE 
80 PSGCHORD 0,"RRR" : REM RELEASES CHORD ON VOICES 0, 1, AND 2
```

### PSGFREQ

**TYPE: Command**  
**FORMAT: PSGFREQ &lt;voice&gt;,&lt;frequency&gt;**

**Action:** Play a note by frequency on the VERA PSG. The accepted range is in Hz from 1 to 24319. PSGFREQ also accepts a frequency of 0 to release the note.

**EXAMPLE of PSGFREQ statement:**

```BASIC
10 PSGINIT : REM RESET ALL VOICES TO SQUARE WAVEFORM
20 PSGFREQ 0,350 : REM PLAY A SQUARE WAVE AT 350 HZ
30 PSGFREQ 1,440 : REM PLAY A SQUARE WAVE AT 440 HZ ON ANOTHER VOICE
40 FOR X=1 TO 10000 : NEXT X : REM DELAY A BIT
50 PSGFREQ 0,0 : PSGFREQ 1,0 : REM RELEASE BOTH VOICES
```

The above BASIC program plays a sound similar to a North American dial tone for a few seconds.

### PSGINIT

**TYPE: Command**  
**FORMAT: PSGINIT**

**Action:** Initialize VERA PSG, silence all voices, set volume to 63 on all voices, and set the waveform to pulse and the duty cycle to 63 (50%) for all 16 voices.

### PSGNOTE

**TYPE: Command**  
**FORMAT: PSGNOTE &lt;voice&gt;,&lt;note&gt;**

**Action:** Play a note on the VERA PSG. The note value is constructed as follows. Using hexadecimal notation, the first nybble is the octave, 0-7, and the second nybble is the note within the octave as follows:

| `$x0` | `$x1` | `$x2` | `$x3` | `$x4` | `$x5` | `$x6` | `$x7` | `$x8` | `$x9` | `$xA` | `$xB` | `$xC` | `$xD-$xF` |
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
| Release | C | C&#9839;/D&#9837; | D | D&#9839;/E&#9837; | E | F | F&#9839;/G&#9837; | G | G&#9839;/A&#9837; | A | A&#9839;/B&#9837; | B | no-op |

**EXAMPLE of PSGNOTE statement:**

```BASIC
10 PSGNOTE 1,$4A : REM PLAYS CONCERT A
20 FOR X=1 TO 5000 : NEXT X : REM DELAYS FOR A BIT
30 PSGNOTE 1,0 : REM RELEASES THE NOTE
40 FOR X=1 TO 2500 : NEXT X : REM SHORT DELAY
50 PSGNOTE 1,$3A : REM PLAYS A IN THE 3RD OCTAVE
60 FOR X=1 TO 2500 : NEXT X : REM SHORT DELAY
70 PSGNOTE 1,0 : REM RELEASES THE NOTE
```

### PSGPAN

**TYPE: Command**  
**FORMAT: PSGPAN &lt;voice&gt;,&lt;panning&gt;**

**Action:** Sets the simple stereo panning on a VERA PSG voice. Valid values are as follows:

* 1 = left
* 2 = right
* 3 = both

### PSGPLAY

**TYPE: Command**  
**FORMAT: PSGPLAY &lt;voice&gt;,&lt;string&gt;**

**Action:** This command is very similar to `PLAY` on other BASICs such as GWBASIC. It takes a string of notes, rests, tempo changes, note lengths, and other macros, and plays all of the notes synchronously.  That is, the PSGPLAY command will not return control until all of the notes and rests in the string have been fully played.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of PSGPLAY statement:**

```BASIC
10 PSGWAV 0,31 : REM PULSE, 25% DUTY
20 PSGPLAY 0,"T180 S0 O5 L32" : REM TEMPO 180 BPM, LEGATO, OCTAVE 5, 32ND NOTES
30 PSGPLAY 0,"C<G>CEG>C<G<A-"
40 PSGPLAY 0,">CE-A-E-A->CE-A-"
50 PSGPLAY 0,"E-<<B->DFB-FB->DFB-F" : REM GRAB YOURSELF A MUSHROOM
```

### PSGVOL

**TYPE: Command**  
**FORMAT: PSGVOL &lt;voice&gt;,&lt;volume&gt;**

**Action:** This command sets the voice's volume. The volume remains at the requested level until another `PSGVOL` command for that voice or `PSGINIT` is called.  Valid range is from 0 (completely silent) to 63 (full volume).

### PSGWAV

**TYPE: Command**  
**FORMAT: PSGWAV &lt;voice&gt;,&lt;w&gt;**

**Action:** Sets the waveform and duty cycle for a PSG voice.

* w = 0-63 -> Pulse: Duty cycle is `(w+1)/128`. A value of 63 means 50% duty.
* w = 64-127 -> Sawtooth (all values have identical effect)
* w = 128-191 -> Triangle (all values have identical effect)
* w = 192-255 -> Noise (all values have identical effect)

**EXAMPLE of PSGWAV Statement:**

```BASIC
10 FOR O=$20 TO $50 STEP $10:REM OCTAVE LOOP
20 FOR N=1 TO 11 STEP 2:REM NOTE LOOP, EVERY OTHER NOTE
30 PSGNOTE 0,O+N:REM START PLAYBACK OF THE NOTE
40 FOR P=0 TO 30:REM PULSE WIDTH MODULATION LOOP (INCREASING DUTY)
50 PSGWAV 0,P:REM SET PW
60 FOR D=1 TO 30:NEXT D:REM DELAY LOOP
70 NEXT P
80 PSGNOTE 0,O+N+1:REM START PLAYBACK OF THE NOTE + A SEMITONE
90 FOR P=31 TO 1 STEP -1:REM PWM LOOP (DECREASING DUTY)
100 PSGWAV 0,P:REM SET PW
110 FOR D=1 TO 30:NEXT D:REM DELAY LOOP
120 NEXT P
130 NEXT N
140 NEXT O
150 PSGNOTE 0,0:REM STOP SOUND
```

This example plays a chromatic scale while applying pulse-width modulation on the voice.

### RECT

**TYPE: Command**  
**FORMAT: RECT &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This command draws a solid rectangle on the graphics screen in a given color.

**EXAMPLE of RECT Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:RECTRND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*256:NEXT
30 GOTO20
```

### REBOOT

**TYPE: Command**  
**FORMAT: REBOOT**

**Action:** Performs a software reset of the system by calling the ROM reset vector.

**EXAMPLE of REBOOT Statement:**

```BASIC
REBOOT
```

### REN

**TYPE: Command**  
**FORMAT: REN [&lt;new line num&gt;[, &lt;increment&gt;[, &lt;first old line num&gt;]]]**

**Action:** Renumbers a BASIC program while updating the line number arguments of GOSUB, GOTO, RESTORE, RUN, and THEN.

Optional arguments:  
- The line number of the first line after renumbering, default: **10**  
- The value of the increment for subsequent lines, default **10**  
- The earliest old line to start renumbering at, default: **0**  

**THIS STATEMENT IS EXPERIMENTAL**.  Please ensure your have saved your program before using this command to renumber.

**EXAMPLE of REN Statement:**

```BASIC
10 PRINT "HELLO"
20 DATA 1,2,3
30 DATA 4,5,6
40 READ X
50 PRINT X
60 RESTORE 30
70 READ X
80 PRINT X
90 GOTO 10

REN 100,5

LIST
100 PRINT "HELLO"
105 DATA 1,2,3
110 DATA 4,5,6
115 READ X
120 PRINT X
125 RESTORE 110
130 READ X
135 PRINT X
140 GOTO 100
READY.
```

### RESET

**TYPE: Command**  
**FORMAT: RESET**

**Action:** This command instructs the SMC to assert the reset line on the system, which performs a hard reset. This is equivalent to pressing the physical reset switch.

**EXAMPLE of RESET Statement:**

```BASIC
RESET
```

### RESTORE

**TYPE: Command**  
**FORMAT: RESTORE \[&lt;linenum&gt;\]**

**Action:** This command resets the pointer for the `READ` command. Without arguments, it will reset the pointer to the first `DATA` constant in the program.  With a parameter `linenum`, the command will reset the pointer to the first `DATA` constant at or after that line number.

**EXAMPLE of RESTORE Statement:**

```BASIC
10 DATA 1,2,3
20 DATA 4,5,6
30 READ Y
40 PRINT Y
50 RESTORE 20
60 READ Y
70 PRINT Y
```

This program will output the number 1 followed by the number 4.

### SCREEN

**TYPE: Command**  
**FORMAT: SCREEN &lt;mode&gt;**

**Action:** This command switches screen modes.

For a list of supported modes, see [Chapter 2: Editor](X16%20Reference%20-%2002%20-%20Editor.md). The value of -1 toggles between modes \$00 and \$03.

**EXAMPLE of SCREEN Statement:**

```BASIC
SCREEN 3 : REM SWITCH TO 40 CHARACTER MODE
SCREEN 0 : REM SWITCH TO 80 CHARACTER MODE
SCREEN -1 : REM SWITCH BETWEEN 40 and 80 CHARACTER MODE
```

### SLEEP

**TYPE: Command**  
**FORMAT: SLEEP \[&lt;jiffies&gt;\]**

**Action:** With the default interrupt source configured and enabled, this command waits for `jiffies`+1 VSYNC events and then resumes program execution. In other words, `SLEEP` with no arguments is equivalent to `SLEEP 0`, which waits until the beginning of the next frame. Another useful example, `SLEEP 60`, pauses for approximately 1 second.

Allowed values for `jiffies` is from 0 to 65535, inclusive.

**EXAMPLE of SLEEP Statement:**

```BASIC
10 FOR I=1 TO 10
20 PRINT I
30 SLEEP 60
40 NEXT
```

### STRPTR

**TYPE: Function**  
**FORMAT: STRPTR(&lt;variable&gt;)**

**Action:** Returns the memory address of the first character of a string contained within a string variable. If the string variable has zero length, this function will likely still return a non-zero value pointing either to the close quotation mark in the literal assignment, or to somewhere undefined in string memory. Programs should check the `LEN()` of string variables before using the pointer returned from `STRPTR`.

**EXAMPLE of STRPTR function:**

```BASIC
10 A$="MOO"
20 P=STRPTR(A$)
30 FOR I=0 TO LEN(A$)-1
40 PRINT CHR$(PEEK(P+I));
50 NEXT
60 A$=""
70 P=STRPTR(A$)
80 FOR I=0 TO LEN(A$)-1 : REM THIS LOOP WILL STILL ALWAYS HAPPEN ONCE
90 PRINT CHR$(PEEK(P+I));
100 NEXT
RUN
MOO"
READY.
```

In this case, the pointer returned on line 70 pointed to the first character after the open quote on line 60. Since it was an empty string, the pointer ended up pointing to the close quote. To avoid this scenario, we should have checked the `LEN(A$)` before line 80 and skipped over the loop.

### SYS

**TYPE: Command**  
**FORMAT: SYS &lt;address&gt;**

**Action:** The SYS command executes a machine language subroutine located at &lt;address&gt;.
Execution continues until an RTS is executed, and control returns to the BASIC program.

In order to communicate with the routine, you can pre-load the CPU registers by using POKE to write to the following
memory locations:

* `$030C`: Accumulator
* `$030D`: X Register
* `$030E`: Y Register
* `$030F`: Status Register/Flags

When the routine is over, the CPU registers will be loaded back in to these locations. So you can read the results of a machine language routine by PEEKing these locations.

**EXAMPLE of SYS statemet:**

Push a &lt;CR&gt; into the keyboard buffer.

```
POKE $30C,13
SYS $FEC3
```

Run the Machine Language Monitor (Supermon)

```BASIC
SYS  $FECC
```

### VPEEK

**TYPE: Integer Function**  
**FORMAT: VPEEK (&lt;bank&gt;, &lt;address&gt;)**

**Action:** Return a byte from the video address space. The video address space has 17 bit addresses, which is exposed as 2 banks of 65536 addresses each.

**EXAMPLE of VPEEK Function:**

```BASIC
PRINT VPEEK(1,$B000) : REM SCREEN CODE OF CHARACTER AT 0/0 ON SCREEN
```

### VPOKE

**TYPE: Command**  
**FORMAT: VPOKE &lt;bank&gt;, &lt;address&gt;, &lt;value&gt;**

**Action:** Set a byte in the video address space. The video address space has 17 bit addresses, which is exposed as 2 banks of 65536 addresses each.

**EXAMPLE of VPOKE Statement:**

```BASIC
VPOKE 1,$B000+1,1 * 16 + 2 : REM SETS THE COLORS OF THE CHARACTER
                             REM AT 0/0 TO RED ON WHITE
```

### VLOAD

**TYPE: Command**  
**FORMAT: VLOAD &lt;filename&gt;, &lt;device&gt;, &lt;VERA_high_address&gt;, &lt;VERA_low_address&gt;**

**Action:** Loads a file directly into VERA RAM, skipping the two-byte header that is presumed to be in the file.

**EXAMPLES of VLOAD:**

```BASIC
VLOAD "MYFILE.PRG", 8, 0, $4000  :REM LOADS MYFILE.PRG FROM DEVICE 8 TO VRAM $4000
                                  REM WHILE SKIPPING THE FIRST TWO BYTES OF THE FILE.
```

To load a raw binary file without skipping the first two bytes, use [`BVLOAD`](#bvload)

## Other New Features

### Hexadecimal and Binary Literals

The numeric constants parser supports both hex (`$`) and binary (`%`) literals, like this:

```BASIC
PRINT $EA31 + %1010
```

The size of hex and binary values is only restricted by the range that can be represented by BASIC's internal floating point representation.

### LOAD into VRAM

In BASIC, the contents of files can be directly loaded into VRAM with the `LOAD` statement. When a secondary address greater than one is used, the KERNAL will now load the file into the VERA's VRAM address space. The first two bytes of the file are used as lower 16 bits of the address. The upper 4 bits are `(SA-2) & 0x0ff` where `SA` is the secondary address.

Examples:

```BASIC
10 REM LOAD VERA SETTINGS
20 LOAD"VERA.BIN",1,17 : REM SET ADDRESS TO $FXXXX
30 REM LOAD TILES
40 LOAD"TILES.BIN",1,3 : REM SET ADDRESS TO $1XXXX
50 REM LOAD MAP
60 LOAD"MAP.BIN",1,2 : REM SET ADDRESS TO $0XXXX
```

### Default Device Numbers

In BASIC, the LOAD, SAVE and OPEN statements default to the last-used IEEE device (device numbers 8 and above), or 8.

## Internal Representation

Like on the C64, BASIC keywords are tokenized.

* The C64 BASIC V2 keywords occupy the range of \$80 (`END`) to \$CB (`GO`).
* BASIC V3.5 also used \$CE (`RGR`) to \$FD (`WHILE`).
* BASIC V7 introduced the \$CE escape code for function tokens \$CE-\$02 (`POT`) to \$CE-\$0A (`POINTER`), and the \$FE escape code for statement tokens \$FE-\$02 (`BANK`) to \$FE-\$38 (`SLOW`).
* The unreleased BASIC V10 extended the escaped tokens up to \$CE-\$0D (`RPALETTE`) and \$FE-\$45 (`EDIT`).

The X16 BASIC aims to be as compatible as possible with this encoding. Keywords added to X16 BASIC that also exist in other versions of BASIC match the token, and new keywords are encoded in the ranges \$CE-\$80+ and \$FE-\$80+.

## Auto-Boot

When BASIC starts, it automatically executes the `BOOT` command, which tries to load a PRG file named `AUTOBOOT.X16` from device 8 and, if successful, runs it. Here are some use cases for this:

* An SD card with a game can auto-boot this way.
* An SD card with a collection of applications can show a menu that allows selecting an application to load.
* The user's "work" SD card can contain a small auto-boot BASIC program that sets the keyboard layout and changes the screen colors, for example.
