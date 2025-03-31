
# Chapter 13: Working With CMDR-DOS

This manual describes Commodore DOS on FAT32, aka CMDR-DOS.

## CMDR-DOS

Commander X16 duplicates and extends the programming interface used by Commodore's line of disk drives, including the
famous (or infamous) VIC-1541. CMDR-DOS uses the industry-standard FAT-32 format. Partitions can be 32MB up to
(in theory) 2TB and supports CMD-style partitions, subdirectories, timestamps and filenames up to 255 characters.
It is the DOS built into the [Commander X16](https://www.commanderx16.com).

There are three basic interfaces for CMDR-DOS: the binary interface (LOAD, SAVE, etc.), the data file interface (OPEN,
PRINT#, INPUT#, GET#), and the command interface. We will give a brief summary of BASIC commands here, but please refer
to  [Chapter 4: BASIC Programming](X16%20Reference%20-%2004%20-%20BASIC.md#chapter-4-basic-programming) for full syntax of each command.

If you are familiar with the SD2IEC or the CMD hard drive, navigating partitions and subdirectories is similar, with "CD", "MD", and "RD" commands
to navigate directories.

## Binary Load/Save

The primary use of the binary interface is loading and saving program files and loading binary files into RAM.

Your binary commands are LOAD, SAVE, BLOAD, VLOAD, BVLOAD, VERIFY, and BVERIFY.

This is a brief summary of the LOAD and SAVE commands. For full documentation, refer to [Chapter 4: BASIC Programming](X16%20Reference%20-%2004%20-%20BASIC.md#chapter-4-basic-programming).

### LOAD

`LOAD <filename> [,device][,secondary_address]`
`LOAD <filename> [,device][,ram_bank,start_address]`

This reads a program file from disk. The first two bytes of the file are the memory location to which the file will be
loaded, with the low byte first. BASIC programs will start with $01 $08, which translates to $0801, the start of BASIC
memory.
The device number should be 8 for reading from the SD card.

If using the first form, secondary_address has multiple meanings:

* 0 or not present: load the data to address $0801, regardless of the address header.

* 1: load to the address specified in the file's header

* 2: load the file headerless to the location $0801.

If using the second form, ram_bank sets the bank for the load, and start_address is the location to read your data into.

The value of the ram_bank argument only affects the load when the start_address is set in the range of \$A000-\$BFFF.

Examples:

`LOAD "ROBOTS.PRG",8,1` loads the program "ROBOTS.PRG" into memory at the address encoded in the file.

`LOAD "HELLO",8` loads a program to the start of BASIC at $0801.

`LOAD "*",8,1` loads the first program in the current directory. See the section below on wildcards for more
information about using * and ? to access files of a certain type or with unprintable characters.

`LOAD "DATA.BIN",8,1,$A000` loads a file into banked RAM, RAM bank 1, starting at $A000. The first two bytes of the file are skipped. To avoid skipping the first two bytes, use the `BLOAD` command instead.

### SAVE

`SAVE <filename>[,device]`

Saves a file from the computer to the SD card. SAVE always reads from the beginning of BASIC memory at $0801, up to the
end of the BASIC program. Device is optional and defaults to 8 (the SD card, or an IEC disk drive, if one is plugged in.)

One word of caution: CMDR-DOS will not let you overwrite a file by default. To overwrite a file, you need to prefix
the filename with @:, like this:

`SAVE "@:DEMO.PRG"`

### BSAVE

`BSAVE <filename>,<device>,<ram_bank>,<start_address>,<end_address>`

Saves an arbitrary region of memory to a file without a two-byte header. To allow concatenating multiple regions of RAM into a single file with multiple successive calls to BSAVE, BSAVE allows the use of append mode in the filename string. To make use of this option, the first call to BSAVE can be called normally, which creates the file anew, while subsequent calls should be in append mode to the same file.

Another way to save arbitrary binary data from arbitrary locations is to use the S command in the MONITOR: [Chapter 7: Machine Language Monitor](X16%20Reference%20-%2007%20-%20Machine%20Language%20Monitor.md#chapter-7-machine-language-monitor).

`S "filename",8,<start_address>,<end_address>`

Where <start_address> and <end_address> are a 16-bit hexadecimal address.

After a SAVE or BSAVE, the DOS command is implicitly run to show the drive status. The Commodore file I/O model does not report certain failures back to BASIC, so you should double-check the result after a write operation.

```BASIC
00, OK,00,00

READY.
```

An OK reply means the file saved correctly. Any other result is an error that should be addressed:

```BASIC
63,FILE EXISTS,00,00
```

CMDR-DOS does not allow files to be overwritten without special handling. If you get FILE EXISTS, either change your file's name or save it with the @: prefix, like this:

`SAVE "@:HELLO"`

### BLOAD

BLOAD loads a file _without an address header_ to an arbitrary location in memory. Usage is similar to LOAD. However, BLOAD does not require
or use the 2-byte header. The first byte in the file is the first byte loaded into memory.
  
`BLOAD "filename",8,<ram_bank>,<start_address>`

### VLOAD

Read binary data into VERA. VLOAD skips the 2-byte address header and starts reading at the third byte of the file.

`VLOAD "filename",8,<vram_bank>,<start_address>`

### BVLOAD

Read binary data into VERA without a header. This works like BLOAD, but into VERA RAM.

`BVLOAD "filename",8,<vram_bank>,<start_address>`

### DOS WEDGE

The DOS wedge allows you to issue quick commands from BASIC with the > or @
symbol.

| Command | Action |
|-|-|
| `/<filename>` | Load a BASIC program into RAM |
| `%<filename>` | Load a machine language program into RAM (like `,8,1`) |
| `↑<filename>` | Load a BASIC program into RAM and then unconditionally run it |
| `←<filename>` | Save a BASIC program to disk |
| `@` | Display (and clear) the disk drive status |
| `@$` | Display the disk directory without overwriting the BASIC program in memory |
| `@#<device number>` | Change default DOS device |
| `@<command>` | Execute a disk drive command (e.g. `@S0:<filename>`) |
| `><command>` | Execute a disk drive command (e.g. `>CD:<dir>`) |

## Sequential Files

Sequential files have two basic modes: read and write. The OPEN command opens a file for reading or writing. The PRINT# command writes to a file, and the GET# and INPUT# commands read from the file.

todo: examples

## Command Channel

The command channel allows you to send commands to the CMDR-DOS interface. You can open and write to the command channel using the OPEN command, or you can use the DOS command to issue commands and read the status. While DOS can be used in immediate mode or in a program, only the combination of OPEN/INPUT# can read the command response back into a variable for later processing.

In either case, the ST psuedo-variable will allow you to quickly check the status. A status of 64 is "okay", and any
other value should be checked by reading the error channel (shown below.)

To open the command channel, you can use the OPEN command with secondary address 15.

`10 OPEN 15,8,15`

If you want to issue a command immediately, add your command string at the end of the OPEN statement:

`10 OPEN 15,8,15, "CD:/"`

This example changes to the root directory of your SD card.

To know whether the OPEN command succeeded, you must open the command channel and read the result. To read the command channel (and clear the error status if an error occurred), you need to read four values:

`20 INPUT#15,A,B$,C,D`

A is the error number. B$ is the error message. C and D are unused in CMDR-DOS for most responses, but will return the track and sector when used with a disk drive on the IEC connector.

```BASIC
30 PRINT A;B$;C;D
40 CLOSE 15
```

So the entire program looks like:

```BASIC
10 OPEN 15,8,15, "CD:/"
20 INPUT#15,A,B$,C,D
30 PRINT A;B$;C;D
40 CLOSE 15
```

If the error number (`A`) is less than 20, no error occurred. Usually this result is 0 (or 00) for OK.

You can also use the DOS command to send a command to CMDR-DOS. Entering DOS by itself will print the drive's status on the screen. Entering a command in quotes or a string variable will execute the command. We will talk more about the status variable and DOS status message in the next section.

```BASIC
DOS
00, 0K, 00, 00
READY.
DOS "CD:/"
```

The special case of `DOS "$"` will print a directory listing.

`DOS "$"`

You can also read the name of the current directory with DOS"$=C"

`DOS "$=C"`

## DOS Features

This is the base features set compared to other Commodore DOS devices:

| Feature          | 1541 | 1571/1581 | CMD HD/FD | SD2IEC   | _CMDR-DOS_      |
|------------------|------|-----------|-----------|----------|-----------------|
| Sequential files | yes  | yes       | yes       | yes      | yes             |
| Relative files   | yes  | yes       | yes       | yes      | not yet         |
| Block access     | yes  | yes       | yes       | yes      | not yet         |
| Code execution   | yes  | yes       | yes       | no       | yes             |
| Burst commands   | no   | yes       | yes       | no       | no              |
| Timestamps       | no   | no        | yes       | yes      | yes             |
| Time API         | no   | no        | yes       | yes      | not yet         |
| Partitions       | no   | no        | yes       | yes      | yes             |
| Subdirectories   | no   | no        | yes       | yes      | yes             |

It consists of the following components:

* Commodore DOS interface
  * `dos/main.s`: TALK/LISTEN dispatching
  * `dos/parser.s`: filename/path parsing
  * `dos/cmdch.s`: command channel parsing, status messages
  * `dos/file.s`: file read/write
* FAT32 interface
  * `dos/match.s`: FAT32 character set conversion, wildcard matching
  * `dos/dir.s`: FAT32 directory listing
  * `dos/function.s`: command implementations for FAT32
* FAT32 implementation
  * `fat32/*`: [FAT32 for 65c02 library](https://github.com/X16Community/x16-rom/tree/master/fat32)

All currently unsupported commands are decoded in `cmdch.s` anyway, but hooked into `31,SYNTAX ERROR,00,00`, so adding features should be as easy as adding the implementation.

CMDR-DOS implements the TALK/LISTEN layer (Commodore Peripheral Bus layer 3), it can therefore be directly hooked up to the Commodore IEEE KERNAL API (`talk`, `tksa`, `untlk`, `listn`, `secnd`, `unlsn`, `acptr`, `ciout`) and be used as a computer-based DOS, like on the C65 and the X16.

CMDR-DOS does not contain a layer 2 implementation, i.e. IEEE-488 (PET) or Commodore Serial (C64, C128, ...). By adding a Commodore Serial (aka "IEC") implementation, CMDR-DOS could be adapted for use as the system software of a standalone 65c02-based Serial device for Commodore computers, similar to an sd2iec device.

The Commodore DOS side and the FAT32 side are well separated, so a lot of code could be reused for a DOS that uses a different filesystem.

Or the core feature set, these are the supported functions:

| Feature                          | Syntax                        | Supported | Comment                                                                                                                       |
|----------------------------------|-------------------------------|-----------|-------------------------------------------------------------------------------------------------------------------------------|
| Reading                          | `,?,R`                        | yes       |                                                                                                                               |
| Writing                          | `,?,W`                        | yes       |                                                                                                                               |
| Appending                        | `,?,A`                        | yes       | Warning, see below<sup>1</sup>                                                                                                |
| Modifying                        | `,?,M`                        | yes       |                                                                                                                               |
| Types                            | `,S`/`,P`/`,U`/`,L`           | yes       | ignored on FAT32                                                                                                              |
| Overwriting                      | `@:`                          | yes       |                                                                                                                               |
| Magic channels 0/1               |                               | yes       |                                                                                                                               |
| Channel 15 command               | _command_`:`_args_...         | yes       |                                                                                                                               |
| Channel 15 status                | _code_`,`_string_`,`_a_`,`_b_ | yes       |                                                                                                                               |
| CMD partition syntax             | `0:`/`1:`/...                 | yes       |                                                                                                                               |
| CMD subdirectory syntax          | `//DIR/:`/`/DIR/:`            | yes       |                                                                                                                               |
| Directory listing                | `$`                           | yes       |                                                                                                                               |
| Dir with name filtering          | `$:FIL*`                      | yes       |                                                                                                                               |
| Dir with name and type filtering | `$:*=P`/`$:*=D`/`$:*=A`       | yes       |                                                                                                                               |
| Dir with timestamps              | `$=T`                         | yes       | with ISO-8601 times                                                                                                           |
| Dir with time filtering          | `$=T<`/`$=T>`                 | not yet   |                                                                                                                               |
| Dir long listing                 | `$=L`                         | yes       | shows human readable file size instead of blocks, time in ISO-8601 syntax, attribute byte, and exact file size in hexadecimal |
| Partition listing                | `$=P`                         | yes       |                                                                                                                               |
| Partition filtering              | `$:NAME*=P`                   | no        |                                                                                                                               |
| Current Working Directory        | `$=C`                         | yes       |                                                                                                                               |

* <sup>1</sup>: Warning: Risk of corrupting SD cards on older ROM versions, see [Appending to file](#appending-to-file)

And this table shows which of the standard commands are supported:

| Name             | Syntax                                                | Description                     | Supported |
|------------------|-------------------------------------------------------|---------------------------------|-----------|
| BLOCK-ALLOCATE   | `B-A` _medium_ _medium_ _track_ _sector_              | Allocate a block in the BAM     | no<sup>1</sup>|
| BLOCK-EXECUTE    | `B-E` _channel_ _medium_ _track_ _sector_             | Load and execute a block        | not yet   |
| BLOCK-FREE       | `B-F` _medium_ _medium_ _track_ _sector_              | Free a block in the BAM         | no<sup>1</sup>|
| BLOCK-READ       | `B-R` _channel_ _medium_ _track_ _sector_             | Read block                      | no<sup>1</sup>|
| BLOCK-STATUS     | `B-S` _channel_ _medium_ _track_ _sector_             | Check if block is allocated     | no<sup>1</sup>|
| BLOCK-WRITE      | `B-W` _channel_ _medium_ _track_ _sector_             | Write block                     | no<sup>1</sup>|
| BUFFER-POINTER   | `B-P` _channel_ _index_                               | Set r/w pointer within buffer   | not yet   |
| CHANGE DIRECTORY | `CD`[_path_]`:`_name_                                 | Change the current sub-directory| yes       |
| CHANGE DIRECTORY | `CD`[_medium_]`:←`                                    | Change sub-directory up         | yes       |
| CHANGE PARTITION | `CP` _num_                                            | Make a partition the default    | yes       |
| COPY             | `C`[_path_a_]`:`_target_name_`=`[_path_b_]`:`_source_name_[`,`...] | Copy/concatenate files | yes   |
| COPY             | `C`_dst_medium_`=`_src_medium_                        | Copy all files between disk     | no<sup>1</sup>|
| DUPLICATE        | `D:`_dst_medium_``=``_src_medium_                     | Duplicate disk                  | no<sup>1</sup>|
| FILE LOCK        | `F-L`[_path_]`:`_name_[`,`...]                        | Enable file write-protect       | yes       |
| FILE RESTORE     | `F-R`[_path_]`:`_name_[`,`...]                        | Restore a deleted file          | not yet   |
| FILE UNLOCK      | `F-U`[_path_]`:`_name_[`,`...]                        | Disable file write-protect      | yes       |
| GET DISKCHANGE   | `G-D`                                                 | Query disk change               | yes       |
| GET PARTITION    | `G-P`[_num_]                                          | Get information about partition | yes       |
| INITIALIZE       | `I`[_medium_]                                         | Re-mount filesystem             | yes       |
| LOCK             | `L`[_path_]`:`_name_                                  | Toggle file write protect       | yes       |
| MAKE DIRECTORY   | `MD`[_path_]`:`_name_                                 | Create a sub-directory          | yes       |
| MEMORY-EXECUTE   | `M-E` _addr_lo_ _addr_hi_                             | Execute code                    | yes       |
| MEMORY-READ      | `M-R` _addr_lo_ _addr_hi_ [_count_]                   | Read RAM                        | yes       |
| MEMORY-WRITE     | `M-W` _addr_lo_ _addr_hi_ _count_ _data_              | Write RAM                       | yes       |
| NEW              | `N`[_medium_]`:`_name_`,`_id_`,FAT32`                 | File system creation            | yes<sup>3</sup>|
| PARTITION        | `/`[_medium_][`:`_name_]                              | Select 1581 partition           | no        |
| PARTITION        | `/`[_medium_]`:`_name_`,`_track_ _sector_ _count_lo_ _count_hi_ `,C` | Create 1581 partition | no   |
| POSITION         | `P` _channel_ _record_lo_ _record_hi_ _offset_        | Set record index in REL file    | not yet   |
| REMOVE DIRECTORY | `RD`[_path_]`:`_name_                                 | Delete a sub-directory          | yes       |
| RENAME           | `R`[_path_]`:`_new_name_`=`_old_name_                 | Rename file                     | yes       |
| RENAME-HEADER    | `R-H`[_medium_]`:`_new_name_                          | Rename a filesystem             | yes       |
| RENAME-PARTITION | `R-P:`_new_name_`=`_old_name_                         | Rename a partition              | no<sup>1</sup>|
| SCRATCH          | `S`[_path_]`:`_pattern_[`,`...]                       | Delete files                    | yes       |
| SWAP             | `S-`{`8`&#x7c;`9`&#x7c;`D`}                           | Change primary address          | yes       |
| TIME READ ASCII  | `T-RA`                                                | Read Time/Date (ASCII)          | no<sup>4</sup>|
| TIME READ BCD    | `T-RB`                                                | Read Time/Date (BCD)            | no<sup>4</sup>|
| TIME READ DECIMAL| `T-RD`                                                | Read Time/Date (Decimal)        | no<sup>4</sup>|
| TIME READ ISO    | `T-RI`                                                | Read Time/Date (ISO)            | no<sup>4</sup>|
| TIME WRITE ASCII | `T-WA` _dow_ _mo_`/`_da_`/`_yr_ _hr_`:`_mi_`:`_se_ _ampm_ | Write Time/Date (ASCII)     | no<sup>4</sup>|
| TIME WRITE BCD   | `T-WB` _b0_ _b1_ _b2_ _b3_ _b4_ _b5_ _b6_ _b7_ _b8_   | Write Time/Date (BCD)           | no<sup>4</sup>|
| TIME WRITE DECIMAL| `T-WD` _b0_ _b1_ _b2_ _b3_ _b4_ _b5_ _b6_ _b7_       | Write Time/Date (Decimal)       | no<sup>4</sup>|
| TIME WRITE ISO   | `T-WI` _yyyy_`-`_mm_`-`_dd_`T`_hh_`:`_mm_`:`_ss_ _dow_| Write Time/Date (ISO)           | no<sup>4</sup>|
| U1/UA            | `U1` _channel_ _medium_ _track_ _sector_              | Raw read of a block             | not yet   |
| U2/UB            | `U2` _channel_ _medium_ _track_ _sector_              | Raw write of a block            | not yet   |
| U3-U8/UC-UH      | `U3` - `U8`                                           | Execute in user buffer          | not yet   |
| U9/UI            | `UI`                                                  | Soft RESET                      | yes       |
| U:/UJ            | `UJ`                                                  | Hard RESET                      | yes       |
| USER             | `U0>` _pa_                                            | Set unit primary address        | yes       |
| USER             | `U0>B` _flag_                                         | Enable/disable Fast Serial      | yes<sup>6</sup>|
| USER             | `U0>D`_val_                                           | Set directory sector interleave | no<sup>1</sup>|
| USER             | `U0>H` _number_                                       | Select head 0/1                 | no<sup>1</sup>|
| USER             | `U0>L`_flag_                                          | Large REL file support on/off   | no        |
| USER             | `U0>M` _flag_                                         | Enable/disable 1541 emulation mode| no<sup>1</sup>|
| USER             | `U0>R` _num_                                          | Set number fo retries           | no<sup>1</sup>|
| USER             | `U0>S` _val_                                          | Set sector interleave           | no<sup>1</sup>|
| USER             | `U0>T`                                                | Test ROM checksum               | no<sup>5</sup>|
| USER             | `U0>V` _flag_                                         | Enable/disable verify           | no<sup>1</sup>|
| USER             | `U0>` _pa_                                            | Set unit primary address        | yes       |
| USER             | `UI`{`+`&#x7c;`-`}                                    | Use C64/VIC-20 Serial protocol  | no<sup>1</sup>|
| UTILITY LOADER   | `&`[[_path_]`:`]_name_                                | Load and execute program        | no<sup>1</sup>|
| VALIDATE         | `V`[_medium_]                                         | Filesystem check                | no<sup>2</sup>|
| WRITE PROTECT    | `W-`{`0`&#x7c;`1`}                                    | Set/unset device write protect  | yes       |

* <sup>1</sup>: outdated API, not useful, or can't be supported on FAT32
* <sup>2</sup>: is a no-op, returns `00, OK,00,00`
* <sup>3</sup>: third argument `FAT32` _has_ to be passed
* <sup>4</sup>: CMDR-DOS was architected to run on the main computer, so it shouldn't be DOS that keeps track of the time
* <sup>5</sup>: Instead of testing the ROM, this command currently verifies that no buffers are allocated, otherwise it halts. This is used by unit tests to detect leaks.
* <sup>6</sup>: Repurposed for SD card read and write mode. _flag_ selects whether fast read (auto_tx) and fast writes are enabled. 0=none, 1=auto_tx, 2=fast writes, 3=both

The following special file syntax and `OPEN` options are specific to CMDR-DOS:

| Feature               | Syntax      | Description                                                                    |
|-----------------------|-------------|--------------------------------------------------------------------------------|
| Open for Read & Write | `,?,M`      | Allows arbitrarily reading, writing and setting the position (`P`)<sup>7</sup> |
| Get current working directory | `$=C` | Produces a directory listing containing the name of the current working directory followed by all parent directory names all the way up to `/` |

* <sup>7</sup>: once the EOF has been reached while reading, no further reads or writes are possible.

The following added command channel features are specific to CMDR-DOS:

| Feature               | Syntax      | Description                                                                    |
|-----------------------|-------------|--------------------------------------------------------------------------------|
| POSITION              | `P` _channel_ _p0_ _p1_ _p2_ _p3_  | Set position within file (like sd2iec); all args binary |
| TELL<sup>8</sup>                  | `T` _channel_ | Return the current position within a file and the file's size; channel arg is binary |

* <sup>8</sup>: available in ROM version R48 and later

To use the POSITION and TELL commands, you need to open two channels: a data channel and the command channel. The _channel_ argument should be the same as the secondary address of the data channel.

If POSITION succeeds, `00, OK,00,00` is returned on the command channel.  

If TELL succeeds, `07,pppppppp ssssssss,00,00` is returned on the command channel, where `pppppppp` is a hexadecimal representation of the position, and `ssssssss` is a hexadecimal represenation of the file's size.  

### Examples

```BASIC
OPEN 1,8,2,"LEVEL.DAT,S,R"
OPEN 15,8,15,"P"+CHR$(2)+CHR$(0)+CHR$(1)+CHR$(0)+CHR$(0)
```

The above opens LEVEL.DAT for reading and positions the read/write pointer at byte 256.

```BASIC
10 OPEN 2,8,5,"LEVEL.DAT,S,R"
20 OPEN 15,8,15,"T"+CHR$(5)
30 INPUT#15,A,A$,T,S
40 CLOSE 15
50 IF A>=20 THEN 90
60 SZ=VAL("$"+MID$(A$,10))
70 PRINT "SIZE=";SZ
80 GOTO 100
90 PRINT"ERROR"
100 CLOSE 2
```

This time, the secondary address is 5, and we're fetching only the file's size.

### Current Working Directory

The $=C command will list the current working directory and its parent path. The current directory will be at the top of the listing, with each parent
directory beneath, with / at the bottom.

```BASIC
DOS"$=C"

0 "/TEST            " 
0    "TEST"             DIR
0    "/"                DIR
65535 BLOCKS FREE.
```
### Appending to file

To append data to an existing file, open the file with `,?,A` and write to it.

**Warning:** Appending to an empty file using R48 or older, will corrupt the file system, due to a severe Kernal bug. The bug is fixed in [#369](https://github.com/X16Community/x16-rom/pull/369). Keep this in mind when releasing software which appends to files, as some users may have older ROM versions installed.

## License

Copyright 2020-2024 Michael Steil <<mist64@mac.com>>, et al.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

<!-- For PDF formatting -->
<div class="page-break"></div>
