
# Appendix C: The 65C02 Processor

This is not meant to be a complete manual on the 65C02 processor, though is meant 
to serve as a convenient quick reference. Much of this information comes from
6502.org and pagetable.com. It is been placed here for convenience though further
information can be found at those (and other) sources.

## Work In Progress

TODO:

  * Add 65C02 addressing modes for ADC AND CMP EOR LDA ORA SBC STA
  * Add flag changes where relevant (likely missing some)

## Possible 65C816 Support Compatibilty

The Commander X16 may be upgraded at some point to use the WDC 65C816 CPU.
The 65C816 is mostly compatible with the 65C02, except for 4 instructions 
(`BBRx`, `BBSx`, `RMBx`, and `SMBx`).

As a result, we recommend *not* using the BBR, BBS, RMB and SMB instructions, as these
may become invalid in future versions of the Commander X16. 

These instructions are *not* supported on the Commander X16 as of the R47 release.

## Overview

The WDC65C02 CPU is a modern version of the MOS6502 with a few additional instructions
and addressing modes and is capable of running at up to 14 MHz. On the Commander X16
it is clocked at 8 MHz.

## Instruction Tables

### Alphabetical

|     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| [ADC](#adc)     | [AND](#and)     | [ASL](#asl) | [BBR](#bbr)[^4] [^5] | [BBS](#bbs)[^4] [^5] | [BCC](#bcc)     | [BCS](#bcs)     | [BEQ](#beq)     |
| [BIT](#bit)     | [BMI](#bmi)     | [BNE](#bne) | [BPL](#bpl)     | [BRA](#bra)     | [BRK](#brk)     | [BVC](#bvc)     | [BVS](#bvs)     |
| [CLC](#clc)     | [CLD](#cld)     | [CLI](#cli) | [CLV](#clv)     | [CMP](#cmp)     | [CPX](#cpx)     | [CPY](#cpy)     | [DEC](#dec)     |
| [DEX](#dex)     | [DEY](#dey)     | [EOR](#eor) | [INC](#inc)     | [INX](#inx)     | [INY](#iny)     | [JMP](#jmp)     | [JSR](#jsr)     |
| [LDA](#lda)     | [LDX](#ldx)     | [LDY](#ldy) | [LSR](#lsr)     | [NOP](#nop)     | [ORA](#ora)     | [PHA](#pha)     | [PHP](#php)     |
| [PHX](#phx)[^4] | [PHY](#phy)[^4] | [PLA](#pla) | [PLP](#plp)     | [PLX](#plx)[^4] | [PLY](#ply)[^4] | [RMB](#rmb)[^4] [^5] | [ROL](#rol)     |
| [ROR](#ror)     | [RTI](#rti)     | [RTS](#rts) | [SBC](#sbc)     | [SEC](#sec)     | [SED](#sed)     | [SEI](#sei)     | [SMB](#smb)[^4] [^5] | 
| [STA](#sta)     | [STP](#stp)[^4] | [STX](#stx) | [STY](#sty)     | [STZ](#stz)[^4] | [TAX](#tax)     | [TAY](#tay)     | [TRB](#trb)[^4] | 
| [TSB](#trb)[^4] | [TSX](#tsx)     | [TXA](#txa) | [TXS](#txs)     | [TYA](#tya)     | [WAI](#wai)[^4] |                 |                 |

### By Function

| Load/Store      | Transfer    | Stack           | Logic           | Math        | Branch          | Flow            | Flags       |
| --------------- | ----------- | -----------     | --------------- | ----------- | --------------- | --------------- | ----------- |
| [LDA](#lda)     | [TAX](#tax) | [PHA](#pha)     | [ASL](#asl)     | [ADC](#adc) | [BCC](#bcc)     | [BRA](#bra)     | [CLC](#clc) |
| [LDX](#ldx)     | [TAY](#tay) | [PHP](#php)     | [LSR](#lsr)     | [SBC](#sbc) | [BCS](#bcs)     | [JMP](#jmp)     | [CLD](#cld) |
| [LDY](#ldy)     | [TSX](#tsx) | [PHX](#phx)[^4] | [ROL](#rol)     | [CMP](#cmp) | [BEQ](#beq)     | [JSR](#jsr)     | [CLI](#cli) |
| [STA](#sta)     | [TXA](#txa) | [PHY](#phy)[^4] | [ROR](#ror)     | [CPX](#cpx) | [BMI](#bmi)     | [RTI](#rti)     | [CLV](#clv) |
| [STX](#stx)     | [TXS](#txs) | [PLA](#pla)     | [AND](#and)     | [CPY](#cpy) | [BNE](#bne)     | [RTS](#rts)     | [SEC](#sec) |
| [STY](#sty)     | [TYA](#tya) | [PLP](#plp)     | [BIT](#bit)     | [INC](#inc) | [BPL](#bpl)     | [BRK](#brk)     | [SED](#sed) |
| [STZ](#stz)[^4] |             | [PLX](#plx)[^4] | [EOR](#eor)     | [INX](#inx) | [BVC](#bvc)     | [STP](#stp)[^4] | [SEI](#sei) |
|                 |             | [PLY](#ply)[^4] | [ORA](#ora)     | [INY](#iny) | [BVS](#bvs)     | [WAI](#wai)[^4] |             |
|                 |             |                 | [TRB](#trb)[^4] | [DEC](#dec) | [BBR](#bbr)[^4] [^5] |                 |             |
|                 |             |                 | [TSB](#tsb)[^4] | [DEX](#dex) | [BBS](#bbs)[^4] [^5] |                 |             |
|                 |             |                 | [NOP](#nop)     | [DEY](#dey) |                 |                 |             |
|                 |             |                 | [RMB](#rmb)[^4] [^5] |             |                 |                 |             |
|                 |             |                 | [SMB](#smb)[^4] [^5] |             |                 |                 |             |

## Instructions

### ADC

Add with Carry

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | ADC #$44    | 2      | 2      |
| Zero Page       | ADC $44     | 2      | 3      |
| Zero Page,X     | ADC $44,X   | 2      | 4      |
| Absolute        | ADC $4400   | 3      | 4      |
| Absolute,X      | ADC $4400,X | 3      | 4[^1]  |
| Absolute,Y      | ADC $4400,Y | 3      | 4[^1]  |
| Indirect,X      | ADC ($44,X) | 2      | 6      |
| Indirect,Y      | ADC ($44),Y | 2      | 5[^1]  |

Add provided value to the A (accumulator) register. There is no way to add
without a carry. Results depend on wether decimal mode is enabled.

  - Sets C (Carry) flag is the result is larger than 255 (or 99 in decimal mode)
  - Sets N (Negative) flag is the two's compliment result is negative (otherwise it is reset)
  - Sets V (Overflow) if the two's compliment result exceeds -128 or +127 (otherwise it is reset)
  - Sets Z (Zero) is the result is zero

### AND

Logical Bitwise And

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | AND #$44    | 2      | 2      |
| Zero Page       | AND $44     | 2      | 3      |
| Zero Page,X     | AND $44,X   | 2      | 4      |
| Absolute        | AND $4400   | 3      | 4      |
| Absolute,X      | AND $4400,X | 3      | 4[^1]  |
| Absolute,Y      | AND $4400,Y | 3      | 4[^1]  |
| Indirect,X      | AND ($44,X) | 2      | 6      |
| Indirect,Y      | AND ($44),Y | 2      | 5[^1]  |

Bitwise AND the provided value with the accumulator.

  - Sets N (Negative) flag if the bit 7 of the result is 1, and otherewise clears it
  - Sets Z (Zero) is the result is zero, and otherwise clears it

### ASL

Arithmetic Shift Left

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Accumulator     | ASL         | 1      | 2      |
| Zero Page       | ASL $44     | 2      | 5      |
| Zero Page,X     | ASL $44,X   | 2      | 6      |
| Absolute        | ASL $4400   | 3      | 6      |
| Absolute,X      | ASL $4400,X | 3      | 7      |

Shifts all bits to the left by one position. Unlike 
[ROL](#rol), the bits do not rotate. 
Instead a 0 is shifted into bit 0 and bit 7 is shifted 
into the carry flag.

Similar to [LSR](#lsr).

### BBR

Branch If Bit Reset

| Addressing Mode | Usage          | Length | Cycles  |
| --------------- | -------------  | ------ | ------- |
| Zero Page       | BBRx $44,LABEL | 3      | 3-5[^2] |

Branch to LABEL if bit x of zero page address is 0 where x is the number 
of the specific bit (0-7).

Specific to the 65C02 (*unavailable on the 65C816*)

#### Example (ca65)

```
  @check_flag:
    BBR3 zeropage_flag, @flag_not_set
  @flag_set:
    NOP
    ...
  @flag_not_set:
    NOP
    ...
```

The above BBR3 looks at value in zeropage_flag (here it's a label to an actual
zero page address) and if bit 3 of the value is *zero* the branch would be
taken to `@flag_not_set`.

### BBS

Branch If Bit Set

| Addressing Mode | Usage          | Length | Cycles |
| --------------- | -------------  | ------ | ------ |
| Zero Page       | BBSx $44,LABEL | 3      | 5[^2]  |

Branch to LABEL if bit x of zero page address is 1 where x is the number 
of the specific bit (0-7).

Specific to the 65C02 (*unavailable on the 65C816*)

#### Example (ca65)

```
  @check_flag:
    BBS3 zeropage_flag, @flag_set
  @flag_not_set:
    NOP
    ...
  @flag_set:
    NOP
    ...
```

The above BBR3 looks at value in zeropage_flag (here it's a label to an actual
zero page address) and if bit 3 of the value is *zero* the branch would be
taken to `@flag_set`.

### BCC

Branch If Carry Clear

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BCC LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the carry flag (C) is clear. 

### BCS

Branch If Carry Set

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BCS LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the carry flag (C) is set.

### BEQ

Branch If Equals

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BEQ LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the zero flag (Z) is set. 

### BIT

Test Bits

| Addressing Mode | Usage         | Length | Cycles |
| --------------- | ------------- | ------ | ------ |
| Zero Page       | BIT $44       | 2      | 3      |
| Absolute        | BIT $4400     | 3      | 4      |

  - Sets Z (Zero) flag based on an and'ing of value provided to the A (accumulator) register. 
  - Sets N (Negative) flag to the value of bit 7 at the provided address.  
  - Sets V (Overflow) flag to the value of bit 6 at the provided addres.  

### BMI

Branch If Minus

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BMI LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the negative flag (N) is set.

### BNE

Branch If Not-Equal

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BNE LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the zero (Z) flag is clear.

### BPL

Branch If Positive

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BPL LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the negative flag (N) is clear.

### BRA

Branch Always

| Addressing Mode | Usage          | Length | Cycles   |
| --------------- | -------------  | ------ | -------- |
| Relative        | BRA LABEL  | 2      | 3-4 [^1] |

Branch to LABEL no matter what. Essentially a relative jump
which uses fewer bytes. Specific to the 65C02.

### BRK

Break

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | BRK           | 1      | 7        |

Fires an NMI (non-maskable interrupt) and increments the
program counter (PC) by 1. Useful in combination with RTI
for debuggning.

### BVC

Branch On Overflow Clear

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BVC LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the overflow flag (V) is clear.

### BVS

Branch On Overflow Set

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BVS LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the overflow flag (V) is set.

### CLC

Clear Carry Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | CLC           | 1      | 2        |

Clears the carry (C) flag.

### CLD

Clear Decimal Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | CLD           | 1      | 2        |

Clears the decimal (D) flag, *disabling* binary-coded 
decimal addition and subtraction.

### CLI

Clear Interrupt Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | CLI           | 1      | 2        |

Clears the interrupt (I) flag, which in turn 
**enables** maskable interrupts (IRQs).

### CLV

Clear Overflow Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | CLV           | 1      | 2        |

Clears the overflow (V) flag, typically used with 
two's compliment addition and subtraction.

### CMP

Compare Accumulator

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | CMP #$44    | 2      | 2      |
| Zero Page       | CMP $44     | 2      | 3      |
| Zero Page,X     | CMP $44,X   | 2      | 4      |
| Absolute        | CMP $4400   | 3      | 4      |
| Absolute,X      | CMP $4400,X | 3      | 4[^1]  |
| Absolute,Y      | CMP $4400,Y | 3      | 4[^1]  |
| Indirect,X      | CMP ($44,X) | 2      | 6      |
| Indirect,Y      | CMP ($44),Y | 2      | 5[^1]  |

Compares the value in A (the accumulator) with the given
value. It behaves as though a subtraction took place of
the given value from the accumulator.

  - Sets C (Carry) flag if the value in A is >= given value
  - Clears C (Carry) flag if the value in A is < given value
  - Sets Z (Zero) flag if the values are equal
  - Clears Z (Zero) flag if the values are not equal
  - Sets N (Negative) flag if value in A is < given value

### CPX

Compare X Register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | CPX #$44    | 2      | 2      |
| Zero Page       | CPX $44     | 2      | 3      |
| Absolute        | CPX $4400   | 3      | 4      |

Compare value in X with given value. The behavior is the same
as with [CMP](#cmp) only using the X register instead of
A.

### CPY

Compare Y Register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | CPY #$44    | 2      | 2      |
| Zero Page       | CPY $44     | 2      | 3      |
| Absolute        | CPY $4400   | 3      | 4      |

Compare value in Y with given value. The behavior is the same
as with [CMP](#cmp) only using the Y register instead of
A.

### DEC

Decrement Value In Memory

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied / A     | DEC         | 1      | 2      |
| Zero Page       | DEC $44     | 2      | 5      |
| Zero Page,X     | DEC $44,X   | 2      | 6      |
| Absolute        | DEC $4400   | 3      | 6      |
| Absolute,X      | DEC $4400,X | 3      | 7      |

Decrement value in memory by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

Implied/A mode is specific to 65C02 and 65C816. This operates on the 
Accumulator (A)

### DEX

Decrement Value In X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | DEX         | 1      | 2      |

Decrement value in the X register by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### DEY

Decrement Value In Y

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | DEY         | 1      | 2      |

Decrement value in the Y register by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### EOR

Exclusive OR

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | EOR #$44    | 2      | 2      |
| Zero Page       | EOR $44     | 2      | 3      |
| Zero Page,X     | EOR $44,X   | 2      | 4      |
| Absolute        | EOR $4400   | 3      | 4      |
| Absolute,X      | EOR $4400,X | 3      | 4[^1]  |
| Absolute,Y      | EOR $4400,Y | 3      | 4[^1]  |
| Indirect,X      | EOR ($44,X) | 2      | 6      |
| Indirect,Y      | EOR ($44),Y | 2      | 5[^1]  |

Perform an exclusive OR of the given value in A 
(the accumulator), storing the result in A.

The exclusive OR version of [ORA](#ora).

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

#### Truth Table

|       | 0 | 1 |
| ----- | - | - |
| **0** | 0 | 1 | 
| **1** | 1 | 0 |

### INC

Increment Value In Memory

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied / A     | INC         | 1      | 2      |
| Zero Page       | INC $44     | 2      | 5      |
| Zero Page,X     | INC $44,X   | 2      | 6      |
| Absolute        | INC $4400   | 3      | 6      |
| Absolute,X      | INC $4400,X | 3      | 7      |

Increment value in memory by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

Implied/A mode is specific to 65C02 and 65C816. This operates on the 
Accumulator (A)

### INX

Increment Value In X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | INX         | 1      | 2      |

Increment value in the X register by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### INY

Increment Value In Y

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | INY         | 1      | 2      |

Increment value in the Y register by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### JMP

Jump To Memory Location

| Addressing Mode | Usage         | Length | Cycles |
| --------------- | -----------   | ------ | ------ |
| Absolute        | JMP $4400     | 3      | 4      |
| (Absolute,X)[^3]| JMP ($4400,X) | 3      | 6      |
| Indirect        | JMP ($4400)   | 3      | 5      |

Jump to specified memory location and begin execution
from this point.

Note for indirect jumps, never jump to a vector
beginning on the last byte of a page.

#### (Absolute,X) and Jump Tables

(Absolute,X) is an addition mode for the 65C02 and is
commonly used for implementing simpler jump tables as it
avoids needing to have two tables for the low and high bytes.

Instead, we might have something like:

```
important_jump_table:
  .word routine1
  .word routine2
...

LDX #$01
JMP (important_jump_table,x)
```

The above would jump to the address of `routine2`.

### JSR

Jump to Subroutine

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Absolute        | JSR $4400   | 3      | 6      |

Jump to a subroutine. Unlike [JMP](#jmp), JSR is commonly
for jumping to a routine that will pass control back
using [RTS](#rts) (return from subroutine) so that program
execution continue at the instruction after the JSR.

In more technical terms, JSR pushes the address-1 of the
next instruciton onto the stack before transferring control
to the jumped to routine.

### LDA

Load Accumulator

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | LDA #$44    | 2      | 2      |
| Zero Page       | LDA $44     | 2      | 3      |
| Zero Page,X     | LDA $44,X   | 2      | 4      |
| Absolute        | LDA $4400   | 3      | 4      |
| Absolute,X      | LDA $4400,X | 3      | 4[^1]  |
| Absolute,Y      | LDA $4400,Y | 3      | 4[^1]  |
| Indirect,X      | LDA ($44,X) | 2      | 6      |
| Indirect,Y      | LDA ($44),Y | 2      | 5[^1]  |

Place the given value from memory into A (the accumulator).

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### LDX

Load X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | LDX #$44    | 2      | 2      |
| Zero Page       | LDX $44     | 2      | 3      |
| Zero Page,Y     | LDX $44,Y   | 2      | 4      |
| Absolute        | LDX $4400   | 3      | 4      |
| Absolute,Y      | LDX $4400,Y | 3      | 4[^1]  |

Place the given value from memory into the X register.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### LDY

Load Y

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | LDY #$44    | 2      | 2      |
| Zero Page       | LDY $44     | 2      | 3      |
| Zero Page,X     | LDY $44,X   | 2      | 4      |
| Absolute        | LDY $4400   | 3      | 4      |
| Absolute,X      | LDY $4400,X | 3      | 4[^1]  |

Place the given value from memory into the Y register.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### LSR

Logical Shift Right

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Accumulator     | LSR         | 1      | 2      |
| Zero Page       | LSR $44     | 2      | 5      |
| Zero Page,X     | LSR $44,X   | 2      | 6      |
| Absolute        | LSR $4400   | 3      | 6      |
| Absolute,X      | LSR $4400,X | 3      | 7      |

Shift all bits to the right one position. Unlike [ROR](#ror),
the bits do not rotate. 0 is shifted into bit 7 and the 
original value of bit 0 is shifted into the carry flag.

Similar to [ASL](#asl).

### NOP

No-Op (Do nothing)

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | NOP         | 1      | 2      |

Spend 2 cycles effectively doing nothing. This can be useful 
under some circumstnaces as place-holder for code, or when 
needing to manage precise timing or delay states.

It can be used, for instance, to add a bit of delay when
writing to the YM2151 chip (see 
[Chapter 11 - YM Write Procedure](X16%20Reference%20-%2011%20-%20Sound%20Programming.md#vera-psg-and-pcm-programming)).

### ORA

Bitwise OR with the Accumulator

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | ORA #$44    | 2      | 2      |
| Zero Page       | ORA $44     | 2      | 3      |
| Zero Page,X     | ORA $44,X   | 2      | 4      |
| Absolute        | ORA $4400   | 3      | 4      |
| Absolute,X      | ORA $4400,X | 3      | 4[^1]  |
| Absolute,Y      | ORA $4400,Y | 3      | 4[^1]  |
| Indirect,X      | ORA ($44,X) | 2      | 6      |
| Indirect,Y      | ORA ($44),Y | 2      | 5[^1]  |

Perform a logical OR of the given value in A 
(the accumulator), storing the result in A.

See [EOR](#eor) for the exclusive-OR version.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### PHA

Push Accumulator (A) onto the Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PHA         | 1      | 3      |

Push the value in the accumulator onto the stack.

### PHP

Push the status register (P) register onto the Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PHA         | 1      | 3      |

Push the value in the status register (P) onto
the stack. Useful as part of interrupt handling.

### PHX

Push the X register register onto the Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PHX     | 1      | 3      |

Push the value in the X onto the stack. Specific to the 65C02.

### PHY

Push the Y register register onto the Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PHY     | 1      | 3      |

Push the value in the Y onto the stack. Specific to the 65C02.

### PLA

Pop value from stack into the Accumulator (A)

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PLA         | 1      | 4      |

Pull/Pop the value on the stack and place into the accumulator.

### PLP

Pop value from stack into status register (P)

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PLP         | 1      | 4      |

Pull/Pop the value on the stack and place into the 
process status register (P).

### PLX

Pop value from stack into the X register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PLX     | 1      | 4      |

Pull/Pop the value on the stack and place into 
the X register. Specific to the 65C02.

### PLY

Pop value from stack into the X register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PLY     | 1      | 4      |

Pull/Pop the value on the stack and place into 
the Y register. Specific to the 65C02.

### RMB

Reset Memory Bit

| Addressing Mode | Usage          | Length | Cycles  |
| --------------- | -------------  | ------ | ------- |
| Zero Page       | RMBx $44       | 2      | 5       |

Set bit x to 0 at the given zero page address where x is the number 
of the specific bit (0-7).

Often used in conjunction with [BBR](#bbr) and [BBS](#bbs).

Specific to the 65C02 (*unavailable on the 65C816*)

### ROL

Rotate Left

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Accumulator     | ROL         | 1      | 2      |
| Zero Page       | ROL $44     | 2      | 5      |
| Zero Page,X     | ROL $44,X   | 2      | 6      |
| Absolute        | ROL $4400   | 3      | 6      |
| Absolute,X      | ROL $4400,X | 3      | 7      |

Rotate all bits to the left one position. The value in 
the carry (C) flag is shifted into bit 0 and the original
bit 7 is shifted into the carry (C).

Unlike [ASL](#asl) the bits rotate rather than shift in
a loop.

### ROR

Rotate Right

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Accumulator     | ROR         | 1      | 2      |
| Zero Page       | ROR $44     | 2      | 5      |
| Zero Page,X     | ROR $44,X   | 2      | 6      |
| Absolute        | ROR $4400   | 3      | 6      |
| Absolute,X      | ROR $4400,X | 3      | 7      |

Rotate all bits to the right one position. The value in 
the carry (C) flag is shifted into bit 7 and the original
bit 0 is shifted into the carry (C).

Unlike [LSR](#lsr) the bits rotate rather than shift in a loop.

### RTI

Return From Interrupt

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | RTI         | 1      | 6      |

Return from an interrupt by popping two values off the stack.
The first is for the status register (P) followed by the program
counter.

Note that unlike [RTS](#rts), the popped address is the actual
return address (rather than address-1).

### RTS

Return From Subroutine

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | RTS         | 1      | 6      |

Typically used at the end of a subroutine. It jumps 
back to the address after the [JSR](#jsr) that called it
by popping the top 2 bytes off the stack and transferring
control to that address +1.

### SBC

Subtract with Carry

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | SBC #$44    | 2      | 2      |
| Zero Page       | SBC $44     | 2      | 3      |
| Zero Page,X     | SBC $44,X   | 2      | 4      |
| Absolute        | SBC $4400   | 3      | 4      |
| Absolute,X      | SBC $4400,X | 3      | 4[^1]  |
| Absolute,Y      | SBC $4400,Y | 3      | 4[^1]  |
| Indirect,X      | SBC ($44,X) | 2      | 6      |
| Indirect,Y      | SBC ($44),Y | 2      | 5[^1]  |

Subtract the provided value from A (accumulator) register. There is no way to 
subtrack without a carry. Results depend on wether decimal mode is enabled.

If the carry flag (C) is cleared it means a borrow occurred.

### SEC

Set Carry Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | SEC           | 1      | 2        |

Sets the carry (C) flag.

### SED

Set Decimal Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | SED           | 1      | 2        |

Set the decimal (D) flag, *enabling* binary-coded decimal
addition and subtraction.

### SEI

Set Interrupt Flag

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Implied         | SEI           | 1      | 2        |

Sets the interrupt (I) flag, which in turn **disables** maskable
interrupts (IRQs).

### SMB

Set Memory Bit

| Addressing Mode | Usage          | Length | Cycles  |
| --------------- | -------------  | ------ | ------- |
| Zero Page       | SMBx $44       | 2      | 5       |

Set bit x to 1 at the given zero page address where x is the number 
of the specific bit (0-7).

Often used in conjunction with [BBR](#bbr) and [BBS](#bbs).

Specific to the 65C02 (*unavailable on the 65C816*)

### STA

Store Accumulator

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | STA $44     | 2      | 3      |
| Zero Page,X     | STA $44,X   | 2      | 4      |
| Absolute        | STA $4400   | 3      | 4      |
| Absolute,X      | STA $4400,X | 3      | 5      |
| Absolute,Y      | STA $4400,Y | 3      | 5      |
| Indirect,X      | STA ($44,X) | 2      | 6      |
| Indirect,Y      | STA ($44),Y | 2      | 6      |

Place the given value from A (the accumulator) into memory.

### STP

Stop the Processor

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | STP         | 1      | 3      |

Stops the processor and places it in a lower power
state until a hardware reset occurs. For the X16 emulator,
when the debugger is enabled using the `-debug` command-line
parameter, the STP instruction will break into the debugger
automatically.

Specific to the 65C02.

### STX

Store X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | STX $44     | 2      | 3      |
| Zero Page,Y     | STX $44,Y   | 2      | 4      |
| Absolute        | STX $4400   | 3      | 4      |

Place the given value from X register into memory.

### STY

Store Y

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | STY $44     | 2      | 3      |
| Zero Page,X     | STY $44,Y   | 2      | 4      |
| Absolute        | STY $4400   | 3      | 4      |

Place the given value from Y register into memory.

### STZ

Store Zero

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | STX $44     | 2      | 3      |
| Zero Page,X     | STX $44,Y   | 2      | 4      |
| Absolute        | STX $4400   | 3      | 4      |
| Absolute,X      | STA $4400,X | 3      | 5      |

Stores 0 into memory. A small optimization when needing
to zero our a memory location instead of calling `LDA #$00`
followed by a `STA $12`.

Specific to the 65C02.

### TAX

Transfer A to X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TAX         | 1      | 2      |

Transfer the value of the accumulator (A) to the X register.

### TAY

Transfer A to Y

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TAY         | 1      | 2      |

Transfer the value of the accumulator (A) to the Y register.

### TRB

Test and Reset Bits

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | TRB $44     | 2      | 5      |
| Absolute        | TRB $4400   | 3      | 6      |

Performs a logical AND between the inverted bits of
the accumulator and the value in memory and then
stores the result back into the same memory location.

  - Sets Z (Zero) flag if all bits from the AND are zero.


Specific to the 65C02.

### TSB

Test and Set Bits

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | TSB $44     | 2      | 5      |
| Absolute        | TSB $4400   | 3      | 6      |

Performs a logical OR between the bits of
the accumulator and the value in memory and then
stores the result back into the same memory location.

  - Sets Z (Zero) flag if all bits from the OR are zero.

Specific to the 65C02.

### TSX

Transfer Stack to X

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TSX         | 1      | 2      |

Pop a value off the stack and place it into X

### TXA

Transfer X to A

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TXA         | 1      | 2      |

Transfer the value of the X register to the accumulator (A).

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### TXS

Transfer X to Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TXS         | 1      | 2      |

Push the value from X onto the stack.

### TYA

Transfer Y to A

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | TYA         | 1      | 2      |

Transfer the value of the Y register to the accumulator (A).

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

### WAI

Wait for Interrupt

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | WAI         | 1      | 3      |

Puts the processor into a low power state until a 
hardware interrupt occurs. The intterupt is processed 
immediately since the processor is not otherwise running
any instructions. This can improve interrupt timing.

## Status Flags

Flags are stored in the P register. PHP and PLP can be used
to directly manipulate this register. Otherwise the flags
are used to indicate certain statuses and changed by 
various instructions.

P-Register:

`NV1B DIZC`

  N = Negative  
  V = oVerflow  
  1 = Always 1  
  B = Interrupt Flag  
  D = Decimal Mode  
  I = Interupts Disabled  
  Z = Zero  
  C = Carry  

## Opcode Matrix

(TODO)

## Replacement Macros for Bit Instructions

Since `BBRx`, `BBSx`, `RMBx`, and `SMBx` should not be used to support a possible
upgrade path to the 65816, here are some example macros that can be used to
help convert existing software that may have been using these instructions:

```
.macro bbs bit_position, data, destination
	.if (bit_position = 7)
		bit data
		bmi destination
	.else
		.if (bit_position = 6)
			bit data
			bvs destination
		.else
			lda data
			and #1 << bit_position
			bne destination
		.endif
  .endif
.endmacro

.macro bbr bit_position, data, destination
	.if (bit_position = 7)
		bit data
		bpl destination
	.else
		.if (bit_position = 6)
			bit data
			bvc destination
		.else
			lda data
			and #1 << bit_position
			beq destination
		.endif
	.endif
.endmacro

.macro rmb bit, destination
	lda #$1 << bit
	trb destination
.endmacro

.macro smb bit, destination
	lda #$1 << bit
	tsb destination
.endmacro
```

The above is CA65 specific but the code should work similarly for other languages.
The logic can also be used to if using an assembly language tool that does not have
macro support with small changes.

## Further Reading

  * <http://www.6502.org/tutorials/6502opcodes.html>
  * <http://6502.org/tutorials/65c02opcodes.html>
  * <https://www.pagetable.com/c64ref/6502/?cpu=65c02>
  * <http://www.oxyron.de/html/opcodesc02.html>
  * <https://www.nesdev.org/wiki/Status_flags>
  * <https://skilldrick.github.io/easy6502/>
  * <https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf>
  * <https://www.westerndesigncenter.com/wdc/documentation/w65c816s.pdf>


[^1]: Add 1 cycle if a page boundary is crossed  
[^2]: Add 1 cycle if branch is taken on the same page, or 2 if it's taken to a different page  
[^3]: 65C02 specific addressing mode  
[^4]: 65C02 specific op-code
[^5]: Not supported on the 65C816

<!-- For PDF formatting -->
<div class="page-break"></div>
