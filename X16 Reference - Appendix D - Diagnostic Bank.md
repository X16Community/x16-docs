
# Appendix D: Diagnostic Bank

The Diagnostic ROM bank can run a full diagnostic on the system memory (base + 512K-2048K extended) of the Commander X16.

## Index

* [Running Diagnostics](#Running-Diagnostics)
* [Progress indicators](#Progress-Indicators)
	* [Without screen](#without-screen)
	* [With screen](#with-screen)
* [Error communication](#Error-communication)

## Running Diagnostics
### Functional system
The memory diagnostics can be started in two different ways. If the system is functional enough to actually boot into BASIC, the diagnostics can be started from there with the following:  
```BASIC
BANK 0, 16: SYS $C000
```

It is also possible to jump directly to the diagnostic ROM bank from assembly.  
```asm
	lda	#$10	; ROM bank $10 (16 in decimal) is the diagnostic bank
	sta	$01	; Write ROM bank to ROM bank registers
	jmp	$C000	; Jump to beginning of diagnostic ROM
```  

NOTE: The Diagnostic ROM is not able to return to BASIC or any program that has called. The only way to exit the Diagnostic ROM is by resetting or powercycling the system.
### Non functional system
If the Commander X16 is not able too boot into BASIC, the memory diagnostics can be started by keeping the powerbutton pressed for about a second when powering on the system.  
This will make the Commander X16 boot directly into the diagnostic ROM bank and start the memory diagnostics.

## Progress indicators
### Without screen
When the diagnostic ROM bank starts, it will use the activity LED to indicate the progress.  
* ON - while zero-page memory is tested (very brief)
* OFF - for 1st test of base memory ($0100-$9EFF)
* ON - for 2nd test of base memory ($0100-$9EFF)
* OFF - for 3rd test of base memory ($0100-$9EFF)
* ON - for 4th test of base memory ($0100-$9EFF)
  
After the inital test of base memory, the number of available memory banks is tested, VERA is initialized and both the activity LED and the keyboard LEDs are used to indicate the progress.  
The keyboard LEDs are used as a binary counter:  
| Num | Binary | Num Lock | Caps Lock | Scroll Lock |
|-----|--------|----------|-----------|-------------|
|  0  |  000   |    0     |     0     |      0      |
|  1  |  001   |    0     |     0     |      1      |
|  2  |  010   |    0     |     1     |      0      |
|  3  |  011   |    0     |     1     |      1      |
|  4  |  100   |    1     |     0     |      0      |
|  5  |  101   |    1     |     0     |      1      |
|  6  |  110   |    1     |     1     |      0      |
|  7  |  111   |    1     |     1     |      1      |
  
#### Main test loop
During the first test iteration, the keyboard LEDs will display 0 0 1  
When the test is done, the activity light will blink once.  
During the second test iteration, the keyboard LEDS will display 0 1 0  
When the test is done, the activity light will blink once.  
During the third test iteration, the keyboard LEDs will display 0 1 1  
When the test is done, the activity light will blink once.  
During the fourth test iteration, the keyboard LEDs will display 1 0 0  
When the test is done, the activity light will blink once.  

As the last part of the test loop, the base memory is tested. Keyboard LEDs will show 1 0 1  
When the test loop is done, keyboard LEDs will show 1 1 1 and the activity LED will blink 3 times before starting over.
### With screen
When the base memory has been tested the first time, VERA is initialized with output to VGA.  
On the screen there is detailed information about the progress of each test iteration.  
Each time through the main test loop, the output of VERA will be switched between VGA and Composite/S-Video.  

## Error communication
If an error is detected before VERA is initialized, the error will be reported with the activity LED by blinking every half second 3 times, staying off for 1 second and repeating. - All tests stop.  
  
This means that if an error occurs before VERA is initialized, you have no way of figuring out exactly where the error is, but you do know that the error has happened in base memory.  
  
When the initial test of base memory has succeeded and VERA is initialized, any errors will be reported to the display. Only if more than 32 errors are encountered, will the tests stop and the activity LED will flash the same way as when an error is encountered before VERA initialization.  
  
The errorcodes on screen are as follows:
<!-- For PDF formatting -->
<div class="page-break"></div>
