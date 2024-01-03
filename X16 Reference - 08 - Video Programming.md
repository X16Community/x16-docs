
# Chapter 8: Video Programming

The VERA video chip supports resolutions up to 640x480 with up to 256 colors from a palette of 4096, two layers of either a bitmap or tiles, 128 sprites of up to 64x64 pixels in size. It can output VGA as well as a 525 line interlaced signal, either as NTSC or as RGB (Amiga-style).

See [Chapter 9](X16%20Reference%20-%2009%20-%20VERA%20Programmer's%20Reference.md#chapter-9-vera-programmers-reference) for further details on programming VERA.

The X16 KERNAL uses the following video memory layout:

| Addresses     | Description                                               |
|---------------|-----------------------------------------------------------|
| $00000-$12BFF | 320x240@256c Bitmap                                       |
| $12C00-$12FFF | *unused* (1024 bytes)                                     |
| $13000-$1AFFF | Sprite Image Data (up to $1000 per sprite at 64x64 8-bit) |
| $1B000-$1EBFF | Text Mode                                                 |
| $1EC00-$1EFFF | *unused* (1024 bytes)                                     |
| $1F000-$1F7FF | Charset                                                   |
| $1F800-$1F9BF | *unused* (1024 bytes)                                     |
| $1F9C0-$1F9FF | VERA PSG Registers (16 x 4 bytes)                         |
| $1FA00-$1FBFF | VERA Color Palette (256 x 2 bytes)                        |
| $1FC00-$1FFFF | VERA Sprite Attributes (128 x 8 bytes)                    |

Application software is free to use any part of video RAM if it does not use the corresponding KERNAL functionality. To restore text mode, call `CINT` ($FF81).

<!-- For PDF formatting -->
<div class="page-break"></div>
