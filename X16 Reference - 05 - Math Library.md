
# Chapter 5: Math Library

The Commander X16 contains a floating point Math library with a precision of 40 bits, which corresponds to 9 decimal digits. It is a stand-alone derivative of the library contained in Microsoft BASIC. Except for the different base address, it is compatible with the C128 and C65 libraries.

The full documentation of these functions can be found in the book [C128 Developers Package for Commodore 6502 Development](http://www.zimmers.net/anonftp/pub/cbm/schematics/computers/c128/servicemanuals/C128_Developers_Package_for_Commodore_6502_Development_(1987_Oct).pdf). The Math Library documentation starts in Chapter 13. (PDF page 257)

The following functions are available from machine language code after setting the ROM bank to 4, which is the default.

## Format Conversions

| Address | Symbol   | Description                                                        |
|---------|----------|--------------------------------------------------------------------|
| $FE00   | `AYINT`  | convert floating point to integer (signed word)                    |
| $FE03   | `GIVAYF` | convert integer (signed word) to floating point                    |
| $FE06   | `FOUT`   | convert floating point to ASCII string                             |
| $FE09   | `VAL_1`  | convert ASCII string to floating point<br/>*[not yet implemented]* |
| $FE0C   | `GETADR` | convert floating point to an address (unsigned word)               |
| $FE0F   | `FLOATC` | convert address (unsigned word) to floating point                  |  

#### X16 Additions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol   | Description                                     |
|---------|----------|-------------------------------------------------|
| $FE87   | `FLOAT`  | FAC = (s8).A   convert signed byte to float     |
| $FE8A   | `FLOATS` | FAC = (s16)facho+1:facho                        |
| $FE8D   | `QINT`   | facho:facho+1:facho+2:facho+3 = u32(FAC)        |
| $FE93   | `FOUTC`  | Convert FAC to ASCIIZ string at fbuffr - 1 + .Y |


## Movement

| Address | Symbol   | Description                          |
|---------|----------|--------------------------------------|
| $FE5A   | `CONUPK` | move RAM MEM to ARG                  |
| $FE5D   | `ROMUPK` | move ROM/RAM MEM to ARG (use CONUPK) |
| $FE60   | `MOVFRM` | move RAM MEM to FACC (use MOVFM)     |
| $FE63   | `MOVFM`  | move ROM/RAM MEM to FACC             |
| $FE66   | `MOVMF`  | move FACC to RAM MEM                 |
| $FE69   | `MOVFA`  | move ARG to FACC                     |
| $FE6C   | `MOVAF`  | move FACC to ARG                     |

#### X16 Additions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol  | Description                                     |
|---------|---------|-------------------------------------------------|
| $FE81   | `MOVEF` | ARG = FAC    (just use MOVAF)                   |


## Math Functions

| Address | Symbol   | Description                           |
|---------|----------|---------------------------------------|
| $FE12   | `FSUB`   | FACC = MEM - FACC                     |
| $FE15   | `FSUBT`  | FACC = ARG - FACC                     |
| $FE18   | `FADD`   | FACC = MEM + FACC                     |
| $FE1B   | `FADDT`  | FACC = ARG + FACC                     |
| $FE1E   | `FMULT`  | FACC = MEM * FACC                     |
| $FE21   | `FMULTT` | FACC = ARG * FACC                     |
| $FE24   | `FDIV`   | FACC = MEM / FACC                     |
| $FE27   | `FDIVT`  | FACC = ARG / FACC                     |
| $FE2A   | `LOG`    | FACC = natural log of FACC            |
| $FE2D   | `INT`    | FACC = INT() truncate of FACC         |
| $FE30   | `SQR`    | FACC = square root of FACC            |
| $FE33   | `NEGOP`  | negate FACC (switch sign)             |
| $FE36   | `FPWR`   | FACC = raise ARG to the MEM power     |
| $FE39   | `FPWRT`  | FACC = raise ARG to the FACC power    |
| $FE3C   | `EXP`    | FACC = EXP of FACC                    |
| $FE3F   | `COS`    | FACC = COS of FACC                    |
| $FE42   | `SIN`    | FACC = SIN of FACC                    |
| $FE45   | `TAN`    | FACC = TAN of FACC                    |
| $FE48   | `ATN`    | FACC = ATN of FACC                    |
| $FE4B   | `ROUND`  | FACC = round FACC                     |
| $FE4E   | `ABS`    | FACC = absolute value of FACC         |
| $FE51   | `SIGN`   | .A = test sign of FACC                |
| $FE54   | `FCOMP`  | .A = compare FACC with MEM            |
| $FE57   | `RND_0`  | FACC = random floating point number   |

#### X16 Additions to math functions

The following calls are new to the X16 and were not part of the C128 math library API:

| Address | Symbol   | Description                               |
|---------|----------|-------------------------------------------|
| $FE6F   | `FADDH`  | FAC += .5                                 |
| $FE72   | `ZEROFC` | FAC = 0                                   |
| $FE75   | `NORMAL` | Normalize FAC                             |
| $FE78   | `NEGFAC` | FAC = -FAC   (just use NEGOP)             |
| $FE7B   | `MUL10`  | FAC *= 10                                 |
| $FE7E   | `DIV10`  | FAC /= 10                                 |
| $FE84   | `SGN`    | FAC = sgn(FAC)                            |
| $FE90   | `FINLOG` | FAC += (s8).A   add signed byte to float  |
| $FE96   | `POLYX`  | Polynomial Evaluation 1 (SIN/COS/ATN/LOG) |
| $FE99   | `POLY`   | Polynomial Evaluation 2 (EXP)             |


## Notes

* `RND_0`: For .Z=1, the X16 behaves differently than the C128 and C65 versions. The X16 version takes entropy from .A/.X/.Y instead of from a CIA timer. So in order to get a "real" random number, you would use code like this:

```ASM
LDA #$00
PHP
JSR entropy_get ; KERNAL call to get entropy into .A/.X/.Y
PLP             ; restore .Z=1
JSR RND_0
```

* The calls `FADDT`, `FMULTT`, `FDIVT` and `FPWRT` were broken on on the C128/C65. They are fixed on the X16.
* For more information on the additional calls, refer to [Mapping the Commodore 64](http://unusedino.de/ec64/technical/project64/mapping_c64.html) by Sheldon Leemon, ISBN 0-942386-23-X, but note these errata:
  * `FMULT` adds mem to FAC, not ARG to FAC

<!-- For PDF formatting -->
<div class="page-break"></div>
