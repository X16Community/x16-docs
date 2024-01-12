
# Appendix  Z: 65816 Processor Upgrade Plans

## Beware of Leopard

This is a temporary/living document with information being updated regularly as
the 65816 plans materialize. If/when the project matures, this content may likely
end up within other documents. 

## Overview

The 8-Bit Guy (David Murray) has expressed a desire to have a possible upgrade path to 
the WDC 65816 processor for all X16s (current and future). This is not guaranteed and
the capabilities depend in several factors with many details still to be discussed.

At present, 
**the X16 is a 65C02 machine**. However, to provide an upgrade path at all, 4 
instructions from the 65C02 instructions/opcodes should not be used in programs. 
These are `BBRx`, `BBSx`, `RMBx`, and `SMBx`.

## How Might This Affect My Programs?

If you are writing BASIC or Prog8 code, you are likely not affected. If you are using C 
you may be somewhat affected.

If you are writing assembly, however, you would be affected if you are or had plans to
use these instructions. Folks writing assembly programs can use [these marcos](X16%20Reference%20-%20Appendix%20C%20-%2065C02%20Processor.md#replacement-macros-for-bit-instructions) 
to emulate the behavior of the instructions.

## How Might This Affect My Existing X16?

If you already have an X16 or are planning on [purchasing](https://texelec.com/product/cx16-preorder/?highlight=x16) 
one, it will come with a 65C02 processor. Your applications will work on any future X16s
that have a 65816 as long as they do not use the CPU instructions noted above.

The 65816 can be used in your X16 now, though the KERNAL does not support the native 
mode and if you use any 65816 features, your code will not run on stock X16s or any
of the emulators. You also cannot service interrupts while in native mode.

Should the 65816 end up being supported in some capacity, part of the requirements 
include an upgrade path for existing machines. Apart from swapping the CPU, there may be 
firmware (ROM) upgrades required as well as possible hardware changes. The price for 
the hardware upgrades, if required, is estimated to be around $17 (including the CPU).

These upgrades would allow for better utilize the 65816. Specifically they
enable using the 16-bit modes with interrupts, something that is not supported on 
existing X16 machines.

Whether hardware upgrades are required is to be determined.

## What Is the Purpose?

Though the X16 Developer edition has a socket for being able to somewhat easily
replace or upgrade the CPU, the other X16 editions will likely use a surface mounted
CPU which cannot be so easily replaced by the end user. Since the 65816 is mostly
compatible with the 65C02, switching these systems to the 65816 still offers 
compatibility with all X16 software (noting the 4 CPU opcodes that should be avoided).

Should any additional 65816 features not be pursued, functionally these systems would
act like 65C02 machines.

This however opens the door to expanded functionality in the future. The 65816 offers
some compelling features (beyond just 16-bit arithmetic) and one project that was 
mentioned was a multi-tasking operating system for the X16. This is a more attainable
goal with the additional features of the 65816.

One of the design principles of the X16 was to have a simple architecture that was
easy to understand and realize using off the shelf logic chips, borrowing heavily
from the Commodore PET architecture. This does mean not all features of the 65816
will be realized. Even then, some potentially attainable features may not end up
being supported.

## What Do I Do Now?

At present, this is not a cause for concern. All X16's will run existing software 
regardless. At some point there may be a viable upgrade path and enough software
that may make the upgrade compelling for you. When that time comes, you will have
options. These are not near term solutions, however, and at present, 
**The X16 is a 65C02 based machine** and should be treated as such (again, 
except for the 4 instructions which the 65816 does not support).

If you are interested in helping make 65816 support a possible reality, there
are some things that need to be addressed:

  * Emulator Support for the 65816
    (including error handling of the 4 unsupported instructions)
  * Documentation of the 65816 (opcodes, memory modes, examples)
  * Solutions for reasonable hardware upgrade paths for existing X16s,
    including the possibility of a board upgrade service
  * KERNAL modifications
  * Testing applications with the 65816 on real hardware (X16 Developer Edition)

## Won't This Fragment the Community?

David has made it clear this is what he does not want. The 65816 is more like
going from an Apple ][ (Apple 2) to an Apple iigs (Apple 2 GS). And at present the project is really
still in the feasibility phase. Unlike the Apple ][, existing X16 machines will
be upgradeable to support the 65816 in the same way future revisions will.

Likewise this is not a near term upgrade. All the X16 Developer machines currently
ship with a 65C02.

## Proposed Upgrade Paths

This is rapidly evolving. Based on conversations within #cpu-65816 on the community Discord,
there are the various options proposed thus far. Note that all of these assume there are 
folks willing to do the work to realize these solutions as software and/or hardware development
would be required.

### Bodge Based Upgrade

Users that wish to upgrade their X16 would be required to make changes to the board directly
which would require soldering a small PCB underneath the X16. This PCB modifies the behavior
of the ROM bank switching to allow for interrupts to be used while the 65816 is running in
native mode.

#### Pros

  * Probably inexpensive
  * X16 could run both 65C02 and 65816 programs

#### Cons

  * Requires soldering and board modifications of which some users may be unwilling or unable to do
  * Upgrade is not easy to revert, may involve "damaging" the board (cutting traces)

### CPU and ROM Upgrade Kit

An upgrade kit would be made available that included the 65816 CPU and an updated ROM.

#### Pros
  
  * Reasonably easy to revert
  * Inexpensive
  * No soldering required or permanent modifications to boards

#### Cons

  * 65C02 native could would not longer work properly. To run 65C02 programs, one would have to 
    swap the CPU/ROM back  
  * Need to maintain two KERNALs which increases the chance of bugs, divergence, and requires more
    human (likely volunteer) work to maintain.

### Super CPU Style Expansion Card

Since the X16 Developer edition has 3 expansion slots and 1 cartridge slot, a Super CPU style card
could be designed. This card would "take over" functions of the on board X16. Unlike the above
options, this one would be the easiest to revert - simply remove the card, or flip a switch on
the card's I/O panel, or perhaps there might be a software solution to switch modes.

#### Pros

  * Easiest hardware based upgrade path
  * Easy to disable/revert
  * No board changes or swapping socketed chips required
  * Avoids hacky (hard to maintain) KERNAL changes

#### Cons

  * Most expensive
  * Eats up an expansion slot
  * May prevent other cards from using DMA as it takes over the bus
  * May need to be disabled to run 65C02 programs
  * Still requires a modified KERNAL separate from the stock KERNAL

### Software Solution

The KERNAL is updated with some trickery to allow for interrupts to work in both modes. Specifically
handling certain KERNAL calls (like SCREEN) which at present stomp over addresses the 65816 uses for 
interrupt handling.

#### Pros

  * Zero cost solution (for users)
  * No hardware changes required
  * X16 can run both 65C02 and 65816 programs

#### Cons

  * Code introduced to the KERNAL which may be hard to understand and maintain
  * Performance implications when calling the affected KERNAL routines

### Do Nothing

While fairly unlikely, among the feasible options is to run all 65816 systems in emulation (65C02) mode.

#### Pros

  * No changes required
  * Zero cost
  * No tech debt (updating KERNAL, designing hardware, etc.)

#### Cons

  * Zero benefits to having an 65816

## Further Reading

  * [David's Statement On Discord](https://discord.com/channels/547559626024157184/549248037923454986/1194034437281812540)

<!-- For PDF formatting -->
<div class="page-break"></div>
