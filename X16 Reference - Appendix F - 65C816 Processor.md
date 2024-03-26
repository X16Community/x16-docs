
# Appendix F: The 65C816 Processor

**Table of Contents**

1. [Overview](#overview)
2. [Compatibility with the 65C02](#compatibility-with-the-65c02)
3. [Registers](#registers)
4. [Status Flags](#status-flags)
5. [16 bit mode](#16-bit-mode)
6. [Address Modes](#address-modes)
7. [Vectors](#vectors)
8. [Instruction Tables](#instruction-tables)

## Overview

This document is a brief introduction and quick reference for the 65C816
Microprocessor. For more details, see the [65C816 data
sheet](https://www.westerndesigncenter.com/wdc/documentation/w65c816s.pdf) or
[Programming the 65816: Including the 6502, 65C02, and 65802](https://www.amazon.com/Programming-65816-Including-65C02-65802-ebook/dp/B01855HL7Q).

The WDC65C816 CPU is an 8/16 bit CPU and a follow-up to the 65C02 processor. The
familiar 65C02 instructions and address modes are retained, and some new ones
are added.

The CPU can optionally operate in 16-bit mode, extending the utility of math
instruction (16-bit adds!) and the coverage of .X and .Y indexed modes to 64KB.

Zero Page has been renamed to Direct Page, and Direct Page can now be relocated
anywhere in the first 64K of RAM. As a result, all of the Zero Page instructions
are now "Direct" instructions and can operate anywhere in the X16's address
range.

Likewise, the Stack can also be relocated, and the stack pointer is now 16 bits.
This allows for a much larger stack, and the combination of stack and DP
relocation offer interesting multitasking opportunities.

## Compatibility with the 65C02

The 65C916 CPU is generally compatible with the 65C02 instruction set, with the
exception  of the `BBRx`, `BBSx`, `RMBx`, and `SMBx` instructions. We recommend
programmers avoid these instructions when writing X16 softwware, using the more
conventional Boolean logic instructions, instead.

## Registers

| Notation  | Name             | Description     |
|-----------|------------------|-----------------|
| A         | Accumulator      | The accumulator. It stores the result of moth math and logical operations.  |
| X         | X Index          | .X is mostly used as a counter and to offset addresses with X indexed modes |
| Y         | Y Index          | .Y is mostly used as a counter and to offset addresses with Y indexed modes |
| S         | Stack Pointer    | SP points to the next open position on the stack.                           |
| DB or DBR | Data Bank        | Data bank is the default bank for operations that use a 16 bit address.     |
| K or  PBR | Program Bank     | The default address for 16 bit JMP and JSR oprerations. Can only be set with a 24 bit JMP or JSR. |
| P         | Processor Status | The flags. |
| PC        | Program Counter  | The address of the current CPU instruction |

.A, .X, and .Y can be 8 or 16 bits wide, based on the flag settings (see below).

The Stack Pointer (.S) is 16 bits wide in Native mode and 8 bits wide (and fixed
to the $100-1FF range) in Emulation mode.

.DB and .K are the bank registers, allowing programs and data to occupy separate
64K banks on computers with more than 64K of RAM. (The X16 does not use the bank
registers, instead using addresses $00 and $01 for banking.)

## Status Flags

The native mode flags are as follows:

`nvmx dizc e`

  n = Negative  
  v = oVerflow  
  m = Memory width (0=16 bit, 1=8 bit)  
  x = Index register width (0=16 bit, 1=8 bit)  
  d = Decimal Mode  
  i = Interupts Disabled  
  z = Zero  
  c = Carry  
  e = Emulation Mode (0=65C02 mode, 1=65C816 mode)

In emulation mode, the **m** and **x** flags are always set to 1.

Here are the 6502 and 65C02 registers, for comparison:

`nv1b dizc`

  n = Negative  
  v = oVerflow  
  1 = this bit is always 1  
  b = brk: set during a BRK instruction interrupt  
  d = Decimal Mode  
  i = Interupts Disabled  
  z = Zero  
  c = Carry  

Note the missing **b** flag on the 65C816. This is no longer needed in native
mode, since the BRK instruction now has its own vector. 

The **e** flag can only accessed via the XCE instruction, which swaps Carry and
the Emulation flag.

The other flags can all be manipulated with SEP and REP, and the various
branch instructions (BEQ, BCS, etc) test some of the flags. The rest
can only be tested indirectly through the stack.

When a BRK or IRQ is triggered in _emulation_ mode, a ghost **b** flag
will be pushed to the stack instead of the **x** flag. This can be used
to test for a BRK vs IRQ in the Interrupt handler.

## 16 bit mode

The 65C816 CPU boots up in emulation mode. This locks the register width to
8 bits and locks out certain operations.

If you want to use the '816 features, including 16-bit operation, you will
need to enable _native_ mode. Clearing **e** switches the CPU to native mode.
However, it's not as simple as just setting a flag. The **e** flag can only
be accessed through the XCE instruction, which swaps the Carry and Emulation
flags.

To switch to native mode, use the following steps:

```
CLC  ; clear the Carry bit
XCE  ; swap the Emulation and Carry bit
```

To switch back to emulation mode, _set_ the Carry flag and perform an XCE again.

```
SEC  ; Set Carry
XCE  ; and push the 1 into the Emulation flag.
```

Once **e** is cleared, the **m** and **x** flags can be set to 1 or 0 to control
the register width.

When the **m** flag is *clear*, Accumulator operations and memory reads and writes
will be 16-bit operations. The CPU reads two bytes at a time with LDA, writes
two bytes at a time with STA, and all math involving .A is 16 bits wide.

Likewise, whenn **x** is clear, the .X and .Y index registers are 16 bits wide.
INX and INY will now count up to 65535, and indexed instructions like `LDA addr,X`
can now cover 64K.

You can use `REP #$10` to enable 16-bit index registers, and `REP #$20` to
enable 16-bit memory and Accumulator. `SEP #$10` or `SEP #$20` will switch back
to 8-bit operation. You can also combine the operand and use `SEP #$30` or 
`REP #$30` to flip both bits at once.

And now we reach the 16-bit assembly trap: the actual assembly opcodes are the
same, regardless of the **x** and **m** flags. This means the assembler needs
to track the state of these flags internally, so it can correctly write one or
two bytes when assembling immediate mode instructions like LDA #$01.

You can help the assembler out by using _hints_. Different assemblers have different
hinting systems, so we will focus on 64TASS and cc65.

[64TASS](https://sourceforge.net/projects/tass64/) accepts `.as` (.A short) and
`.al` (.A long) to  tell the assembler to store 8 bits or 16 bits in an immediate
mode operand. For LDX and LDY, use the `.xs` and `.xl` hints.

The hints for [ca65](https://cc65.github.io/) are `.a8`, `.a16`, `.i8`, and `.i16`

Note that this has no effect on _absolute_ or _indirect_ addressing modes, such
as `LDA $1234` and `LDA ($1000)`, since the operand for these modes is always
16 bits.

To make it easy to remember the modes, just remember that **e**, **m**, and **x**
all _emulate_ 65C02 behavior when _set_.

****

## Address Modes

The 65C816 now has 24 discinct address modes, although most are veriations on a
theme. Make note of the new syntax for Stack relative instructions (,S), the use
of brackets for [24 bit indirect] addressing, and the fact that Zero Page has
been renamed to Direct Page. This means that $0001 and $01 are now two different
addresses (although they would be the same if .DP is set to $00.

| Mode                            | Syntax    | Description |
| ------------------------------- | --------- | ------------------------------------------------------------------ |
| Immediate                       | #$12      | Value is supplied in the program stream                            |
| Absolute                        | $1234     | Data is at this address.                                           |
| Absolute X Indexed              | $1234,X   | Address is offset by X. If X=2 this is $1236.                      |
| Absolute Y Indexed              | $1234,Y   | Address is offset by X. If Y=2 this is $1236.                      |
| Direct                          | $12       | Direct Page address. Operand is 1 byte.                            |
| Direct X Indexed                | $12,X     | Address on Direct Page is offset by .X                             |
| Direct Y Indexed                | $12,Y     | Address on Direct Page is offset by .Y                             |
| Direct Indirect                 | ($12)     | Value at $12 is a 16-bit address.                                  |
| Direct Indirect Y Indexed       | ($12),Y   | Resolve pointer at $12 then offset by Y.                           |
| Direct X Indexed Indirect       | ($12,X)   | Start at $12, offset by X, then read that address.                 |
| Direct Indirect Long            | [$12]     | 24 bit pointer on Direct Page.                                     |
| Direct Indrect Long Y Indexed   | [$12],Y   | Resolve address at $12, then offset by Y.                          |
| Indirect                        | ($1234)   | Read pointer at $1234 and get data from the resultant address      |
| Indirect X Indexed              | ($1234,X) | Read pointer at $1234 offset by X, get data from resultant address |
| Indirect Long                   | [$1234]   | Pointer is a 24-bit address.                                       |
| Absolute Long                   | $123456   | 24 bit address.                                                    |
| Absolute Indexed Long           | $123456,X | 24 bit address, offset by X.                                       |
| Stack Relative Indexed          | $12,S     | Stack relative.                                                    |
| Stack Relative Indirect Indexed | ($12,S),Y | Resolve Pointer at $12, then offset by Y.                          |
| Accumulator (implied)           |           | Operation acts on .A                                               |
| Implied                         |           | Target is part of the opcode name.                                 |
| Relative Address (8 bit signed) | $1234     | Branches can only jump by -128 to 127 bytes.                       |
| 16 bit relative address         | $1234     | BRL can jump by 32K bytes.                                         |
| Block Move                      | #$12,#$34 | Operands are the bank numbers for block move/copy.                 |

## Vectors

The 65816 has two different sets of interrupt vectors. In emulation mode, the
vectors are the same as the 65C02. In native mode (.e = 0), the native vectors
are used. This allows you to switch to the desired operation mode, based on the
operating mode of your interrupt handlers.

The Commander X16 operates mostly in emulation mode, so native mode interrupts
on the X16 will switch to emulation mode, then simply call the 8-bit interrupt
handlers.

The vectors are:

| Name  | Emu   | Native |
|-------|-------|--------|
| COP   | FFF4  | 00FFE4 |
| BRK   | FFFE  | 00FFE6 |
| ABORT | FFF8  | 00FFE8 |
| NMI   | FFFA  | 00FFEA |
| RESET | FFFC  |        |
| IRQ   | FFFE  | 00FFEE |

The 65C02 shares the same interrupt for BRK and IRQ, and the **b** flag tells
the interrupt handler whether to execute a break or interrupt.

In emulation mode, the 65C816 pushes a modified version of the flags to the
stack. The BRK instruction actually pushes a 1 in bit 4, which can then be
tested in the Interrupt Service Routine. In native mode, however, the flags are
pushed verbatim, since BRK has its own handler.

There is also no native RESET vector, since the CPU always boots to emulation
mode. The CPU always starts at the address stored in $FFFC.

## Instruction Tables

## Instructions By Opcode

|           |x0         |x1         |x2         |x3         |x4         |x5         |x6         |x7         |x8         |x9         |xA         |xB         |xC         |xD         |xE         |xF         |
|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
|        0x |[BRK](#brk)|[ORA](#ora)|[COP](#cop)|[ORA](#ora)|[TSB](#tsb)|[ORA](#ora)|[ASL](#asl)|[ORA](#ora)|[PHP](#php)|[ORA](#ora)|[ASL](#asl)|[PHD](#phd)|[TSB](#tsb)|[ORA](#ora)|[ASL](#asl)|[ORA](#ora)|
|        1x |[BPL](#bpl)|[ORA](#ora)|[ORA](#ora)|[ORA](#ora)|[TRB](#trb)|[ORA](#ora)|[ASL](#asl)|[ORA](#ora)|[CLC](#clc)|[ORA](#ora)|[INC](#inc)|[TCS](#tcs)|[TRB](#trb)|[ORA](#ora)|[ASL](#asl)|[ORA](#ora)|
|        2x |[JSR](#jsr)|[AND](#and)|[JSL](#jsl)|[AND](#and)|[BIT](#bit)|[AND](#and)|[ROL](#rol)|[AND](#and)|[PLP](#plp)|[AND](#and)|[ROL](#rol)|[PLD](#pld)|[BIT](#bit)|[AND](#and)|[ROL](#rol)|[AND](#and)|
|        3x |[BMI](#bmi)|[AND](#and)|[AND](#and)|[AND](#and)|[BIT](#bit)|[AND](#and)|[ROL](#rol)|[AND](#and)|[SEC](#sec)|[AND](#and)|[DEC](#dec)|[TSC](#tsc)|[BIT](#bit)|[AND](#and)|[ROL](#rol)|[AND](#and)|
|        4x |[RTI](#rti)|[EOR](#eor)|[WDM](#wdm)|[EOR](#eor)|[MVP](#mvp)|[EOR](#eor)|[LSR](#lsr)|[EOR](#eor)|[PHA](#pha)|[EOR](#eor)|[LSR](#lsr)|[PHK](#phk)|[JMP](#jmp)|[EOR](#eor)|[LSR](#lsr)|[EOR](#eor)|
|        5x |[BVC](#bvc)|[EOR](#eor)|[EOR](#eor)|[EOR](#eor)|[MVN](#mvn)|[EOR](#eor)|[LSR](#lsr)|[EOR](#eor)|[CLI](#cli)|[EOR](#eor)|[PHY](#phy)|[TCD](#tcd)|[JML](#jml)|[EOR](#eor)|[LSR](#lsr)|[EOR](#eor)|
|        6x |[RTS](#rts)|[ADC](#adc)|[PER](#per)|[ADC](#adc)|[STZ](#stz)|[ADC](#adc)|[ROR](#ror)|[ADC](#adc)|[PLA](#pla)|[ADC](#adc)|[ROR](#ror)|[RTL](#rtl)|[JMP](#jmp)|[ADC](#adc)|[ROR](#ror)|[ADC](#adc)|
|        7x |[BVS](#bvs)|[ADC](#adc)|[ADC](#adc)|[ADC](#adc)|[STZ](#stz)|[ADC](#adc)|[ROR](#ror)|[ADC](#adc)|[SEI](#sei)|[ADC](#adc)|[PLY](#ply)|[TDC](#tdc)|[JMP](#jmp)|[ADC](#adc)|[ROR](#ror)|[ADC](#adc)|
|        8x |[BRA](#bra)|[STA](#sta)|[BRL](#brl)|[STA](#sta)|[STY](#sty)|[STA](#sta)|[STX](#stx)|[STA](#sta)|[DEY](#dey)|[BIT](#bit)|[TXA](#txa)|[PHB](#phb)|[STY](#sty)|[STA](#sta)|[STX](#stx)|[STA](#sta)|
|        9x |[BCC](#bcc)|[STA](#sta)|[STA](#sta)|[STA](#sta)|[STY](#sty)|[STA](#sta)|[STX](#stx)|[STA](#sta)|[TYA](#tya)|[STA](#sta)|[TXS](#txs)|[TXY](#txy)|[STZ](#stz)|[STA](#sta)|[STZ](#stz)|[STA](#sta)|
|        Ax |[LDY](#ldy)|[LDA](#lda)|[LDX](#ldx)|[LDA](#lda)|[LDY](#ldy)|[LDA](#lda)|[LDX](#ldx)|[LDA](#lda)|[TAY](#tay)|[LDA](#lda)|[TAX](#tax)|[PLB](#plb)|[LDY](#ldy)|[LDA](#lda)|[LDX](#ldx)|[LDA](#lda)|
|        Bx |[BCS](#bcs)|[LDA](#lda)|[LDA](#lda)|[LDA](#lda)|[LDY](#ldy)|[LDA](#lda)|[LDX](#ldx)|[LDA](#lda)|[CLV](#clv)|[LDA](#lda)|[TSX](#tsx)|[TYX](#tyx)|[LDY](#ldy)|[LDA](#lda)|[LDX](#ldx)|[LDA](#lda)|
|        Cx |[CPY](#cpy)|[CMP](#cmp)|[REP](#rep)|[CMP](#cmp)|[CPY](#cpy)|[CMP](#cmp)|[DEC](#dec)|[CMP](#cmp)|[INY](#iny)|[CMP](#cmp)|[DEX](#dex)|[WAI](#wai)|[CPY](#cpy)|[CMP](#cmp)|[DEC](#dec)|[CMP](#cmp)|
|        Dx |[BNE](#bne)|[CMP](#cmp)|[CMP](#cmp)|[CMP](#cmp)|[PEI](#pei)|[CMP](#cmp)|[DEC](#dec)|[CMP](#cmp)|[CLD](#cld)|[CMP](#cmp)|[PHX](#phx)|[STP](#stp)|[JML](#jml)|[CMP](#cmp)|[DEC](#dec)|[CMP](#cmp)|
|        Ex |[CPX](#cpx)|[SBC](#sbc)|[SEP](#sep)|[SBC](#sbc)|[CPX](#cpx)|[SBC](#sbc)|[INC](#inc)|[SBC](#sbc)|[INX](#inx)|[SBC](#sbc)|[NOP](#nop)|[XBA](#xba)|[CPX](#cpx)|[SBC](#sbc)|[INC](#inc)|[SBC](#sbc)|
|        Fx |[BEQ](#beq)|[SBC](#sbc)|[SBC](#sbc)|[SBC](#sbc)|[PEA](#pea)|[SBC](#sbc)|[INC](#inc)|[SBC](#sbc)|[SED](#sed)|[SBC](#sbc)|[PLX](#plx)|[XCE](#xce)|[JSR](#jsr)|[SBC](#sbc)|[INC](#inc)|[SBC](#sbc)|

## Instructions By Name

|             |             |             |             |             |             |             |             |             |             |
|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|
| [ADC](#adc) | [AND](#and) | [ASL](#asl) | [BCC](#bcc) | [BCS](#bcs) | [BEQ](#beq) | [BIT](#bit) | [BMI](#bmi) | [BNE](#bne) | [BPL](#bpl) |
| [BRA](#bra) | [BRK](#brk) | [BRL](#brl) | [BVC](#bvc) | [BVS](#bvs) | [CLC](#clc) | [CLD](#cld) | [CLI](#cli) | [CLV](#clv) | [CMP](#cmp) |
| [COP](#cop) | [CPX](#cpx) | [CPY](#cpy) | [DEC](#dec) | [DEX](#dex) | [DEY](#dey) | [EOR](#eor) | [INC](#inc) | [INX](#inx) | [INY](#iny) |
| [JMP](#jmp) | [JML](#jml) | [JSL](#jsl) | [JSR](#jsr) | [LDA](#lda) | [LDX](#ldx) | [LDY](#ldy) | [LSR](#lsr) | [MVN](#mvn) | [MVP](#mvp) |
| [NOP](#nop) | [ORA](#ora) | [PEA](#pea) | [PEI](#pei) | [PER](#per) | [PHA](#pha) | [PHB](#phb) | [PHD](#phd) | [PHK](#phk) | [PHP](#php) |
| [PHX](#phx) | [PHY](#phy) | [PLA](#pla) | [PLB](#plb) | [PLD](#pld) | [PLP](#plp) | [PLX](#plx) | [PLY](#ply) | [REP](#rep) | [ROL](#rol) |
| [ROR](#ror) | [RTI](#rti) | [RTL](#rtl) | [RTS](#rts) | [SBC](#sbc) | [SEC](#sec) | [SED](#sed) | [SEI](#sei) | [SEP](#sep) | [STA](#sta) |
| [STP](#stp) | [STX](#stx) | [STY](#sty) | [STZ](#stz) | [TAX](#tax) | [TAY](#tay) | [TCD](#tcd) | [TCS](#tcs) | [TDC](#tdc) | [TRB](#trb) |
| [TSB](#tsb) | [TSC](#tsc) | [TSX](#tsx) | [TXA](#txa) | [TXS](#txs) | [TXY](#txy) | [TYA](#tya) | [TYX](#tyx) | [WAI](#wai) | [WDM](#wdm) |
| [XBA](#xba) | [XCE](#xce) |             |             |             |             |             |             |             |             |

## Instructions By Category

|Category       |Instructions   |
|---------------|---------------|
| Arithmetic    | [ADC](#adc) , [SBC](#sbc) |
| Boolean       | [AND](#and) , [EOR](#eor) , [ORA](#ora) |
| Shift         | [ASL](#asl) , [LSR](#lsr) , [ROL](#rol) , [ROR](#ror) |
| Branch        | [BCC](#bcc) , [BCS](#bcs) , [BEQ](#beq) , [BMI](#bmi) , [BNE](#bne) , [BPL](#bpl) , [BRA](#bra) , [BRK](#brk) , [BRL](#brl) , [BVC](#bvc) , [BVS](#bvs) |
| Test          | [BIT](#bit) , [TRB](#trb) , [TSB](#tsb) |
| Flags         | [CLC](#clc) , [CLD](#cld) , [CLI](#cli) , [CLV](#clv) , [REP](#rep) , [SEC](#sec) , [SED](#sed) , [SEI](#sei) , [SEP](#sep) |
| Compare       | [CMP](#cmp) , [CPX](#cpx) , [CPY](#cpy) |
| Interrupt     | [COP](#cop) , [WAI](#wai) |
| Inc/Dec       | [DEC](#dec) , [DEX](#dex) , [DEY](#dey) , [INC](#inc) , [INX](#inx) , [INY](#iny) |
| Flow          | [JMP](#jmp) , [JML](#jml) , [JSL](#jsl) , [JSR](#jsr) , [NOP](#nop) , [RTI](#rti) , [RTL](#rtl) , [RTS](#rts) , [WDM](#wdm) |
| Load          | [LDA](#lda) , [LDX](#ldx) , [LDY](#ldy) |
| Block Move    | [MVN](#mvn) , [MVP](#mvp) |
| Stack         | [PEA](#pea) , [PEI](#pei) , [PER](#per) , [PHA](#pha) , [PHB](#phb) , [PHD](#phd) , [PHK](#phk) , [PHP](#php) , [PHX](#phx) , [PHY](#phy) , [PLA](#pla) , [PLB](#plb) , [PLD](#pld) , [PLP](#plp) , [PLX](#plx) , [PLY](#ply) |
| Store         | [STA](#sta) , [STP](#stp) , [STX](#stx) , [STY](#sty) , [STZ](#stz) |
| Register Swap | [TAX](#tax) , [TAY](#tay) , [TCD](#tcd) , [TCS](#tcs) , [TDC](#tdc) , [TSC](#tsc) , [TSX](#tsx) , [TXA](#txa) , [TXS](#txs) , [TXY](#txy) , [TYA](#tya) , [TYX](#tyx) , [XBA](#xba) , [XCE](#xce) |

### ADC

**Add with Carry**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
ADC #$20/#$1234  imm        69  3-m 3-m         nv....zc .
ADC $20          dir        65  2   4-m+w       nv....zc .
ADC $20,X        dir,X      75  2   5-m+w       nv....zc .
ADC $20,S        stk,S      63  2   5-m         nv....zc .
ADC $1234        abs        6D  3   5-m         nv....zc .
ADC $1234,X      abs,X      7D  3   6-m-x+x*p   nv....zc .
ADC $1234,Y      abs,Y      79  3   6-m-x+x*p   nv....zc .
ADC $FEDBCA      long       6F  4   6-m         nv....zc .
ADC $FEDCBA,X    long,X     7F  4   6-m         nv....zc .
ADC ($20)        (dir)      72  2   6-m+w       nv....zc .
ADC ($20),Y      (dir),Y    71  2   7-m+w-x+x*p nv....zc .
ADC ($20,X)      (dir,X)    61  2   7-m+w       nv....zc .
ADC ($20,S),Y    (stk,S),Y  73  2   8-m         nv....zc .
ADC [$20]        [dir]      67  2   7-m+w       nv....zc .
ADC [$20],Y      [dir],Y    77  2   7-m+w       nv....zc .
```

ADC adds the accumulator (.A), the supplied operand, and the Carry bit (0 or 1).
The result is stored in .A.

Since Carry is always added in, you should always remember to use CLC (Clear
Carry) before performing an addition operation. When adding larger numbers (16,
24, 32, or more bits), you can use the Carry flag to chain additions.

Here is an example of a 16-bit add, when in 8 bit mode:

```asm
CLC
LDA Addend1
ADC Addend2
STA Result1
LDA Addend1+1  ; Reads the high byte of the addend
ADC Addend2+1  ; (the +1 refers to the *address* of Addend, not the value)
STA Result1+1  ;
done:
; the final result is at Result1
```

Flags:

* **n** is set when the high bit of .A is set. This indicates a negative number
when using Two's Complement signed values.
* **v** (overflow) is set when the sum exceeds the maximum *signed* value for .A.
(More on that below). * **n** is set when the high bit is 1.
* **z** is set when the result is zero. This is useful for loop counters and can be
tested with BEQ and BNE. (BEQ and BNE test the Zero bit, which is also the
"equal" bit when performing subtraction or Compare operations.)
* **c** is set when the unsigned result exceeds the register's capacity (255 or
65535).

#### Overflow vs Carry

The CPU detects addition that goes past the 7 or 15 bit boundary of a signed
number, as well as the 8 bit boundary of an unsigned number.

In 8-bit mode, when you add two positive numbers that result in a sum
higher than 127 or add two negative numbers that result in a sum below -128, you
will get a signed overflow, and the v flag will be set.

When the sum of the two numbers exceeeds 255 or 65535, then the Carry flag will
be set. This bit can be added to the next higher byte with ADC #0.

```asm
CLC
LDA #$7F
ADC #$10
BRK
```


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### AND

**Boolean AND**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
AND #$20/#$1234  imm        29  3-m 3-m         n.....z. .
AND $20          dir        25  2   4-m+w       n.....z. .
AND $20,X        dir,X      35  2   5-m+w       n.....z. .
AND $20,S        stk,S      23  2   5-m         n.....z. .
AND $1234        abs        2D  3   5-m         n.....z. .
AND $1234,X      abs,X      3D  3   6-m-x+x*p   n.....z. .
AND $1234,Y      abs,Y      39  3   6-m-x+x*p   n.....z. .
AND $FEDBCA      long       2F  4   6-m         n.....z. .
AND $FEDCBA,X    long,X     3F  4   6-m         n.....z. .
AND ($20)        (dir)      32  2   6-m+w       n.....z. .
AND ($20),Y      (dir),Y    31  2   7-m+w-x+x*p n.....z. .
AND ($20,X)      (dir,X)    21  2   7-m+w       n.....z. .
AND ($20,S),Y    (stk,S),Y  33  2   8-m         n.....z. .
AND [$20]        [dir]      27  2   7-m+w       n.....z. .
AND [$20],Y      [dir],Y    37  2   7-m+w       n.....z. .
```

Perform a logical AND operation with the operand and .A

AND compares each bit of the operands and sets the result bit to 1 only when the
matching bit of each operand is 1.

AND is useful for reading a group of bits from a byte. For example, `AND #$0F`
will clear the top nibble of .A, returning the bits from the lower nibble.

Truth table for AND:

```text
Operand 1: 1100
Operand 2: 1010
Result:    1000
```

Flags:

* **n** is set when the high bit of the result is 1
* **z** is set when the result is Zero

See also: [ORA](#ora), [EOR](#eor)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### ASL

**Arithmetic Shift Left**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
ASL              acc        0A  1   2           n.....zc .
ASL $20          dir        06  2   7-2*m+w     n.....zc .
ASL $20,X        dir,X      16  2   8-2*m+w     n.....zc .
ASL $1234        abs        0E  3   8-2*m       n.....zc .
ASL $1234,X      abs,X      1E  3   9-2*m       n.....zc .
```

ASL shifts the target left one place. It shifts the high bit of the operand into
the Carry flag and a zero into the low bit.

See also: [LSR](#lsr), [ROL](#rol), [ROR](#ror)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BCC

**Branch on Carry Clear**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BCC LABEL        rel8       90  2   2+t+t*e*p   ........ .
```

Jumps to the target address when the Carry flag (**c**) is Zero.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.

BCC can be used after add, subtract, or compare operations. After a compare,
**c** is as follows:

* When A < Operand, **c** is clear.
* When A >= Operand, **c** is set.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BCS

**Branch on Carry Set**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BCS LABEL        rel8       B0  2   2+t+t*e*p   ........ .
```

Jumps to the target address when the Carry flag is 1.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.

BCC can be used after add, subtract, or compare operations. After a compare,
**c** is as follows:

* When A < Operand, **c** is clear.
* When A >= Operand, **c** is set.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BEQ

**Branch on Equal.**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BEQ LABEL        rel8       F0  2   2+t+t*e*p   ........ .
```

Jumps to the target address when the Zero flag is 1. While this is most commonly
used after a compare (see [CMP](#cmp) ) operation, it's also useful to test if a
number is zero after a Load operation, or to test if a loop is complete after a
DEC operation.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BIT

**Bit Test**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BIT #$20/#$1234  imm        89  3-m 3-m         ......z. .
BIT $20          dir        24  2   4-m+w       nv....z. .
BIT $20,X        dir,X      34  2   5-m+w       nv....z. .
BIT $1234        abs        2C  3   5-m         nv....z. .
BIT $1234,X      abs,X      3C  3   6-m-x+x*p   nv....z. .
```

Tests the operand against the Accumulator. The ALU does an AND
operation internally, setting **z** if the result is 0.

When **m**=1, **n** and **v** are set based on the value of bits 7 and 6 in
memory.

When **m**=0, **n** and **v** are set based on the value of bits 15 and 14 in
memory.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BMI

**Branch on Minus**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BMI LABEL        rel8       30  2   2+t+t*e*p   ........ .
```

Jumps to the specified address when the Negative flag (**n**) is set.

**n** is set when ALU operations result in a negative number, or when the high bit
of an ALU operation is 1.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BNE

**Branch on Not Equal.**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BNE LABEL        rel8       D0  2   2+t+t*e*p   ........ .
```

Jumps to the target address when the Zero flag is 0. While this is most commonly
used after a compare (CMP) operation, it's also useful to test if a number is
zero after a Load operation, or to test if a loop is complete after a DEC
operation.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BPL

**Branch on Plus**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BPL LABEL        rel8       10  2   2+t+t*e*p   ........ .
```

Jumps to the specified address when the Negative flag (**n**) is clear.

**n** is clear when ALU operations result in a positive number, or when the high bit
of an ALU operation is 0.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BRA

**Branch Always**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BRA LABEL        rel8       80  2   3+e*p       ........ .
```

Jumps to the specified address.

A branch operation uses an 8 bit signed value internally, starting from the
instruction after the branch. So the branch destination can be 126 bytes before
or 128 bytes after the branch instruction.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BRK

**Break**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BRK #$20         imm        00  1   8-e         ....di.. .
```

Perform a break interrupt. The exact behavior changes slightly, based on whether
the CPU is in native or emulation mode. (e is 1 in emulation mode.)

Since the Program Counter is incremented

In emulation mode:

1. .PC (Program Counter) is incremented by 1 byte.
1. If the CPU is in Native mode, the Program Bank is pushed to the stack.
1. .PC is pushed onto the stack.
1. .P (flags) is pushed to the stack. (the **b** bit, bit 4, is set to 1.)
1. The **d** (Decimal) flag is cleared, forcing the CPU into binary mode.
1. The CPU reads the address from the IRQ vector at $FFFE and jumps there.

An IRQ is similar, except that IRQ clears bit 4 (**b**) during the push to the
stack. So an Interrupt Service Routine can read the last byte on the stack to
determine whether an emulation-mode interrupt is a BRK or IRQ.

On the X16, the IRQ services the keyboard, mouse, game pads, updates the clock,
blinks the cursor, and updates the LEDs.

In native mode:

1. .PC is incremented by 1 byte.
1. .X (Program Bank) is pushed the stack
1. .PC is pushed to the stack
1. .P (flags) is pushed to the stack
1. The **d** (Decimal) flag is cleared, forcing the CPU into binary mode.
1. The CPU reads the address from the BRK vector at $00FFE6 and jumps there.

Since the Native Mode has a distinct BRK vector, you do not need to query the
stack to dispatch a BRK vs IRQ interrupt. You can just handle each immediately.

The RTI instruction is used to return from an interrupt. It pulls the values
back off the stack (this varies, depending on the CPU mode) and returns to the
pushed PC address.

RTI

See the [Vectors](#vectors) section for the break vector.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BRL

**Branch Long**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BRL LABEL        rel16      82  3   4           ........ .
```

BRL is a 16 bit _branch_ instruction, meaning assembly creates a relative
address. Unlike BRA and the other branch instructions, BRL uses a 16-bit
address, which allows for an offset of -32768 to 32767 bytes away from the
instruction _following_ The BRL.

Of course, due to wrapping of the 64K bank, this means that the entire 64K
region is accessible. Values below 0 will simply wrap around and start from
$FFFF, and values above $FFFF will wrap around to 0.

Since this is a _relatve_ branch, that means code assembled with BRL, instead of
JMP, can be moved around in memory without the need for re-assembly.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BVC

**Branch on Overflow Clear**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BVC LABEL        rel8       50  2   2+t+t*e*p   ........ .
```

Branches to the specified address when the Overflow bit is 0.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### BVS

**Branch on Overflow Set**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
BVS LABEL        rel8       70  2   2+t+t*e*p   ........ .
```

Branches to the specified address when the Overflow bit is 0.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CLC

**Clear Carry**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CLC              imp        18  1   2           .......c .
```

Clears the Carry bit in the flags. You'll usually use CLC before addition and
SEC before subtraction. You'll also want to use CLC or SEC appropriately before
calling certain KERNAL routines that use the **c** bit as an input value.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CLD

**Clear Decimal**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CLD              imp        D8  1   2           ....d... .
```

Clears the Decimal flag, returning the CPU to 8-bit or 16-bit binary operation.

When Decimal is set, the CPU will store numbers in Binary Coded Decimal format.
Clearing this flag restores the CPU to binary \(base 16\) operation. See
[Decimal Mode](#decimal-mode) for more information.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CLI

**Clear Interrupt Flag**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CLI              imp        58  1   2           .....i.. .
```

Clears the **i** flag, _allowing interrupts to be handled_.

The **i** flag operates somewhat non-intuitively: when **i** is set (1), IRQ is
suppressed. When **i** is clear (0), interrupts are handled. So CLI _allows_
interrupts to be handled.

See [BRK}(#brk) for more information on interrupt handling.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CLV

**Clear Overflow**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CLV              imp        B8  1   2           .v...... .
```

Overflow is _set_ when the result of an addition operation goes up through $80
or subtraction goes down through $80.

CLV clears the overflow flag. There is no "SEV" instruction, but overflow can be
set with SEP #$40.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CMP

**Compare**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CMP #$20/#$1234  imm        C9  3-m 3-m         n.....zc .
CMP $20          dir        C5  2   4-m+w       n.....zc .
CMP $20,X        dir,X      D5  2   5-m+w       n.....zc .
CMP $20,S        stk,S      C3  2   5-m         n.....zc .
CMP $1234        abs        CD  3   5-m         n.....zc .
CMP $1234,X      abs,X      DD  3   6-m-x+x*p   n.....zc .
CMP $1234,Y      abs,Y      D9  3   6-m-x+x*p   n.....zc .
CMP $FEDBCA      long       CF  4   6-m         n.....zc .
CMP $FEDCBA,X    long,X     DF  4   6-m         n.....zc .
CMP ($20)        (dir)      D2  2   6-m+w       n.....zc .
CMP ($20),Y      (dir),Y    D1  2   7-m+w-x+x*p n.....zc .
CMP ($20,X)      (dir,X)    C1  2   7-m+w       n.....zc .
CMP ($20,S),Y    (stk,S),Y  D3  2   8-m         n.....zc .
CMP [$20]        [dir]      C7  2   7-m+w       n.....zc .
CMP [$20],Y      [dir],Y    D7  2   7-m+w       n.....zc .
```

Compares the Accumulator with memory. This performs a subtract operation
between .A and the operand and sets the **n**, **z**, and **c** flags based on
the result. The Accumulator is not altered.

* WHen A = Operand, **z** is set.
* When A < Operand, **c** is clear.
* When A <> Operand, **z** is clear.
* When A >= Operand, **c** is set.

You can use the Branch instructions (BEQ, BNE, BPL, BMI, BCC, BCS) to jump to
different parts of your program based on the results of CMP. Here are some BASIC
comparisons and the equivalent assembly language steps.

```asm65816
; IF A = N THEN 1000
CMP N
BEQ $1000

; IF A <> N THEN 1000
CMP N
BNE $1000

; IF A < N THEN 1000
CMP N
BCC $1000

; IF A >= N THEN 1000
CMP N
BCS $1000

; IF A > N THEN 1000
CMP N
BEQ skip
BCS $1000
skip:

; IF A <= N THEN 1000
CMP N
BEQ $1000
BCC $1000
```

As you can see, some comparisons will require two distinct branch instructions.

Also, note that the Branch instructions (except BRL) require that the target
address be within 128 bytes of the instruciton after the branch. If you need to
branch further, the usual method is to invert the branch instruction and use a
JMP to take the branch.

For example, the following two branches behave the same, but the second one can
jump to any address on the computer, whereas the first can only jump -128/+127
bytes away:

```asm65816
short_branch:
CMP N
BEQ target

longer_branch:
CMP N
BNE skip
JMP target
skip:
```


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### COP

**COP interrupt.**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
COP #$20         imm        02  2   8-e         ....di.. .
```

COP is similar to BRK, but uses the FFE4 or FFF4 vectors. The intent is to COP
is to switch to a Co-Processor, but this can be used for any purpose on the X16
(including triggering a DMA controller, if that's what you want to do.)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CPX

**Compare X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CPX #$20/#$1234  imm        E0  3-x 3-x         n.....zc .
CPX $20          dir        E4  2   4-x+w       n.....zc .
CPX $1234        abs        EC  3   5-x         n.....zc .
```

This compares the X register to an operand and sets the flags accordingly.

See [CMP](#cmp) for more information.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### CPY

**Compare Y Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
CPY #$20/#$1234  imm        C0  3-x 3-x         n.....zc .
CPY $20          dir        C4  2   4-x+w       n.....zc .
CPY $1234        abs        CC  3   5-x         n.....zc .
```

This compares the Y register to an operand and sets the flags accordingly.

See [CMP](#cmp) for more information.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### DEC

**Decrement**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
DEC              acc        3A  1   2           n.....z. .
DEC $20          dir        C6  2   7-2*m+w     n.....z. .
DEC $20,X        dir,X      D6  2   8-2*m+w     n.....z. .
DEC $1234        abs        CE  3   8-2*m       n.....z. .
DEC $1234,X      abs,X      DE  3   9-2*m       n.....z. .
```

Decrement .A or memory. The **z** flag is set when the value reaches zero. This
makes DEC, DEX, and DEY useful as a loop counter, by setting the number of
iterations, the repeated operation, then DEX followed by BNE.

**z** is set when the counter reaches zero.
**n** is set when the high bit gets set.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### DEX

**Decrement .X**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
DEX              imp        CA  1   2           n.....z. .
```

Decrement .X The **z** flag is set when the value reaches zero. This
makes DEC, DEX, and DEY useful as a loop counter, by setting the number of
iterations, the repeated operation, then DEX followed by BNE.

**z** is set when the counter reaches zero.
**n** is set when the high bit gets set.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### DEY

**Decrement .Y**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
DEY              imp        88  1   2           n.....z. .
```

Decrement .X The **z** flag is set when the value reaches zero. This
makes DEC, DEX, and DEY useful as a loop counter, by setting the number of
iterations, the repeated operation, then DEX followed by BNE.

**z** is set when the counter reaches zero.
**n** is set when the high bit gets set.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### EOR

**Exclusive OR**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
EOR #$20/#$1234  imm        49  3-m 3-m         n.....z. .
EOR $20          dir        45  2   4-m+w       n.....z. .
EOR $20,X        dir,X      55  2   5-m+w       n.....z. .
EOR $20,S        stk,S      43  2   5-m         n.....z. .
EOR $1234        abs        4D  3   5-m         n.....z. .
EOR $1234,X      abs,X      5D  3   6-m-x+x*p   n.....z. .
EOR $1234,Y      abs,Y      59  3   6-m-x+x*p   n.....z. .
EOR $FEDBCA      long       4F  4   6-m         n.....z. .
EOR $FEDCBA,X    long,X     5F  4   6-m         n.....z. .
EOR ($20)        (dir)      52  2   6-m+w       n.....z. .
EOR ($20),Y      (dir),Y    51  2   7-m+w-x+x*p n.....z. .
EOR ($20,X)      (dir,X)    41  2   7-m+w       n.....z. .
EOR ($20,S),Y    (stk,S),Y  53  2   8-m         n.....z. .
EOR [$20]        [dir]      47  2   7-m+w       n.....z. .
EOR [$20],Y      [dir],Y    57  2   7-m+w       n.....z. .
```

Perform an Exclusive OR operation with the operand and .A

EOR compares each bit of the operands and sets the result bit to 1 if one of the
two bits is 1. If both bits are 1, the result is 0. If both bits are 0, the
result is 0.

EOR is useful for _inverting_ the bits in a byte. `EOR #$FF` will flip an entire
byte. (This will always flip the low byte in .A. To flip both bytes when **m**
is 0, you would use `EOR #$FFFF`.)

Truth table for EOR:

```text
Operand 1: 1100
Operand 2: 1010
Result:    0110
```


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### INC

**Increment**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
INC              acc        1A  1   2           n.....z. .
INC $20          dir        E6  2   7-2*m+w     n.....z. .
INC $20,X        dir,X      F6  2   8-2*m+w     n.....z. .
INC $1234        abs        EE  3   8-2*m       n.....z. .
INC $1234,X      abs,X      FE  3   9-2*m       n.....z. .
```

Increment .A or memory

Adds 1 to the value in .A or the specified memory address. The **n** and **z**
flags are set, based on the resultant value.

INC is useful for reading strings and operating on large areas of memory,
especially with indirect and indexed addressing modes.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### INX

**Increment .X**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
INX              imp        E8  1   2           n.....z. .
```

Increment the X register.

The following routine prints a null-terminated string (**a** should be 1.)

```asm65816
LDX #$0
loop:
LDA string_addr, X
BEQ done
JSR CHROUT
INX
BRA loop
done:
```

See [INC}(#inc)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### INY

**Increment .Y**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
INY              imp        C8  1   2           n.....z. .
```

Increment the Y register.

See [INC}(#inc)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### JMP

**Jump**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
JMP $2034        abs        4C  3   3           ........ .
JMP ($2034)      (abs)      6C  3   5           ........ .
JMP ($2034,X)    (abs,X)    7C  3   6           ........ .
```

Jump to a differnent address in memory, continuing program execution at the
specified address.

Instructions like `JMP ($1234,X)` make it possible to branch to a selectable
subroutine by setting X to the indesx into the vector table.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### JML

**Jump Long**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
JML $FEDCBA      long       5C  4   4           ........ .
JMP [$2034]      [abs]      DC  3   6           ........ .
```

Jump to a differnent address in memory, continuing program execution at the
specified address. JML accepts a 24-bit address, allowing the program to change
program banks.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### JSL

**Jmp to Subroutine Long**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
JSL $203456      long       22  4   8           ........ .
```

This is a 24-bit instruction, which can jump to a subroutine located in another
program bank.

Use the [RTL](#rtl) instruction to return to the instruction following the JSL.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### JSR

**Jump to Subroutine**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
JSR $2034        abs        20  3   6           ........ .
JSR ($2034,X)    (abs,X)    FC  3   8           ........ .
```

Jumps to a new operating address in memory. Also pushes the return address to
the stack, allowing an RTS insruction to pick up at the address following the
JSR.

The [RTS](#rts) instruction returns to the instruction following JSR.

The actual address pushed to the stack is the _before_ the next instruction.
This means that the CPU still needs to increment the PC by 1 step during the
RTS.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### LDA

**Load Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
LDA #$20/#$1234  imm        A9  3-m 3-m         n.....z. .
LDA $20          dir        A5  2   4-m+w       n.....z. .
LDA $20,X        dir,X      B5  2   5-m+w       n.....z. .
LDA $20,S        stk,S      A3  2   5-m         n.....z. .
LDA $1234        abs        AD  3   5-m         n.....z. .
LDA $1234,X      abs,X      BD  3   6-m-x+x*p   n.....z. .
LDA $1234,Y      abs,Y      B9  3   6-m-x+x*p   n.....z. .
LDA $FEDBCA      long       AF  4   6-m         n.....z. .
LDA $FEDCBA,X    long,X     BF  4   6-m         n.....z. .
LDA ($20)        (dir)      B2  2   6-m+w       n.....z. .
LDA ($20),Y      (dir),Y    B1  2   7-m+w-x+x*p n.....z. .
LDA ($20,X)      (dir,X)    A1  2   7-m+w       n.....z. .
LDA ($20,S),Y    (stk,S),Y  B3  2   8-m         n.....z. .
LDA [$20]        [dir]      A7  2   7-m+w       n.....z. .
LDA [$20],Y      [dir],Y    B7  2   7-m+w       n.....z. .
```

Reads a value from memory into .A. This sets **n** and **z** appropriately,
allowing you to use BMI, BPL, BEQ, and BNE to act based on the value being read.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### LDX

**Load X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
LDX #$20/#$1234  imm        A2  3-x 3-x         n.....z. .
LDX $20          dir        A6  2   4-x+w       n.....z. .
LDX $20,Y        dir,Y      B6  2   5-x+w       n.....z. .
LDX $1234        abs        AE  3   5-x         n.....z. .
LDX $1234,Y      abs,Y      BE  3   6-2*x+x*p   n.....z. .
```

Read a value into .X. This sets **n** and **z** appropriately, allowing you to
use BMI, BPL, BEQ, and BNE to act based on the value being read.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### LDY

**Load X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
LDY #$20/#$1234  imm        A0  3-x 3-x         n.....z. .
LDY $20          dir        A4  2   4-x+w       n.....z. .
LDY $20,X        dir,X      B4  2   5-x+w       n.....z. .
LDY $1234        abs        AC  3   5-x         n.....z. .
LDY $1234,X      abs,X      BC  3   6-2*x+x*p   n.....z. .
```

Read a value into .Y. This sets **n** and **z** appropriately, allowing you to
use BMI, BPL, BEQ, and BNE to act based on the value being read.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### LSR

**Logical Shift Right**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
LSR              acc        4A  1   2           n.....zc .
LSR $20          dir        46  2   7-2*m+w     n.....zc .
LSR $20,X        dir,X      56  2   8-2*m+w     n.....zc .
LSR $1234        abs        4E  3   8-2*m       n.....zc .
LSR $1234,X      abs,X      5E  3   9-2*m       n.....zc .
```

Shifts all bits to the right by one position.

Bit 0 is shifted into Carry.;
0 shifted into the high bit (7 or 15, depending on the **m** flag.)

**Similar instructions:**;
[ASL](#asl) is the opposite instruction, shifting to the left.;
[ROR](#ror) rotates bit 0 through Carry to bit 7.;

+p Adds a cycle if ,X crosses a page boundary.;
+c New for the 65C02;


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### MVN

**Block Copy/Move Negative**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
MVN #$20,#$34    src,dest   54  3   7           ........ .
```

This performs a block copy. Use MVN when the source and destination ranges
overlap and dest < source.

Copying anything other than page zero requires 16-bit index registers, so it's
wise to clear **m** and **x** with `REP #$30`.

* Set .X to the source address
* Set .Y to the destination address
* Set .A to size-1
* MVN #source_bank, #dest_bank


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### MVP

**Block Copy/Move Positive**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
MVP #$20,#$34    src,dest   44  3   7           ........ .
```

This performs a block copy. Use MVP when the source and destination ranges
overlap and dest > source.

Copying anything other than page zero requires 16-bit index registers, so it's
wise to clear **m** and **x** with `REP #$30`.

* Set .X to the source_address + size - 1
* Set .Y to the destination_address
* Set .A to size-1
* MVP #source_bank, #dest_bank


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### NOP

**No Operation**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
NOP              imp        EA  1   2           ........ .
```

The CPU performs no operation. This is useful when blocking out instructions, or
reserving space for later use.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### ORA

**Boolean OR**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
ORA #$20/#$1234  imm        09  3-m 3-m         n.....z. .
ORA $20          dir        05  2   4-m+w       n.....z. .
ORA $20,X        dir,X      15  2   5-m+w       n.....z. .
ORA $20,S        stk,S      03  2   5-m         n.....z. .
ORA $1234        abs        0D  3   5-m         n.....z. .
ORA $1234,X      abs,X      1D  3   6-m-x+x*p   n.....z. .
ORA $1234,Y      abs,Y      19  3   6-m-x+x*p   n.....z. .
ORA $FEDBCA      long       0F  4   6-m         n.....z. .
ORA $FEDCBA,X    long,X     1F  4   6-m         n.....z. .
ORA ($20)        (dir)      12  2   6-m+w       n.....z. .
ORA ($20),Y      (dir),Y    11  2   7-m+w-x+x*p n.....z. .
ORA ($20,X)      (dir,X)    01  2   7-m+w       n.....z. .
ORA ($20,S),Y    (stk,S),Y  13  2   8-m         n.....z. .
ORA [$20]        [dir]      07  2   7-m+w       n.....z. .
ORA [$20],Y      [dir],Y    17  2   7-m+w       n.....z. .
```

Perform a Boolean OR operation with the operand and .A

ORA compares each bit of the operands and sets the result bit to 1 if either or
both of the two bits is 1. If both bits are 0, the result is 0.

ORA is useful for *setting* a specific bit in a byte.

Truth table for ORA:

```text
Operand 1: 1100
Operand 2: 1010
Result:    1110
```


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PEA

**Push Absolute**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PEA $2034        imm        F4  3   5           ........ .
```

PEA, PEI, and PER push values to the stack *without* affecting registers.

PEA pushes the operand value onto the stack. The literal operand is used, rather
than an address.

This seems inconsistent with the absolute address syntax, as PEA and PEI follow
their own syntax rules.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PEI

**Push Effecive Indirect Address**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PEI ($20)        dir        D4  2   6+w         ........ .
```

PEI takes a _pointer_ as an operand. The value written to the stack is the two
bytes at the supplied address.

Example:
```
; data at $20 is $1234
PEI ($20)
; pushes $1234 onto the stack.
```

The written form of PEI is inconsistent with the usual indirect mode syntax, as
PEI and PEA follow their own syntax rules.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PER

**Push Effective PC Relative Indirect Address**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PER LABEL        imm        62  3   6           ........ .
```

PER pushes the address _relative to the program counter_. This allows you to
mark the current executing location and push that to the stack.

When used in conjunctin with BRL, PER can form a reloatable JSR instruction.

Consider the following ca65 macro:

```asm65816
.macro bsr addr
per .loword(:+ - 1)
brl addr
:
.endmacro
```

This gets the address following the BRL instruction and pushes that to the
stack. See [JSR](#jsr) to understand why the -1 is required.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHA

**Push Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHA              imp        48  1   4-m         ........ .
```

Pushes the Accumulator to the stack. This will push 1 byte when **m** is 1 and
two bytes when **m** is 0 (16-bit memory/.A mode.)

An 8-bit stack push writes data at the Stack Pointer address, then moves SP down
by 1 byte.

A 16-bit push writes the high byte first, decrements the PC, then writes the low
byte, and decrements the PC again.

In Emulation mode, the Stack Pointer will always be an address in the $100-$1FF
range, so there is only room for 256 bytes on the stack. In native mode, the
stack can be anywhere in the first 64KB of RAM.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHB

**Push Data Bank register.**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHB              imp        8B  1   3           ........ .
```

The data bank register sets the top 8 bits used when reading data with LDA, LDX,
and LDY.

This is always an 8-bit operation.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHD

**Push Direct Page**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHD              imp        0B  1   4           ........ .
```

Pushes the 16-bit Direct Page register to the stack. This is useful for
preserving the location of .D before relocating Direct Page for another use
(such as an operating system routine.)


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHK

**Push Program Bank**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHK              imp        4B  1   3           ........ .
```

Pushes the Program Bank register to the stack. The Program Bank is the top 8
bits of the 24-bit Program Counter address.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHP

**Push Program Status (Flags)**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHP              imp        08  1   3           ........ .
```

The CPU writes the flags in the order `nvmx dizc`. (**e** does
not get written to the stack.)

Note: the 6502 and 65C02 use bit 4 (**x** on the '816) for the Break flag. While
**b** does get written to the stack in a BRK operation, bit 4 in .P always
reflects the state of the 8-bit-index flag. Since the flags differ slightly in
behavior, make sure your Interrupt handler code reads from the stack, not the .P
bits, when dispatching a IRQ/BRK interrupt.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHX

**Push X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHX              imp        DA  1   4-x         ........ .
```

Pushes the X register to the stack. This will push 1 byte when **x** is 1 and
two bytes when **x** is 0 (16-bit index mode.)

An 8-bit stack push writes data at the Stack Pointer address, then moves SP down
by 1 byte. A 16-bit stack push moves the stack pointer down 2 bytes.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PHY

**Push Y Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PHY              imp        5A  1   4-x         ........ .
```

Pushes the Y register to the stack. This will push 1 byte when **y** is 1 and
two bytes when **y** is 0 (16-bit index mode.)

An 8-bit stack push writes data at the Stack Pointer address, then moves SP down
by 1 byte. A 16-bit stack push moves the stack pointer down 2 bytes.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLA

**Pull Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLA              imp        68  1   5-m         n.....z. .
```

Pulls the Accumulator from the stack.

In the opposite of PHA, the PLA instruction reads the current value from the
stack and _increments_ the stack pointer by 1 or 2 bytes.

The number of bytes read is based on the value of the **m** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLB

**Pull Data Bank Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLB              imp        AB  1   4           n.....z. .
```

Pull the Data Bank register from the stack.

In the opposite of PHB, the PLB instruction reads the current value from the
stack and _increments_ the stack pointer by 1 byte.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLD

**Pull Direct Page Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLD              imp        2B  1   5           n.....z. .
```

This pulls a word from the stack and loads it into the Direct Page register.

That value can be placed on the stack in several ways, such as PHA, PHX, or PEA.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLP

**Pull Prgram Status Byte (flags)**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLP              imp        28  1   4           nvmxdizc .
```

This reads the flags back from the stack. Since the flags affect the state of
the **m** and **x** register-width flags, this should be performed *before* a
PLA, PLX, or PLY operation.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLX

**Pull X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLX              imp        FA  1   5-x         n.....z. .
```

Pulls the X Register from the stack.

In the opposite of PHX, the PLX instruction reads the current value from the
stack and _increments_ the stack pointer by 1 or 2 bytes.

The number of bytes read is based on the value of the **x** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### PLY

**Pull Y Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
PLY              imp        7A  1   5-x         n.....z. .
```

Pulls the Y Register from the stack.

In the opposite of PHY, the PLY instruction reads the current value from the
stack and _increments_ the stack pointer by 1 or 2 bytes.

The number of bytes read is based on the value of the **x** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### REP

**Reset Program Status Bit**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
REP #$20/#$1234  imm        C2  2   3           nvmxdizc .
```

This clears (to 0) flags in the Program Status Byte. The 1 bits in the will be
cleared in the flags, so REP #$30 will set the **a** and **x** bits low.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### ROL

**Rotate Left**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
ROL              acc        2A  1   2           n.....zc .
ROL $20          dir        26  2   7-2*m+w     n.....zc .
ROL $20,X        dir,X      36  2   8-2*m+w     n.....zc .
ROL $1234        abs        2E  3   8-2*m       n.....zc .
ROL $1234,X      abs,X      3E  3   9-2*m       n.....zc .
```

Shifts bits in the accumulator or memory left one bit. The Carry bit (**c**) is
shifted into bit 0. The high bit (7 or 15) is shifted into **c**.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### ROR

**Rotate Right**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
ROR              acc        6A  1   2           n.....zc .
ROR $20          dir        66  2   7-2*m+w     n.....zc .
ROR $20,X        dir,X      76  2   8-2*m+w     n.....zc .
ROR $1234        abs        6E  3   8-2*m       n.....zc .
ROR $1234,X      abs,X      7E  3   9-2*m       n.....zc .
```

Shifts bits in the accumulator or memory right one bit. The Carry bit (**c**) is
shifted into the high bit (15 or 7). The low bit (0) is shifted into **c**.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### RTI

**Return From Interrupt**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
RTI              imp        40  1   7-e         nvmxdizc .
```

This returns control to the executing program. The following steps happen, in
order:

1. The CPU pulls the flags from the stack (including **m** and **x**, which
switch to 8/16 bit mode, as appropriate.
2. The CPU pulls the Program Counter from the stack.
3. If the CPU is in native mode, the CPU pulls the Program Bank register.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### RTL

**Return From Subroutine Long**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
RTL              imp        6B  1   6           ........ .
```

This returns to the caller at the end of a subroutine. This should be used to
return to the instruction following a [JSL](#jsl) instruction.

This reads 3 bytes from the stack and loads them into the Program Counter and
Program Bank register. The next instruction executed will then be the
instruction after the JSL that jumped to the subroutine.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### RTS

**Return From Subroutine**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
RTS              imp        60  1   6           ........ .
```

Return to to a calling routine after a [JSR](#jsr).

RTS reads a 2 byte address from the stack and loads that address into the
Program Counter. The next instruction executed will then be the
instruction after the JSR that jumped to the subroutine.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### SBC

**Subtract With Carry**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
SBC #$20/#$1234  imm        E9  3-m 3-m         nv....zc .
SBC $20          dir        E5  2   4-m+w       nv....zc .
SBC $20,X        dir,X      F5  2   5-m+w       nv....zc .
SBC $20,S        stk,S      E3  2   5-m         nv....zc .
SBC $1234        abs        ED  3   5-m         nv....zc .
SBC $1234,X      abs,X      FD  3   6-m-x+x*p   nv....zc .
SBC $1234,Y      abs,Y      F9  3   6-m-x+x*p   nv....zc .
SBC $FEDBCA      long       EF  4   6-m         nv....zc .
SBC $FEDCBA,X    long,X     FF  4   6-m         nv....zc .
SBC ($20)        (dir)      F2  2   6-m+w       nv....zc .
SBC ($20),Y      (dir),Y    F1  2   7-m+w-x+x*p nv....zc .
SBC ($20,X)      (dir,X)    E1  2   7-m+w       nv....zc .
SBC ($20,S),Y    (stk,S),Y  F3  2   8-m         nv....zc .
SBC [$20]        [dir]      E7  2   7-m+w       nv....zc .
SBC [$20],Y      [dir],Y    F7  2   7-m+w       nv....zc .
```

Subtract a value from .A. The result is left in .A.

When performing subtraction, the Carry bit indicates a Borrow and operates in
reverse from addition: when **c** is 0, SBC subtracts one from the final result,
to account for the borrow.

After the operation, **c** will be set to 0 if a borrow took place and 1 if it
did not.

When **m** is 0, this will be a 16 bit add, and the CPU will read two bytes from
memory.

Since there is no "subtract with no carry", you should always use SEC before the
first SBC in a sequence, to ensure that the Carry bit is _set_, going into a
subtraction.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### SEC

**Set Carry**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
SEC              imp        38  1   2           .......c .
```

Sets the Carry bit to 1


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### SED

**Set Decimal**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
SED              imp        F8  1   2           ....d... .
```

Sets the Decimal bit to 1, setting the CPU to BCD mode.

In binary mode, adding 1 to $09 will set the Accumulator to $0A. In BCD mode,
adding 1 to $09 will set the Accumulator to $10.

Using BCD allows for easier conversion of binary numbers to decimal. BCD also
allows for storing decimal numbers without loss of precision due to power-of-2
rounding.

Also, a math operation (ADC or SBC) is required to actually trigger BCD
conversion. So if you have a number like $1A on the accumulator and you SED, you
will need to ADC #$00 to actually convert .A to $20.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### SEI

**Set IRQ Disable**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
SEI              imp        78  1   2           .....i.. .
```

Sets **i**, which inhibits IRQ handling. When **i** is set, the CPU will not
respond to the IRQ pin. When **i** is clear, the CPU will perform an interrupt
when the IRQ pin is asserted.

The **i** flag operates somewhat non-intuitively: when **i** is set (1), IRQ is
suppressed. When **i** is clear (0), interrupts are handled. So CLI _allows_
interrupts to be handled and SEI _blocks_ interrupt handling.

See [BRK](#brk) for a brief description of interrupts.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### SEP

**Set Processor Status Bit**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
SEP #$20/#$1234  imm        E2  2   3           nvmxdizc .
```

Reset Program Status Bit

This sets (to 1) a flag in the Program Status Byte. The operand value will be
loaded into the flags, so SEP #$30 will set the **a** and **x** bits high.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### STA

**Store Accumulator to Memory**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
STA $20          dir        85  2   4-m+w       ........ .
STA $20,X        dir,X      95  2   5-m+w       ........ .
STA $20,S        stk,S      83  2   5-m         ........ .
STA $1234        abs        8D  3   5-m         ........ .
STA $1234,X      abs,X      9D  3   6-m         ........ .
STA $1234,Y      abs,Y      99  3   6-m         ........ .
STA $FEDBCA      long       8F  4   6-m         ........ .
STA $FEDCBA,X    long,X     9F  4   6-m         ........ .
STA ($20)        (dir)      92  2   6-m+w       ........ .
STA ($20),Y      (dir),Y    91  2   7-m+w       ........ .
STA ($20,X)      (dir,X)    81  2   7-m+w       ........ .
STA ($20,S),Y    (stk,S),Y  93  2   8-m         ........ .
STA [$20]        [dir]      87  2   7-m+w       ........ .
STA [$20],Y      [dir],Y    97  2   7-m+w       ........ .
```

Stores the value in .A to a memory address.

When **m** is 0, the value saved will be a 16-bit number, using two bytes of
memory. When **m** is 1, the value will be an 8-bit number, using one byte of
RAM.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### STP

**Stop the Clock**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
STP              imp        DB  1   3           ........ .
```

Halts the CPU. The CPU will no longer process instructions until the Reset pin
is asserted.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### STX

**Store Index X to Memory**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
STX $20          dir        86  2   4-x+w       ........ .
STX $20,Y        dir,Y      96  2   5-x+w       ........ .
STX $1234        abs        8E  3   5-x         ........ .
```

Stores the value in .X to a memory address.

When the flag **x** is 0, the value saved will be a 16-bit number, using two
bytes of memory. When **x** is 1, the value will be an 8-bit number, using one
byte of RAM.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### STY

**Store Index Y to Memory**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
STY $20          dir        84  2   4-x+w       ........ .
STY $20,X        dir,X      94  2   5-x+w       ........ .
STY $1234        abs        8C  3   5-x         ........ .
```

Stores the value in .Y to a memory address.

When the flag **x** is 0, the value saved will be a 16-bit number, using two
bytes of memory. When **x** is 1, the value will be an 8-bit number, using one
byte of RAM.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### STZ

**Store Sero to Memory**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
STZ $20          dir        64  2   4-m+w       ........ .
STZ $20,X        dir,X      74  2   5-m+w       ........ .
STZ $1234        abs        9C  3   5-m         ........ .
STZ $1234,X      abs,X      9E  3   6-m         ........ .
```

Stores a zero to a memory address.

When **m** is 0, the value saved will be a 16-bit number, using two bytes of
memory. When **m** is 1, the value will be an 8-bit number, using one byte of
RAM.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TAX

**Transfer Accumulator to Index X**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TAX              imp        AA  1   2           n.....z. .
```

Copies the contents of .A to .X.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TAY

**Transfer Accumulator to Index Y**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TAY              imp        A8  1   2           n.....z. .
```

Copies the contents of .A to .Y.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TCD

**Transfer C Accumulator to Direct Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TCD              imp        5B  1   2           n.....z. .
```

This copies the 16-bit value from the 16-bit Accumulator to the Direct Register,
allowing you to relocate Direct Page anywhere in the first 64K of RAM.

This is one of the times that the 16-bit Accumulator is called .C, as it always
operates on a 16-bit value, regardless of the state of the **m** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TCS

**Transfer C Accumulator to Stack Pointer**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TCS              imp        1B  1   2           ........ .
```

This copies the 16-bit value from the 16-bit Accumulator to the Stack Pointer,
allowing you to relocate the stack anywhere in the first 64K of RAM.

This is one of the times that the 16-bit Accumulator is called .C, as it always
operates on a 16-bit value, regardless of the state of the **m** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TDC

**Transfer Direct Register to C Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TDC              imp        7B  1   2           n.....z. .
```

Copies the value of the Direct Register to the Accumulator.

This is one of the times that the 16-bit Accumulator is called .C, as it always
operates on a 16-bit value, regardless of the state of the **m** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TRB

**Test and Reset Bit**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TRB $20          dir        14  2   7-2*m+w     ......z. .
TRB $1234        abs        1C  3   8-2*m       ......z. .
```

TRB does two things with one operation: it tests specified bits in a memory
location, and it clears (resets) those bits after the test.

First, TRB performs a logical AND between the memory address specified and the
Accmulator. If the result of the AND is zero, the **z** flag will be set.

Second, TRB clears bits in the memory value based on the bit mask in the
accmulator. Any bit that is 1 in .A will be changed to 0 in memory.

So to _clear_ a bit in a memory value, set that value to 1 in .A, like this:

```
; memory at $2000 contains $84
LDA #$80
TRB $2000
; memory at $2000 now contains $04, and z flag is clear

; memory at $1234 contains $20
LDA #$01
TRB $1234
; memory at $1234 contains $20 and z flag is set
; because $20 AND $01 == 0.
```


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TSB

**Test and Set Bit**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TSB $20          dir        04  2   7-2*m+w     ......z. .
TSB $1234        abs        0C  3   8-2*m       ......z. .
```

TSB does two things with one operation: it tests specified bits in a memory
location, and it clears (resets) those bits after the test.

First, TSB performs a logical AND between the memory address specified and the
Accmulator. If the result of the AND is zero, the **z** flag will be set.

TSB also _sets_ the bits that are 1 in the accumulator, similar to an OR
operation.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TSC

**Transfer Stack Pointer to C accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TSC              imp        3B  1   2           n.....z. .
```

Copies the Stack Pointer to the 16-bit Accumulator.

This is one of the times that the 16-bit Accumulator is called .C, as it always
operates on a 16-bit value, regardless of the state of the **m** flag.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TSX

**Transfer Stack Pointer X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TSX              imp        BA  1   2           n.....z. .
```

Copies the Stack Pointer to the X register.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TXA

**Transfer X Register to Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TXA              imp        8A  1   2           n.....z. .
```

Copies the value in .X to .A


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TXS

**Transfer X Register to Stack Pointer**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TXS              imp        9A  1   2           ........ .
```

Copies the X register to the Stack Pointer. This is used to reset the stack to a
known location, usually at boot or when context-switching.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TXY

**Transfer X Register to Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TXY              imp        9B  1   2           n.....z. .
```

Copies the value in .X to .Y


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TYA

**Transfer Y Register to Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TYA              imp        98  1   2           n.....z. .
```

Copies the value in .Y to .A


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### TYX

**Transfer Y Register to X Register**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
TYX              imp        BB  1   2           n.....z. .
```

Copies the value in .Y to .X


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### WAI

**Wait For Interrupt**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
WAI              imp        CB  1   3           ........ .
```

Stops the CPU until the next interrupt is triggered. This allows the CPU to
respond to an interrupt immediately, rather than waiting for an instruction to
complete.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### WDM

**WDM**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
WDM              imm        42  2   2           ........ .
```

WDM is a 2 byte NOP: the WDM opcode and the operand byte following are both
read, but not executed.

The WDM opcode is reserved for future use and should be avoided in 65C816
programs.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### XBA

**Exchange B and A Accumulator**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
XBA              imp        EB  1   3           n.....z. .
```

Swaps the values in .A and .B. This exchanges the high and low bytes of the
Accumulator. XBA functions the same in both 8 and 16 bit modes.


[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---

### XCE

**Exchange Carry and Emulation Flags**

```text
SYNTAX           MODE       HEX LEN CYCLES      FLAGS   
XCE              imp        FB  1   2           .......c e
```

This allows the CPU to switch between Native and Emulation modes.

To switch into native mode:

```asm65816
CLC
XCE
```

To switch to 65C02 emulation mode:

```asm65816
SEC
XCE
```

[[Opcodes](#instructions-by-opcode)] [[By Name](#instructions-by-name)] [[By Category](#instructions-by-category)]

---


<!-- For PDF formatting -->
<div class="page-break"></div>
