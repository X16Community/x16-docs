
# 15: Upgrade Guide

This chapter provides tips for running upgrades on the various programmable chips.

**WARNING**: flashing any of these components has a risk of leading to an unbootable system. At the current time, doing hardware flash updates requires skill and knowledge beyond that of an ordinary end user and is not recommended without guidance from the community on the Commander X16 Discord.

Under the headings of each component is a matrix which indicates which software tools can be used to perform the flash of that component, depending on which flashing hardware you have access to and the operating system of the computer you have the device connected to. Some components of the Commander X16 can be self-flashed, but the risk of a failed flash rendering your X16 unbootable is high, in which case an external programmer must be used to flash the component and thus "unbrick" the system.

### Flashable components
* System ROM
* SMC (PS/2 and Power controller)
* VERA

## System ROM

Official community system ROMs will be posted as releases at [X16Community/x16-emulator](https://github.com/X16Community/x16-emulator/releases) inside the distribution for the Emulator.

TODO: link to instructions for each solution in the matrix

| ↓ Hardware / OS → | Windows | Linux | Mac OS | Commander X16 |
|-|-|-|-|-|
| Commander X16 | - | - | - | x16-flash |
| XGecu TL866II+ | Xgpro | minipro | minipro | - |
| XGecu TL866-3G / T48 | Xgpro | - | - | - |

## SMC

Official community SMC ROMs will be posted as releases at [X16Community/x16-smc](https://github.com/X16Community/x16-smc/releases).

TODO: link to instructions for each solution in the matrix

| ↓ Hardware / OS → | Windows | Linux | Mac OS | Commander X16 |
|-|-|-|-|-|
| Commander X16 | - | - | - | - |
| USBtinyISP | arduino | arduino | arduino | - |
| XGecu TL866II+ | Xgpro | - | - | - |
| XGecu TL866-3G / T48 | Xgpro | - | - | - |

## VERA

TODO: link to instructions for each solution in the matrix

Official community VERA bitstreams will be posted as releases at [X16Community/vera-module](https://github.com/X16Community/vera-module/releases)

| ↓ Hardware / OS → | Windows | Linux | Mac OS | Commander X16 |
|-|-|-|-|-|
| Commander X16 | - | - | - | flashvera |
| XGecu TL866II+ | Xgpro | minipro | minipro | - |
| XGecu TL866-3G / T48 | [Xgpro](X16%20Reference%20-%20Appendix%20B%20-%20VERA%20Recovery.md#appendix-b-vera-firmware-recovery) | - | - | - |

<!-- For PDF formatting -->
<div class="page-break"></div>
