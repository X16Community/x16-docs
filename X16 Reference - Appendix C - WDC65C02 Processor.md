# Appendix C: The WDC65C02 Processor

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
| [BIT](#bit) | BMI | BNE | BPL | BRA | BRK | BVC | BVS |
| CLC | CLD | CLI | CLV | CMP | CPX | CPY | DEC |
| DEX | DEY | EOR | INC | INX | INY | JMP | JSR |
| LDA | LDX | LDY | LSR | NOP | ORA | PHA | PHP |
| PLA | PLP | RMB | ROL | ROR | RTI | RTS | SBC |
| SEC | SED | SEI | SMB | STA | STP | STX | STY |
| TAX | TAY | TRB | TSB | TSX | TXA | TXS | TYA |
| WAI |     |     |     |     |     |     |     |

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

Shifts all bits to the left by one position, unlike ROL,
the bits do not rotate. Instead a 0 is shifted into bit 0
and bit 7 is shifted into the carry flag.

### BBR

Branch On Bit Reset

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

Branch On Bit Set

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

Branch On Carry Clear

| Addressing Mode | Usage          | Length | Cycles   |
| --------------- | -------------  | ------ | -------- |
| Relative        | BCC LABEL      | 3      | 2-4 [^2] |

Branch to LABEL if the carry flag is clear.

### BCS

Branch On Carry Set

| Addressing Mode | Usage          | Length | Cycles   |
| --------------- | -------------  | ------ | -------- |
| Relative        | BCS LABEL      | 3      | 2-4 [^2] |

Branch to LABEL if the carry flag is set.

### BEQ

Branch On Equals (Branch if Zero flag is set)

| Addressing Mode | Usage          | Length | Cycles   |
| --------------- | -------------  | ------ | -------- |
| Relative        | BEQ LABEL      | 3      | 2-4 [^2] |

Branch to LABEL if the zero flag is set.

### BIT

Test Bits

| Addressing Mode | Usage          | Length | Cycles |
| --------------- | -------------  | ------ | ------ |
| Zero Page       | BIT $44        | 2      | 3      |
| Absolute        | BIT $4400      | 3      | 4      |

  - Sets Z (Zero) flag based on an and'ing of value provided to the A (accumulator) register. 
  - Sets N (Negative) flag to the value of bit 7 at the provided address.  
  - Sets V (Overflow) flag to the value of bit 6 at the provided addres.  



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

[^1]: Add 1 cycle if a page boundary is crossed
[^2]: Add 1 cycle if branch is taken on the same page, or 2 if it's taken to a different page