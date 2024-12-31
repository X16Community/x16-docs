
# Appendix C: The 65C02 Processor

This is not meant to be a complete manual on the 65C02 processor, though is
meant to serve as a convenient quick reference. Much of this information comes
from 6502.org and pagetable.com. It is been placed here for convenience though
further information can be found at those (and other) sources.

## Overview

The WDC65C02 CPU is a modern version of the MOS6502 with a few additional
instructions and addressing modes and is capable of running at up to 14 MHz. On
the Commander X16, it is clocked at 8 MHz.

## A note about 65C816 Compatibility

The Commander X16 may be upgraded at some point to use the WDC 65C816 CPU.
The 65C816 is mostly compatible with the 65C02, except for 4 instructions
(`BBRx`, `BBSx`, `RMBx`, and `SMBx`).

These instructions *may* be deprecated in a future release of the emulator, and
so we suggest not using these instructions. Some people are already using the
65C816 in their X16 systems, and so using these instructions will cause your
programs to malfunction on these computers.

## Instruction Tables

## Instructions By Number

|    | x0          | x1          | x2          | x3 | x4          | x5          | x6          | x7            | x8          | x9          | xA          | xB          | xC          | xD          | xE          | xF            |
|----|-------------|-------------|-------------|----|-------------|-------------|-------------|---------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|---------------|
| 0x | [BRK](#brk) | [ORA](#ora) |             |    | [TSB](#tsb) | [ORA](#ora) | [ASL](#asl) | [RMB0](#rmbx) | [PHP](#pha) | [ORA](#ora) | [ASL](#asl) |             | [TSB](#tsb) | [ORA](#ora) | [ASL](#asl) | [BBR0](#bbrx) |
| 1x | [BPL](#bcc) | [ORA](#ora) | [ORA](#ora) |    | [TRB](#trb) | [ORA](#ora) | [ASL](#asl) | [RMB1](#rmbx) | [CLC](#clc) | [ORA](#ora) | [INC](#inc) |             | [TRB](#trb) | [ORA](#ora) | [ASL](#asl) | [BBR1](#bbrx) |
| 2x | [JSR](#jsr) | [AND](#and) |             |    | [BIT](#bit) | [AND](#and) | [ROL](#rol) | [RMB2](#rmbx) | [PLP](#pla) | [AND](#and) | [ROL](#rol) |             | [BIT](#bit) | [AND](#and) | [ROL](#rol) | [BBR2](#bbrx) |
| 3x | [BMI](#bcc) | [AND](#and) | [AND](#and) |    | [BIT](#bit) | [AND](#and) | [ROL](#rol) | [RMB3](#rmbx) | [SEC](#sec) | [AND](#and) | [DEC](#dec) |             | [BIT](#bit) | [AND](#and) | [ROL](#rol) | [BBR3](#bbrx) |
| 4x | [RTI](#rti) | [EOR](#eor) |             |    |             | [EOR](#eor) | [LSR](#lsr) | [RMB4](#rmbx) | [PHA](#pha) | [EOR](#eor) | [LSR](#lsr) |             | [JMP](#jmp) | [EOR](#eor) | [LSR](#lsr) | [BBR4](#bbrx) |
| 5x | [BVC](#bcc) | [EOR](#eor) | [EOR](#eor) |    |             | [EOR](#eor) | [LSR](#lsr) | [RMB5](#rmbx) | [CLI](#cli) | [EOR](#eor) | [PHY](#pha) |             |             | [EOR](#eor) | [LSR](#lsr) | [BBR5](#bbrx) |
| 6x | [RTS](#rts) | [ADC](#adc) |             |    | [STZ](#stz) | [ADC](#adc) | [ROR](#ror) | [RMB6](#rmbx) | [PLA](#pla) | [ADC](#adc) | [ROR](#ror) |             | [JMP](#jmp) | [ADC](#adc) | [ROR](#ror) | [BBR6](#bbrx) |
| 7x | [BVS](#bcc) | [ADC](#adc) | [ADC](#adc) |    | [STZ](#stz) | [ADC](#adc) | [ROR](#ror) | [RMB7](#rmbx) | [SEI](#sei) | [ADC](#adc) | [PLY](#pla) |             | [JMP](#jmp) | [ADC](#adc) | [ROR](#ror) | [BBR7](#bbrx) |
| 8x | [BRA](#bcc) | [STA](#sta) |             |    | [STY](#sty) | [STA](#sta) | [STX](#stx) | [SMB0](#smbx) | [DEY](#dec) | [BIT](#bit) | [TXA](#txx) |             | [STY](#sty) | [STA](#sta) | [STX](#stx) | [BBS0](#bbsx) |
| 9x | [BCC](#bcc) | [STA](#sta) | [STA](#sta) |    | [STY](#sty) | [STA](#sta) | [STX](#stx) | [SMB1](#smbx) | [TYA](#txx) | [STA](#sta) | [TXS](#txx) |             | [STZ](#stz) | [STA](#sta) | [STZ](#stz) | [BBS1](#bbsx) |
| Ax | [LDY](#ldy) | [LDA](#lda) | [LDX](#ldx) |    | [LDY](#ldy) | [LDA](#lda) | [LDX](#ldx) | [SMB2](#smbx) | [TAY](#txx) | [LDA](#lda) | [TAX](#txx) |             | [LDY](#ldy) | [LDA](#lda) | [LDX](#ldx) | [BBS2](#bbsx) |
| Bx | [BCS](#bcc) | [LDA](#lda) | [LDA](#lda) |    | [LDY](#ldy) | [LDA](#lda) | [LDX](#ldx) | [SMB3](#smbx) | [CLV](#clv) | [LDA](#lda) | [TSX](#txx) |             | [LDY](#ldy) | [LDA](#lda) | [LDX](#ldx) | [BBS3](#bbsx) |
| Cx | [CPY](#cpy) | [CMP](#cmp) |             |    | [CPY](#cpy) | [CMP](#cmp) | [DEC](#dec) | [SMB4](#smbx) | [INY](#inc) | [CMP](#cmp) | [DEX](#dec) | [WAI](#wai) | [CPY](#cpy) | [CMP](#cmp) | [DEC](#dec) | [BBS4](#bbsx) |
| Dx | [BNE](#bcc) | [CMP](#cmp) | [CMP](#cmp) |    |             | [CMP](#cmp) | [DEC](#dec) | [SMB5](#smbx) | [CLD](#cld) | [CMP](#cmp) | [PHX](#pha) | [STP](#stp) |             | [CMP](#cmp) | [DEC](#dec) | [BBS5](#bbsx) |
| Ex | [CPX](#cpx) | [SBC](#sbc) |             |    | [CPX](#cpx) | [SBC](#sbc) | [INC](#inc) | [SMB6](#smbx) | [INX](#inc) | [SBC](#sbc) | [NOP](#nop) |             | [CPX](#cpx) | [SBC](#sbc) | [INC](#inc) | [BBS6](#bbsx) |
| Fx | [BEQ](#bcc) | [SBC](#sbc) | [SBC](#sbc) |    |             | [SBC](#sbc) | [INC](#inc) | [SMB7](#smbx) | [SED](#sed) | [SBC](#sbc) | [PLX](#pla) |             |             | [SBC](#sbc) | [INC](#inc) | [BBS7](#bbsx) |

<!-- For PDF formatting -->
<div class="page-break"></div>

## Instructions By Name

|             |             |             |               |               |             |             |               |             |             |             |             |             |             |               |             |
|-------------|-------------|-------------|---------------|---------------|-------------|-------------|---------------|-------------|-------------|-------------|-------------|-------------|-------------|---------------|-------------|
| [ADC](#adc) | [AND](#and) | [ASL](#asl) | [BBRx](#bbrx) | [BBSx](#bbsx) | [BCC](#bcc) | [BCS](#bcc) | [BEQ](#bcc)   | [BIT](#bit) | [BMI](#bcc) | [BNE](#bcc) | [BPL](#bcc) | [BRA](#bcc) | [BRK](#brk) | [BVC](#bcc)   | [BVS](#bcc) |
| [CLC](#clc) | [CLD](#cld) | [CLI](#cli) | [CLV](#clv)   | [CMP](#cmp)   | [CPX](#cpx) | [CPY](#cpy) | [DEC](#dec)   | [DEX](#dec) | [DEY](#dec) | [EOR](#eor) | [INC](#inc) | [INX](#inc) | [INY](#inc) | [JMP](#jmp)   | [JSR](#jsr) |
| [LDA](#lda) | [LDX](#ldx) | [LDY](#ldy) | [LSR](#lsr)   | [NOP](#nop)   | [ORA](#ora) | [PHA](#pha) | [PHP](#pha)   | [PHX](#pha) | [PHY](#pha) | [PLA](#pla) | [PLP](#pla) | [PLX](#pla) | [PLY](#pla) | [RMBx](#rmbx) | [ROL](#rol) |
| [ROR](#ror) | [RTI](#rti) | [RTS](#rts) | [SBC](#sbc)   | [SEC](#sec)   | [SED](#sed) | [SEI](#sei) | [SMBx](#smbx) | [STA](#sta) | [STP](#stp) | [STX](#stx) | [STY](#sty) | [STZ](#stz) | [TAX](#txx) | [TAY](#txx)   | [TRB](#trb) |
| [TSB](#tsb) | [TSX](#txx) | [TXA](#txx) | [TXS](#txx)   | [TYA](#txx)   | [WAI](#wai) |             |               |             |             |             |             |             |             |               |             |

## Instructions By Category

|                     |               |               |             |             |             |             |             |             |             |
|---------------------|---------------|---------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|
| Arithmetic          | [ADC](#adc)   | [SBC](#sbc)   |             |             |             |             |             |             |             |
| Boolean             | [AND](#and)   | [EOR](#eor)   | [ORA](#ora) |             |             |             |             |             |             |
| Bit Shift           | [ASL](#asl)   | [LSR](#lsr)   | [ROL](#rol) | [ROR](#ror) |             |             |             |             |             |
| Branch              | [BBRx](#bbrx) | [BBSx](#bbsx) |             |             |             |             |             |             |             |
| Test Bit            | [BIT](#bit)   | [TRB](#trb)   | [TSB](#tsb) |             |             |             |             |             |             |
| Branching           | [BCC](#bcc)   | [BCS](#bcc)   | [BEQ](#bcc) | [BMI](#bcc) | [BNE](#bcc) | [BPL](#bcc) | [BVC](#bcc) | [BVS](#bcc) | [BRA](#bcc) |
| Misc                | [BRK](#brk)   | [NOP](#nop)   | [STP](#stp) | [WAI](#wai) |             |             |             |             |             |
| Flags               | [CLC](#clc)   | [CLD](#cld)   | [CLI](#cli) | [CLV](#clv) | [SEC](#sec) | [SED](#sed) | [SEI](#sei) |             |             |
| Compare             | [CMP](#cmp)   | [CPX](#cpx)   | [CPY](#cpy) |             |             |             |             |             |             |
| Increment/Decrement | [DEC](#dec)   | [DEX](#dec)   | [DEY](#dec) | [INX](#inc) | [INY](#inc) | [INC](#inc) |             |             |             |
| Flow                | [JMP](#jmp)   | [JSR](#jsr)   | [RTI](#rti) | [RTS](#rts) |             |             |             |             |             |
| Load Data           | [LDA](#lda)   | [LDX](#ldx)   | [LDY](#ldy) |             |             |             |             |             |             |
| Stack               | [PHA](#pha)   | [PHP](#pha)   | [PHX](#pha) | [PHY](#pha) | [PLA](#pla) | [PLP](#pla) | [PLX](#pla) | [PLY](#pla) |             |
| Bit Operations      | [RMBx](#rmbx) | [SMBx](#smbx) |             |             |             |             |             |             |             |
| Store Data          | [STA](#sta)   | [STX](#stx)   | [STY](#sty) | [STZ](#stz) |             |             |             |             |             |
| Transfer            | [TAX](#txx)   | [TXA](#txx)   | [TAY](#txx) | [TYA](#txx) | [TSX](#txx) | [TXS](#txx) |             |             |             |

<!-- For PDF formatting -->
<div class="page-break"></div>

### ADC

Add with Carry

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
ADC #$20     Immediate      $69   2     2     NV----ZC 
ADC $20      Zero Page      $65   2     3     NV----ZC 
ADC $20,X    Zero Page,X    $75   2     4     NV----ZC 
ADC $8080    Absolute       $6D   3     4     NV----ZC 
ADC $8080,X  Absolute,X     $7D   3     4+    NV----ZC +p
ADC $8080,Y  Absolute,Y     $79   3     4+    NV----ZC +p
ADC ($20,X)  Indirect,X     $61   2     6     NV----ZC 
ADC ($20),Y  Indirect,Y     $71   2     5+    NV----ZC +p
ADC ($20)    ZP Indirect    $72   2     5     NV----ZC +c
```

Add a number to the Accumulator and stores the result in A.

Use the Carry (C) or Overflow (V) flags to determine whether the result was too
large for an 8 bit number.

If C is set before operation, then 1 will be added to the result.

C is set when result is more than 255 ($FF)  
Z is set when result is zero  
V is set when signed result is too large. (Goes below -128 or above 127).  
N is set when result is negative (bit 7=1)  

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### AND

Logical And

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
AND #$20     Immediate      $29   2     2     N-----Z- 
AND $20      Zero Page      $25   2     3     N-----Z- 
AND $20,X    Zero Page,X    $35   2     4     N-----Z- 
AND $8080    Absolute       $2D   3     4     N-----Z- 
AND $8080,X  Absolute,X     $3D   3     4+    N-----Z- +p
AND $8080,Y  Absolute,Y     $39   3     4+    N-----Z- +p
AND ($20,X)  Indirect,X     $21   2     6     N-----Z- 
AND ($20),Y  Indirect,Y     $31   2     5+    N-----Z- +p
AND ($20)    ZP Indirect    $32   2     5     N-----Z- +c
```

Bitwise AND the provided value with the Accumulator.

- Sets N (Negative) flag if the bit 7 of the result is 1, and otherwise
clears it.
- Sets Z (Zero) is the result is zero, and otherwise clears it  

`AND #$FF` will leave A unaffected (but still set the flags).  
`AND #$00` will clear A.  
`AND #$0F` will clear the high nibble of A, leaving a value of $00 to $0F
in A.  

| M | A | Result |
|---|---|--------|
| 0 | 0 | 0      |
| 0 | 1 | 0      |
| 1 | 0 | 0      |
| 1 | 1 | 1      |

**Other Boolean Instructions:**  
[EOR](#eor) exclusive-OR  
[ORA](#ora) bitwise OR  

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### ASL

Arithmetic Shift Left

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
ASL A        Accumulator    $0A   1     2     N-----ZC 
ASL $20      Zero Page      $06   2     5     N-----ZC
ASL $20,X    Zero Page,X    $16   2     6     N-----ZC
ASL $8080    Absolute       $0E   3     6     N-----ZC
ASL $8080,X  Absolute,X     $1E   3     6+    N-----ZC +p
```

Shifts all bits to the left by one position, moving 0 into the low bit.

0 is shifted into bit 0.  
Bit 7 is shifted to Carry.  

**Similar instructions:**  
[LSR](#lsr) is the opposite instruction and shifts to the right.  
[ROL](#rol) shifts left through Carry.

+p: Add 1 cycle if a page boundary is crossed when forming address.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### BBRx

Branch on Bit Reset

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
BBR0 $20,$8080 ZP Relative    $0F   3     5     -------- +c -816
BBR1 $20,$8080 ZP Relative    $1F   3     5     -------- +c -816
BBR2 $20,$8080 ZP Relative    $2F   3     5     -------- +c -816
BBR3 $20,$8080 ZP Relative    $3F   3     5     -------- +c -816
BBR4 $20,$8080 ZP Relative    $4F   3     5     -------- +c -816
BBR5 $20,$8080 ZP Relative    $5F   3     5     -------- +c -816
BBR6 $20,$8080 ZP Relative    $6F   3     5     -------- +c -816
BBR7 $20,$8080 ZP Relative    $7F   3     5     -------- +c -816
```

Branch to LABEL if bit x of zero page address is 0 where x is the number of the
specific bit (0-7).

+c: New for the 65C02
-816: *Not available* on the 65C816  

#### BBR Example

```asm
  check_flag:
    BBR3 zeropage_flag, flag_not_set
  flag_set:
    NOP
    ...
  flag_not_set:
    NOP
    ...
```

The above BBR3 looks at value in zeropage_flag (here it's a label to an actual
zero page address) and if bit 3 of the value is *zero* the branch would be
taken to `@flag_not_set`.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### BBSx

Branch on Bit Set

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
BBS0 $20,$8080 ZP Relative    $8F   3     5     -------- +c -816
BBS1 $20,$8080 ZP Relative    $9F   3     5     -------- +c -816
BBS2 $20,$8080 ZP Relative    $AF   3     5     -------- +c -816
BBS3 $20,$8080 ZP Relative    $BF   3     5     -------- +c -816
BBS4 $20,$8080 ZP Relative    $CF   3     5     -------- +c -816
BBS5 $20,$8080 ZP Relative    $DF   3     5     -------- +c -816
BBS6 $20,$8080 ZP Relative    $EF   3     5     -------- +c -816
BBS7 $20,$8080 ZP Relative    $FF   3     5     -------- +c -816
```

Branch to LABEL if bit x of zero page address is 1 where x is the number
of the specific bit (0-7).

+c: New for the 65C02
-816: *Not available* on the 65C816  

#### BBS Example

```asm
check_flag:
    BBS3 zeropage_flag, flag_set
flag_not_set:
    NOP
    ...
flag_set:
    NOP
    ...
```

The above BBR3 looks at value in zeropage_flag (here it's a label to an actual
zero page address) and if bit 3 of the value is *zero* the branch would be
taken to `@flag_set`.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### BIT

Test Bit

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
BIT $20      Zero Page      $24   2     3     NV----Z- 
BIT $8080    Absolute       $2C   3     4     NV----Z- 
BIT #$20     Immediate      $89   2     2     ------Z- +c
BIT $20,X    Zero Page,X    $34   2     4     NV----Z- +c
BIT $8080,X  Absolute,X     $3C   3     4+    NV----Z- +c +p
```

- Sets Z (Zero) flag based on an AND of value provided to the Accumulator.
- Sets N (Negative) flag to the value of bit 7 at the provided address (NOTE: not with immediate).
- Sets V (Overflow) flag to the value of bit 6 at the provided address (NOTE: not with immediate).

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### B*cc*

Branch Instructions

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
BCC $8080    Relative       $90   2    2/3+   -------- +p Carry Clear
BCS $8080    Relative       $B0   2    2/3+   -------- +p Carry Set
BEQ $8080    Relative       $F0   2    2/3+   -------- +p Equal: Zero bit set
BMI $8080    Relative       $30   2    2/3+   -------- +p Negative bit set
BNE $8080    Relative       $D0   2    2/3+   -------- +p Not Equal: Zero bit clear
BPL $8080    Relative       $10   2    2/3+   -------- +p Negative bit clear
BVC $8080    Relative       $50   2    2/3+   -------- +p oVerflow Clear
BVS $8080    Relative       $70   2    2/3+   -------- +p oVerflow Set
BRA $8080    Relative       $80   2    3/4+   -------- +p +c Always
```

The branch instructions take the branch when the related flag is Set (1) or
Clear (0).

When combined with CMP, this is the 6502's "IF THEN" construct.

```asm
LDA $1234  ; Reads the value of address $1234
CMP #$20   ; Compares it with the literal $20 (32)
BEQ Match  ; If they are equal, move to the label "Match".
```

The operand is a *relative* address, based on the Program Counter at the start
of the next opcode. As a result, you can only branch 127 bytes forward or 128
bytes back. However, most assemblers take a label or an address literal. So
the assembled value will be computed based on the PC and the entered value.

For example, if the PC is `$1000`, the statement `BCS $1023` will be `$B0 $21`.

`BCC` also functions as "branch less-than" (`<`) after a comparison (some
assemblers support a `BLT` macro/alias).
Similarly, `BCS` also functions as "branch greater-than-or-equal" (`>=`) after
a comparison (some assemblers support a `BGE` macro/alias).

+p: Execution takes one additional cycle when branching crosses a page boundary.
+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### BRK

Break: Software Interrupt

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
BRK          Implied        $00   1     7     ---BD--- 
```

BRK is a software interrupt. With any interrupt several things happen:

1. The Program Counter is incremented by 2 bytes.
2. The new PC and flags are pushed onto the stack (pushed flags has B set on BRK).
3. The B flag is set (but only valid in stack memory flags interrupt pushed).
4. The D (Decimal) flag is cleared, forcing the CPU into binary mode.
5. The CPU reads the address from the IRQ vector at $FFFE and jumps there.

On the X16, BRK will jump out of the running program to the machine monitor.
You can then examine the state of the CPU registers and memory.

The B flag (as pushed on the stack) is used to distinguish a BRK from an NMI. An
interrupt triggered by asserting the NMI pin does not set the B flag, and so the X16
does a warm boot of BASIC, rather than jumping to MONitor.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CLC

Clear Carry

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CLC          Implied        $18   1     2     -------C 
```

Clears the Carry flag. This is useful before ADC to prevent an extra 1 during
addition. C is also often used in KERNAL routines to alter the operation of the
routine or return certain information.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CLD

Clear Decimal Flag

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CLD          Implied        $D8   1     2     ----D--- 
```

Clears the Decimal flag. This switches the CPU back to binary operation if it
was previously in BCD mode.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CLI

Clear Interrupt Disable

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CLI          Implied        $58   1     2     -----I-- 
```

Clear Interrupt disable. This allows IRQ interrupts to proceed normally. NMI
and RST are always enabled.

Use SEI to disable interrupts

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CLV

Clear oVerflow

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CLV          Implied        $B8   1     2     -V------ 
```

Clear the Overflow (V) flag after an arithmetic operation, such as ADC or SBC.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CMP

Compare A to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CMP #$20     Immediate      $C9   2     2     N-----ZC 
CMP $20      Zero Page      $C5   2     3     N-----ZC 
CMP $20,X    Zero Page,X    $D5   2     4     N-----ZC 
CMP $8080    Absolute       $CD   3     4     N-----ZC 
CMP $8080,X  Absolute,X     $DD   3     4+    N-----ZC +p
CMP $8080,Y  Absolute,Y     $D9   3     4+    N-----ZC +p
CMP ($20,X)  Indirect,X     $C1   2     6     N-----ZC 
CMP ($20),Y  Indirect,Y     $D1   2     5+    N-----ZC +p
CMP ($20)    ZP Indirect    $D2   2     5     N-----ZC +c
```

Compares the value in the Accumulator (A) with the given value. It sets flags
based on subtracting A - *Value*.

- Sets C (Carry) flag if the value in A is >= given value
- Clears C (Carry) flag if the value in A is < given value
- Sets Z (Zero) flag if the values are equal
- Clears Z (Zero) flag if the values are not equal
- Sets N (Negative) flag if value in A is < given value

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CPX

Compare X to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CPX #$20     Immediate      $E0   2     2     N-----ZC 
CPX $20      Zero Page      $E4   2     3     N-----ZC 
CPX $8080    Absolute       $EC   3     4     N-----ZC 
```

Compares the value in the X register with the given value. It sets flags
based on subtracting X - *Value*.

- Sets C (Carry) flag if the value in X is >= given value
- Clears C (Carry) flag if the value in X is < given value
- Sets Z (Zero) flag if the values are equal
- Clears Z (Zero) flag if the values are not equal
- Sets N (Negative) flag if value in X is < given value

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### CPY

Compare Y to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
CPY #$20     Immediate      $C0   2     2     N-----ZC 
CPY $20      Zero Page      $C4   2     3     N-----ZC 
CPY $8080    Absolute       $CC   3     4     N-----ZC 
```

Compares the value in the Y register with the given value. It sets flags
based on subtracting Y - *Value*.

- Sets C (Carry) flag if the value in Y is >= given value
- Clears C (Carry) flag if the value in Y is < given value
- Sets Z (Zero) flag if the values are equal
- Clears Z (Zero) flag if the values are not equal
- Sets N (Negative) flag if value in Y is < given value

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### DEC

Decrement Value

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
DEC A        Accumulator    $3A   1     2     N-----Z- +c
DEC $20      Zero Page      $C6   2     5     N-----Z- 
DEC $20,X    Zero Page,X    $D6   2     6     N-----Z- 
DEC $8080    Absolute       $CE   3     6     N-----Z- 
DEC $8080,X  Absolute,X     $DE   3     7     N-----Z- 
DEX          Implied        $CA   1     2     N-----Z- 
DEY          Implied        $88   1     2     N-----Z- 
```

Decrement value by one: this subtracts 1 from memory or the designated register,
leaving the new value in its place.

`DEC` with an operand operates on memory.

`DEX` operates on the X register  
`DEY` operates on the Y register  
`DEC A` or `DEC` operates on the Accumulator.

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

+c: New for the 65C02  

#### 16-bit DEC Example

You can perform a 16-bit DEC by chaining two DECs together, testing the low
byte before decrementing the high byte:

```asm
;16 bit decrement
      LDA Num_Low
      BNE skip
      DEC Num_High
skip: DEC Num_Low
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### EOR

Exclusive OR

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
EOR #$20     Immediate      $49   2     2     N-----Z- 
EOR $20      Zero Page      $45   2     3     N-----Z- 
EOR $20,X    Zero Page,X    $55   2     4     N-----Z- 
EOR $8080    Absolute       $4D   3     4     N-----Z- 
EOR $8080,X  Absolute,X     $5D   3     4+    N-----Z- +p
EOR $8080,Y  Absolute,Y     $59   3     4+    N-----Z- +p
EOR ($20,X)  Indirect,X     $41   2     6     N-----Z- 
EOR ($20),Y  Indirect,Y     $51   2     5+    N-----Z- +p
EOR ($20)    ZP Indirect    $52   2     5     N-----Z- +c
```

Perform an exclusive OR of the given value in A
(the accumulator), storing the result in A.

The exclusive OR version of [ORA](#ora).

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

Exclusive OR returns a 1 bit for each bit that is different in the values
tested. It returns a 0 for each bit that is the same.

`EOR #$00` has no effect on A, but still sets the Z and N flags.  
`EOR #$FF` inverts the bits in A.  

| M | A | Result |
|---|---|--------|
| 0 | 0 | 0      |
| 0 | 1 | 1      |
| 1 | 0 | 1      |
| 1 | 1 | 0      |

**Other Boolean Instructions:**  
[ORA](#ora) bitwise OR  
[AND](#and) bitwise AND  

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### INC

Increment Value

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
INC A        Accumulator    $1A   1     2     N-----Z- +c
INC $20      Zero Page      $E6   2     5     N-----Z- 
INC $20,X    Zero Page,X    $F6   2     6     N-----Z- 
INC $8080    Absolute       $EE   3     6     N-----Z- 
INC $8080,X  Absolute,X     $FE   3     6/7   N-----Z- 
INX          Implied        $E8   1     2     N-----Z- 
INY          Implied        $C8   1     2     N-----Z- 
```

Increment by one: this adds 1 to memory or the designated register, leaving the
new value in its place.

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

`INC oper` operates on memory.  
`INX` operates on the X register.  
`INY` operates on the Y register.  
`INC A` or `INC` with no operand operates on the Accumulator.  

+c: New for the 65C02  

#### 16-bit INC Example

You can perform a 16-bit INC by chaining two INCs together, testing the low
byte after incrementing it.

```asm
;16 bit increment
        INC Addr_Low
        BNE skip
        INC Addr_High
skip:   ...
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### JMP

Jump to new address

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
JMP $8080    Absolute       $4C   3     3     -------- 
JMP ($8080)  Indirect       $6C   3     5     -------- 
JMP $8080,X  Absolute,X     $7C   3     6     -------- +c
```

Jump to specified memory location and begin execution from this point.

Note for indirect jumps: The CPU does not correctly retrieve the second byte
of the pointer from the next page, so you should never use a pointer address
on the last byte of a page. ie: $12FF. *[Issue is fixed on 65C02]*

+c: New for the 65C02  

#### (Absolute,X) and Jump Tables

(Absolute,X) is an additional mode for the 65C02 and is commonly used for
implementing jump tables.

So we might have something like:

```asm
important_jump_table:
  .word routine1
  .word routine2
...

LDX #$02     ; table index * 2
JMP (important_jump_table,x)
```

The above would jump to the address of `routine2`, and is much faster than
the old 6502 method of pushing the two bytes onto the stack and performing
an RTS.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### JSR

Jump to Subroutine

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
JSR $8080    Absolute       $20   3     6     -------- 
```

Stores the address of the Program Counter to the stack.  
Jump to specified memory location and begin execution from this point.  

This is used to run subroutines in user programs, as well as running KERNAL
routines. RTS is used at the end of the routine to return to the instruction
immediately after the JSR.

Be careful to always match JSR and RTS, as imbalanced JSR/RTS operations will
either overflow or underflow the stack.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### LDA

Read memory to Accumulator

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
LDA #$20     Immediate      $A9   2     2     N-----Z- 
LDA $20      Zero Page      $A5   2     3     N-----Z- 
LDA $20,X    Zero Page,X    $B5   2     4     N-----Z- 
LDA $8080    Absolute       $AD   3     4     N-----Z- 
LDA $8080,X  Absolute,X     $BD   3     4+    N-----Z- +p
LDA $8080,Y  Absolute,Y     $B9   3     4+    N-----Z- +p
LDA ($20,X)  Indirect,X     $A1   2     6     N-----Z- 
LDA ($20),Y  Indirect,Y     $B1   2     5+    N-----Z- +p
LDA ($20)    ZP Indirect    $B2   2     5     N-----Z- +c
```

Place the given value from memory into the accumulator (A).

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### LDX

Read memory to X Index Register

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
LDX #$20     Immediate      $A2   2     2     N-----Z- 
LDX $20      Zero Page      $A6   2     3     N-----Z- 
LDX $20,Y    Zero Page,Y    $B6   2     4     N-----Z- 
LDX $8080    Absolute       $AE   3     4     N-----Z- 
LDX $8080,Y  Absolute,Y     $BE   3     4+    N-----Z- +p
```

Place the given value from memory into the X register.

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

+p: Add 1 cycle if a page boundary is crossed when forming address.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### LDY

Read memory to Y Index Register

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
LDY #$20     Immediate      $A0   2     2     N-----Z- 
LDY $20      Zero Page      $A4   2     3     N-----Z- 
LDY $20,X    Zero Page,X    $B4   2     4     N-----Z- 
LDY $8080    Absolute       $AC   3     4     N-----Z- 
LDY $8080,X  Absolute,X     $BC   3     4+    N-----Z- +p
```

Place the given value from memory into the Y register.

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

+p: Add 1 cycle if a page boundary is crossed when forming address.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### LSR

Logical Shift Right

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
LSR A        Accumulator    $4A   1     2     N-----Z- 
LSR $20      Zero Page      $46   2     5     N-----Z- 
LSR $20,X    Zero Page,X    $56   2     6     N-----Z- 
LSR $8080    Absolute       $4E   3     6     N-----Z- 
LSR $8080,X  Absolute,X     $5E   3    6/7    N-----Z-
```

Shifts all bits to the right by one position.

Bit 0 is shifted into Carry.  
0 shifted into bit 7.  

**Similar instructions:**  
[ASL](#asl) is the opposite instruction, shifting to the left.  
[ROR](#ror) rotates bit 0 through Carry to bit 7.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### NOP

No Operation

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
NOP          Implied        $EA   1     2     -------- 
```

NOP simply does nothing for 2 clock cycles. No registers are affected, and no
memory reads or writes occur. This can be used to delay the clock by 2 ticks.

It's also a useful way to blank out unwanted instructions in memory or in
a machine language program on disk. By changing the byte values of the opcode
and operands to $EA, you can effectively cancel out an instruction.

It is also useful for adding small delays to your code. For instance, to add a
bit of delay when writing to the YM2151 chip (see [Chapter 11 - YM Write Procedure](X16%20Reference%20-%2011%20-%20Sound%20Programming.md#vera-psg-and-pcm-programming)).

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### ORA

Logical OR

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
ORA #$20     Immediate      $09   2     2     N-----Z- 
ORA $20      Zero Page      $05   2     3     N-----Z- 
ORA $20,X    Zero Page,X    $15   2     4     N-----Z- 
ORA $8080    Absolute       $0D   3     4     N-----Z- 
ORA $8080,X  Absolute,X     $1D   3     4+    N-----Z- +p
ORA $8080,Y  Absolute,Y     $19   3     4+    N-----Z- +p
ORA ($20,X)  Indirect,X     $01   2     6     N-----Z- 
ORA ($20),Y  Indirect,Y     $11   2     5+    N-----Z- +p
ORA ($20)    ZP Indirect    $12   2     5     N-----Z- +c
```

Perform a logical OR of the given value in A
(the Accumulator), storing the result in A.

- Sets N (Negative) flag if the two's compliment value is negative
- Sets Z (Zero) flag is the value is zero

`OR #$00` has no effect on A, but still sets the Z and N flags.  
`OR #$FF` results in $FF.

| M | A | Result |
|---|---|--------|
| 0 | 0 | 0      |
| 0 | 1 | 1      |
| 1 | 0 | 1      |
| 1 | 1 | 1      |

**Other Boolean Instructions:**  
[EOR](#eor) exclusive-OR  
[AND](#and) bitwise AND  

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### PHA

Push to stack

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
PHA          Implied        $48   1     3     -------- 
PHP          Implied        $08   1     3     -------- 
PHX          Implied        $DA   1     3     -------- +c
PHY          Implied        $5A   1     3     -------- +c
```

Pushes a register to the stack.

This instruction copies the value in the affected register to the address
of the stack pointer, then moves the stack pointer downward by one byte.

Be careful to match Push and Pull operations so that you don't accidentally
overflow or underflow the stack.

PHP pushes the Flags, also called P for Program Status Register.

The corresponding "Pull" instructions are [PLA](#pla), [PHP](#pla), [PHX](#pla),
and [PHY](#pla).

+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### PLA

Pull from stack

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
PLA          Implied        $68   1     4     N-----Z- 
PLP          Implied        $28   1     4     NV--DIZC 
PLX          Implied        $FA   1     4     N-----Z- +c
PLY          Implied        $7A   1     4     N-----Z- +c
```

Pulls a value from the stack into a register.

This instruction moves the stack pointer up by one byte, then copies the value
from the address of the stack pointer to the affected register.

Be careful to match Push and Pull operations so that you don't accidentally
overflow or underflow the stack.

PLP pulls the Flags, also called P for Program Status Register.

Use TXS or TSX to directly manage the stack pointer.

The corresponding "Push" instructions are [PHA](#pha), [PHP](#pha), [PHX](#pha),
and [PHY](#pha).

+c: New for the 65C02  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### RMBx

Memory Bit Operations

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
RMB0 $20     Zero Page      $07   2     5     -------- +c -816
RMB1 $20     Zero Page      $17   2     5     -------- +c -816
RMB2 $20     Zero Page      $27   2     5     -------- +c -816
RMB3 $20     Zero Page      $37   2     5     -------- +c -816
RMB4 $20     Zero Page      $47   2     5     -------- +c -816
RMB5 $20     Zero Page      $57   2     5     -------- +c -816
RMB6 $20     Zero Page      $67   2     5     -------- +c -816
RMB7 $20     Zero Page      $77   2     5     -------- +c -816
```

Set bit x to 0 at the given zero page address where x is the number of the
specified bit (0-7).

Often used in conjunction with [BBR](#bbrx) and [BBS](#bbsx).

+c: New for the 65C02
-816: *Not available* on the 65C816  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### ROL

Rotate Left

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
ROL A        Accumulator    $2A   1     2     N-----ZC 
ROL $20      Zero Page      $26   2     5     N-----ZC 
ROL $20,X    Zero Page,X    $36   2     6     N-----ZC 
ROL $8080    Absolute       $2E   3     6     N-----ZC 
ROL $8080,X  Absolute,X     $3E   3    6/7    N-----ZC +p
```

Rotate all bits to the left one position. The value in the carry (C) flag is
shifted into bit 0 and the original bit 7 is shifted into the carry (C).

[ASL](#asl) shifts left, moving 0 into bit 0  
[ROR](#ror) rotates to the right.

+p: Add 1 cycle if a page boundary is crossed when forming address.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### ROR

Rotate Right

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
ROR A        Accumulator    $6A   1     2     N-----ZC 
ROR $20      Zero Page      $66   2     5     N-----ZC 
ROR $20,X    Zero Page,X    $76   2     6     N-----ZC 
ROR $8080    Absolute       $7E   3     6     N-----ZC 
ROR $8080,X  Absolute,X     $6E   3    6/7    N-----ZC +p
```

Rotate all bits to the right one position. The value in
the carry (C) flag is shifted into bit 7 and the original
bit 0 is shifted into the carry (C).

[LSR](#lsr) shifts right, placing 0 into bit 7.  
[ROL](#rol) rotates to the left.  

+p: Add 1 cycle if a page boundary is crossed when forming address.  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### RTI

Return from Interrupt

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
RTI          Implied        $40   1     6     -------- 
```

Return from an interrupt by popping three values off the stack.
The first is for the status register (P) followed by the two bytes of the
program counter.

Note that unlike [RTS](#rts), the popped address is the actual
return address (rather than address-1).

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### RTS

Return from Subroutine

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
RTS          Implied        $60   1     6     -------- 
```

Typically used at the end of a subroutine. It jumps
back to the address after the [JSR](#jsr) that called it
by popping the top 2 bytes off the stack and transferring
control to that address +1.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### SBC

Subtract With Carry

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
SBC #$20     Immediate      $E9   2     2     NV----ZC 
SBC $20      Zero Page      $E5   2     3     NV----ZC 
SBC $20,X    Zero Page,X    $F5   2     4     NV----ZC 
SBC $8080    Absolute       $ED   3     4     NV----ZC 
SBC $8080,X  Absolute,X     $FD   3     4+    NV----ZC +p
SBC $8080,Y  Absolute,Y     $F9   3     4+    NV----ZC +p
SBC ($20,X)  Indirect,X     $E1   2     6     NV----ZC 
SBC ($20),Y  Indirect,Y     $F1   2     5+    NV----ZC +p
SBC ($20)    ZP Indirect    $F2   2     5     NV----ZC +c
```

Subtract the operand from A and places the result in A.

When Carry is 0, an additional 1 is subtracted.

There is no "Subtract without carry". To do that, use SEC first to set the Carry
flag.

If D=1, subtraction is Binary Coded Decimal. If D=0 then subtraction is binary.

C is clear when result is less than 0. (ie: Borrow took place)  
Z is set when result is zero  
V is set when signed result goes below -128 or above 127.  
N is set when result is negative (bit 7=1)  

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### SEC

Set Carry

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
SEC          Implied        $38   1     2     -------C 
```

Sets the Carry flag. This is used before SBC to prevent an extra subtract. C
is also often used in KERNAL routines to alter the operation of the routine
or return certain information.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### SED

Set Decimal

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
SED          Implied        $F8   1     2     ----D--- 
```

Sets the Decimal flag. This will put the CPU in BCD mode, which affects the
behavior of ADC and SBC.

In binary mode, adding 1 to $09 will set the Accumulator to $0F.  
In BCD mode, adding 1 to $09 will set the Accumulator to $10.  

Using BCD allows for easier conversion of binary numbers to decimal. BCD also
allows for storing decimal numbers without loss of precision due to power-of-2
rounding.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### SEI

Set Interrupt Disable

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
SEI          Implied        $78   1     2     -----I-- 
```

Sets or clears the Interrupt Disable flag. When I is set, the CPU will not
execute IRQ interrupts, even if the line is asserted. Use CLI to re-enable
interrupts.

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### SMBx

Set Memory Bit

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
SMB0 $20     Zero Page      $87   2     5     -------- +c -816
SMB1 $20     Zero Page      $97   2     5     -------- +c -816
SMB2 $20     Zero Page      $A7   2     5     -------- +c -816
SMB3 $20     Zero Page      $B7   2     5     -------- +c -816
SMB4 $20     Zero Page      $C7   2     5     -------- +c -816
SMB5 $20     Zero Page      $D7   2     5     -------- +c -816
SMB6 $20     Zero Page      $E7   2     5     -------- +c -816
SMB7 $20     Zero Page      $F7   2     5     -------- +c -816
```

Set bit x to 1 at the given zero page address where x is the number
of the specific bit (0-7).

Often used in conjunction with [BBR](#bbrx) and [BBS](#bbsx).

Specific to the 65C02 (*unavailable on the 65C816*)

+c: New for the 65C02
-816: *Not available* on the 65C816  

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### STA

Store Accumulator contents to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
STA $20      Zero Page      $85   2     3     -------- 
STA $20,X    Zero Page,X    $95   2     4     -------- 
STA $8080    Absolute       $8D   3     4     -------- 
STA $8080,X  Absolute,X     $9D   3     5+    -------- +p
STA $8080,Y  Absolute,Y     $99   3     5+    -------- +p
STA ($20,X)  Indirect,X     $81   2     6     -------- 
STA ($20),Y  Indirect,Y     $91   2     6+    -------- +p
STA ($20)    ZP Indirect    $92   2     5     -------- +c
```

Place the given value from the accumulator (A) into memory.

+p: Add 1 cycle if a page boundary is crossed when forming address.  
+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### STP

Stop

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
STP          Implied        $DB   1     3     -------- +c
```

Stops (or halts) the processor and places it in a lower power state until a
hardware reset occurs. For the X16 emulator, when the debugger is enabled
using the `-debug` command-line parameter, the STP instruction will break into
the debugger automatically.

If debugging is not enabled, the emulator will prompt the user to close the
emulator or reset the emulation.

+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### STX

Save X Index Register contents to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
STX $20      Zero Page      $86   2     3     -------- 
STX $20,Y    Zero Page,Y    $96   2     4     -------- 
STX $8080    Absolute       $8E   3     4     -------- 
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### STY

Save Y Index Register contents to memory

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
STY $20      Zero Page      $84   2     3     -------- 
STY $20,X    Zero Page,X    $94   2     4     -------- 
STY $8080    Absolute       $8C   3     4     -------- 
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### STZ

Set memory to zero

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
STZ $20      Zero Page      $64   2     3     -------- +c
STZ $20,X    Zero Page,X    $74   2     4     -------- +c
STZ $8080    Absolute       $9C   3     4     -------- +c
STZ $8080,X  Absolute,X     $9E   3     5     -------- +c
```

+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### TRB

Test and reset bit

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
TRB $20      Zero Page      $14   2     5     ------Z- +c
TRB $8080    Absolute       $1C   3     5     ------Z- +c
```

Effectively an inverted AND between memory and the Accumulator. The bits that
are 1 in the Accumulator are set to 0 in memory.

- Sets Z (Zero) flag if all bits from the AND are zero.

+c: New for the 65C02

#### TRB Example

```asm
          ; Assume location $20 has a value of $11.
LDA #$01  ; Load a bit mask of 0000 0001
TRB $20   ; Apply the mask and reset bit 0
          ; Location $20 now has a value of $10.
```

This is conceptually similar to

```asm
LDA #$01 ; We want to clear bit 1 of the data
EOR #$FF ; Invert the mask, so $01 becomes $FE (1111 1110)
AND $20  ; AND with memory, saving the result in .A
STA $20  ; Store it back to memory.
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### TSB

Test and set bit

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
TSB $20      Zero Page      $04   2     5     ------Z- +c
TSB $8080    Absolute       $0C   3     5     ------Z- +c
```

Performs an OR with each bit in the accumulator and memory.
Each bit that is 1 in the Accumulator is set to 1 in memory. This is similar to
an ORA operation, except that the result is stored in memory, not in A.

The Z flag is set based on the final result of the operation, ie: the memory
data is 0.

+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### Txx

Transfer between registers

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
TAX          Implied        $AA   1     2     N-----Z- Copy from .A to .X
TXA          Implied        $8A   1     2     N-----Z- Copy from .X to .A
TAY          Implied        $A8   1     2     N-----Z- Copy from .A to .Y
TYA          Implied        $98   1     2     N-----Z- Copy from .Y to .A
TSX          Implied        $BA   1     2     N-----Z- Copy from Stack Pointer to .X
TXS          Implied        $9A   1     2     -------- Copy from .X to Stack Pointer
```

Copies data from one register to another.

TSX and TSX copy between the Stack Pointer and the X register. This is the only
way to directly control the Stack Pointer. To initialize the Stack Pointer to
a specific address, you can use the following instructions.

```asm
LDX #$FF
TXS
```

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

### WAI

Wait

```text
SYNTAX       MODE           HEX  LEN  CYCLES  FLAGS    
WAI          Implied        $CB   1     3     -------- +c
```

Effectively stops the processor until a hardware interrupt occurs. The interrupt
is processed immediately, and execution resumes in the Interrupt handler.

NMI, IRQ, and RST (Reset) will recover from the WAI condition.

Normally, an instruction completes its operation before actually handling an
interrupt. But if WAI has executed, the CPU does not need to defer the
interrupt, and so the interrupt can be handled immediately.

+c: New for the 65C02

---
[[Opcodes](#instructions-by-number)] | [[By Name](#instructions-by-name)] | [[By Category](#instructions-by-category)]

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
  I = Interrupts Disabled  
  Z = Zero  
  C = Carry  

## Replacement Macros for Bit Instructions

Since `BBRx`, `BBSx`, `RMBx`, and `SMBx` should not be used, to maintain
compatibility with the 65C816, here are some example macros that can be
used to help convert existing software that may have been using these
instructions:

```asm
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

The above is CA65 specific but the code should work similarly for other
languages. The logic can also be used to if using an assembly language tool
that does not have macro support with small changes.

## Further Reading

- <http://www.6502.org/tutorials/6502opcodes.html>
- <http://6502.org/tutorials/65c02opcodes.html>
- <https://www.pagetable.com/c64ref/6502/?cpu=65c02>
- <http://www.oxyron.de/html/opcodesc02.html>
- <https://www.nesdev.org/wiki/Status_flags>
- <https://skilldrick.github.io/easy6502/>
- <https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf>
- <https://www.westerndesigncenter.com/wdc/documentation/w65c816s.pdf>

a different page  

<!-- For PDF formatting -->
<div class="page-break"></div>
