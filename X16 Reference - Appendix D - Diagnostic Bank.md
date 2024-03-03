
# Appendix D: Diagnostic Bank

The Diagnostic ROM bank can run a full diagnostic on the system memory (base + 512K-2048K extended) of the Commander X16.

## Index

* [Running Diagnostics](#Running_Diagnostics)
* [Progress indicators](#Progress_Indicators)
* [Error communication](#Error_communication)

## Running Diagnostics
### Functional system
The memory diagnostics can be started in two different ways. If the system is functional enough to actually boot into BASIC, the diagnostics can be started from there with the following:  
´´´BASIC
BANK 0, 16: SYS $C000
´´´  

It is also possible to jump directly to the diagnostic ROM bank from assembly.  
´´´asm
	lda	#$10	; ROM bank $10 (16 in decimal) is the diagnostic bank
	sta	$01	; Write ROM bank to ROM bank registers
	jmp	$C000	; Jump to beginning of diagnostic ROM
´´´  

NOTE: The Diagnostic ROM is not able to return to BASIC or any program that has called. The only way to exit the Diagnostic ROM is by resetting or powercycling the system.
### Non functional system
If the Commander X16 is not able too boot into BASIC, the memory diagnostics can be started by keeping the powerbutton pressed for about a second when powering on the system.  
This will make the Commander X16 boot directly into the diagnostic ROM bank and start the memory diagnostics.

## Progress indicators

<!-- For PDF formatting -->
<div class="page-break"></div>
