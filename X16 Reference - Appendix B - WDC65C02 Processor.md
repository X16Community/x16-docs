# Appendix B: The WDC65C02 Processor

**Work In Progress**

TODO:

  * Add 65C02 addressing modes for ADC AND CMP EOR LDA ORA SBC STA


The WDC65C02 CPU is modern version of the MOS6502 with a few additional opcodes.

This is not meant to be a complete manual on the 65C02 processor, though is meant 
to serve as a convenient quick reference. Much of this information comes from
6502.org and pagetable.com. It is been placed here for convenience though further
information can be found at those (and other) sources.

## Opcode Tables

### Alphabetical

|     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| [ADC](#adc) | [AND](#and) | [ASL](#asl) | [BBR](#bbr) | [BBS](#bbs) | [BCC](#bcc) | [BCS](#bcs) | [BEQ](#beq) |
| [BIT](#bit) | [BMI](#bmi) | [BNE](#bne) | [BPL](#bpl) | [BRA](#bra) | [BRK](#brk) | [BVC](#bvc) | [BVS](#bvs) |
| [CLC](#clc) | [CLD](#cld) | [CLI](#cli) | [CLV](#clv) | [CMP](#cmp) | [CPX](#cpx) | [CPY](#cpy) | [DEC](#dec) |
| [DEX](#dex) | [DEY](#dey) | [EOR](#eor) | [INC](#inc) | [INX](#inx) | [INY](#iny) | [JMP](#jmp) | [JSR](#jsr) |
| [LDA](#lda) | [LDX](#ldx) | [LDY](#ldy) | [LSR](#lsr) | [NOP](#nop) | [ORA](#ora) | [PHA](#pha) | [PHP](#php) |
| [PHX](#phx) | [PHY](#phy) | [PLA](#pla) | [PLP](#plp) | [PLX](#plx) | [PLY](#ply) | RMB | ROL |
| ROR | RTI | RTS | SBC | SEC | SED | SEI | SMB | 
| STA | STP | STX | STY | STZ | TAX | TAY | TRB | 
| TSB | TSX | TXA | TXS | TYA | WAI |     |     |

### By Function

| Load/Store | Transfer | Stack | Logic | Math | Branch | Flow | Flags |
| --- | --- | --- | --- | --- | --- | --- | --- |
| LDA | TAX | PHA | [ASL](#asl) | [ADC](#adc) | [BCC](#bcc) | BRA | CLC |
| LDX | TAY | PHP | LSR | SBC | [BCS](#bcs) | JMP | CLD |
| LDY | TSX | PHX | ROL | CMP | [BEQ](#beq) | JSR | CLI |
| STA | TXA | PHY | ROR | CPX | BMI | RTI | CLV |
| STX | TXS | PLA | [AND](#and) | CPY | BNE | RTS | SEC |
| STY | TYA | PLP | BIT | INC | BPL | BRK | SED |
| STZ |     | PLX | EOR | INX | BVC | STP | SEI |
|     |     | PLY | ORA | INY | BVS | WAI |     |
|     |     |     | TRB | DEC | [BBR](#bbr) |     |     |
|     |     |     | TSB | DEX | [BBS](#bbs) |     |     |
|     |     |     | NOP | DEY |     |     |     |
|     |     |     | RMB |     |     |     |     |
|     |     |     | SMB |     |     |     |     |

## Opcodes

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

Flags Affected: CNVZ

Add provided value to the A (accumlator) register. There is no way to add
without a carry. Results depend on wether decimal mode is enabled.

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

Add provided value to the A (accumlator) register. There is no way to add
without a carry. Results depend on wether decimal mode is enabled.

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

Branch to LABEL if bit x of zero page address is 0. This is a 65C02 
specific instruction.

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

Branch to LABEL if bit x of zero page address is 1. This is a 65C02 
specific instruction.

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

Branch to LABEL if the carry flag is clear.

### BCS

Branch If Carry Set

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BCS LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the carry flag is set.

### BEQ

Branch If Equals

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BEQ LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the zero flag is set.

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

Branch to LABEL if the negative flag is set.

### BNE

Branch If Not-Equal

| Addressing Mode | Usage         | Length | Cycles   |
| --------------- | ------------- | ------ | -------- |
| Relative        | BNE LABEL     | 3      | 2-4 [^2] |

Branch to LABEL if the negative flag is set.

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
| Relative        | BRA LABEL      | 2      | 3-4 [^1] |

Branch to LABEL no matter what. This is a 65C02 specific opcode.

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

Clears the interrupt (I) flag, which in turn enables maskable
interrupts (IRQs).

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

Compare value in X with given value. Apart from the 
fewer addressing modes, the behavior is the same
as with [CMP](#cmp) only using the X register insteaf of
A.

### CPY

Compare Y Register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Immediate       | CPY #$44    | 2      | 2      |
| Zero Page       | CPY $44     | 2      | 3      |
| Absolute        | CPY $4400   | 3      | 4      |

Compare value in Y with given value. Apart from the 
fewer addressing modes, the behavior is the same
as with [CMP](#cmp) only using the Y register insteaf of
A.

### DEC

Decrement Value In Memory

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Zero Page       | DEC $44     | 2      | 5      |
| Zero Page,X     | DEC $44,X   | 2      | 6      |
| Absolute        | DEC $4400   | 3      | 6      |
| Absolute,X      | DEC $4400,X | 3      | 7      |

Decrement value in memory by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

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
| Zero Page       | INC $44     | 2      | 5      |
| Zero Page,X     | INC $44,X   | 2      | 6      |
| Absolute        | INC $4400   | 3      | 6      |
| Absolute,X      | INC $4400,X | 3      | 7      |

Increment value in memory by one.

  - Sets N (Negative) flag if the two's compliment value is negative
  - Sets Z (Zero) flag is the value is zero

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
also
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
| Implied         | PHX         | 1      | 3      |

Push the value in the X onto the stack.

65C02 specific opcode.

### PHY

Push the Y register register onto the Stack

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PHY         | 1      | 3      |

Push the value in the Y onto the stack.

65C02 specific opcode.

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
| Implied         | PLX         | 1      | 4      |

Pull/Pop the value on the stack and place into 
the X register.

65C02 specific opcode.

### PLY

Pop value from stack into the X register

| Addressing Mode | Usage       | Length | Cycles |
| --------------- | ----------- | ------ | ------ |
| Implied         | PLY         | 1      | 4      |

Pull/Pop the value on the stack and place into 
the Y register.

65C02 specific opcode.

## Status Flags

Flags are stored in the P register. PHP and PLP can be used
to directly manipulate this register. Otherwise the flags
are used to indicate certain statuses and changed by 
various opcodes.

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

## Further Reading

  * http://www.6502.org/tutorials/6502opcodes.html
  * http://6502.org/tutorials/65c02opcodes.html
  * https://www.pagetable.com/c64ref/6502/?cpu=65c02
  * https://www.nesdev.org/wiki/Status_flags
  * https://skilldrick.github.io/easy6502/

[^1]: Add 1 cycle if a page boundary is crossed
[^2]: Add 1 cycle if branch is taken on the same page, or 2 if it's taken to a different page
[^3]: 65C02 specific addressing mode