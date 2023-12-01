
# Chapter 5: Math Library

The Commander X16 contains a floating point Math library with a precision of 40 bits, which corresponds to 9 decimal digits. It is a stand-alone derivative of the library contained in Microsoft BASIC. Except for the different base address, it is compatible with the C128 and C65 libraries.

The full documentation of these functions can be found in the book [C128 Developers Package for Commodore 6502 Development](http://www.zimmers.net/anonftp/pub/cbm/schematics/computers/c128/servicemanuals/C128_Developers_Package_for_Commodore_6502_Development_(1987_Oct).pdf). The Math Library documentation starts in Chapter 13. (PDF page 257)

The following functions are available from machine language code after setting the ROM bank to 4, which is the default.

## Format Conversions

| Address | Symbol   | Description                                                          |
|---------|----------|----------------------------------------------------------------------|
| \$FE00  | `AYINT`  | convert floating point to integer (signed word)                      |
| \$FE03  | `GIVAYF` | convert integer (signed word) to floating point                      |
| \$FE06  | `FOUT`   | convert floating point to ASCII string                               |
| \$FE09  | `VAL_1`  | convert ASCII string in .X:.Y length in .A, to floating point in FAC |
| \$FE0C  | `GETADR` | convert floating point to an address (unsigned word)                 |
| \$FE0F  | `FLOATC` | convert address (unsigned word) to floating point                    |

#### X16 Additions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol   | Description                                     |
|---------|----------|-------------------------------------------------|
| \$FE87  | `FLOAT`  | FAC = (s8).A   convert signed byte to float     |
| \$FE8A  | `FLOATS` | FAC = (s16)facho+1:facho                        |
| \$FE8D  | `QINT`   | facho:facho+1:facho+2:facho+3 = u32(FAC)        |
| \$FE93  | `FOUTC`  | Convert FAC to ASCIIZ string at fbuffr - 1 + .Y |


## Movement

| Address | Symbol   | Description                          |
|---------|----------|--------------------------------------|
| \$FE5A  | `CONUPK` | move RAM MEM to ARG                  |
| \$FE5D  | `ROMUPK` | move ROM/RAM MEM to ARG (use CONUPK) |
| \$FE60  | `MOVFRM` | move RAM MEM to FACC (use MOVFM)     |
| \$FE63  | `MOVFM`  | move ROM/RAM MEM to FACC             |
| \$FE66  | `MOVMF`  | move FACC to RAM MEM                 |
| \$FE69  | `MOVFA`  | move ARG to FACC                     |
| \$FE6C  | `MOVAF`  | move FACC to ARG                     |

#### X16 Additions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol  | Description                                     |
|---------|---------|-------------------------------------------------|
| \$FE81  | `MOVEF` | ARG = FAC    (just use MOVAF)                   |


## Math Functions

| Address | Symbol   | Description                           |
|---------|----------|---------------------------------------|
| \$FE12  | `FSUB`   | FACC = MEM - FACC                     |
| \$FE15  | `FSUBT`  | FACC = ARG - FACC                     |
| \$FE18  | `FADD`   | FACC = MEM + FACC                     |
| \$FE1B  | `FADDT`  | FACC = ARG + FACC                     |
| \$FE1E  | `FMULT`  | FACC = MEM * FACC                     |
| \$FE21  | `FMULTT` | FACC = ARG * FACC                     |
| \$FE24  | `FDIV`   | FACC = MEM / FACC                     |
| \$FE27  | `FDIVT`  | FACC = ARG / FACC                     |
| \$FE2A  | `LOG`    | FACC = natural log of FACC            |
| \$FE2D  | `INT`    | FACC = INT() truncate of FACC         |
| \$FE30  | `SQR`    | FACC = square root of FACC            |
| \$FE33  | `NEGOP`  | negate FACC (switch sign)             |
| \$FE36  | `FPWR`   | FACC = raise ARG to the MEM power     |
| \$FE39  | `FPWRT`  | FACC = raise ARG to the FACC power    |
| \$FE3C  | `EXP`    | FACC = EXP of FACC                    |
| \$FE3F  | `COS`    | FACC = COS of FACC                    |
| \$FE42  | `SIN`    | FACC = SIN of FACC                    |
| \$FE45  | `TAN`    | FACC = TAN of FACC                    |
| \$FE48  | `ATN`    | FACC = ATN of FACC                    |
| \$FE4B  | `ROUND`  | FACC = round FACC                     |
| \$FE4E  | `ABS`    | FACC = absolute value of FACC         |
| \$FE51  | `SIGN`   | .A = test sign of FACC                |
| \$FE54  | `FCOMP`  | .A = compare FACC with MEM            |
| \$FE57  | `RND_0`  | FACC = random floating point number   |

#### X16 Additions to math functions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol   | Description                               |
|---------|----------|-------------------------------------------|
| \$FE6F  | `FADDH`  | FACC += .5                                |
| \$FE72  | `ZEROFC` | FACC = 0                                  |
| \$FE75  | `NORMAL` | Normalize FACC                            |
| \$FE78  | `NEGFAC` | FACC = -FACC   (just use NEGOP)           |
| \$FE7B  | `MUL10`  | FACC *= 10                                |
| \$FE7E  | `DIV10`  | FACC /= 10                                |
| \$FE84  | `SGN`    | FACC = sgn(FACC)                          |
| \$FE90  | `FINLOG` | FACC += (s8).A   add signed byte to float |
| \$FE96  | `POLYX`  | Polynomial Evaluation 1 (SIN/COS/ATN/LOG) |
| \$FE99  | `POLY`   | Polynomial Evaluation 2 (EXP)             |


## How to use the routines

**Concepts:**

* **FACC** (sometimes abbreviated to FAC): the floating point accumulator. You can compare this to the 6502 CPU's .A register,
  which is the accumulator for most integer operations performed by the CPU. 
  FACC is the primary floating point register. Calculations are done on the value in this register,
  usually combined with ARG. After the operation, usually the original value in FACC has been replaced by the result of the calculation.
* **ARG**: the second floating point register, used in most calculation functions. Often the value in this register will be lost after a calculation.
* **MEM**: means a floating point value stored in system memory somewhere.  The format is [40 bits (5 bytes) Microsoft binary format](https://en.wikipedia.org/wiki/Microsoft_Binary_Format).
  To be able to work with given values in calculations, they need to be stored in memory somewhere in this format. 
  To do this you'll likely need to use a separate program to pre-convert floating point numbers to this format, unless you are using a compiler that
  directly supports it.

*Note that FACC and ARG are just a bunch of zero page locations. This means you can poke around in them. 
But that's not good practice because their locations aren't guaranteed/public, and the format is slightly different
than how the 5-byte floats are normally stored into memory. Just use one of the Movement routines to 
copy values into or out of FACC and ARG.*

To perform a floating point calculation, follow the following pattern:

1. load a value into FACC. You can convert an integer, or move a MEM float number into FACC.
1. do the same but for ARG, the second floating point register.
1. call the required floating point calculation routine that will perform a calculation on FACC with ARG.
1. repeat the previous 2 steps if required.
1. the result is in FACC, move it into MEM somewhere or convert it to another type or string.

An example program that calculates and prints the distance an object has fallen over a certain period
using the formula  $d = \dfrac{1}{2} g {t}^{2}$

```ASM
; calculate how far an object has fallen:  d = 1/2 * g * t^2.
; we set g = 9.81 m/sec^2, time = 5 sec -> d = 122.625 m.

CHROUT = $ffd2
FOUT   = $fe06
FMULTT = $fe21
FDIV   = $fe24
CONUPK = $fe5a
MOVFM  = $fe63

    lda  #4
    sta  $01         ; rom bank 4 (BASIC) contains the fp routines.
    lda  #<flt_two
    ldy  #>flt_two
    jsr  MOVFM
    lda  #<flt_g
    ldy  #>flt_g
    jsr  FDIV        ; FACC= g/2
    lda  #<flt_time
    ldy  #>flt_time
    jsr  CONUPK      ; ARG = time
    jsr  FMULTT      ; FACC = g/2 * time
    lda  #<flt_time
    ldy  #>flt_time
    jsr  CONUPK      ; again ARG = time
    jsr  FMULTT      ; FACC = g/2 * time * time
    jsr  FOUT        ; to string
    ; print string in AY
    sta  $02
    sty  $03
    ldy  #0
loop:
    lda  ($02),y
    beq  done
    jsr  CHROUT
    iny
    bne  loop
done:
    rts

flt_g:      .byte  $84, $1c, $f5, $c2, $8f  ; float 9.81
flt_time:   .byte  $83, $20, $00, $00, $00  ; float 5.0
flt_two:    .byte  $82, $00, $00, $00, $00  ; float 2.0
```



## Notes

* `RND_0`: For .Z=1, the X16 behaves differently than the C128 and C65 versions. The X16 version takes entropy from .A/.X/.Y instead of from a CIA timer. So in order to get a "real" random number, you would use code like this:

```ASM
LDA #$00
PHP
JSR entropy_get ; KERNAL call to get entropy into .A/.X/.Y
PLP             ; restore .Z=1
JSR RND_0
```

* The calls `FADDT`, `FMULTT`, `FDIVT` and `FPWRT` were broken on the C128/C65. They are fixed on the X16.
* For more information on the additional calls, refer to [Mapping the Commodore 64](http://unusedino.de/ec64/technical/project64/mapping_c64.html) by Sheldon Leemon, ISBN 0-942386-23-X, but note these errata:
  * `FMULT` adds mem to FAC, not ARG to FAC

<!-- For PDF formatting -->
<div class="page-break"></div>
