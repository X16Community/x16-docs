
# Chapter 2: Getting Started

This is a brief guide to your first few minutes on the Commander X16. For a
complete New User experience, please refer to the
[Commander X16 User Guide](https://github.com/X16Community/x16-user-guide).

## Finding and starting programs

When starting your Commander X16, you'll notice that it's not like other
computers. There is no GUI, and command line commands like `DIR` or `LS` don't
get you anywhere. Here are some quick tips to getting started:

The Commander X16 uses a full screen interface known as "Editor". This was unique
when it was introduced on the PET in 1977, when most computers still treated the
screen as if it was a teletype display. The full screen Editor lets you use the
arrow keys to move around the screen and edit or re-enter input from previous
interactions.

The first thing you will want to do is view a list of files on your SD card.
Type the below command and press the Return key (or Enter key) to see a list of
files:

### DOS

`DOS "$"`

You can also type `@$` and press Return. All of the commands you type must be
followed by the Return or Enter key, to actually execute the command.

Let's try some variations on this command:

`DOS "$=D"` lists just the subdirectories in the current directory.

To get the DOS command a little faster, try pressing F8, then typing `$=D`. You
can even leave off the last quote; DOS doesn't care.

So now that you have a list of directories, try moving to one:

`DOS "CD:BASIC"`

Press F7 or type `DOS"$` again to list the files in this directory. A file with
.PRG at the end is a "Program" file and can be loaded with the LOAD command. The
shortcut for LOAD" is the F3 key. Try it now:

### LOAD

`LOAD "MAD.PRG"`

You can see that the program list loaded by typing `LIST` and pressing Enter.

### RUN

Now type `RUN` and Enter. This will start the loaded program.

### STOP

STOP isn't a command: it's a key. Press it to stop the running program.

If you are using the official Commander X16 keyboard, the key is labeled
`RUN STOP` and is up near the upper right corner of the keyboard.

If you are using a PC keyboard, it's probably labeled `Pause` or `Pause Brk`.

Holding Control and pressing C (also written as `Control+C` or `^C`) will also
stop the running program.

There are a few ways to get back to the text screen, but the quickest is to
hold Control, Alt, and press the Del key. (Or just press the RESET button.)

## Using The Keyboard

The Commander X16's keyboard is a little different than a standard PC: there are
three distinct modes of operation, and the keyboard can create graphic symbols
known as PETSCII characters. There are also some special keys used for
controlling the computer.

### PETSCII Characters

When the system first boots up, the X16 will be in PETSCII Upper Case/Graphic
mode. Pressing a letter key without the shift key will generate an upper case
letter. Unlike a PC or Mac, this mode does not have any lower case text, so
everything you type is UPPER CASE.

Now, notice the extra symbols on your keycaps? There are two sets of extra
symbols: the ones on the lower-right can be accessed by holding SHIFT and a
letter. Go ahead: try pressing Shift and S. You should see a small heart symbol
on your screen. We know you'll love the Commander X16 as much as we do. Press
Alt and a letter, and you'll get the symbol on the lower-left corner of the
screen. Try pressing Alt and the ` key next to the nummber 1. You should get a
large + symbol. One of the Plusses of PETSCII is using these line drawing
symbols to draw shapes on the screen.

You can also change colors by pressing Control and a number. Go ahead: Press
Control+1 and type a few letters. Notice they come out in black. Now try Alt+1.
Notice the cursor changes to orange, and notice the next thing you type comes
out orange.

You can also use Control+9 to turn on Reverse Print and Control+0 to turn it off.

There are some unexpected changes to the PC keyboard layout, as follows:

* The Grave key (`) prints a left arrow (←) symbol.
* Shift+Grave prints the Pi symbol (π). This is actually the constant "pi". Try it by typing `PRINT π` and RETURN.
* Shift+6 prints an up arrow (↑)
* The \ key prints the British Pound (£).
* The pipe (|) is replaced with a triangle corner symbol.
* { and } are replaced with two box drawing symbols.
* Underline (Shift+-) is replaced with a | symbol.

Note that programming languages that need {, }, and _ will alter the character
set to show those symbols on the appropriate keys when needed. Or you can use
ISO mode when editing C code in EDIT.

### Lower Case Mode

WORKING IN _PETSCII_ MIGHT MAKE PEOPLE THINK YOU'RE YELLING ALL THE TIME.
Fortunately, there's an upper/lower case mode, too: Hold the Alt key and tap
Shift to activate lower case. Notice that the upper case letters shift to lower
case, and the shifted graphic symbols (such as the heart) shift to upper case
letters. The tradeoff of upper/lower case mode is that half of the graphic
symbols are unavailable, but you you get lower case letters.

Now try typing a command. `print "Hello World"` and press RETURN. Notice that
you need to type `print` in lower case. If you did it right, you should see
"Hello World" appear on the next line.

Now tap Alt+Shift again. The text will change to |ELLO oORLD. Again, this is the
tradeoff: you can have the Shifted graphic symbols or lower case, but not both.

### ISO Mode

Finally, the computer has ISO mode. The ISO mode character set operates more
like a PC, with upper case text, lower case text, and an assortment of accented
and other letters. In addition, ISO mode has the \, ~, {, and } symbols, which
are not available in PETSCII modes. ISO mode is useful when you need PC
compatibility or want the letters with accents. Elsewhere in this guide, we have
a full manual on using the Right Alt key to compose accented symbols, like é or
ō. Getting back to PETSCII mode from ISO mode is a little more complicated.
Press Control+Alt+RESTORE (or Control+Alt+PrintScreen) to warm start BASIC and
switch back to PETSCII mode.

### EDIT text modes

The built-in EDIT utility includes a character set mode switch: Press Control+E
to cycle through Upper/Graphic, Upper/Lower, and ISO mode.

## Special Keys

### RUN STOP

This key actually has two separate functions: "RUN" and "STOP". Holding
Shift+RUN will load the first program on your SD card and automatically run it.
If you are using the SD card that came with your Commander X16, this will print
some information on getting started with your computer.

If you are running a BASIC program, pressing STOP will stop the program.

### RESTORE

As mentioned above, RESTORE can be used with Control+Alt to perform a
warm start of BASIC. Less drastic than a cold boot, this stops a running
program and returns you to the `READY.` prompt. If you had a BASIC program
loaded, you can still re-start it with RUN or view it with LIST.

### Control+Alt_Delete

Yes, the Commander X16 has the famous "3 fingered salute." This performs a cold
boot of the computer, including a full power cycle. You will be returned to the
boot screen, and if you have an AUTOEXEC.X16, it will execute on startup.

### 40/80 DISPLAY

This switches the computer between 80x60 text mode and 40x30 text mode. 40x30
is more useful on CRT screens, so you may want to boot up into 40x30 mode. You
can set these modes with BASIC by typing

`SCREEN 1` or `SCREEN 3`.

Protip: you can force your computer to start in 40-column mode by modifying your
AUTOBOOT.X16 file:

```basic
LOAD "AUTOBOOT.X16"
0 SCREEN 3
SAVE "@:AUTOBOOT.X16"
BOOT
```

Don't worry, if you don't like this change, you can change it back:

```basic
LOAD "AUTOBOOT.X16"
SCREEN 1
SAVE "@:AUTOBOOT.X16"
BOOT
```

### F-KEYS

The F-keys, also known as the "Function Keys" are pre-loaded with special
shortcuts:

**F1** `LIST` Displays your currently loaded BASIC program.

**F2** `SAVE"@:` is a quick shortcut for saving a program. The @: allows you to
overwrite an existing file with the same name.

**F3** `LOAD "` helps you load a program. Protip: if you use @$ to get a
directory listing, you can then use the arrow keys to move up to a line with a
filename. Press F3 and press RETURN to load a file.

**F4** and RETURN swaps between 40 and 80 column screen modes.

**F5** `RUN` runs the currently loaded program

**F6** `MONITOR` Runs the machine monitor. The monitor allows you to directly
edit memory, view assembly language dumps, and even write short assembly
language programs at your keyboard.

**F7** `DOS"$` Lists the current directory

**F8** `DOS"` allows you to enter a disk command, such as CD:. More info can be
found in chapter 13.

## WHAT IS `PC  RA RO AC XR YR SP NV#BDIZC`?

There are times when the computer will drop to the MONITOR prompt. That looks
like this:

```text
C*
   PC  RA RO AC XR YR SP NV#BDIZC
.;E3BB 01 04 00 65 2B F6 ........
.█
```

This is the MONITOR screen. You can get there in BASIC by typing `MON`.

Type `X` and Enter to exit back to BASIC. If you just get bounced to MONITOR
again, then you'll need to Control+Alt+Restore or Control+Alt+Delete to restore
to a working state.

MONITOR is covered in [Chapter 7](X16%20Reference%20-%2007%20-%20Machine%20Language%20Monitor.md#chapter-6-machine-language-monitor).

<!-- For PDF formatting -->
<div class="page-break"></div>
