;---------------
; Assembly Code
;---------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global start
.global led
.global myDelay
;------------------------
start:
    SBI   DDRC, 0             ;set PC0 (arduino D14, led light L0) as o/p
    RET                       ;return to setup() function
;---------------------------------------------------------------------------
led:
    CPI   R24, 0x00           ;value in R24 passed by caller compared with 0
    BREQ  ledOFF              ;jump (branch) if equal to subroutine ledOFF
    SBI   PORTC, 0            ;set PC0 (arduino D14, led light L0) to high
    RET                       ;return to loop() function
;---------------------------------------------------------------------------
ledOFF:
    CBI   PORTC, 0            ;set PC0 (arduino D14, led light L0) to low
    RET                       ;return to loop() function
;---------------------------------------------------------------------------
.equ  delayVal, 10000         ;initial count value for inner loop
;---------------------------------------------------------------------------
myDelay:
    CPI   R24, 0
    BREQ  minDelay
    CPI   R24, 1
    BREQ  midDelay
    CPI   R24, 2
    BREQ  maxDelay
minDelay:
    LDI   R20, 50
    JMP   outerLoop
midDelay:
    LDI   R20, 150            ;initial count value for outer loop
    JMP   outerLoop
maxDelay:
    LDI   R20, 255
outerLoop:
    LDI   R30, lo8(delayVal)  ;low byte of delayVal in R30
    LDI   R31, hi8(delayVal)  ;high byte of delayVal in R31
innerLoop:
    SBIW  R30, 1              ;subtract 1 from 16-bit value in R31, R30
    BRNE  innerLoop           ;jump if countVal not equal to 0
    ;--------------
    SUBI  R20, 1              ;subtract 1 from R20
    BRNE  outerLoop           ;jump if R20 not equal to 0
    RET
;---------------------------------------------------------------------------
