# Chapter 4: BASIC Programming

<!--
********************************************************************************
NOTICE: This file uses two trailing spaces on some lines to indicate line breaks
for GitHub's Markdown flavor. Do not remove!
********************************************************************************
New styling features were used in this document and may not render correctly  
when viewed on github.  PDF output appears correct.
-->

## Table of BASIC Statements and Functions

| Keyword | Type | Summary | Origin |
| - | - | - | - |
| [`ABS`](#abs)  | Numeric Function | Returns absolute value of a number | C64 |
| [`AND`](#and) | Operator | Returns boolean "AND" or bitwise intersection | C64 |
| [`ASC`](#asc) | Numeric Function | Returns numeric PETSCII value from string | C64 |
| [`ATN`](#atn) | Numeric Function | Returns arctangent of a number | C64 |
| [`BANK`](#bank) | Command | Sets the RAM and ROM banks to use for PEEK, POKE, and SYS | C128 |
| [`BASLOAD`](#bank) | Command | Load and tokenize a BASLOAD (.basl) text file | X16 |
| [`BIN$`](#bin) | String Function | Converts numeric to a binary string | X16 |
| [`BINPUT#`](#binput) | I/O Statement | Reads a fixed-length block of data from an open file | X16 |
| [`BLOAD`](#bload) | Command | Loads a headerless binary file from disk to a memory address | X16 |
| [`BOOT`](#boot) | Command | Loads and runs `AUTOBOOT.X16` | X16 |
| [`BSAVE`](#bsave) | Command | Saves a headerless copy of a range of memory to a file | X16 |
| [`BVERIFY`](#bverify) | Command | Verifies that a file on disk matches RAM contents | X16 |
| [`BVLOAD`](#bvload) | Command | Loads a headerless binary file from disk to VRAM | X16 |
| [`CHAR`](#char) | Command | Draws a text string in graphics mode | X16 |
| [`CHR$`](#chr) | String Function | Returns PETSCII character from numeric value | C64 |
| [`CLOSE`](#close) | I/O Statement | Closes a logical file number | C64 |
| [`CLR`](#clr) | Statement | Clears BASIC variable state | C64 |
| [`CLS`](#cls) | Statement | Clears the screen | X16 |
| [`CMD`](#cmd) | I/O Statement | Redirects output to non-screen device | C64 |
| [`COLOR`](#color) | Statement | Sets text foreground and background color | X16 |
| [`CONT`](#cont) | Command | Resumes execution of a BASIC program | C64 |
| [`COS`](#cos) | Function | Returns cosine of an angle in radians | C64 |
| [`DA$`](#da$) | String Function | Returns the date in YYYYMMDD format from the system clock | X16 |
| [`DATA`](#data) | Statement | Declares one or more constants | C64 |
| [`DEF FN`](#def-fn) | Statement | Defines a function for use later in BASIC | C64 |
| [`DIM`](#dim) | Statement | Allocates storage for an array | C64 |
| [`DOS`](#dos) | Command | Disk and SD card directory operations | X16 |
| [`EDIT`](#edit) | Command | Open the built-in text editor | X16 |
| [`END`](#end) | Statement | Terminate program execution and return to `READY.` | C64 |
| [`EXEC`](#exec) | Command | Play back a script from RAM into the BASIC editor | X16 |
| [`EXP`](#exp) | Function | Returns the inverse natural log of a number | C64 |
| [`FMCHORD`](#fmchord) | Statement | Start or stop simultaneous notes on YM2151 | X16 |
| [`FMDRUM`](#fmdrum) | Statement | Plays a drum sound on YM2151 | X16 |
| [`FMFREQ`](#fmfreq) | Statement | Plays a frequency in Hz on YM2151 | X16 |
| [`FMINIT`](#fminit) | Statement | Stops sound and reinitializes YM2151 | X16 |
| [`FMINST`](#fminst) | Statement | Loads a patch preset into a YM2151 channel | X16 |
| [`FMNOTE`](#fmnote) | Statement | Plays a musical note on YM2151 | X16 |
| [`FMPAN`](#fmpan) | Statement | Sets stereo panning on YM2151 | X16 |
| [`FMPLAY`](#fmplay) | Statement | Plays a series of notes on YM2151 | X16 |
| [`FMPOKE`](#fmpoke) | Statement | Writes a value into a YM2151 register | X16 |
| [`FMVIB`](#fmvib) | Statement | Controls vibrato and tremolo on YM2151 | X16 |
| [`FMVOL`](#fmvol) | Statement | Sets channel volume on YM2151 | X16 |
| [`FN`](#fn) | Function | Calls a previously defined function | C64 |
| [`FOR-TO-STEP`](#for-to-step) | Statement | Declares the start of a loop construct | C64 |
| [`FRAME`](#frame) | Statement | Draws an unfilled rectangle in graphics mode | X16 |
| [`FRE`](#fre) | Function | Returns the number of unused BASIC bytes free | C64 |
| [`GET`](#get) | Statement | Polls the keyboard cache for a single keystroke | C64 |
| [`GET#`](#get-1) | I/O Statement | Polls an open logical file for a single character | C64 |
| [`GOSUB`](#gosub) | Statement | Jumps to a BASIC subroutine | C64 |
| [`GOTO`](#goto) | Statement | Branches immediately to a line number | C64 |
| [`HELP`](#help) | Command | Displays a brief summary of online help resources | X16 |
| [`HEX$`](#hex) | String Function | Converts numeric to a hexadecimal string | X16 |
| [`I2CPEEK`](#i2cpeek) | Function | Reads a byte from a device on the I²C bus | X16 |
| [`I2CPOKE`](#i2cpoke) | Statement | Writes a byte to a device on the I²C bus | X16 |
| [`IF-THEN`](#if-then) | Statement | Tests a boolean condition and branches on result | C64 |
| [`INPUT`](#input) | Statement | Reads a line or values from the keyboard | C64 |
| [`INPUT#`](#input-1) | I/O Statement | Reads lines or values from a logical file | C64 |
| [`INT`](#int) | Integer Function | Discards the fractional part of a number | C64 |
| [`JOY`](#joy) | Integer Function | Reads gamepad button state | X16 |
| [`KEYMAP`](#keymap) | Command | Changes the keyboard layout | X16 |
| [`LEFT$`](#left) | String Function | Returns a substring starting from the beginning of a string | C64 |
| [`LEN`](#len) | Integer Function | Returns the length of a string | C64 |
| [`LET`](#let) | Statement | Explicitly declares a variable | C64 |
| [`LINE`](#line) | Statement | Draws a line in graphics mode | X16 |
| [`LINPUT`](#linput) | Statement | Reads a line from the keyboard | X16 |
| [`LINPUT#`](#linput-1) | I/O Statement | Reads a line or other delimited data from an open file | X16 |
| [`LIST`](#list) | Command | Outputs the program listing to the screen | C64 |
| [`LOAD`](#load) | Command | Loads a program from disk into memory | C64 |
| [`LOCATE`](#locate) | Statement | Moves the text cursor to new location | X16 |
| [`LOG`](#log) | Floating-Point Function | Returns the natural logarithm of a number | C64 |
| [`MENU`](#menu) | Command | Invokes the Commander X16 utility menu | X16 |
| [`MID$`](#mid) | String Function | Returns a substring from the middle of a string | C64 |
| [`MOD`](#mod) | Function | Returns the truncated remainder of a division | X16 |
| [`MON`](#mon) | Command | Enters the machine language monitor | X16 |
| [`MOUSE`](#mouse) | Statement | Hides or shows mouse pointer | X16 |
| [`MOVSPR`](#movspr) | Statement | Set the X/Y position of a sprite | X16 |
| [`MX/MY/MB`](#mxmymb) | variable | Reads the mouse position and button state | X16 |
| [`MWHEEL`](#mwheel) | variable | Reads the mouse wheel movement | X16 |
| [`NEW`](#new) | Command | Resets the state of BASIC and clears program memory | C64 |
| [`NEXT`](#next) | Statement | Declares the end of a loop construct | C64 |
| [`NOT`](#not) | Logical Operator | Bitwise or boolean inverse | C64 |
| [`OLD`](#old) | Command | Undoes a NEW command or warm reset | X16 |
| [`ON`](#on) | Statement | A GOTO/GOSUB table based on a variable value | C64 |
| [`OPEN`](#open) | I/O Statement | Opens a logical file to disk or other device | C64 |
| [`OR`](#or) | Logical Operator | Bitwise or boolean "OR" | C64 |
| [`OVAL`](#oval) | Statement | Draws a filled oval in graphics mode | X16 |
| [`PEEK`](#peek) | Function | Returns a value from a memory address | C64 |
| `π` | Function | Returns the constant for the value of pi | C64 |
| [`POINTER`](#pointer) | Function | Returns the address of a BASIC variable | C128 |
| [`POKE`](#poke) | Statement | Assigns a value to a memory address | C64 |
| [`POS`](#pos) | Integer Function | Returns the column position of the text cursor | C64 |
| [`POWEROFF`](#poweroff) | Command | Immediately powers down the Commander X16 | X16 |
| [`PRINT`](#print) | Statement | Prints data to the screen or other output | C64 |
| [`PRINT#`](#print-1) | I/O Statement | Prints data to an open logical file | C64 |
| [`PSET`](#pset) | Statement | Changes a pixel's color in graphics mode | X16 |
| [`PSGCHORD`](#psgchord) | Statement | Starts or stops simultaneous notes on VERA PSG | X16 |
| [`PSGFREQ`](#psgfreq) | Statement | Plays a frequency in Hz on VERA PSG | X16 |
| [`PSGINIT`](#psginit) | Statement | Stops sound and reinitializes VERA PSG | X16 |
| [`PSGNOTE`](#psgnote) | Statement | Plays a musical note on VERA PSG | X16 |
| [`PSGPAN`](#psgpan) | Statement | Sets stereo panning on VERA PSG | X16 |
| [`PSGPLAY`](#psgplay) | Statement | Plays a series of notes on VERA PSG | X16 |
| [`PSGVOL`](#psgvol) | Statement | Sets voice volume on VERA PSG | X16 |
| [`PSGWAV`](#psgwav) | Statement | Sets waveform on VERA PSG | X16 |
| [`READ`](#read) | Statement | Assigns the next `DATA` constant to one or more variables | C64 |
| [`REBOOT`](#reboot) | Command | Performs a warm reboot of the system | X16 |
| [`RECT`](#rect) | Statement | Draws a filled rectangle in graphics mode | X16 |
| [`REM`](#rem) | Statement | Declares a comment | C64 |
| [`REN`](#ren) | Command | Renumbers a BASIC program | X16 |
| [`RESET`](#reset) | Command | Performs a hard reset of the system | X16 |
| [`RESTORE`](#restore) | Statement | Resets the `READ` pointer to a `DATA` constant | C64 |
| [`RETURN`](#return) | Statement | Returns from a subroutine to the statement following a GOSUB | C64 |
| [`RIGHT$`](#right) | String Function | Returns a substring from the end of a string | C64 |
| [`RING`](#ring) | Statement | Draws an oval outline in graphics mode | X16 |
| [`RND`](#rnd) | Floating-Point Function | Returns a floating point number 0 <= n < 1 | C64 |
| [`RPT$`](#rpt) | String Function | Returns a string of repeated characters | X16 |
| [`RUN`](#run) | Command | Clears the variable state and starts a BASIC program | C64 |
| [`SAVE`](#save) | Command | Saves a BASIC program from memory to disk | C64 |
| [`SCREEN`](#screen) | Statement | Selects a text or graphics mode | X16 |
| [`SGN`](#sgn) | Integer Function | Returns the sign of a numeric value | C64 |
| [`SIN`](#sin) | Floating-Point Function | Returns the sine of an angle in radians | C64 |
| [`SLEEP`](#sleep) | Statement | Introduces a delay in program execution | X16 |
| [`SPC`](#spc) | Special Function | Returns a string with a set number of spaces | C64 |
| [`SPRITE`](#sprite) | Statement | Sets attributes for a sprite including visibility | X16 |
| [`SPRMEM`](#sprmem) | Statement | Set the VRAM address for a sprite's visual data | X16 |
| [`SQR`](#sqr) | Floating-Point Function | Returns the square root of a numeric value | C64 |
| [`ST`](#st) | Integer Function | Returns the status of certain DOS/peripheral operations | C64 |
| [`STEP`](#step) | Statement | Used in a `FOR` declaration to declare the iterator step | C64 |
| [`STOP`](#stop) | Statement | Breaks out of a BASIC program | C64 |
| [`STR$`](#str) | String Function | Converts a numeric value to a string | C64 |
| [`STRPTR`](#strptr) | Function | Returns the address of a BASIC string | X16 |
| [`SYS`](#sys) | Command | Transfers control to machine language at a memory address | C64 |
| [`TAB`](#tab) | Special Function | Returns a string with spaces used for column alignment | C64 |
| [`TAN`](#tan) | Floating-Point Function | Return the tangent for an angle in radians | C64 |
| [`TATTR`](#tattr) | Function | Returns a tile attribute from the tile/text layer | X16 |
| [`TDATA`](#tdata) | Function | Returns a tile from the tile/text layer | X16 |
| [`TILE`](#tile) | Command | Changes a tile or character on the tile/text layer | X16 |
| [`TIME`](#time) | Numeric Function | Returns the jiffy timer value | C64 |
| [`TIME$`](#time-1) | String Function | Returns the time HHMMSS from the system clock | C64 |
| [`USR`](#usr) | Floating-Point Function | Call a user-defined function in machine language | C64 |
| [`VAL`](#val) | Numeric Function | Parse a string to return a numeric value | C64 |
| [`VERIFY`](#verify) | Command | Verify that a BASIC program was written to disk correctly | C64 |
| [`VPEEK`](#vpeek) | Function | Returns a value from VERA's VRAM | X16 |
| [`VPOKE`](#vpoke) | Statement | Sets a value in VERA's VRAM | X16 |
| [`VLOAD`](#vload) | Statement | Loads a file to VERA's VRAM | X16 |
| [`WAIT`](#wait) | Statement | Waits for a memory location to match a condition | C64 |

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
* The BASIC vector table ($0300-$030B, $0311/$0312)
* [`SYS`](#sys) arguments in RAM

Because of the differences in hardware, the following functions and statements are incompatible between C64 and X16 BASIC programs.

* [`POKE`](#poke): write to a memory address
* [`PEEK`](#peek): read from a memory address
* [`WAIT`](#wait): wait for memory contents
* [`SYS`](#sys): execute machine language code (when used with ROM code)

The BASIC interpreter also currently shares all problems of the C64 version, like the slow garbage collector.

## Saving Files

By default, you cannot automatically overwrite a file with [`SAVE`](#save), [`BSAVE`](#bsave), or [`OPEN`](#open). To overwrite a file, you must prefix the filename with `@:`, like this: `SAVE "@:HELLO WORLD"`. (`"@0:filename"` is also acceptable.)

This follows the Commodore convention, which extended to all of their diskette drives and third party hard drives and flash drive readers.

Always confirm you have successfully saved a file by checking the DOS status. When you use the SAVE command from Immediate (or Direct) mode, the system does this for you. In Program mode, you have to do it yourself.

There are two ways to check the error channel from inside a program:

1. You can use the [`DOS`](#dos) command and make the user perform actions necessary to recover from an error (such as re-saving the file with an @: prefix).
2. You can read the error yourself, using the following BASIC code:

```BASIC
10 OPEN 15,8,15
20 INPUT#15,A,B$
30 PRINT A;B$
40 CLOSE 15
```

Refer to [Chapter 13](X16%20Reference%20-%2013%20-%20Working%20with%20CMDR-DOS.md#chapter-13-working-with-cmdr-dos) for more details on CMDR-DOS and the command channel.

## New Statements and Functions

There are several new statement and functions. Note that all BASIC keywords (such as [`FOR`](#for-to-step)) get converted into tokens (such as `$81`), and the tokens for the new keywords have likely shifted from one ROM version to the next. Therefore, loading BASIC program saved from an old revision of BASIC may mix up keywords. As of ROM version R42, the keyword token positions should no longer shift and programs saved in R42 BASIC should be compatible with future versions.

### ABS

**TYPE: Integer Function**  
**FORMAT: ABS(&lt;expression&gt;)**

**Action:** Returns the absolute value of the given expression, which is its value without a sign.

**EXAMPLE of the ABS Function:**

```BASIC
PRINT ABS(-24)
 24

PRINT ABS(50)
 50
```

### AND

**TYPE: Operator**  
**FORMAT: &lt;expression&gt; AND &lt;expression&gt;**

**Action:** `AND` is used in Boolean operations to test bits.  It can also be used in operations 
to check the truth of both operands.

In Boolean algebra, the result of an `AND` operation is 1 only if both numbers being `AND`ed are 1.  The result is 
0 if either or both operands is 0 (false).

**Simple 1 bit truth table for AND**

|  |  |  |  |  |
| :-- | --: | --: | --: | --: |
| Operand 1 | 0 | 1 | 0 | 1 |
| Operand 2 | 0 | 0 | 0 | 1 |
| Result | 0 | 0 | 0 | 1 |

The Commander X16 BASIC can perform the `AND` operation on numbers in the range -32768 to +32767.  Any fractional values are ignored, and numbers beyond the stated range will cause an `?ILLEGAL QUANTITY` error.  When converted to binary format, the range allowed yields 16 bits for each operand.  Corresponding bits are ANDed together, forming a 16 bit result in the same range.

**EXAMPLES of 16 bit AND Operation:**

```
                                37
                           AND 123
               0000 0000 0010 0101
               0000 0000 0111 1011
Binary Result: 0000 0000 0010 0001
Decimal Result: 33

                                 3
                         AND 21432
               0101 0011 1011 1000
               0000 0000 0000 0011
Binary Result: 0000 0000 0000 0000
Decimal Result: 0

```
When evaluating a number for true or false, the computer assumes the number is true as long as its value isn't 0.  When evaluating a comparison, it assigns a value of -1 if the result is true, while false has a value of 0.  In binary format, -1 is all 1's and 0 is all 0's.  Therefore, when ANDing true/false evaluations, the result will be true if any bits in the result are true.

**EXAMPLES of the AND Operator:**

```BASIC
10 REM Test, set, and clear specific bits in a value
20 A = 321
30 IF A AND 7 THEN PRINT "BIT 7 IS SET"
40 A = A OR 5 : REM Set bit 5
50 IF A AND 5 THEN PRINT "BIT 5 IS SET"
60 A = A AND (255 - 7) : REM Clear bit 7
70 IF NOT A AND 7 THEN PRINT "BIT 7 IS NOT SET"
```

```BASIC
10 REM True/False evaluations.
20 IF A=21 AND B=30 THEN GOTO 40: REM only true if both are true.
30 IF Z AND M=8 THEN GOTO 40: REM True if A is non-zero and M=8 is true.
40 PRINT "DONE."
```

### ASC

**TYPE: Integer Function**  
**FORMAT: ASC(&lt;string&gt;)**

**Action:** Returns an integer value representing the [PETSCII](X16%20Reference%20-%20Appendix%20I%20-%20Character%20Sets.md#pet-uppercase--graphics) code for the first character of &lt;string&gt;. If &lt;string&gt; is an empty ("") string, `ASC` returns 0.

**EXAMPLE of the ASC Function:**

```BASIC
PRINT ASC("A")
 65

PRINT ASC("")
 0
```

### ATN

**TYPE: Integer Function**  
**FORMAT: ATN(&lt;number&gt;)**

**Action:** This mathematical function returns the arctangent of the number given.  The result is the angle (in radians) whose tangent is the number given.  The result is always in the range -&pi; / 2 to +&pi; / 2.

**EXAMPLES of the ATN Function:**

```BASIC
10 PRINT ATN(5)
20 A=ATN(Z) * 180 / PI; : REM Convert to degrees.
```

### BANK

**TYPE: Command**  
**FORMAT: BANK m[,n]**

**Action:** Set the active RAM (m) and ROM bank (n) for the purposes of [`PEEK`](#peek), [`POKE`](#poke), and [`SYS`](#sys).  Specifying the ROM bank is optional. If it is not specified, its previous value is retained.

**EXAMPLE of the BANK Statement:**

```BASIC
BANK 1,10    : REM SETS THE RAM BANK TO 1 AND THE ROM BANK TO 10
PRINT PEEK($A000) : REM PRINTS OUT THE VALUE STORED IN $A000 IN RAM BANK 1
SYS $C063    : REM CALLS ROUTINE AT $C09F IN ROM BANK 10 AUDIO (YM_INIT)
```

Note: In the above example, the `SYS $C063` in ROM bank 10 is a call to [ym_init](X16%20Reference%20-%2011%20-%20Sound%20Programming.md#audio-api-routines), which does the first half of what the BASIC command [`FMINIT`](#fminit) does, without setting any default instruments. It is generally not recommended to call routines in ROM directly this way, and most BASIC programmers will never have a need to call [`SYS`](#sys) directly, but advanced users may find a good reason to do so.

Note: BANK uses its own register to store the command's desired bank numbers; this will not always be the same as the value stored in `$00` or `$01`. In fact, `$01` is always going to read `4` when PEEKing from BASIC. If you need to know the currently selected RAM and/or RAM banks, you should explicitly set them and use variables to track your selected bank number(s).

Note: Memory address `$00`, which is the hardware RAM bank register, will usually report the bank set by the `BANK` statement. The one exception is after a [`BLOAD`](#bload) or [`BVERIFY`](#bverify) inside of a running BASIC program.  `BLOAD` and `BVERIFY` change the RAM bank (as if you called `BANK`) to the bank that `BLOAD` or `BVERIFY` stopped at.

### BASLOAD

**TYPE: Command**  
**FORMAT: BASLOAD &lt;filename&gt;[,<device>]**

**Action:** Loads a plain text file with `BASLOAD` source and converts it into a runnable program.

The device number is optional.  If it's not specified, the current device is used.  The current device is set to 8 at system boot and may be changed with the [`DOS`](#dos) command.

For more information about `BASLOAD`, see [this external documentation](https://github.com/stefan-b-jakobsson/basload-rom)

**EXAMPLE of the BASLOAD Command:**

```BASIC
BASLOAD "MYPROG.BASL"
LOADING...
READY.
LIST

1 PRINT "HELLO, WORLD!"
2 GOTO 1
READY.
```

### BIN&#36;

**TYPE: String Function**  
**FORMAT: BIN$(n)**

**Action:** Return a string representing the binary value of n. If n <= 255, 8 characters are returned and if 255 < n <= 65535, 16 characters are returned.

**EXAMPLE of the BIN$ Function:**

```BASIC
PRINT BIN$(200)   : REM PRINTS 11001000 AS BINARY REPRESENTATION OF 200
PRINT BIN$(45231) : REM PRINTS 1011000010101111 TO REPRESENT 16 BITS
```

### BINPUT&#35;

**TYPE: I/O Statement**  
**FORMAT: BINPUT&#35; &lt;n&gt;,&lt;var$&gt;,&lt;len&gt;**

**Action:** `BINPUT#` Reads a block of data from an open file and stores the data into a string variable. If there are fewer than &lt;len&gt; bytes available to be read from the file, fewer bytes will be stored.  If the end of the file is reached, [`ST`](#st)` AND 64` will be true.

**EXAMPLE of the BINPUT&#35; Statement:**

```BASIC
10 OPEN 8,8,8,"FILE.BIN,S,R"
20 BINPUT#8,A$,10
30 PRINT "I GOT";LEN(A$);"BYTES"
40 IF ST<>0 THEN 20
50 CLOSE 8
```

### BOOT

**TYPE: Command**  
**FORMAT: BOOT**

**Action:** Load and run a PRG file named `AUTOBOOT.X16` from device 8. If the file is not found, nothing is done and no error is printed.

**EXAMPLE of the BOOT Command:**

```BASIC
BOOT
```

### BLOAD

**TYPE: Command**  
**FORMAT: BLOAD &lt;filename&gt;, &lt;device&gt;, &lt;bank&gt;, &lt;address&gt;**

**Action:** Loads a binary file directly into RAM

Note: If the file is loaded to high RAM (starting in the range `$A000-$BFFF`), and the file is larger than what would fit in the current bank, the load will wrap around into subsequent banks.

After a successful load, `$030D` and `$030E` will contain the address of the final byte loaded + 1.  If relevant, the value in memory location `$00` will point to the bank in which the next byte would have been loaded.

**EXAMPLES of the BLOAD Command:**

```BASIC
BLOAD "MYFILE.BIN",8,1,$A000:REM LOADS A FILE NAMED MYFILE.BIN FROM DEVICE 8 STARTING IN BANK 1 AT $A000.
BLOAD "WHO.PCX",8,10,$B000:REM LOADS A FILE NAMED WHO.PCX INTO RAM STARTING IN BANK 10 AT $B000.
```

### BSAVE

**TYPE: Command**  
**FORMAT: BSAVE &lt;filename&gt;, &lt;device&gt;, &lt;bank&gt;, &lt;start address&gt;, &lt;end address&gt;**

**Action:** Saves a region of memory to a binary file.

Note: The save will stop one byte before &lt;end address&gt;.

This command does not allow for automatic bank advancing, but you can achieve a similar result with successive `BSAVE` invocations to append additional memory locations to the same file.

**EXAMPLES of the BSAVE Command:**

```BASIC
BSAVE "MYFILE.BIN",8,1,$A000,$C000
```

The above example saves a region of memory from `$A000` in bank 1 through and including `$BFFF`, stopping before `$C000`.

```BASIC
BSAVE "MYFILE.BIN,S,A",8,2,$A000,$B000
```

The above example appends a region of memory from `$A000` through and including `$AFFF`, stopping before `$B000`.  Running both of the above examples in succession will result in a file MYFILE.BIN 12KiB in size.

**Warning:** Appending to file involves a risk of corrupting the file system of the SD card! See [Appending to file](X16%20Reference%20-%2013%20-%20Working%20with%20CMDR-DOS.md#appending-to-file).

### BVERIFY

**TYPE: Command**  
**FORMAT: BVERIFY &lt;filename&gt;, &lt;device&gt;, &lt;bank&gt;, &lt;start address&gt;, &lt;end address&gt;**

**Action:** Verifies that a file on disk matches RAM contents.

**EXAMPLE of the BVERIFY Command:**

```BASIC
BVERIFY "MYFILE.BIN",8,1,$A000,$C000
```

The above example compares a region of memory from `$A000` in bank 1 through and including `$BFFF`, stopping before `$C000`, against the filename listed.


### BVLOAD

**TYPE: Command**  
**FORMAT: BVLOAD &lt;filename&gt;, &lt;device&gt;, &lt;VERA_high_address&gt;, &lt;VERA_low_address&gt;**

**Action:** Loads a binary file directly into VERA RAM.

**EXAMPLES of the BVLOAD Command:**

```BASIC
BVLOAD "MYFILE.BIN", 8, 0, $4000  :REM LOADS MYFILE.BIN FROM DEVICE 8 TO VRAM $4000.
BVLOAD "MYFONT.BIN", 8, 1, $F000  :REM LOAD A FONT INTO THE DEFAULT FONT LOCATION ($1F000).
```

### CHAR

**TYPE: Statement**  
**FORMAT: CHAR &lt;x&gt;,&lt;y&gt;,&lt;color&gt;,&lt;string&gt;**

**Action:** This command draws a text string on the graphics screen in a given color.

The string can contain printable ASCII characters (`CHR$($20)` to `CHR$($7E)`), as well most PETSCII control codes.

**EXAMPLE of the CHAR Statement:**

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

### CHR$

**TYPE: String Function**  
**FORMAT: CHR$(&lt;number&gt;)**

**Action:** This function converts a Commodore ASCII code to its character equivalent. 
See Appendix I for a list of available character sets and their codes.  The number must 
have a value between 0 and 255 (`$00-$FF`), or an ?ILLEGAL QUANTITY error message will result.

The string can contain printable ASCII characters (`CHR$($20)` to `CHR$($7E)`), as well most PETSCII control codes.

**EXAMPLE of the CHR$ Function:**

```BASIC
10 PRINT CHR$($41) : REM Decimal 65, upper case A
20 Z$ = CHR$(13) : REM 13 = RETURN key
50 B = ASC(A$) : B$ = CHR$(B) : REM Converts to X16 ASCII code and back.
```

### CLOSE

**TYPE: I/O Statement**
**FORMAT: CLOSE &lt;file number&gt;**

**Action:** Closes any files used by [`OPEN`](#open) statements.  The `CLOSE` statement takes a single argument that is the file number to be closed.

**EXAMPLE of the CLOSE I/O Statement:**

```BASIC
CLOSE 0   : REM CLOSE FILE OPENED AS 0
CLOSE 4   : REM CLOSE FILE OPENED AS 4
```

### CLR

**TYPE: Statement**  
**FORMAT: CLR**

**Action:** This statement clears RAM that had been used, but is no longer needed. 
The BASIC program in memory is untouched, but all variables, arrays, [`GOSUB`](#gosub) addresses, [`FOR..NEXT`](#for-to-step) loops, user-defined functions, and files are erased from memory, and their space is made available to new variables, etc.


**EXAMPLE of the CLR Statement:**

```BASIC
CLR
```

### CLS

**TYPE: Command**  
**FORMAT: CLS**

**Action:** Clears the screen. Same effect as `PRINT CHR$(147);`.

**EXAMPLE of the CLS Statement:**

```BASIC
CLS
```

### CMD

**TYPE: I/O Statement**  
**FORMAT: CMD &lt;file number&gt;[, string]**

**Action:** This statement switches the primary output device from the video display to the file specified. This file could be on disk, a printer, or an I/O device like the modem<sup>1</sup>.  The file number must be specified in a prior [OPEN](#open) statement.  The string, when specified, is sent to the file.  This is handy 
for titling printouts, etc.

When this command is in effect, any [`PRINT`](#print) statements and [`LIST`](#list) commands will not display on the screen, but will send the text in the same format to the file.

To re-direct the output back to the screen, the [`PRINT#`](#print-1) command should send a blank line to the [`CMD`](#cmd) device before [`CLOSE`](#close)ing, so it will stop expecting data.  This is called "un-listening" the device.

Any system error (like `?SYNTAX ERROR`) will cause output to return to the screen.  Devices aren't un-listened by this, so you should send a blank line after an error condition.

**EXAMPLE of the CMD I/O Statement:**

```BASIC
OPEN 4,4: CMD 4, "LISTING" : LIST : REM Lists program on the printer
PRINT# 4: CLOSE 4: REM Un-listens and closes printer

10 OPEN 2,8,2, "TEST.TXT,S,W" : REM Create a SEQ file.
20 CMD 2 : REM Direct output to the file not the screen.
30 FOR X = 1 TO 100
40 PRINT X
50 NEXT X
60 PRINT# 2 : REM Un-listen
70 CLOSE 1 : REM Write remaining buffer contents, close file.
```

* <sup>1</sup> Device #2 (RS-232) support has been removed from the X16 KERNAL.

### COLOR

**TYPE: Statement**  
**FORMAT: COLOR &lt;fgcol&gt;[,&lt;bgcol&gt;]**

**Action:** This command works sets the text mode foreground color, and optionally the background color.

**EXAMPLES of the COLOR Statement:**

```BASIC
COLOR 2   : REM SET FG COLOR TO RED, KEEP BG COLOR
COLOR 2,0 : REM SET FG COLOR TO RED, BG COLOR TO BLACK
```

### CONT

**TYPE: Command**  
**FORMAT: CONT**

**Action:** This command re-starts the execution of a program which was halted by a [`STOP`](#stop) or [`END`](#end) statement, or the <mark >**RUN/STOP**</mark> key being pressed.  The program will re-start at the exact place from which it left off.

While the program is stopped, the user can inspect or change any variables or look at the program.  When debugging or examing a program, `STOP` statements can be placed at strategic locations to allow examination of variables and check the flow of the program.

The error message `?CAN'T CONTINUE` will result from editing the program (even just hitting <mark >**RETURN**</mark> with the cursor on an unchanged line), or if the program halted due to an error, or if you caused an error before typing `CONT` to re-start the program.


**EXAMPLE of the CONT Command:**

```BASIC
10 PI=0 : C=1
20 PI=PI+4/C-4/(C+2)
30 PRINT PI
40 C=C+4 : GOTO 20
```

This program calculates the value of PI.  Run this program, and after a few seconds, hit the <mark >**RUN/STOP**</mark> key.  You will see the display:

```
   BREAK IN x
```
Where `x` is the line number where program execution was interrupted.

Type the command `PRINT C` to see how far the Commander X16 has gotten.  Then use `CONT` to resume from where the Commander X16 left off.

### COS

**TYPE: Function**  
**FORMAT: COS(&lt;number&gt;)**

**Action:** This mathematical function calculates the cosine of the number, where the number is an angle expressed in radians.

**EXAMPLES of the COS Function:**

```BASIC
10 PRINT COS(5)
15 A = 232
20 PI = 3.14159265
30 Y = COS(A * PI / 180) : REM Convert degrees to radians.
```

### DA$

**TYPE: String Function**  
**FORMAT: DA$**

**Action:**  Returns or sets the date in the system clock.  The format is YYYYMMDD.

**EXAMPLE of the DA$ String Function**

```BASIC
10 HD$ = DA$
20 PRINT "HOLD DATE IS ";HD$;"."
30 DA$ = "20251121"
40 PRINT "NEW DATE IS NOW ";DA$;"."
50 DA$ = HD$
```

### DATA

**TYPE: Statement**  
**FORMAT: DATA &lt;list of constants&gt;**

**Action:**  `DATA` statements store information within a program.  The program uses the information by means of the [`READ`](#read) statement, which pulls successive constants from the `DATA` statements.

The `DATA` statements don't have to be executed by the program, they only have to be present.  Therefore, they are usually placed at the end of the program.

All data statements in a program are treated as a continuous list.  Data is `READ` from left to right, from the lowest numbered line to the highest.  If the `READ` statement encounters data that doesn't fit the type requested (if it needs a number and finds a string) an error message occurs.

Any characters can be included as data, but if certain ones are used, the data item must be enclosed by quote marks (" ").  These include punctuation like comma (,), colon (:), blank spaces, shifted letters, graphics, and cursor control characters.


**EXAMPLE of DATA Statements**

```BASIC
10 FOR X = 1 TO 5
20 READ Z
30 PRINT Z
40 NEXT X
50 DATA 2, 4, 6, 8, 10
```

### DEF FN

**TYPE: Statement**  
**FORMAT: DEF FN &lt;name&gt; (&lt;variable&gt;) = &lt;expression&gt;**

**Action:** This sets up a user-defined function that can be used later in the program. The function can consist of any mathematical formula.

User-defined functions save space in programs where a long formula is used in several places.  The formula need only be specified once, in the definition statement, and then it is abbreviated as a function name.  It must be executed once, but any subsequent executions are ignored.

The function name is the letters `FN` followed by any variable name. This can be 1 or 2 characters, the first being a letter and the second a letter or digit.

**EXAMPLES of the DEF FN Statement:**

```BASIC
10 DEF FN A(X) = X + 7
20 DEF FN AA(X) = Y * Z
30 DEF FN A9(Q) = INT(RND(1)*Q+1)
```
The function is called later in the program by using the function name with a variable in parenthesis.  This function name is used like any other variable, and its value is automatically calculated.

**EXAMPLES of FN Use:**

```BASIC
40 PRINT FN A(9)
50 R = FNAA(9)
60 G = G + FN A9(10)
```

In line 50 above, the number 9 inside the parenthesis does not affect the outcome of the function because the function definition in line 20 doesn't use the variable in parenthesis.  The result is Y times Z, regardless of the value of X.  In the other two functions, the value in parenthesis does affect the result.

### DIM

**TYPE: Statement**  
**FORMAT: DIM &lt;variable&gt;(&lt;subscripts&gt;) [,&lt;variable&gt;(&lt;subscripts&gt;)... ]**

**Action:** This statement defines an array or matrix of variables.  This allows you to use the variable name with a subscript.  The subscript points to the element being used.  The lowest element number in an array is zero, and the highest is the number given in the `DIM` statement, which has a maximum of 32767.

The `DIM` statement must be executed once and only once for each array.  A `?REDIM'D ARRAY` error occurs if this line is re-executed.  Therefore, most programs perform all `DIM` operations at the very beginning.

There may be any number of dimensions and 255 subscripts in an array, limited only by the amount of RAM memory which is available to hold the variables.  The array may be made up of normal numeric variables, as shown above, or of strings or integer numbers.  If the variables are other than normal numeric, use the `$` or `%` signs after the variable name to indicate string or integer variables.

If an array referenced in a program was never `DIM`ensioned, it is automatically dimensioned to 11 elements in each dimension used in the first reference.

**EXAMPLES of the DIM Statement:**

```BASIC
10 DIM A(100)
20 DIM Z(5,7), Y(3,4,5)
30 DIM Y1%(Q)
40 DIM OH$(1000)
50 Z(5) = 9 : REM Automatically performs DIM Z(10)
```

**CALCULATING MEMORY USED BY DIM:**

 * 5 bytes for the array name.
 * 2 bytes for each dimension.
 * 2 bytes per element for integer variables.
 * 5 bytes per element for floating point variables.
 * 3 bytes per element for string variables.
 * 1 byte for each character in each string element.
  
### DOS

**TYPE: Command**  
**FORMAT: DOS &lt;string or number&gt;**

**Action:** This command works with the command/status channel or the directory of a Commodore DOS device and has different functionality depending on the type of argument.

* Without an argument, `DOS` prints the status string of the current device.
* With a numeric argument, the current device is switched to the given number.
* With a string argument of `"8"` or `"9"`, it switches the current device to the given number.
* With an argument starting with `"$"`, it shows the directory of the device.
* Any other argument will be sent as a DOS command.

**EXAMPLES of the DOS Command:**

```BASIC
DOS"$"          : REM SHOWS DIRECTORY
DOS"S:BAD_FILE" : REM DELETES "BAD_FILE"
DOS             : REM PRINTS DOS STATUS, E.G. "01,FILES SCRATCHED,01,00"
```

### EDIT

**TYPE: Command**  
**FORMAT: EDIT \[&lt;filename&gt;\]**

**Action:** Opens the built-in text editor, X16-Edit, a modeless editor with features similar to GNU Nano.

* Without an argument, the editor begins with an empty file.
* With a string argument, it attempts to load a file before displaying it.

The EDIT command loads the editor in the screen mode and character set that was active at the time the command was run.

**EXAMPLE of the EDIT Statement:**

```BASIC
EDIT "README.TXT"
```

A more elaborate X16-Edit manual can be found [here](https://github.com/X16Community/x16-rom/blob/master/x16-edit/docs/manual.pdf)

### END

**TYPE: Statement**
**FORMAT: END**

**Action:** This finishes a program's execution and displays the `READY` message, returning control to the person operating the computer.  There may be any number of `END` statements within a program.  While it is not necessary to include any `END` statements at all, it is recommended that a program does conclude with one, rather than just running out of lines.

The `END` statement is similar to the [`STOP`](#stop) statement.  The only difference is that `STOP` causes the computer to display the message `BREAK IN XX` and `END` just displays `READY`.  both statements allow the computer to resume execution by typing the [`CONT`](#cont) command.

**EXAMPLES of the END Statement:
```BASIC
10 PRINT "TYPE 'Y' TO END PROGRAM: ";
20 INPUT A$
30 IF A$ = "Y" THEN END
50 PRINT "CONTINUING..."
50 REM The rest of the program...
999 END
```

### EXEC

**TYPE: Command**  
**FORMAT: EXEC &lt;memory address&gt;\[,&lt;ram bank&gt;\]**

**Action:** Plays back a null-terminated script from MEMORY into the BASIC editor. Among other uses, this can be used to "type" in a program from a plain text file.

* If the `ram bank` argument is omitted and the address is in the range \$A000-\$BFFF, the RAM bank selected by the [`BANK`](#bank) command is used.
* The input can span multiple RAM banks. The input will stop once it reaches a null byte ($00) or if a BASIC error occurs.
* The redirected input only applies to BASIC immediate mode. While programs are running, the EXEC handling is suspended.

**EXAMPLE of the EXEC Statement:**

```BASIC
BLOAD "MYPROGRAM.BAS",8,1,$A000 : REM "BANK PEEK(0)" NO LONGER NEEDED
POKE PEEK($30D)+(PEEK($30E)*256),0 : REM NULL TERMINATE IN END BANK
EXEC $A000,1
```

This program will load a plain ASCII or PETSCII FILE.BAS from disk and tokenize
it for you:

```BASIC
10 BLOAD "FILE.BAS", 8, 1, $A000
20 POKE PEEK(781) + 256 * PEEK(782), 0
30 EXEC $A000, 1
40 NEW
```

### EXP

**TYPE: Numeric Function**
**FORMAT: EXP (&lt;number&gt;)**

**Action:** This mathematical function calculates the constant e (2.71828183) raised to the power of the number given.  A value greater than 88.0296919 causes `?OVERFLOW ERROR` to occur.

**EXAMPLES of the EXP Function:**

```BASIC
10 PRINT EXP(12)
20 C = D * EXP(A * B)
```

### FMCHORD

**TYPE: Statement**  
**FORMAT: FMCHORD &lt;first channel&gt;,&lt;string&gt;**

**Action:** This command uses the same syntax as [`FMPLAY`](#fmplay), but instead of playing a series of notes, it will start all of the notes in the string simultaneously on one or more channels. The first parameter to `FMCHORD` is the first channel to use, and will be used for the first note in the string, and subsequent notes in the string will be started on subsequent channels, with the channel after 7 being channel 0.

All macros are supported, even the ones that only affect the behavior of [`PSGPLAY`](#psgplay) and [`FMPLAY`](#fmplay).

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of the FMCHORD Statement:**

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

This will play the first few lines of _Silent Night_ with a vibraphone lead and organ accompaniment.

### FMDRUM

**TYPE: Statement**  
**FORMAT: FMDRUM &lt;channel&gt;,&lt;drum number&gt;**

**Action:** Loads a [drum preset](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#drum-presets "list of drum presets") onto the YM2151 and triggers it. Valid range is from 25 to 87, corresponding to the General MIDI percussion note values. FMDRUM will load a patch preset corresponding to the selected drum into the channel. If you then try to play notes on that same channel without loading an instrument patch, it will use the drum patch that was loaded for the drum sound instead, which may not sound particularly musical.

### FMFREQ

**TYPE: Statement**  
**FORMAT: FMFREQ &lt;channel&gt;,&lt;frequency&gt;**

**Action:** Play a note by frequency on the YM2151. The accepted range is in Hz from 17 to 4434. `FMFREQ` also accepts a frequency of 0 to release the note.

**EXAMPLE of the FMFREQ Statement:**

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

**TYPE: Statement**  
**FORMAT: FMINIT**

**Action:** Initialize the YM2151, silence all channels, and load a set of default patches into all 8 channels.

### FMINST

**TYPE: Statement**  
**FORMAT: FMINST &lt;channel&gt;,&lt;patch&gt;**

Load an instrument onto the YM2151 in the form of a [patch preset](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#fm-instrument-patch-presets) into a channel. Valid channels range from 0 to 7. Valid patches range from 0 to 162.

### FMNOTE

**TYPE: Statement**  
**FORMAT: FMNOTE &lt;channel&gt;,&lt;note&gt;**

**Action:** Play a note on the YM2151. The note value is constructed as follows. Using hexadecimal notation, the first nybble is the octave, 0-7, and the second nybble is the note within the octave as follows:

| `$x0` | `$x1` | `$x2` | `$x3` | `$x4` | `$x5` | `$x6` | `$x7` | `$x8` | `$x9` | `$xA` | `$xB` | `$xC` | `$xD-$xF` |
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
| Release | C | C&#9839;/D&#9837; | D | D&#9839;/E&#9837; | E | F | F&#9839;/G&#9837; | G | G&#9839;/A&#9837; | A | A&#9839;/B&#9837; | B | no-op |

Notes can also be represented by negative numbers to skip retriggering, and will thus snap to another note without restarting the playback of the note.

**EXAMPLE of the FMNOTE Statement:**

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

**TYPE: Statement**  
**FORMAT: FMPAN &lt;channel&gt;,&lt;panning&gt;**

**Action:** Sets the simple stereo panning on a YM2151 channel. Valid values are as follows:

* 1 = left
* 2 = right
* 3 = both

### FMPLAY

**TYPE: Statement**  
**FORMAT: FMPLAY &lt;channel&gt;,&lt;string&gt;**

**Action:** This command is very similar to `PLAY` on other BASICs such as GWBASIC. It takes a string of notes, rests, tempo changes, note lengths, and other macros, and plays all of the notes synchronously.  That is, the FMPLAY command will not return control until all of the notes and rests in the string have been fully played.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of the FMPLAY Statement:**

```BASIC
10 FMINIT : REM INITIALIZE AND LOAD DEFAULT PATCHES, WILL USE E.PIANO
20 FMPLAY 1,"T90 O4 L4" : REM TEMPO 90 BPM, OCTAVE 4, NOTE LENGTH 4 (QUARTER)
30 FMPLAY 1,"CDECCDECEFGREFGR" : REM FIRST TWO LINES OF TUNE
40 FMPLAY 1,"G8A8G8F8EC G8A8G8F8EC" : REM THIRD LINE
50 FMPLAY 1,"C<G>CRC<G>CR" : REM FOURTH LINE
```

### FMPOKE

**TYPE: Statement**  
**FORMAT: FMPOKE &lt;register&gt;,&lt;value&gt;**

**Action:** This command uses the AUDIO API to write a value to one of the YM2151's registers at a low level.

**EXAMPLE of the FMPOKE Statement:**

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

**EXAMPLE of the FMVIB Statement:**

```BASIC
10 FMVIB 200,30
20 FMINST 0,11 : REM VIBRAPHONE
30 FMPLAY 0,"T60 O4 CDEFGAB>C"
40 FMVIB 0,0
50 FMPLAY 0,"C<BAGFEDC"
```

The above BASIC program plays a C major scale with a vibraphone patch, first with a vibrato/tremolo effect, and then plays the scale in reverse with the vibrato turned off.

### FMVOL

**TYPE: Statement**  
**FORMAT: FMVOL &lt;channel&gt;,&lt;volume&gt;**

**Action:** This command sets the channel's volume. The volume remains at the requested level until another `FMVOL` command for that channel or [`FMINIT`](#fminit) is called.  Valid range is from 0 (completely silent) to 63 (full volume)

### FN

**TYPE: Numeric Function**  
**FORMAT: FN &lt;name&gt; (&lt;number&gt;)**

**Action:** This function references the previously [`DEF`](#def-fn)ined formula specified by name.  The number is substituted into its place (if any) and the formula is calculated.  The result will be a numeric value.

This function can be used in direct mode, as long as the statement `DEF`ining it has been executed.

If an `FN` is executed before the `DEF` statement which defines it, an `?UNDEF'D FUNCTION` error occurs.

**EXAMPLES the FN (User Defined) Function:**

```BASIC
PRINT FN Z(Q)
135 A = FN A(3) + FN A(21)
210 IF FN X1(A+1) = 42 THEN END
```

### FOR-TO-STEP

**TYPE: Statement**  
**FORMAT: FOR &lt;variable&gt; = &lt;start&gt; TO &lt;limit&gt; [STEP &lt;increment&gt;]**

**Action:** This is a special BASIC statement that lets you easily use a variable as a counter.  You must specify certain parameters: the floating-point variable name, its starting value, the limit of the count, and how much to add during each cycle.

Here is a simple BASIC program that counts from 1 to 10, [`PRINT`](#print)ing each number and [`END`](#end)ing when complete, and using no `FOR` statements:
```BASIC
10 A = 1
20 PRINT A
30 A = A + 1
40 IF A <= 10 THEN 20
50 END
```
Using the `FOR` statement, here is the same program:
```BASIC
10 FOR A = 1 TO 10
20 PRINT A
30 NEXT A
40 END
```

As you can see, the program is shorter and easier to understand using the `FOR` statement.

When the `FOR` statement is executed, several operations take place.  The &lt;start&gt; value is placed in the &lt;variable&gt; being used in the counter.  In the example above, a 1 is placed in `A`.

When the [`NEXT`](#next) statement is reached, the &lt;increment&gt; value is added to the &lt;variable&gt;.  If a `STEP` was not included, the &lt;increment&gt; is set to +1.  The first time the program hits line 30, 1 is added to `A`, so the new value of `A` is 2.

Now the value in the &lt;variable&gt; is compared to the &lt;limit&gt;.  if the &lt;limit&gt; has not been reached yet, the program `GO`es `TO` the line after the original `FOR` statement.  In this case, the value of 2 in `A` is less than the limit of 10, so it `GO`es `TO` line 20.

Eventually, the value of &lt;limit&gt; is exceeded by the &lt;variable&gt;.  At that time, the loop is concluded and the program continues with the line following the `NEXT` statement.  In our example, the value of `A` reaches 11, which exceeds the limit of 10, and the program goes on with line 40.

When the value of &lt;increment&gt; is positive, the &lt;variable&gt; must exceed the &lt;limit&gt;, and when it is negative, it must become less than the &lt;limit&gt;.

**NOTE: A loop always executes at least once.**

**EXAMPLES of the FOR.. TO.. STEP.. Statement:**
```BASIC
10 FOR X = 100 TO 0 STEP -1
10 FOR Z = PI TO 6 * 3.1459 STEP .01
10 FOR ZY = 42 TO 42
```

### FRAME

**TYPE: Statement**  
**FORMAT: FRAME &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This command draws a rectangle frame on the graphics screen in a given color.

**EXAMPLE of the FRAME Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:FRAMERND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*128:NEXT
30 GOTO20
```

### FRE

**TYPE: Function**  
**FORMAT: FRE(&lt;variable&gt;)**

**Action:**  This function tells you how much RAM is available for your programs and its variables.  If a program tries to use more space than is available, the `?OUT OF MEMORY` error results.

The number in parenthesis can have any value, and it is not used in the calculation.

**NOTE: If the result of `FRE` is negative, add 65536 to the `FRE` number to get the number of bytes available in memory.**

**EXAMPLES of the FRE Function:**
```BASIC
PRINT FRE(0)
10 FM = (FRE(K) - 1000) / 7
60000 IF FRE(0) < 100 THEN PRINT "NOT ENOUGH ROOM"
```
**NOTE: The following always tells you the current available RAM:**
```BASIC
PRINT FRE(0) - (FRE(0) < 0) * 65536
```

### GET

**TYPE: Statement**  
**FORMAT: GET &lt;variable list&gt;**

**Action:** This statement reads each key typed by the user.  As the user is typing, the characters are stored in the Commander X16's keyboard buffer.  Up to 10 characters are stored here, and any keys struck after the 10th are discarded.  Reading one of the characters with the `GET` statement makes room for another character.

If the `GET` statement specifies numeric data, and the user types a key other than a number, the message `?SYNTAX ERROR` appears.  To be safe, read the keys as strings and convert them to numbers later.

The `GET` statement can be used to avoid some of the limitations of the [`INPUT`](#input) statement.  For more on this, see the section on Using the `GET` Statement in the Programming Techniques<sup>2</sup> section.

**EXAMPLES of the GET Statement:**

```BASIC
10 GET OK$ : IF OK$ = "" THEN 10 : REM Loops until a key is pressed.
20 GET A1$, A2$, A3$, A4$, A5$ : REM Reads 5 keys
30 GET B, B$ : REM Reads a number key (0..9) and any key.
```

* <sup>2</sup>: There is no Programming Techniques section currently.

### GET&#35;

**TYPE: I/O Statement**  
**FORMAT: GET# &lt;file number&gt;, &lt;variable list&gt;**

**Action:** This statement reads characters one-at-a-time from the device or file specified.  It works the same as the [`GET`](#get) statement, except that the data comes from a different place than the keyboard.  If no character is received, the variable list is set to an empty string (equal to "") or to 0 for numeric variables.  Characters used to separate data in files, like the comma `(,)` or <mark>**RETURN**</mark> key code (ASCII code of 13), are received like any other character.
 
 **EXAMPLES of the GET# Statement:**

 ```BASIC
 10 GET# 1, A$
 20 OPEN 1,3 : GET# 1, A3$
 30 GET# 1, A(1), A(2), A$, B$
 ```

### GOSUB

**TYPE: Statement** 
**FORMAT: GOSUB &lt;line number&gt;**

**Action** This is a specialized form of the [`GOTO`](#goto) statement, with one important difference: [`GOSUB`,](#gosub) remembers where it came from.  When the [`RETURN`](#return) statement (different from the <mark>**RETURN**</mark> key on the keyboard) is reached in the program, the program jumps back to the statement immediately following the original `GOSUB` statement.

The major use of a subroutine (`GOSUB` means `GO` to a `SUB`-routine) is when a small section of program is used by different sections of the program.  By using subroutines rather that repeating the same lines over and over at different places in the program, you can save lots of program space.  In this way, `GOSUB` is similar to [`DEF FN`](#def-fn).  `DEF FN` lets you save space when using a formula, while `GOSUB` saves space when using a several-line routine.

**An inefficient program that doesn't use `GOSUB`**
```BASIC
10 PRINT "THIS PROGRAM PRINTS"
20 FOR I = 1 TO 500 : NEXT I
30 PRINT "SLOWLY ON THE SCREEN"
40 FOR I = 1 TO 500 : NEXT I
50 PRINT "USING A SIMPLE LOOP"
60 FOR I = 1 TO 500 : NEXT I
70 PRINT "AS A TIME DELAY"
180 FOR I = 1 TO 500 : NEXT I
```

**The same program using `GOSUB`**
```BASIC
10 PRINT "THIS PROGRAM PRINTS"
20 GOSUB 200
30 PRINT "SLOWLY ON THE SCREEN"
40 GOSUB 200
50 PRINT "USING A SIMPLE LOOP"
60 GOSUB 200
80 PRINT "AS A TIME DELAY"
90 GOSUB 200
100 END
200 FOR I = 1 TO 500 : NEXT I
210 RETURN
```
Each time the program executes a `GOSUB`, the line number and position in the program line are saved in a special area called the "stack", which takes up 256 bytes of memory.  This limits the amount of data that can be stored in the stack.  Therefore, the number of subroutine return addresses that can be stored is limited, and care should be taken to make sure every `GOSUB` hits the corresponding `RETURN`, otherwise you'll run out of memory even though the computer has plenty of bytes free.

### GOTO

**TYPE: Statement**
**FORMAT: GOTO &lt;line number&gt; or GO TO &lt;line number&gt;**

**Action:** This statement allows the BASIC program to execute lines out of numerical order.  The word `GOTO` followed by a number will make the program jump to the line with that number.  `GOTO` NOT followed by a number equals `GOTO 0`.  It must have the line number after the word `GOTO`.

It is possible to create loops with `GOTO` that will never end.  The simplest example of this is a line that `GO`es `TO` itself, like `10 GOTO 10`.

These loops can be stopped by using the <mark>**RUN/STOP**</mark> key on the keyboard.

**EXAMPLES of the GOTO Statement:**
```BASIC
GOTO 25
10 GO TO 100
20 GOTO 12000
```

### HELP

**TYPE: Command**  
**FORMAT: HELP**

**Action:** The `HELP` command displays a brief summary of the ROM build, and points users to this guide at its home on GitHub, and to the community forums website.

### HEX$

**TYPE: String Function**  
**FORMAT: HEX$(n)**

**Action:** Return a string representing the hexadecimal value of n. If n <= 255, 2 characters are returned and if 255 < n <= 65535, 4 characters are returned.

**EXAMPLE of the HEX$ Function:**

```BASIC
PRINT HEX$(200)   : REM PRINTS C8 AS HEXADECIMAL REPRESENTATION OF 200
PRINT HEX$(45231) : REM PRINTS B0AF TO REPRESENT 16 BIT VALUE
```

### I2CPEEK

**TYPE: Integer Function**  
**FORMAT: I2CPEEK(&lt;device&gt;,&lt;register&gt;)**

**Action:** Returns the value from a register on an I²C device.

**EXAMPLE of the I2CPEEK Function:**

```BASIC
PRINT HEX$(I2CPEEK($6F,0) AND $7F)
```

This command reports the seconds counter from the system clock by converting its internal BCD representation to a string.

### I2CPOKE

**TYPE: Statement**  
**FORMAT: I2CPOKE &lt;device&gt;,&lt;register&gt;,&lt;value&gt;**

**Action:** Sets the value to a register on an I²C device.

**EXAMPLE of the I2CPOKE Function:**

```BASIC
I2CPOKE $6F,$40,$80
```

This command sets a byte in NVRAM on the RTC to the value `$80`

### IF-THEN

**TYPE: Statement**  
**FORMAT:**
- **IF &lt;expression&gt; THEN &lt;line number&gt;**
- **IF &lt;expression&gt; GOTO &lt;line number&gt;**
- **IF &lt;expression&gt; &lt;statements&gt;**

**Action:** This is the statement that gives BASIC most of its "intelligence", the ability to evaluate conditions and take different actions depending on the outcome.

The word `IF` is followed by an expression, which can include variables, strings, numbers, comparisons, and logical operators.  The word `THEN` appears on the same line and is followed by either a line number or one or more BASIC statements.  When the expression is false, everything else after the word `THEN` on that line is ignored, and execution continues with the next line number in the program.  A true result makes the program either branch to the line number after the word `THEN` or execute whatever other BASIC statements are found on that line.

**EXAMPLE of the IF...GOTO... Statement:**
```BASIC
10 INPUT "ENTER A NUMBER";N
20 IF N <= 0 GOTO 50
30 PRINT "SQUARE ROOT=";SQR(N)
40 GOTO 10
50 PRINT "NUMBER MUST BE > 0"
60 GOTO 10
```
This program prints out the square root of any positive number.  The `IF` statement here is used to validate the result of the `INPUT`.  When the result of `N` is less than or equal to zero, the program skips to line 50, and when the result is false, the next line to be executed is 30.  Note that `THEN GOTO` is not needed with `IF...THEN`, as in line 20 where `GOTO 50` actually means `THEN GOTO 50`.

**EXAMPLE of the IF...THEN... Statement:**
```BASIC
10 FOR I = 1 TO 100
20 IF RND(1) < .5 THEN X = X + 1 : GOTO 40
30 Y = Y + 1
40 NEXT I
50 PRINT "HEADS= ";X
60 PRINT "TAILS= ";Y
```
The `IF` in line 20 tests a random number to see if it is less than .5.

When the result is true, the whole series of statements following the word `THEN` are executed: first `X` is incremented by 1, then the program skips to line 40.  When the result is false, the program drops to the next statement, line 30.

### INPUT

**TYPE: Statement**  
**FORMAT: INPUT ["&lt;prompt&gt;"] &lt;variable list&gt;**

**Action:** This is a statement that lets the person [`RUN`](#run)ning the program "feed" information into the computer.  When executed, this statement [`PRINT`](#print)s a question mark `(?)` on the screen, and positions the cursor 1 space to the right of the question mark.  Now the computer waits, cursor blinking, for the operator to type in the answer and press the <mark>**RETURN**</mark> key.

The word `INPUT` may be followed by any text contained in quote marks `(" ")`.  This text is `PRINT`ed on the screen, followed by the question mark.

After the text comes a semicolon `(;)` and the name of one or more variables separated by commas.  This variable is where the computer stores the information that the operator types.  The variable can be any legal variable name, and you can have several different variable names, each for a different input.

**EXAMPLES of the INPUT Statement:**
```BASIC
10 INPUT R
20 INPUT E, X, I$
30 INPUT "ENTER ANSWER"; A$(42)
```
When this program `RUN`s, the question mark appears to prompt the operator that the Commander X16 is expecting an input for line 30.  Any number typed goes into A for later use in the program.  If the answer typed was not a number, the `?REDO FROM START` message appears, which means that a string was entered when a number was expected.  If the operator just hits <mark>**RETURN**</mark> without typing anything, the variable's value doesn't change.

Now the question mark for line 20, appears.  If we type only one number and hit <mark>**RETURN**</mark>, the Commander X16 will now display 2 question marks `(??)`, which means that more input is required.  You can just type as many inputs as you need, separated by commas, which prevents the double question mark from appearing.  If you type more data than the `INPUT` statement requested, the `?EXTRA IGNORED` message appears, which means that the extra items you typed were not put into any variables.

Line 30 displays the words ENTER ANSWER before the question mark appears.  The semicolon is required between the prompt and any list of variables.

The `INPUT` statement can never be used outside a program.  The Commander X16 needs space for a buffer for the `INPUT` variables, the same space that is used for commands.

### INPUT&#35;

**TYPE: I/O Statement**  
**FORMAT: INPUT# &lt;file number&gt;, &lt;variable list&gt;**

**Action:**  This is usually the fastest and easiest way to retrieve data stored in a file on disk.  The data is in the form of whole variables of up to 80 characters in length, as opposed to the one-at-a-time method of [`GET#`](#get-1).  First, the file must have been [`OPEN`](#open)ed, then `INPUT#` can fill the variables.

The `INPUT#` command assumes a variable is finished when it reads a [`RETURN`](#return) code ([`CHR$`](#chr)(13)), a comma `(,)`, or colon `(:)`.  Quote marks `(")` can be used to enclose these characters when writing if they are needed (see the [`PRINT#`](#print-1) statement).

If the variable  type used is numeric, and non-numeric characters are received, a `BAD DATA` error results.  `INPUT#` can read strings up to 80 characters long, beyond which a `?STRING TOO LONG` error results.

When used with device #3 (the screen), this statement will read an entire logical line and move the cursor down to the next line.

**EXAMPLES of the INPUT# Statement:**
```BASIC
10 INPUT# 1, FR
20 INPUT# 2, X$, Y$
```

### INT

**TYPE: Integer Function**  
**FORMAT: INT(&lt;numeric&gt;)**

**Action:** Returns the integer value of the expression.  If the expression is positive, the fractional part is left off.  If the expression is negative, any fraction causes the next lower integer to be returned.

**EXAMPLES of the INT Function:**
```BASIC
10 PRINT INT(102.4242), INT(-16.702)
RUN
 102       -17
```

### JOY

**TYPE: Integer Function**  
**FORMAT: JOY(n)**

**Action:** Return the state of a joystick.

`JOY(1)` through `JOY(4)` return the state of SNES controllers connected to the system, and `JOY(0)` returns the state of the "keyboard joystick", a set of keyboard keys that map to the SNES controller layout. See [`joystick_get`](X16%20Reference%20-%2005%20-%20KERNAL.md#function-name-joystick_get) for details.

If no controller is connected to the SNES port (or no keyboard is connected), the function returns -1. Otherwise, the result is a bit field, with pressed buttons [`OR`](#or)ed together:

| Value  | Button |
|--------|--------|
| $800   | A      |
| $400   | X      |
| $200   | L      |
| $100   | R      |
| $080   | B      |
| $040   | Y      |
| $020   | SELECT |
| $010   | START  |
| $008   | UP     |
| $004   | DOWN   |
| $002   | LEFT   |
| $001   | RIGHT  |

Note that this bitfield is different from the `joystick_get` KERNAL API one. Also note that the keyboard joystick will allow LEFT and RIGHT as well as UP and DOWN to be pressed at the same time, while controllers usually prevent this mechanically.

**EXAMPLE of the JOY Function:**

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

**EXAMPLE of the KEYMAP Statement:**

```BASIC
10 KEYMAP"SV-SE"    :REM SMALL BASIC PROGRAM TO SET LAYOUT TO SWEDISH/SWEDEN
SAVE"AUTOBOOT.X16"  :REM SAVE AS AUTOBOOT FILE
```

### LEFT&#36;

**TYPE: String Function**  
**FORMAT: LEFT$(&lt;string&gt;, &lt;integer&gt;)**

**Action:** Returns a string comprised of the leftmost &lt;integer&gt; characters of the &lt;string&gt;.  The integer argument value must be in the range 0 to 255.  If the integer is greater than the length of the string, the entire string will be returned.  If an &lt;integer&gt; value of zero is used, then a null string (of zero length) is returned.

**EXAMPLES of the LEFT$ Function:**
```BASIC
10 X$ = "COMMANDER X16 COMPUTER"
20 C$ = LEFT$(X$, 9): PRINT C$
RUN

COMMANDER
```

### LEN

**TYPE: Integer Function**  
**FORMAT: LEN(&lt;string&gt;)**

**Action:** Returns the number of characters in the string expression.  Non-printed characters and blanks are counted.

**EXAMPLE of the LEN Function:**
```BASIC
10 CX$ = "COMMANDER X16 COMPUTER"
20 PRINT LEN(CX$)
RUN
 22
```

### LET

**TYPE: Statement**  
**FORMAT: [LET] &lt;variable&gt; = &lt;expression&gt;**

**Action:** The `LET` statement can be used to assign a value to a variable.  However, the word `LET` is optional and therefore most advanced programmers leave `LET` out because it's always understood and wastes valuable memory.  The equal sign `(=)` alone is sufficient when assigning the value of an expression to a variable name.

**EXAMPLES of the LET Statement:**
```BASIC
10 LET A = 42 : REM This is the same as A=12
20 LET A$ = "123"
30 B$ = "WIDGETS"
40 ANS$ = A$ + " " + B$ : REM ANS$ would equal "123 WIDGETS"
```

### LINE

**TYPE: Statement**  
**FORMAT: LINE &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This statement draws a line on the graphics screen in a given color.

**EXAMPLE of the LINE Statement:**

```BASIC
10 SCREEN128
20 FORA=0TO2*πSTEP2*π/200
30 :  LINE100,100,100+SIN(A)*100,100+COS(A)*100
40 NEXT
```

> **If you're pasting this example into the Commander X16 emulator, use this code block instead so that the &pi; symbol is properly received.**

```BASIC
10 SCREEN128
20 FORA=0TO2*\XFFSTEP2*\XFF/200
30 :  LINE100,100,100+SIN(A)*100,100+COS(A)*100
40 NEXT
```

### LINPUT

**TYPE: Command**  
**FORMAT: LINPUT &lt;var$&gt;**

**Action:** `LINPUT` Reads a line of data from the keyboard and stores the data into a string variable. Unlike [`INPUT`](#input), no parsing or cooking of the input is done, and therefore quotes, commas, and colons are stored in the string as typed. No prompt is displayed, either.

The input is taken from the KERNAL editor, hence the user will have the freedom of all of the features of the editor such as cursor movement, mode switching, and color changing.

Due to how the editor works, an empty line will return `" "`&ndash; a string with a single space, and trailing spaces are not preserved.

**EXAMPLE of the LINPUT Statement:**

```BASIC
10 LINPUT A$
20 IF A$=" " THEN 50
30 PRINT "YOU TYPED: ";A$
40 END
50 PRINT "YOU TYPED AN EMPTY STRING: ";A$
```

### LINPUT&#35;

**TYPE: Command**  
**FORMAT: LINPUT&#35; &lt;n&gt;,&lt;var$&gt;\[,&lt;delimiter&gt;\]**

**Action:** `LINPUT#` Reads a line of data from an open file and stores the data into a string variable. The delimiter of a line by default is 13 (carriage return). The delimiter is not part of the stored value. If the end of the file is reached while reading, [`ST`](#st)` AND 64` will be true.

`LINPUT#` can be used to read structured data from files. It can be particularly useful to extract quoted or null-terminated strings from files while reading.

**EXAMPLE of the LINPUT&#35; Statement:**

```BASIC
10 I=0
20 OPEN 1,8,0,"$"
30 LINPUT#1,A$,$22
40 IF ST<>0 THEN 130
50 LINPUT#1,A$,$22
60 IF I=0 THEN 90
70 PRINT "ENTRY: ";
80 GOTO 100
90 PRINT "LABEL: ";
100 PRINT CHR$($22);A$;CHR$($22)
110 I=I+1
120 IF ST=0 THEN 30
130 CLOSE 1
```

The above example parses and prints out the filenames from a directory listing.

### LIST

**TYPE: Command**  
**FORMAT: LIST [start] [-] [end]**

**Action:** `LIST` Displays the currently loaded BASIC program on the screen.
The start and ending line numbers are both optional.

The start and/or end may be specified. If both are specified, a hyphen must
be included. So `LIST` has 4 modes:

`LIST` by itself will display the entire program.

`LIST 10-20` will display lines 10 to 20, inclusive.

`LIST -100` will display from the start to line 100

`LIST 50-` will display line 50 to the end of the program.

Pressing the <mark>**CTRL**</mark> key during a listing will slow the listing down once
printing reaches the bottom of the screen. Approximately one line per second will
be displayed.  `LIST` is aborted by hitting the <mark>**RUN/STOP**</mark> key.

Pressing the <mark>**SPACE BAR**</mark> during the listing will cause the listing to pause.
Pressing the <mark>**SPACE BAR**</mark> a second time will unpause the listing. You may also
use the down arrow key to scroll by one line or use the `PgDn` key to scroll
approximately one screen full of text.

### LOAD

**TYPE: Command**  
**FORMAT: LOAD ["&lt;filename&gt;"][,&lt;device&gt;][,&lt;address&gt;] LOAD ["&lt;filename&gt;"][,&lt;device&gt;][,&lt;ram bank&gt;, &lt;start address&gt;] **

**Action:** The `LOAD` statement reads the contents of a program file from disk into memory.  That way you can use the information `LOAD`ed or change the information in some way.  The device number is optional, but when it is left out, the Commander X16 will automatically default to 8, the first disk device.  The `LOAD` command closes all open files and if it is used in direct mode, it performs a [`CLR`](#clr) (clear) before reading the program.  If `LOAD` is executed from within a program, the program is `RUN`.  this means that you can use `LOAD` to "chain" several programs together.  None of the variables are cleared during a chain operation.

If you are using file name pattern matching, the first file which matches the pattern is loaded.  The asterisk in quotes by itself `("*")` causes the first file name in the disk directory to be loaded.  If the file name used does not or if it is not a program, the BASIC error message `?FILE NOT FOUND` occurs.

Programs will `LOAD` starting at memory location $0801 (hex) unless a secondary &lt;address&gt; of 1 is used.  If you use the secondary address of 1 this will cause the program to `LOAD` to the memory location from which it was saved. 

If using the second form of the `LOAD` command, &lt;ram bank&gt; sets the back for the load, and &lt;start address&gt; is the location where your data will be `LOAD`ed into.

The value of the &lt;ram bank&gt; argument only affects the `LOAD` when the &lt;start address&gt; is set in the range of `$A000-$BFFF`.

**EXAMPLES of the LOAD Command:**
- LOAD FN$ (uses the contents of FN$ to load from disk)
- LOAD "*",8 (loads the first program from device 8)
- LOAD "GAME",8,1 (loads "GAME" into the same memory address it was saved from)
- LOAD "MUSIC.BIN",8,1,$A000 (loads a file into banked RAM, RAM bank 1, starting at $A000.  The first two bytes of the file are skipped.  To avoid skipping the first two bytes, use the `BLOAD` command instead.)

### LOCATE

**TYPE: Statement**  
**FORMAT: LOCATE &lt;line&gt;[,&lt;column&gt;]**

**Action:** This command positions the text mode cursor at the given location.
The values are 1-based. If no column is given, only the line is changed.

**EXAMPLE of the LOCATE Statement:**

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

### LOG

**TYPE: Floating-Point Function** 
**FORMAT: LOG(&lt;numeric&gt;)**

**Action:** Returns the natural logarithm (log to the base of e) of the argument.  If the value of the argument is zero or negative, the BASIC error message `?ILLEGAL QUANTITY` will occur.

**EXAMPLES of the LOG Function:**
```BASIC
10 PRINT LOG(42/9)
RUN
 1.54044504

10 NUM = LOG(ARG) / LOG(10): REM Calculates the LOG of ARG to the base 10)
```

### MID$

**TYPE: String Function**  
**FORMAT: MID$(&lt;string&gt;, &lt;numeric-1&gt;[,&lt;numeric-2&gt;])**

**Action:** The `MID$` function returns a sub-string which is taken from within a larger &lt;string&gt; argument.  The starting position of the sub-string is defined by the &lt;numeric-1&gt; argument and the length of the sub-string by the &lt;numeric-2&gt; argument.  Both of the numeric arguments can have values ranging from 0 to 255.

If the &lt;numeric-1&gt; value is greater than the length of the &lt;string&gt;, or if the &lt;numeric-2&gt; value is zero, then `MID$` gives a null string value.  If the &lt;numeric-2&gt; is left out, then the computer will assume that a length of the rest of the string is to be used.  And if the source string has fewer characters than &lt;numeric-2&gt;, from the starting position to the end of the string argument, then the whole rest of the string is used.

**EXAMPLE of the MID$ Function:**
```BASIC
10 G$ = "GOOD"
20 A$ = "MORNING EVENING AFTERNOON"
30 PRINT G$ + MID$(A$, 8, 8)
RUN
GOOD EVENING
```

### MENU

**TYPE: Command**  
**FORMAT: MENU**

**Action:** This command currently invokes the Commander X16 Control Panel. In the future, the menu may instead present a menu of ROM-based applications and routines.

**EXAMPLE of the MENU Command:**

```BASIC
MENU
```

### MOD

**TYPE: Function**  
**FORMAT: MOD(&lt;dividend&gt;, &lt;divisor&gt;)**

**Action:** Returns the truncated remainder of &lt;dividend&gt; divided by &lt;divisor&gt;

The `MOD` function supports 16bit signed numbers (-32768 to 32767)

**EXAMPLE of the MOD Function:**
```BASIC
PRINT MOD(-17, 5)        :REM RESULT WILL HAVE THE SAME SIGN AS DIVIDEND
-2

PRINT MOD(17, 5)
 2

PRINT MOD(42, 0)         :REM DIVISOR IS 0, RETURN ERROR
?DIVISION BY ZERO ERROR

PRINT MOD(65000, 101)    :REM DIVIDEND IS TOO LARGE FOR A SIGNED 16BIT VALUE
?ILLEGAL QUANTITY ERROR
```

### MON

**TYPE: Command**  
**FORMAT: MON (Alternative: MONITOR)**

**Action:** This command enters the machine language monitor. See the [Chapter 7: Machine Language Monitor](X16%20Reference%20-%2007%20-%20Machine%20Language%20Monitor.md#chapter-7-machine-language-monitor) for a  description.

**EXAMPLE of the MON Command:**

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

The sprite attributes for the mouse pointer are always read from VERA address $1:FC00-$1:FC07, the attributes for sprite 0. The default cursor will be written to the default sprite 0 data address in VERA at $1:3000 when Mode is set to 1.

The size of the mouse pointer's area will be configured according to the current screen mode. If the screen mode is changed, the MOUSE statement has to be repeated.

**EXAMPLES of MOUSE Statement:**

```BASIC
MOUSE 1 : REM ENABLE MOUSE
MOUSE 0 : REM DISABLE MOUSE
```

### MOVSPR

**TYPE: Statement**  
**FORMAT: MOVSPR &lt;sprite idx&gt;,&lt;x&gt;,&lt;y&gt;**

**Action:** This command positions a sprite's upper left corner at a specific pixel location.  It does not change its visibility.

&lt;sprite idx&gt; is a value between 0-127 inclusive.
`x` and `y` have a range of -32768 to 32767 inclusive, but their meanings wrap every 1024 values. Values approaching 1023 will peek out from the left and top of the screen for x and y respectively as if they were negative and approaching 0. -1024, 1024, 0, and 2048 are all equivalent. Likewise, -10 and 1014 are equivalent.

**EXAMPLE of the MOVSPR Statement:**

```BASIC
10 BVLOAD "MYSPRITE.BIN",8,1,$3000
20 SPRMEM 1,1,$3000,1
30 SPRITE 1,3,0,0,3,3
40 MOVSPR 1,320,200
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

**EXAMPLE of the MX/MY/MB variables:**

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

### MWHEEL

**TYPE: System variable**  
**FORMAT: MWHEEL**

**Action:** Return the mouse scroll wheel movement since the value was last read. The value is negative if the scroll wheel is
moved away from the user, and positive if it is moved towards the user. The range of the returned value is -128 to +127.

### NEW

**TYPE: Command**  
**FORMAT: NEW**

**Action:** The `NEW` command is used to delete the program currently in memory and clear all variables.  Before typing in a new program, `NEW` should be used in direct mode to clear memory.  `NEW` can also be used in a program, but you should be aware of the fact that it will erase everything that has gone before and is still in the computer's memory.  This can be particularly troublesome when you're trying to debug your program.

> **BE CAREFUL**: Not clearing out an old program before typing a new one can result in a confusing mix of the two programs.

**EXAMPLES of the NEW Command:**
```BASIC
NEW : REM Clears the program and all variables)
10 NEW : REM Performs a NEW operation and STOPs the program.
```

### NEXT

**TYPE: Statement**  
**FORMAT: NEXT [&lt;counter&gt;],[&lt;counter&gt;]...**

**Action:** The `NEXT` statement is used with [`FOR`](#for-to-step) to establish the end of a `FOR`...`NEXT` loop.  The `NEXT` need not be physically the last statement in the loop, but it is always the last statement executed in a loop.  The &lt;counter&gt; is the loop index's variable name used with `FOR` to start the loop.  A single `NEXT` can stop several nested loops when it is followed by each `FOR`'s &lt;counter&gt; variable name(s).  to do this each name must appear in the order of inner-most nested loop first, to outer-most nested loop last.  When using a single `NEXT` to increment and stop several variable names, each variable name must be separated by commas.  Loops can be nested to 9 levels.  If the counter variable(s) are omitted, the counter associated with the `FOR` of the current level (of the nested loops) is incremented.

When the `NEXT` is reached, the counter value is incremented by 1 or by an optional `STEP` value.  It is then tested against an end-value to see if it's time to stop the loop.  A loop will be stopped when a `NEXT` is found which has its counter value greater than the end-value.

**EXAMPLES of the NEXT Statement:**
```BASIC
10 FOR A=1 TO 5: FOR B=10 TO 20: FOR C=5 TO -10 STEP -1
20 NEXT C, B, A : REM Stopping nested loops

10 FOR A = 1 TO 100
20 FOR B = 1 TO 10
30 NEXT B
500 NEXT A  : REM Note how the loops do NOT cross each other.

10 FOR Z = 1 TO 10
20 FOR X = 1 TO 20
30 NEXT
40 NEXT : REM Notice that no variable names are needed
```

### NOT

**TYPE: Logical Operator**  
**FORMAT: NOT &lt;expression&gt;**

**Action:** The `NOT` logical operator "complements" the value of each bit in its single operand, producing an integer "two's complement" result.  In other words, the `NOT` is really saying, "if it isn't...".  When working with a floating-point number, the operands are converted to integers and any fractions are lost.  The `NOT` operator can also be used in a comparison to reverse the true/false value which was the result of a relationship test and therefore it will reverse the meaning of the comparison.  In the first example below, if the "two's complement" of "I" is equal to "D" and if "D" is `NOT` equal to "JA" then the expression is true.

**EXAMPLES of the NOT Operator:**
```BASIC
10 IF NOT I = D AND NOT (D=JA) THEN...

IA% = NOT 42 : PRINT IA%
-43
```

> **NOTE:** To find the value of `NOT` use the expression X = (-(X+1)).  (The two's complement of any integer is the bit complement plus one.)

### ON

**TYPE: Statement**  
**FORMAT: ON &lt;variable&gt; GOTO / GOSUB &lt;line number&gt; [,&lt;line number&gt;]...**

**Action:** The `ON` statement is used to [`GOTO`](#goto) or [`GOSUB`](#gosub) to one of several given line numbers, depending on the value of a variable.  The value of the variables can range from zero through the number of lines given.  If the value is a non-integer, the fractional portion is left off.  for example, if the variable value is 3, `ON` will `GOTO` (or `GOSUB`) the third line number in the list.

If the value of the variable is negative, the BASIC error message `?ILLEGAL QUANTITY` occurs.  If the number is zero, or greater than the number of items in the list, the program just ignores the statement and continues with the statement following the `ON` statement.

`ON` is really an underused variant of the [`IF...THEN...`](#if-then) statement.  Instead of using a whole lot of `IF` statements each of which sends the program to one specific line, one `ON` statement can replace a list of `IF` statements.  When you look at the first example you should notice that the one `ON` statement replaces four `IF...THEN...` statements.

**EXAMPLES of the ON Statement:**
```BASIC
ON -(X=2) - 2 * (X=6) - 3 * (X < 3) - 4 * (X > 7) GOTO 400, 900, 1000, 100

ON A GOTO 100,130,180,220

ON Z+7 GOSUB 4800, 230, 4800

100 ON NUM GOTO 250, 350, 320, 490

500 ON SUM / 2 + 1 GOSUB 100, 900, 50
```

### OLD

**TYPE: Command**  
**FORMAT: OLD**

**Action:** This command recovers the BASIC program in RAM that has been previously deleted using the [`NEW`](#new) command or through a [`RESET`](#reset).

**EXAMPLE of the OLD Statement:**

```BASIC
OLD
```

### OPEN

**TYPE: I/O Statement**  
**FORMAT: OPEN &lt;file number&gt;, &lt;device&gt; [, &lt;address&gt;] [, "&lt;file name&gt; [,&lt;type&gt;][, &lt;mode&gt;]"]**

**Action** This statement `OPEN`s a channel for input and/or output to a peripheral device.  however, you may NOT need all those ports for every `OPEN` statement.  Some `OPEN` statements require only two codes:

- LOGICAL FILE NUMBER
- DEVICE NUMBER

The &lt;file number&gt; is the logical file number, which relates to the `OPEN`, [`CLOSE`](#close), [`CMD`](#cmd), [`GET#`](#get-1), [`INPUT#`](#input-1), and [`PRINT#`](#print-1) statements to each other and associates them with the file name and the piece of equipment being used.  The logical file number can range from 1 to 255 and you can assign it any number you want in that range.

> **NOTE:** File numbers over 128 were really designed for other uses, so it's good practice to use only numbers below 127 for file numbers.

Each peripheral device (printer, disk drive, etc) in the system has its own number which it answers to.  The &lt;device&gt; number is used with `OPEN` to specify on which device the data file exists. Peripherals like disk drives or printers also answer to several secondary addresses.  Think of these as codes which tell each device what operation to perform.  The device logical file number is used with every `GET#`, `INPUT#`, and `PRINT#`.

If the &lt;device&gt; number is left out the Commander X16 will automatically assume that you want to talk to device #1, which has traditionally been assigned to the tape device.  Since the Commander X16 has no support for the tape device, I/O statements that reference it may operate with no error, but no actual work will be done.  Because of this, it should be assumed that specifying the device address is NOT optional.

For disk files, the secondary addresses 2 through 14 are available for data files, but other numbers have special meanings for DOS commands.  You must use a secondary address when using your disk drive(s).

The &lt;file name&gt; is a string of 1 to 16 characters and is optional for printer files.  If the file &lt;type&gt; is left out, the type of file will automatically default to the Program (PRG) file type unless the &lt;mode&gt; is given.  Sequential (SEQ) files are `OPEN`ed for reading (&lt;mode&gt;=R) unless you specify that files should be `OPEN`ed for writing (&lt;mode&gt;=W)  A file &lt;type&gt; can be used to `OPEN` an existing Relative file.  Use **REL** for &lt;type&gt; with Relative files.  Relative and Sequential files are for disk only.

> **NOTE:** Sequential files written outside of a disk image (.D64, .D81, etc) will appear as **PRG** files when viewing the file listing of the SD card.  This is because the FAT32 file system used by the SD card does not differentiate between file types. 

If you try to access a file before it is `OPEN`ed the BASIC error message `?FILE NOT OPEN` will occur.  If you try to `OPEN` a file for reading which does not exist the BASIC error message `?FILE NOT FOUND` will occur.  If a file is `OPEN`ed to disk and the file name already exists, the DOS error message `FILE EXISTS` occurs.  If a file is `OPEN`ed that is already `OPEN`, the BASIC error message `FILE OPEN` occurs.

**EXAMPLES of the OPEN Statement:**
- OPEN 2, 8, 2, "TEXT FILE, SEQ, W"  (opens a sequential file on disk)
- OPEN 50, 0 (keyboard input)
- OPEN 4, 3 (screen output)
- OPEN 75, 4 (printer output)
- OPEN 1, 8, 15, "COMMAND" (send a command to a disk device)


> **NOTE:** More information on working with disk files can be found in [Chapter 13](X16%20Reference%20-%2013%20-%20Working%20with%20CMDR-DOS.md#chapter-13-working-with-cmdr-dos).

### OR

**TYPE: Logical Operator**  
**FORMAT: &lt;operand&gt; OR &lt;operand&gt;**

**Action:** Just as the relational operators can be used to make decisions regarding program flow, logical operators can connect two or more relations and return a true or false value which can then be used in a decision.  When used in calculations, the logical `OR` gives you a bit result of 1 if the corresponding bit of either, or both, operands is 1.  This will produce an integer as a result, depending on the values of the operands.

When used in comparisons the logical `OR` operator is also used to link two expressions into a single compound expression.  If either of the expressions are true, the combined expression value is true (-1).  In the first example below, if AA is equal to BB `OR` if XX is 20, the expression is true.

Logical operators work by converting their operands to 16 bit, signed, two's complement integers in the range of -32768 to +32767.  If the operands are not in that range, an error message results.  Each bit of thee result is determined by the corresponding bits in the two operands.

**EXAMPLES of the OR Operator:**
```BASIC
10 IF (AA=BB) OR (XX=20) THEN...

50 KK% = 64 OR 32: PRINT KK%
RUN
 96 (64 has a bit value of 1000000 and 100000 for 32. ORing the two together results in 1100000 or 96 decimal)
```

### OVAL

**TYPE: Statement**  
**FORMAT: OVAL &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This command draws a filled oval on the graphics screen in a given color.

The coordinate arguments define the rectangular bounding box of the oval. To draw a filled circle, make the width and height equal to each other.

**EXAMPLE of the OVAL Statement:**

```BASIC
10 SCREEN $80
20 FORI=1 TO 20:OVAL RND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*128:NEXT
30 GOTO 20
```

### PEEK

**TYPE: Integer Function**  
**FORMAT: PEEK(&lt;address&gt;)**

**Action:** Returns the value at given memory address

`PEEK`ing values within the BRAM (`$A000`) and KERNAL/Cartridge (`$C000`)
requires using [`BANK`](#bank) to set the banks accordingly.

**EXAMPLE of the PEEK function:**

```BASIC
10 A=PEEK($C000)
20 PRINT A
```

### POINTER

**TYPE: Function**  
**FORMAT: POINTER(&lt;variable&gt;)**

**Action:** Returns the memory address of the internal structure representing a BASIC variable.

**EXAMPLE of the POINTER Function:**

```BASIC
10 A$="MOO"
20 PRINT HEX$(POINTER(A$))
RUN
0823
```

### POKE

**TYPE: Statement**  
**FORMAT: POKE &lt;address&gt;, &lt;value&gt;**

**Action:** Sets the contents of the memory address to given value.

To write to memory within a RAMBANK page, [`BANK`](#bank) must be 
called beforehand with the appropriate arguments.

Writing to values within the KERNAL/Cartridge area (`$C000`)
will not work as expected and may silently fail in KERNAL ROM versions
older than R49. In R49, POKE works as expected assuming the 
area being written to is RAM and that `BANK` has been 
called with appropriate arguments.

**EXAMPLE of the POKE Statement:**

```BASIC
10 POKE $A000,47
```

### POS

**TYPE: Integer Function**  
**FORMAT: POS(&lt;dummy&gt;)**

**Action:** Tells you the current cursor position which, of course, is in the range of 0 (leftmost character) through position 79 on an 80 character logical screen line.  If the Commander X16 is in 40 column mode, any position from 40 to 79 will refer to the second screen line.  The &lt;dummy&gt; argument is ignored.

**EXAMPLE of the POS Function:**
```BASIC
10 IF POS(0) > 38 THEN PRINT CHR$(13)
```

### POWEROFF

**TYPE: Command**  
**FORMAT: POWEROFF**

**Action:** This command instructs the SMC to power down the system. This is equivalent to pressing the physical power switch.

**EXAMPLE of the POWEROFF Statement:**

```BASIC
POWEROFF
```

### PRINT

**TYPE: Statement**  
**FORMAT: PRINT [&lt;variable&gt;][&lt;,/;&gt;&lt;variable&gt;]...**

**Action:** The `PRINT` statement is normally used to write data items to the screen.  However, the [`CMD`](#cmd) statement may be used to redirect that output to any other device in the system.  The &lt;variable(s)&gt; in the output-list are expressions of any type.  If no output-list is present, a blank line is printed.  The position of each printed item is determined by the punctuation used to separate items in the output-list.

The punctuation characters that you can use are blanks, commas, or semicolons.  the 80 character logical screen line is divided into 8 print zones of 10 spaces each.  In the list of expressions, a comma causes the next value to be printed at the beginning of the next zone.  A semicolon causes the next value to be printed immediately following the previous value.  However, there are two exceptions to this rule:

1. Numeric items are followed by an added space.
2. Positive numbers have a space preceding them.

When you use blanks or no punctuation between string constants or variable names, it has the same effect as a semicolon.  However, blanks between a string and a numeric item or between two numeric items will stop output without printing the second item.

If a comma or a semicolon is at the end of the output-list, the next `PRINT` statement begins printing on the same line, and spaced accordingly.  If no punctuation finishes the list, a carriage-return and a line-feed are printed at the end of the data.  The next `PRINT` statement will begin on the next line.  If your output is directed to the screen and the data printed is longer than 40 columns, the output is continued on the next screen line.

There is no statement in BASIC with more variety than the `PRINT` statement.  There are so many symbols, functions, and parameters associated with this statement that it might almost be considered as a language of its own within BASIC; a language specially designed for writing on the screen.

**EXAMPLES of the PRINT Statement:**

```BASIC
10 X = 10
20 PRINT -5 * X, X - 5, X + 5, X / 5
RUN
-50        5         15        2
```
```BASIC
10 X = 9
20 PRINT X; "SQUARED IS";X * X;"AND";
30 PRINT X "MULTIPLIED BY 19 IS" X * 19
RUN
 9 SQUARED IS 81 AND 9 MULTIPLIED BY 19 IS 171
```
```BASIC
10 A$(1)="ALPHA":A$(2)="BRAVO":A$(3)="CHARLIE":A$(4)="DELTA":A$(5)="ECHO"
20 PRINT A$(1)A$(2);A$(3) A$(4),A$(5)
RUN
ALPHABRAVOCHARLIEDELTA        ECHO
```
**Quote Mode**

Once the quote mark ( <mark>**SHIFT**</mark> <mark>**2**</mark> ) is typed, the cursor controls stop operating and start displaying reversed characters which actually stand for the cursor control you are hitting.  This allows you to program these cursor controls, because once the text inside the quotes is `PRINT`ed, they perform their functions.  The <mark>**INST/DEL**</mark> key is the only cursor control not affected by "quote mode".

**1. Cursor Movement**

The cursor controls which can be "programmed" in quote mode are:

> | **KEY** | **APPEARS AS** |
> |---------:|:----------------:|
> | <mark>**CLR/HOME**</mark> | ![Reverse S](images/rvs-S.png) |
> | <mark>**SHIFT**</mark> <mark>**CLR/HOME**</mark> | ![Reverse Heart](images/rvs-heart.png) |
> | <mark>**&uarr;CRSR&darr;**</mark> | ![Reverse Q](images/rvs-Q.png) |
> | <mark>**SHIFT**</mark> <mark>**&uarr;CRSR&darr;**</mark> | ![Reverse Ball](images/rvs-ball.png) |
> | <mark>**&larr;CRSR&rarr;**</mark> | ![Reverse Left Bracket](images/rvs-r-bracket.png) |
> | <mark>**SHIFT**</mark> <mark>**&larr;CRSR&rarr;**</mark> | ![Reverse Bar](images/rvs-bar.png) |

If you wanted the word HELLO to `PRINT` diagonally from the upper left corner of the screen, you would type:

PRINT "<mark>**CLR/HOME**</mark> H <mark>**&uarr;CRSR&darr;**</mark> E <mark>**&uarr;CRSR&darr;**</mark> L <mark>**&uarr;CRSR&darr;**</mark> L <mark>**&uarr;CRSR&darr;**</mark> O"

Which would appear as:

![Cursor Pos. Example](images/print-screen-pos-example.png)

**2. Reverse Characters**

Holding down the <mark>**CTRL**</mark> key and hitting <mark>**9**</mark> will cause <marksq>**R**</marksq> to appear inside the quotes.  This will make all characters print starting in *reverse video* (like a negative of a picture).  To end the reverse printing hit <mark>**CTRL**</mark> <mark>**0**</mark>, which prints a ![](images/norm-lower-bar.png) or else `PRINT` a <mark>**RETURN**</mark> ([`CHR$`](#chr)(13)).  (Just ending the `PRINT` statement without a semicolon or a comma will take care of this.)

**3. Color Controls**

Holding down the <mark>**CTRL**</mark> or the <mark>**ALT**</mark> key with any of the 8 color keys will make a special reversed character which appears in quotes.  When the character is `PRINT`ed, then the color change will occur.

> | **KEY** | **COLOR** | **APPEARS AS** |
> |--------:|:---------:|:--------------:|
> | <mark>**CTRL**</mark> <mark>**1**</mark> | Black | ![Reverse UR Corner](images/rvs-ur-corner.png) |
> | <mark>**CTRL**</mark> <mark>**2**</mark> | White | ![Reverse E](images/rvs-E.png) |
> | <mark>**CTRL**</mark> <mark>**3**</mark> | Red | ![Reverse Pound](images/rvs-pound.png) |
> | <mark>**CTRL**</mark> <mark>**4**</mark> | Cyan | ![Reverse Left Ramp](images/rvs-l-ramp.png) |
> | <mark>**CTRL**</mark> <mark>**5**</mark> | Purple | ![Reverse Left Half Tile](images/rvs-half-tile.png) |
> | <mark>**CTRL**</mark> <mark>**6**</mark> | Green | ![Reverse Up Arrow](images/rvs-up-arr.png) |
> | <mark>**CTRL**</mark> <mark>**7**</mark> | Blue | ![Reverse Left Arrow](images/rvs-l-arr.png) |
> | <mark>**CTRL**</mark> <mark>**8**</mark> | Yellow | ![Reverse Pi](images/rvs-pi.png) |
> | <mark>**ALT**</mark> <mark>**1**</mark> | Orange | ![Reverse Spade](images/rvs-spade.png) |
> | <mark>**ALT**</mark> <mark>**2**</mark> | Brown | ![Reverse Upper Left Corner](images/rvs-ul-corner.png) |
> | <mark>**ALT**</mark> <mark>**3**</mark> | Light Red | ![Reverse X Symbol](images/rvs-x-symbol.png) |
> | <mark>**ALT**</mark> <mark>**4**</mark> | Grey 1 | ![Reverse Circle](images/rvs-circle.png) |
> | <mark>**ALT**</mark> <mark>**5**</mark> | Grey 2 | ![Reverse Club](images/rvs-club.png) |
> | <mark>**ALT**</mark> <mark>**6**</mark> | Light Green | ![Reverse Right Offset Bar](images/rvs-r-offset-bar.png) |
> | <mark>**ALT**</mark> <mark>**7**</mark> | Light Blue | ![Reverse Diamond](images/rvs-diamond.png) |
> | <mark>**ALT**</mark> <mark>**8**</mark> | Grey 3 | ![Reverse Plus Symbol](images/rvs-plus-symbol.png) |

If you wanted to print the word HELLO in cyan and the word THERE in white, type:

PRINT "<mark>**CTRL**</mark> <mark>**4**</mark>HELLO<mark>**CTRL**</mark> <mark>**2**</mark>THERE"

Which would appear as:

![Print Color Example](images/print-color-example.png)

**4. Insert Mode**

The spaces created by using the <mark>**INST/DEL**</mark> key have some of the same characteristics as quote mode.  The cursor controls and color controls show up as reversed characters.  The only difference is in the <mark>**INST**</mark> and <mark>**DEL**</mark> which performs
its normal function even in quote mode, now creates the <marksq>**T**</marksq>.  And <mark>**INST**</mark>, which created a special character in quote mode, inserts spaces normally.

Because of this, it is possible to create a `PRINT` statement containing <mark>**DEL**</mark>etes, which cannot be `PRINT`ed in quote mode.  Here is an example of how this is done:

10 PRINT "HELLO" <mark>**INST/DEL**</mark> <mark>**SHIFT**</mark> <mark>**INST/DEL**</mark> <mark>**SHIFT**</mark> <mark>**INST/DEL**</mark> <mark>**INST/DEL**</mark> <mark>**INST/DEL**</mark>P"

which displays as:

10 PRINT "HELLO<marksq>**T**</marksq><marksq>**T**</marksq>P"

When the above line is [`RUN`](#run), the word displayed will be HELP, because the last two letters are deleted and the P is put in their place.

> **WARNING:** The <mark>**DEL**</mark>etes will work when [`LIST`](#list)ing as well as `PRINT`ing, so editing a line with these characters will be difficult.

The "insert mode" condition is ended when the <mark>**RETURN**</mark> (or <mark>**SHIFT**</mark> <mark>**RETURN**</mark>) key is hit, or when as many characters have been typed as spaces were inserted.

**5. Other Special Characters**

There are some other characters that can be `PRINT`ed for special function, although they are not easily available from the keyboard.  In order to get these in quotes, you must leave empty spaces for them in the line, hit <mark>**RETURN**</mark> or <mark>**SHIFT**</mark> <mark>**RETURN**</mark>, and go back to the spaces with the cursor controls. Now you must hit <mark>**CTRL**</mark> <mark>**RVS/ON**</mark>, to start typing reversed characters, and type the keys shown below:

| Function | Type     | Appears As |
|:--------:|:---------|:-----------|
| <mark>**SHIFT**</mark> <mark>**RETURN**</mark> | <mark>**SHIFT**</mark> <mark>**M**</mark> | ![Reverse Backslash](images/rvs-backslash.png) |
| Switch to lower case | <mark>**N**</mark> | ![Reverse N](images/rvs-N.png) |
| Switch to upper case | <mark>**SHIFT**</mark> <mark>**N**</mark> | ![Reverse Slash](images/rvs-slash.png) |
| Disable case-switching keys | <mark>**H**</mark> | ![Reverse H](images/rvs-H.png) |
| Enable case-switching keys | <mark>**I**</mark> | ![Reverse I](images/rvs-I.png) |

The <mark>**SHIFT**</mark> <mark>**RETURN**</mark> will work in the `LIST`ing as well as `PRINT`ing, so editing will be almost impossible if this character is used.  The `LIST`in will also look very strange.

### PRINT#

**TYPE: I/O Statement**  
**FORMAT: PRINT# &lt;file number&gt; [&lt;variable&gt;][&lt;,/;&gt;&lt;variable&gt;]...** 

**Action:** The `PRINT#` statement is used to write data items to a logical file.  It must use the same number used to `OPEN` the file.  Output goes to the device number used in the [`OPEN`](#open) statement.  The &lt;variable&gt; expressions in the output-list can be of any type.  The punctuation characters between items are the same as with the `PRINT` statement and they can be used in the same ways.  The effects of punctuation are different in one significant respects.

If no punctuation finishes the list, a carriage-return and a line-feed are written at the end of the data.  If a comma or semicolon terminates the output-list, the carriage-return and line-feed are suppressed.  Regardless of the punctuation, the next `PRINT#` statement beings output in the next available character position.  The line-feed will act as a stop when using the [`INPUT#`](#input-1) statement, leaving an empty variable when the next `INPUT#` is executed.  The line-feed can be suppressed or compensated for as shown in the examples below.

The easiest way to write more than one variable to a file is to set a string variable to [`CHR$`](#chr)(13), and use that string in between all the other variables when writing the file.

**EXAMPLES of the PRINT# Statement:**
```BASIC
10 OPEN 1,8,1, "TEXT FILE,SEQ,W"
20 CR$ = CHR$(13)                     :REM By changing the CHR$(13) to CHR$(44)
30 PRINT# 1,1;CR$;2;CR$;3;CR$;4;CR$;5 :REM you put a "," between each variable.
40 PRINT# 1,6                         :REM CHR$(59) would put a ";" between each variable.
```
```BASIC
10 CM$=CHR$(44) : CR$=CHR$(13)
20 PRINT#1, "AAA" CM$ "BBB","CCC";"DDD";"EEE" CR$ "FFF",CR$;
30 REM Result: "AAA,BBB     CCCDDDEEE<CR>FFF<CR>
40 INPUT#1, A$,BCDE$,F$
```
```BASIC
10 CR$=CHR$(13)
20 PRINT#2, "AAA";CR$;"BBB"
30 PRINT#2, "CCC";
40 INPUT#2, A$, B$, DUMMY$, C$
```

### PSET

**TYPE: Statement**  
**FORMAT: PSET &lt;x&gt;,&lt;y&gt;,&lt;color&gt;**

**Action:** This command sets a pixel on the graphics screen to a given color.

**EXAMPLE of the PSET Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:PSETRND(1)*320,RND(1)*200,RND(1)*256:NEXT
30 GOTO20
```

### PSGCHORD

**TYPE: Statement**  
**FORMAT: PSGCHORD &lt;first voice&gt;,&lt;string&gt;**

**Action:** This command uses the same syntax as [`PSGPLAY`](#psgplay), but instead of playing a series of notes, it will start all of the notes in the string simultaneously on one or more voices. The first parameter to `PSGCHORD` is the first voice to use, and will be used for the first note in the string, and subsequent notes in the string will be started on subsequent voices, with the voice after 15 being voice 0.

All macros are supported, even the ones that only affect `PSGPLAY` and [`FMPLAY`](#fmplay).

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of the PSGCHORD Statement:**

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

**TYPE: Statement**  
**FORMAT: PSGFREQ &lt;voice&gt;,&lt;frequency&gt;**

**Action:** Play a note by frequency on the VERA PSG. The accepted range is in Hz from 1 to 24319. PSGFREQ also accepts a frequency of 0 to release the note.

**EXAMPLE of the PSGFREQ Statement:**

```BASIC
10 PSGINIT : REM RESET ALL VOICES TO SQUARE WAVEFORM
20 PSGFREQ 0,350 : REM PLAY A SQUARE WAVE AT 350 HZ
30 PSGFREQ 1,440 : REM PLAY A SQUARE WAVE AT 440 HZ ON ANOTHER VOICE
40 FOR X=1 TO 10000 : NEXT X : REM DELAY A BIT
50 PSGFREQ 0,0 : PSGFREQ 1,0 : REM RELEASE BOTH VOICES
```

The above BASIC program plays a sound similar to a North American dial tone for a few seconds.

### PSGINIT

**TYPE: Statement**  
**FORMAT: PSGINIT**

**Action:** Initialize VERA PSG, silence all voices, set volume to 63 on all voices, and set the waveform to pulse and the duty cycle to 63 (50%) for all 16 voices.

### PSGNOTE

**TYPE: Statement**  
**FORMAT: PSGNOTE &lt;voice&gt;,&lt;note&gt;**

**Action:** Play a note on the VERA PSG. The note value is constructed as follows. Using hexadecimal notation, the first nybble is the octave, 0-7, and the second nybble is the note within the octave as follows:

| `$x0` | `$x1` | `$x2` | `$x3` | `$x4` | `$x5` | `$x6` | `$x7` | `$x8` | `$x9` | `$xA` | `$xB` | `$xC` | `$xD-$xF` |
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
| Release | C | C&#9839;/D&#9837; | D | D&#9839;/E&#9837; | E | F | F&#9839;/G&#9837; | G | G&#9839;/A&#9837; | A | A&#9839;/B&#9837; | B | no-op |

**EXAMPLE of the PSGNOTE Statement:**

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

**TYPE: Statement**  
**FORMAT: PSGPAN &lt;voice&gt;,&lt;panning&gt;**

**Action:** Sets the simple stereo panning on a VERA PSG voice. Valid values are as follows:

* 1 = left
* 2 = right
* 3 = both

### PSGPLAY

**TYPE: Statement**  
**FORMAT: PSGPLAY &lt;voice&gt;,&lt;string&gt;**

**Action:** This command is very similar to `PLAY` on other BASICs such as GWBASIC. It takes a string of notes, rests, tempo changes, note lengths, and other macros, and plays all of the notes synchronously.  That is, the PSGPLAY command will not return control until all of the notes and rests in the string have been fully played.

The full set of macros is documented [here](X16%20Reference%20-%20Appendix%20A%20-%20Sound.md#basic-fmplay-and-psgplay-string-macros).

**EXAMPLE of the PSGPLAY Statement:**

```BASIC
10 PSGWAV 0,31 : REM PULSE, 25% DUTY CYCLE
20 PSGPLAY 0,"T180 S0 O5 L32" : REM TEMPO 180 BPM, LEGATO, OCTAVE 5, 32ND NOTES
30 PSGPLAY 0,"C<G>CEG>C<G<A-"
40 PSGPLAY 0,">CE-A-E-A->CE-A-"
50 PSGPLAY 0,"E-<<B->DFB-FB->DFB-F" : REM GRAB YOURSELF A MUSHROOM
```

### PSGVOL

**TYPE: Statement**  
**FORMAT: PSGVOL &lt;voice&gt;,&lt;volume&gt;**

**Action:** This statement sets the voice's volume. The volume remains at the requested level until another `PSGVOL` command for that voice or [`PSGINIT`](#psginit) is called.  Valid range is from 0 (completely silent) to 63 (full volume).

### PSGWAV

**TYPE: Statement**  
**FORMAT: PSGWAV &lt;voice&gt;,&lt;w&gt;**

**Action:** Sets the waveform and duty cycle for a PSG voice.

* w = 0-63 -> Pulse: Duty cycle is `(w+1)/128`. A value of 63 means 50% duty cycle.
* w = 64-127 -> Sawtooth (all values have identical effect)
* w = 128-191 -> Triangle (all values have identical effect)
* w = 192-255 -> Noise (all values have identical effect)

**EXAMPLE of the PSGWAV Statement:**

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

### READ

**TYPE: Statement**  
**FORMAT: READ &lt;<variable>&gt; [,&lt;variable&gt;]...***

**Action:** The `READ` statement is used to fill variable names from constants in [`DATA`](#data) statements.  The data actually read must agree with the variable types specified or the BASIC error message `?SYNTAX ERROR` will result.  Variables in the `DATA` input-list must be separated by commas.

A single `READ` statement can access on or more `DATA` statements, which will be accessed in order (see [DATA](#data)), or several `READ` statements can access the same `DATA` statement.  If more `READ` statements are executed than the number of elements in `DATA` statement(s), in the program, the BASIC error message `?OUT OF DATA` is printed.  If the number of variables specified is fewer than the number of elements in the `DATA` statement(s), subsequent `READ` statements will continue reading at the next data element. (See [RESTORE](#restore).)

> **NOTE:** The `?SYNTAX ERROR` will appear with the line number from the `DATA` statement, NOT the `READ` statement.

**EXAMPLES of the READ Statement:**
```BASIC
10 READ A, B, C$
20 DATA 4, 42, HELLO
```
```BASIC
10 FOR X = 1 TO 10: READ A(X): NEXT X
20 DATA 3.14, 42.5, 18.32, 103.52, 16.67
30 DATA 1.11, 86.0, 32.54, 5.52, 2.23
```
```BASIC
10 READ CITY$, STATE$, ZIP
20 DATA PUYALLUP, WASHINGTON, 98373
```

### REM

**TYPE: Statement**  
**FORMAT: REM [&lt;remark&gt;]**

**Action:** The `REM` statement makes your programs more easily understood when [`LIST`](#list)ed.  It's a reminder to yourself to tell you what you had in mind when you were writing each section of the program.  For instance, you might want to remember what a variable is used for, or some other useful information.  The `REM`ark can be any text, word, or character including the colon `(:)` or BASIC keywords.  The `REM` statement and anything following it on the same line number are ignored by BASIC, but `REM`arks are printed exactly as entered when the program is listed.  A `REM` statement can be referred to by a [`GOTO`](#goto) or [`GOSUB`](#gosub) statement, and the execution of the program will continue with the next higher program line having executable statements.

**EXAMPLES of the REM Statement:**
```BASIC
10 REM CALCULATE THE AVERAGE VELOCITY OF AN UNLADEN SWALLOW
20 FOR X = 1 TO 20: REM LOOP FOR TWENTY VALUES
30 SUM = SUM + VEL(X) : NEXT X
40 AVG = SUM / 20
```

### RING

**TYPE: Statement**  
**FORMAT: RING &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This statement draws an oval outline on the graphics screen in a given color.

The coordinate arguments define the rectangular bounding box of the oval. To draw a circle outline, make the width and height equal to each other.

**EXAMPLE of the RING Statement:**

```BASIC
10 SCREEN $80
20 FORI=1 TO 20:RING RND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*128:NEXT
30 GOTO 20
```

### RECT

**TYPE: Statement**  
**FORMAT: RECT &lt;x1&gt;,&lt;y1&gt;,&lt;x2&gt;,&lt;y2&gt;,&lt;color&gt;**

**Action:** This statement draws a solid rectangle on the graphics screen in a given color.

**EXAMPLE of the RECT Statement:**

```BASIC
10 SCREEN$80
20 FORI=1TO20:RECTRND(1)*320,RND(1)*200,RND(1)*320,RND(1)*200,RND(1)*256:NEXT
30 GOTO20
```

### REBOOT

**TYPE: Command**  
**FORMAT: REBOOT**

**Action:** Performs a software reset of the system by calling the ROM reset vector.

**EXAMPLE of the REBOOT Statement:**

```BASIC
REBOOT
```

### REN

**TYPE: Command**  
**FORMAT: REN [&lt;new line num&gt;[, &lt;increment&gt;[, &lt;first old line num&gt;]]]**

**Action:** Renumbers a BASIC program while updating the line number arguments of [`GOSUB`](#gosub), [`GOTO`](#goto), [`RESTORE`](#restore), [`RUN`](#run), and [`THEN`](#if-then).

Optional arguments:  

* The line number of the first line after renumbering, default: **10**  
* The value of the increment for subsequent lines, default **10**  
* The earliest old line to start renumbering at, default: **0**  

**Please ensure your have saved your program before using this command to renumber.**

> **KNOWN BUG:**  In release R43, due to improper parsing of escape tokens, REN will improperly treat arguments to these statements as line numbers:
> 
> * [`FRAME`](#frame)
> * [`RECT`](#rect)
> * [`MOUSE`](#mouse)
> * [`COLOR`](#color)
> * [`PSGWAV`](#psgwav)
> 
> This behavior has been fixed in R44.


**EXAMPLE of the REN Statement:**

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

**EXAMPLE of the RESET Statement:**

```BASIC
RESET
```

### RESTORE

**TYPE: Statement**  
**FORMAT: RESTORE [&lt;linenum&gt;]**

**Action:** This statement resets the pointer for the [`READ`](#read) command. Without arguments, it will reset the pointer to the first [`DATA`](#data) constant in the program.  With &gt;linenum&gt; parameter, the statement will reset the pointer to the first `DATA` constant at or after that line number.

**EXAMPLE of the RESTORE Statement:**

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

### RETURN

**TYPE: Statement**  
**FORMAT: RETURN**

**Action:** The `RETURN` statement is used to exit from a subroutine called for by a [`GOSUB`](#gosub) statement.  `RETURN` restarts the rest of your program at the next executable statement following the `GOSUB`.  If you are nesting subroutines, each `GOSUB` must be paired with at least one `RETURN` statement.  A subroutine can contain any number of `RETURN` statements, but the first one encountered will exit the subroutine.

**EXAMPLE of the RETURN Statement:**
```BASIC
10 PRINT "THIS IS THE PROGRAM"
20 GOSUB 1000
30 PRINT "THE PROGRAM CONTINUES"
40 GOSUB 1000
60 END
1000 PRINT "THIS IS THE SUBROUTINE." : RETURN
```

### RIGHT$

**TYPE: String Function**  
**FORMAT: RIGHT$(&lt;string&gt;, &lt;numeric&gt;)**

**Action:** The `RIGHT$` function returns a sub-string taken from the right-most end of the &lt;string&gt; argument.  The length of the sub-string is defined by the &lt;numeric&gt; argument which can be any integer in the range of 0 to 255.  If the value of the numeric expression is zero, then a null string `("")` is returned.  If the value you give in the &lt;numeric&gt; argument is greater than the length of the &lt;string&gt; then the entire string is returned.

**EXAMPLE of the RIGHT$ Function:**
```BASIC
10 MSG$ = "COMMANDER X16"
20 PRINT RIGHT$(MSG$, 3)
RUN
X16
```

### RND

**TYPE: Floating-Point Function**  
**FORMAT: RND(&lt;numeric&gt;)**

**Action:** `RND` creates a floating-point random number from 0.0 to 1.0.  the computer generates a sequence of random numbers by performing calculations on a starting number, which in computer jargon is called a "seed".  The `RND` function is seeded on system power-up.  the &lt;numeric&gt; argument is a dummy, except for its sign (positive, zero, or negative).

If the &lt;numeric&gt; argument is positive, the same "pseudorandom" sequence of numbers is returned, starting from a given seed value.  Different number sequences will result from different seeds, but any sequence is repeatable by starting from the same seed number.  Having a known sequence of "random" numbers is useful in testing programs.

If you choose a &lt;numeric&gt; argument of zero, then `RND` generates a number directly from a free-running hardware clock (the system "jiffy clock").  Negative arguments cause the `RND` function to be re-seeded with each function call.

**EXAMPLES of the RND Function:**

```BASIC
10 PRINT INT(RND(0) * 50) : REM Returns random integers from 0 to 49

20 X = INT(RND(1) * 6) + INT(RND(1) * 6) + 2 : REM SIMULATES TWO DICE

30 X = INT(RND(1) * 1000) + 1 : REM RANDOM INTEGERS FROM 0 TO 1000

40 X = INT(RND(1) * 50) + 100 : REM RANDOM NUMBERS FROM 100 TO 249

50 X = RND(1) * (U - L) + L : REM RANDOM NUMBERS BETWEEN UPPER (U) AND LOWER (L) LIMITS.
```

### RPT$

**TYPE: Function**  
**FORMAT: RPT$(&lt;byte&gt;,&lt;count&gt;)**

**Action:** Returns a string of &lt;count&gt; instances of the PETSCII character represented by the numeric value &lt;byte&gt;.  This function is similar in behavior to [`CHR$`](#chr) but takes a second argument as a repeat count.

`RPT$(A,1)` is functionally equivalent to `CHR$(A)`.

**EXAMPLE of the RPT$ Function:**

```BASIC
10 REM TEN EXCLAMATION MARKS
20 PRINT RPT$(33,10)
READY.
RUN
!!!!!!!!!!

READY.
```

### RUN

**TYPE: Command**  
**FORMAT: RUN [&lt;line number&gt;]**

**Action:** The system command `RUN` is used to start the program currently in memory.  The `RUN` command causes an implied [`CLR`](#clr) operation to be performed before starting the program.  You can void the `CLR` operation by using [`CONT`](#cont) or [`GOTO`](#goto) to restart a program instead of `RUN`.  If a &lt;line number&gt; is specified, your program will start on that line.  Otherwise, the `RUN` command starts at the first line of the program.

The `RUN` command can also be used within a program.  if the &lt;line number&gt; you specify doesn't exist, the BASIC error message `?UNDEF'D STATEMENT` occurs.

A `RUN`ning program stops and BASIC returns to direct mode when an [`END`](#end) or [`STOP`](#stop) statement is reached, when the last line of the program is finished, or when a BASIC error occurs during execution.

**EXAMPLES of the RUN Command:**
- RUN - Starts at the first line of a program.
- RUN 500 - Starts at line number 500.
- RUN X - Starts at line X, or `?UNDEF'D STATEMENT error if there is no line X.

### SAVE

**TYPE: Command**
**FORMAT: SAVE &lt;filename&gt; \[, &lt;device&gt;**\]

**Action:** Saves a BASIC program to a file.

This saves the currently loaded BASIC program to a file. If the device number is not supplied, `SAVE` will use the default drive. This is usually the SD card.

Note that `SAVE` will not overwrite an existing file by default. To do this, you must prefix the filename with @:, like this: `SAVE "@:filename"`

**EXAMPLES of the SAVE Command:**

```BASIC
SAVE "HELLO.PRG"
```

The above example saves your Hello World program to the SD card.

```BASIC
SAVE "@:HELLO.PRG",9
```

The above example overwrites an existing file on drive 9, which would be a Commodore style disk drive plugged into the IEC port.

### SCREEN

**TYPE: Statement**  
**FORMAT: SCREEN &lt;mode&gt;**

**Action:** This statement switches screen modes.

**Suported Modes**
| Mode | Description |
|------|-------------|
| $00  | 80x60 text  |
| $01  | 80x30 text  |
| $02  | 40x60 text  |
| $03  | 40x30 text  |
| $04  | 40x15 text  |
| $05  | 20x30 text  |
| $06  | 20x15 text  |
| $07  | 22x23 text  |
| $08  | 64x50 text  |
| $09  | 64x25 text  |
| $0A  | 32x50 text  |
| $0B  | 32x25 text  |
| $80  | 320x240@256c 40x30 text |

Please refer to [Chapter 3: Editor](X16%20Reference%20-%2003%20-%20Editor.md#chapter-3-editor) for more information on text modes.  

The value of -1 toggles between modes $00 and $03.

**EXAMPLE of the SCREEN Statement:**

```BASIC
SCREEN 3 : REM SWITCH TO 40 CHARACTER MODE
SCREEN 0 : REM SWITCH TO 80 CHARACTER MODE
SCREEN -1 : REM SWITCH BETWEEN 40 and 80 CHARACTER MODE
```

To edit text on the screen, refer to the following commands:
* [CHAR](#char)
* [COLOR](#color)
* [LOCATE](#locate)
* [POS](#pos)
* [TATTR](#tattr)
* [TDATA](#tdata)
* [TILE](#tile)

To edit bitmap data in screen mode $80, refer to the following commands:
* [FRAME](#frame)
* [LINE](#line)
* [OVAL](#oval)
* [PSET](#pset)
* [RECT](#rect)
* [RING](#ring)

Direct writing of the VERA's memory can be performed via [VPOKE](#vpoke).

Details about programming for the VERA video adapter can be found in [Chapter 9: VERA Programmer's Reference](X16%20Reference%20-%2009%20-%20VERA%20Programmer's%20Reference.md). In particular, please refer to the sections on [VRAM Address Space Layout](X16%20Reference%20-%2009%20-%20VERA%20Programmer's%20Reference.md#vram-address-space-layout) and [Tile mode 1 bpp (16 color text mode)](X16%20Reference%20-%2009%20-%20VERA%20Programmer's%20Reference.md#tile-mode-1-bpp-16-color-text-mode). All text modes use Tile mode 1 bpp (16 color text mode), with 128 tiles per line and 64 lines, even though the display will not show the entire range at once.

The video memory for all text modes start at VERA bank 1, address $B000. (e.g. `VPOKE 1, $B000, 0`).
For mode $80, bitmap memory starts at VERA bank 0, address $0000. (e.g. `VPOKE 0, $0000, 0`).

### SGN

**TYPE: Integer Function**  
**FORMAT: SGN(&lt;numeric&gt;)**

**Action:** `SGN` gives you an integer value depending upon the sign of the &lt;numeric&gt; argument.  If the argument is positive, the result is 1, if zero the result is also zero, if negative the result is -1.

**EXAMPLE of the SGN Function:**

```BASIC
20 ON SGN(DV) + 2 GOTO 1000, 2000, 3000
25 REM JUMP TO 1000 IF DV IS NEGATIVE, 2000 IF DV IS ZERO, AND 300 IF DV IS POSITIVE.
```

### SIN

**TYPE: Floating-Point Function**  
**FORMAT: SIN(&lt;numeric&gt;)**

**Action:** `SIN` gives you the sine of the &lt;numeric&gt; argument, in radians.  The value of [`COS`](#cos)(x) is equal to `SIN`(x + 3.1415925 / 2).

**EXAMPLE of the SIN Function:**
```BASIC
125 AA = SIN(1.5) : PRINT AA
```
The result is .997494987.

### SLEEP

**TYPE: Statement**  
**FORMAT: SLEEP \[&lt;jiffies&gt;\]**

**Action:** With the default interrupt source configured and enabled, this command waits for `jiffies`+1 VSYNC events and then resumes program execution. In other words, `SLEEP` with no arguments is equivalent to `SLEEP 0`, which waits until the beginning of the next frame. Another useful example, `SLEEP 60`, pauses for approximately 1 second.

Allowed values for `jiffies` is from 0 to 65535, inclusive.

**EXAMPLE of the SLEEP Statement:**

```BASIC
10 FOR I=1 TO 10
20 PRINT I
30 SLEEP 60
40 NEXT
```

### SPC

**TYPE: Special Function:**  
**FORMAT: SPC(&lt;numeric&gt;)**

**Action:** The `SPC` function is used to control the formatting of data, as either an output to the screen or into a logical file.  The number of spaces given by the &lt;numeric&gt; argument are printed, starting at the first available position.  For screen files, the value of the argument is in the range of 0 to 255 and for disk files, up to 254.  For printer files, an automatic carriage-return and line-feed will be performed by the printer if a space is printed in the last character position of a line.  No spaces are printed on the following line.

**EXAMPLE of the SPC Function:**
```BASIC
10 PRINT "FIRST "; "SECOND";
20 PRINT SPC(6) "THIRD" SPC(20) "FOURTH"
RUN
FIRST SECOND      THIRD                    FOURTH
```

### SPRITE

**TYPE: Statement**  
**FORMAT: SPRITE &lt;sprite idx&gt;,&lt;priority&gt;\[,&lt;palette offset&gt;\[,&lt;flip&gt;\[,&lt;x-width&gt;\[,&lt;y-width&gt;\[,&lt;color depth&gt;\]\]\]\]\]**

**Action:** This statement configures a sprite's geometry, palette, and visibility.

The first two arguments are required, but the remainder are optional.

* &lt;sprite idx&gt; is a value between 0-127 inclusive.
* &lt;priority&gt;, also known as z-depth changes the visibility of the sprite and above which layer it is rendered.  Range is 0-3 inclusive.  0 = off, 1 = below layer 0, 2 = in between layers 0 and 1, 3 = above layer 1
* &lt;palette offset&gt; is the palette offset for the sprite. Range is 0-15 inclusive. This value is multiplied by 16 to determine the starting palette index.
* &lt;flip&gt; controls the X and Y flipping of the sprite. Range is 0-3 inclusive. 0 = unflipped, 1 = X is flipped, 2 = Y is flipped, 3 = both X and Y are flipped.
* &lt;x-width&gt; and &lt;y-width&gt; represent the dimensions of the sprite. Range is 0-3 inclusive. 0 = 8px, 1 = 16px, 2 = 32px, 3 = 64px.
* &lt;color depth&gt; selects either 4 or 8-bit color depth for the sprite. 0 = 4-bit, 1 = 8-bit.  This attribute can also be set by the [`SPRMEM`](#sprmem) command.

Note: If VERA's sprite layer is disabled when the `SPRITE` command is called, the sprite layer will be enabled, regardless of the arguments to `SPRITE`.

**EXAMPLE of the SPRITE Statement:**

```BASIC
10 BVLOAD "MYSPRITE.BIN",8,1,$3000
20 SPRMEM 1,1,$3000,1
30 SPRITE 1,3,0,0,3,3
40 MOVSPR 1,320,200
```

### SPRMEM

**TYPE: Statement**  
**FORMAT: SPRMEM &lt;sprite idx&gt;,&lt;VRAM bank&gt;,&lt;VRAM address&gt;\[,&lt;color depth&gt;\]**

**Action:** This command configures the address of where the sprite's pixel data is to be found. It also can change or set the color depth of the sprite.

The first three arguments are required, but the last one is optional.

* &lt;sprite idx&gt; is a value between 0-127 inclusive.
* &lt;VRAM bank&gt; is a value, `0` or `1`, which represents which of the two 64k regions of VRAM to select.
* &lt;VRAM address&gt; is a 16-bit value, \$0000-\$FFFF, is the address within the VRAM bank to point the sprite to. The lowest 5 bits are ignored.
* &lt;color depth&gt; selects either 4 or 8-bit color depth for the sprite. 0 = 4-bit, 1 = 8-bit.  This attribute can also be set by the `SPRITE` command.

**EXAMPLE of the SPRITE Statement:**

```BASIC
10 BVLOAD "MYSPRITE.BIN",8,1,$3000
20 SPRMEM 1,1,$3000,1
30 SPRITE 1,3,0,0,3,3
40 MOVSPR 1,320,200
```

### SQR

**TYPE: Floating-Point Function**  
**FORMAT: SQR(&lt;numeric&gt;)**

**Action:** `SQR` gives you the value of the square root of the &lt;numeric&gt; argument.  The value of the argument must not be negative, or the BASIC error message `?ILLEGAL QUANTITY` will occur.

**EXAMPLE of the SQR Function:**
```BASIC
10 FOR X = 4 TO 10: PRINT X*5, SQR(J * 5): NEXT X
RUN
 20        4.47213595
 25        5
 30        5.47722557
 35        5.91607979
 40        6.32455532
 45        6.70820393
 50        7.07106781
```

### ST

**TYPE Integer Function**  
**FORMAT: ST**

**Action:** Returns a completion status for the last input/output operation which was performed on an open file.  The `ST`atus can be read from any peripheral device.  The `ST` (or `STATUS`) keyword is a system-defined variable name into which the `KERNAL` puts the status of I/O operations.  A table of status code values for printer, disk, and RS-232 file operations are shown below:

| **ST Bit Position** | **ST Numeric Value** | **Serial Bus R/W** | **RS-232** |
|:-------------------:|:--------------------:|:-------------------|:-----------|
| 0 | 1 | Indicates data direction if a timeout occurred;<br> 0 = reading, 1 = writing. | Parity Error |
| 1 | 2 | Timeout error | Framing error |
| 2 | 4 | - | Receive buffer overrun |
| 3 | 8 | - | Receive buffer empty |
| 4 | 16 | [`VERIFY`](#verify) error. | CTS signal missing |
| 5 | 32 | - | - |
| 6 | 64 | EOF | RTS signal missing | 
| 7 | -128 | Device Not Present | BREAK Detected |

**EXAMPLE of the ST Function:**
```BASIC
10 OPEN 1,4: OPEN 2,8,4, "TEXT FILE,SEQ,W"
20 GOSUB 100 : REM CHECK STATUS
30 INPUT#2, A$, B, C
40 IF STATUS AND 64 THEN 80 : REM HANDLE END-OF-FILE
50 GOSUB 100 : REM CHECK STATUS
60 PRINT#1, A$, B, C
70 GOTO 20
80 CLOSE 1 : CLOSE 2
90 GOSUB 100 : END
100 IF ST > 0 THEN 9000 : REM HANDLE I/O ERROR
110 RETURN
```

### STEP

**TYPE: Statement**  
**FORMAT: [STEP &lt;expression&gt;]**

**Action:** The optional `STEP` keyword follows the &lt;end-value&gt; expression in a [`FOR`](#for-to-step) statement.  It defines an increment value for the loop counter variable.  Any value can be used as the `STEP` increment.  Of course, a `STEP` value of zero will loop forever.  If the `STEP` keyword is left out, the increment value will be + 1.  When the [`NEXT`](#next) statement in a `FOR` loop is reached, the `STEP` increment happens.  Then the counter is tested against the end-value to see if the loop is finished.  (See the [`FOR`](#for-to-step) statement for more information.)

> **NOTE:** The `STEP` value cannot be changed once it's in the loop.

**EXAMPLES of the STEP Statement:**
```BASIC
10 FOR AA = 2 TO 20 STEP 2 : REM LOOP REPEATS 10 TIMES
20 FOR K2 = 0 TO -20 STEP -2 : REM LOOP REPEATS 11 TIMES
```

### STOP

**TYPE: Statement:**  
**FORMAT: STOP**

**Action:** The `STOP` statement is used to halt execution of the current program and return to direct mode.  Typing the <mark>**RUN/STOP**</mark> key on the keyboard has the same effect as a `STOP` statement.  The BASIC error message `BREAK IN XX` is displayed on the screen, followed by `READY`.  The "XX" is the line number where the `STOP` occurs.  Any open files remain open and all variables are preserved and can be examined.  The program can be restarted by using the [`CONT`](#cont) or [`GOTO`](#goto) statements.

**EXAMPLES of the STOP Statement:**
```BASIC
10 INPUT#5, AA, BB, CC
20 IF AA = BB AND BB = CC THEN STOP
30 STOP
```
If AA is -1 and BB is equal to CC, the result will be `BREAK IN 20`, otherwise the result will be `BREAK IN 30`.

### STR$

**TYPE: String Function**  
**FORMAT: STR$(&lt;numeric&lt;)**

**Action:** `STR$` gives you the string representation of the numeric value of the argument.  When the `STR$` value is converted to each variable represented in the &lt;numeric&gt; argument, any number shown is followed by a space, and if it's positive, it is also preceded by a space.

**EXAMPLE of the STR$ Function:**
```BASIC
10 ZA = 9.2E5: RZ$ = STR$(ZA)
20 PRINT ZA, RZ$
RUN
 920000     920000
```

### STRPTR

**TYPE: Function**  
**FORMAT: STRPTR(&lt;variable&gt;)**

**Action:** Returns the memory address of the first character of a string contained within a string variable. If the string variable has zero length, this function will likely still return a non-zero value pointing either to the close quotation mark in the literal assignment, or to somewhere undefined in string memory. Programs should check the [`LEN`](#len)gth of string variables before using the pointer returned from `STRPTR`.

**EXAMPLE of the STRPTR function:**

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

In order to communicate with the routine, you can pre-load the CPU registers by using [`POKE`](#poke) to write to the following
memory locations:

* `$030C`: Accumulator
* `$030D`: X Register
* `$030E`: Y Register
* `$030F`: Status Register/Flags

When the routine is over, the CPU registers will be loaded back in to these locations. So you can read the results of a machine language routine by [`PEEK`](#peek)ing these locations.

**EXAMPLE of the SYS statement:**

Push a &lt;CR&gt; into the keyboard buffer.

```BASIC
POKE $30C,13
SYS $FEC3
```

Run the Machine Language Monitor (Supermon)

```BASIC
SYS  $FECC
```

### TAB

**TYPE: Special Function**  
**FORMAT: TAB(&lt;numeric&gt;)**

**Action:** The `TAB` function moves the cursor to a relative [SPC](#spc) move position on the screen given by the &lt;numeric&gt; argument, starting with the left-most position of the current line.  The value of the argument can range from 0 to 255.  The `TAB` function should only be used with the `PRINT` statement, since it has no effect if used with the [`PRINT#`](#print-1) to a logical file.

**EXAMPLE of the TAB Function:**
```BASIC
10 PRINT "NAME" TAB(25) "AMOUNT": PRINT
20 INPUT#1, NAME$, AMT$
30 PRINT NAME$ TAB(25) AMT$
RUN
NAME                    AMOUNT
ARTHUR DENT             42.00
```

### TAN

**TYPE: Floating-Point Function**  
**FORMAT: TAN(&lt;number&gt;)**

**Action:** Returns the tangent of the value of the &lt;numeric&gt; expression in radians.  If the `TAN` function overflows, the BASIC error message `?DIVISION BY ZERO` is displayed.

**EXAMPLE of the TAN Function:**
```BASIC
10 JP = .8675309 : JJ = TAN(JP) : PRINT JJ
RUN
 1.179404
```

### TATTR

**TYPE: Function**  
**FORMAT: TATTR(&lt;x coordinate&gt;,&lt;y coordinate&gt;)**

**Action:** The `TATTR`function retrieves the text/tile attribute at the given x/y coordinate. It works for tiles or text on Layer 1.

In the default text modes, this can be used to retrieve the color attribute (foreground/background) of a specific coordinate without needing to calculate the VRAM address for [`VPEEK`](#vpeek).

**EXAMPLE of the TATTR Function:**

```BASIC
10 REM COPY BUTTERFLY LOGO WITH COLORS TO CENTER OF 80X60 SCREEN
20 XO = 37 : YO = 27
30 FOR X = 0 TO 6
40 FOR Y = 0 TO 6
50 TD = TDATA(X, Y)
60 TA = TATTR(X, Y)
70 TILE XO+X, YO+Y, TD, TA
80 NEXT:NEXT
```

### TDATA

**TYPE: Function**  
**FORMAT: TDATA(&lt;x coordinate&gt;,&lt;y coordinate&gt;)**

**Action:** The `TDATA` function retrieves the text/tile at the given x/y coordinate. It works for tiles or text on Layer 1.

In the default text modes, this can be used to retrieve the character a specific coordinate without needing to calculate the VRAM address for [`VPEEK`](#vpeek).

**EXAMPLE of the TATTR Function:**

```BASIC
10 REM COPY BUTTERFLY LOGO TO CENTER OF 80X60 SCREEN
20 XO = 37 : YO = 27
30 FOR X = 0 TO 6
40 FOR Y = 0 TO 6
50 TD = TDATA(X, Y)
60 TILE XO+X, YO+Y, TD
70 NEXT:NEXT
```

### TILE

**TYPE: Statement**  
**FORMAT: TILE &lt;x&gt;,&lt;y&gt;,&lt;tile/screen code&gt;\[,&lt;attribute&gt;\]**

**Action:** The `TILE` statement sets the tile or text character at the given x/y tile/character coordinate to the given screen code or tile index, optionally resetting the attribute byte. It works for tiles or text on Layer 1.

In the default text mode, this can be used to quickly change a character on the screen and optionally its foreground/background color without needing to calculate the VRAM address for [`VPOKE`](#vpoke).

However, it can also be used if VERA Layer 1's map base value is changed or the map size is changed.

**EXAMPLE of the TILE Statement:**

```BASIC
10 REM VERY SLOWLY CLEAR THE SCREEN IN STYLE
20 FOR Y=59 TO 0 STEP -1
30 FOR X=79 TO 0 STEP -1
40 FOR I=255 TO 32 STEP -1
50 TILE X,Y,I
60 NEXT:NEXT:NEXT
```

### TIME

**TYPE: Numeric Function**  
**FORMAT: TI**

**Action:** The `TI` function reads the interval `TI`mer.  This type of "clock" is called a "jiffy clock".  The "jiffy clock" value is set at zero (initialized) when you power-up the system.  Each "tick" of the clock is 1/60th of a second.

**EXAMPLE of the TI Function:**
```BASIC
10 PRINT TI/60 "SECONDS SINCE POWER UP."
```

### TIME$

**TYPE: String Function**  
**FORMAT: TI$**

**Action:** The `TI$` timer looks and works like a real clock as long as your system is powered on.  The hardware system clock is read and used to update the value of `TI$`, which will give you a time string of six characters in hours, minutes, and seconds.  The `TI$` timer can also be assigned an arbitrary starting point similar to the way you set your wrist watch.  If you assign a value to `TI$`, it will persist across system restarts.

**EXAMPLE of the TI$ Function:**
```BASIC
10 HH$ = MID$(TI$,1,2)
20 MM$ = MID$(TI$,3,2)
30 SS$ = MID$(TI$,5,2)
40 PRINT "THE TIME IS ";HH$;":";MM$;":";SS$
```

### USR

**TYPE: Floating-Point Function**  
**FORMAT: USR(&lt;numeric&gt;)**

**Action:** The `USR` function jumps to a user callable machine language subroutine which has its starting address pointed to by the contents of memory locations 785 ($0311) and 786 ($0312).  The starting address is established before calling the `USR` function by using [POKE](#poke) statements to set up locations 785 and 786.  Unless [POKE](#poke) statements are used, locations 785 and 786 an `? ILLEGAL QUANTITY` error message.

The value of the &lt;numeric&gt; argument is stored in the floating-point accumulator starting at location 97 ($61), for access by assembler code, and the result of the `USR` function is the value which ends up there when the subroutine returns to BASIC.

**EXAMPLES of the USR Function:**
```BASIC
10 A = T * SIN(ZD)
20 C = USR(A / 2)
30 D = USR(A / 3)
```

### VAL

**TYPE: Numeric Function**  
**FORMAT: VAL(&lt;string&gt;)**

**Action:** Returns a numeric value representing the data in the &lt;string&gt; argument.  If the first non-blank character of the string is not a plus sign `(+)`, minus sign `(-)`, or a digit, the value returned is zero.  String conversion is finished when the end of a string or any non-digit character is found (except decimal point or exponential e).

**EXAMPLE of the VAL Function:**
```BASIC
100 INPUT#1, NAM$, ZIP$
110 IF VAL(ZIP$) > 98100 OR VAL(ZIP$) < 98109 THEN PRINT NAM$ TAB(10) "SEATTLE, WA"
```

### VERIFY

**TYPE: Command**  
**FORMAT: VERIFY ["&lt;file name&gt;"][,&lt;device&gt;]**

**Action:** The `VERIFY` command is used, in direct or program mode, to compare the contents of a BASIC program file on disk with the program currently in memory.  `VERIFY` is normally used right after a [SAVE](#save), to make sure that the program was stored correctly on disk.

If the &lt;device&gt; number is left out, the program is assumed to be on the first disk device, which is device #8.  If any differences in program text are found, the BASIC error message `?VERIFY ERROR` is displayed.

A program name can be given either in quotes `(" ")` or as a string variable.

**EXAMPLES of the VERIFY Command:**

- VERIFY (Checks the first file on the first disk device (#8))
```BASIC
100 SAVE "MYPROG", 8
105 VERIFY "MYPROG", 8
```

### VPEEK

**TYPE: Integer Function**  
**FORMAT: VPEEK (&lt;bank&gt;, &lt;address&gt;)**

**Action:** Return a byte from the video address space. The video address space has 17 bit addresses, which is exposed as 2 banks of 65536 addresses each.

In addition, `VPEEK` can reach add-on VERA cards with higher bank numbers.

BANK 2-3 is for IO3 (VERA at \$9F60-\$9F7F)  
BANK 4-5 is for IO4 (VERA at \$9F80-\$9F9F)  

**EXAMPLE of the VPEEK Function:**

```BASIC
PRINT VPEEK(1,$B000) : REM SCREEN CODE OF CHARACTER AT 0/0 ON SCREEN
```

### VPOKE

**TYPE: Command**  
**FORMAT: VPOKE &lt;bank&gt;, &lt;address&gt;, &lt;value&gt;**

**Action:** Set a byte in the video address space. The video address space has 17 bit addresses, which is exposed as 2 banks of 65536 addresses each.

In addition, `VPOKE` can reach add-on VERA cards with higher bank numbers.

BANK 2-3 is for IO3 (VERA at \$9F60-\$9F7F)  
BANK 4-5 is for IO4 (VERA at \$9F80-\$9F9F)  

**EXAMPLE of the VPOKE Statement:**

```BASIC
VPOKE 1,$B000+1,1 * 16 + 2 : REM SETS THE COLORS OF THE CHARACTER
                             REM AT 0/0 TO RED ON WHITE
```

### VLOAD

**TYPE: Statement**  
**FORMAT: VLOAD &lt;filename&gt;, &lt;device&gt;, &lt;VERA_high_address&gt;, &lt;VERA_low_address&gt;**

**Action:** Loads a file directly into VERA RAM, skipping the two-byte header that is presumed to be in the file.

**EXAMPLES of the VLOAD Statement:**

```BASIC
VLOAD "MYFILE.PRG", 8, 0, $4000  :REM LOADS MYFILE.PRG FROM DEVICE 8 TO VRAM $4000
                                  REM WHILE SKIPPING THE FIRST TWO BYTES OF THE FILE.
```

To load a raw binary file without skipping the first two bytes, use [`BVLOAD`](#bvload)

### WAIT

**TYPE: Statement**  
**FORMAT: WAIT &lt;location&gt;, &lt;mask-1&gt; [,&lt;mask-2&gt;]**

**Action:** The `WAIT` statement causes program execution to be suspended until a given memory address recognizes a specified bit pattern.  In other words, `WAIT` can be used to halt the program until some external event has occurred.  This is done by monitoring the status of bits in the input/output registers.  The data items used with `WAIT` can be any numeric expressions, but they will be converted to integer values.

For most programmers, this statement should never be used.  It causes the program to halt until a specific memory location's bits change in a specific way.  This is used for certain I/O operations and almost nothing else.

The `WAIT` statement takes the value in the memory location and performs a logical [AND](#and) operation with the value in &lt;mask-1&gt;.  If there is a &lt;mask-2&gt; in the statement, the result of the first operation is exclusive-ORed with &lt;mask-2&gt;  In other words, &lt;mask-1&gt; "filters out" any bits that you don't want to test.  Where the bit is 0 in &lt;mask-1&gt;, the corresponding bit in the result will always be 0.  The &lt;mask-2&gt; value flips any bits, so that you can test of an off condition as well as an on condition.  Any bits being tested for a 0 should have a 1 in the corresponding position in &lt;mask-2&gt;

If corresponding bits of the &lt;mask-1&gt; and &lt;mask-2&gt; operands differ, the exclusive-OR operation gives a bit result of 1.  If corresponding bits get the same result, the bit is 0.  It is possible to enter an infinite pause with the `WAIT` statement, in which case the <mark>**RUN/STOP**</mark> and <mark>**RESTORE**</mark> keys can be used to recover.  Hold down the <mark>**RUN/STOP**</mark> key and then press <mark>**RESTORE**</mark>.

**EXAMPLES of WAIT Statements:**
```BASIC
10 WAIT 53273, 6, 6
20 WAIT 32868, 144, 16
```

## Other New Features

### Hexadecimal and Binary Literals

The numeric constants parser supports both hex (`$`) and binary (`%`) literals, like this:

```BASIC
PRINT $EA31 + %1010
```

The size of hex and binary values is only restricted by the range that can be represented by BASIC's internal floating point representation.

### LOAD into VRAM

In BASIC, the contents of files can be directly loaded into VRAM with the [`LOAD`](#load) statement. When a secondary address greater than one is used, the KERNAL will now load the file into the VERA's VRAM address space. The first two bytes of the file are used as lower 16 bits of the address. The upper 4 bits are `(SA-2) & 0x0ff` where `SA` is the secondary address.

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

In BASIC, the [LOAD], [`SAVE`](#save) and [`OPEN`](#open) statements default to the last-used IEEE device (device numbers 8 and above), or 8.

## Internal Representation

Like on the C64, BASIC keywords are tokenized.

* The C64 BASIC V2 keywords occupy the range of \$80 ([`END`](#end)) to \$CB (`GO`).
* BASIC V3.5 also used \$CE (`RGR`) to \$FD (`WHILE`).
* BASIC V7 introduced the \$CE escape code for function tokens \$CE-\$02 (`POT`) to \$CE-\$0A (`POINTER`), and the \$FE escape code for statement tokens \$FE-\$02 ([`BANK`](#bank)) to \$FE-\$38 (`SLOW`).
* The unreleased BASIC V10 extended the escaped tokens up to \$CE-\$0D (`RPALETTE`) and \$FE-\$45 (`EDIT`).

The X16 BASIC aims to be as compatible as possible with this encoding. Keywords added to X16 BASIC that also exist in other versions of BASIC match the token, and new keywords are encoded in the ranges \$CE-\$80+ and \$FE-\$80+.

## Auto-Boot

When BASIC starts, it automatically executes the [`BOOT`](#boot) command, which tries to load a PRG file named `AUTOBOOT.X16` from device 8 and, if successful, runs it. Here are some use cases for this:

* An SD card with a game can auto-boot this way.
* An SD card with a collection of applications can show a menu that allows selecting an application to load.
* The user's "work" SD card can contain a small auto-boot BASIC program that sets the keyboard layout and changes the screen colors, for example.

<!-- For PDF formatting -->
<div class="page-break"></div>
