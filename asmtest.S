#include "avr/io.h"
#include "asmtest.h"

; Define the function asminit()
;.DSEG ; Start data segment 
counter: .BYTE; reserve 1 byte to var1

.global asminit
asminit:
ldi r16, 1
sts counter,r16
sbi  4,5; 4 = DDRB (0x24 - 0x20). Bit 5 = pin 13
rjmp main_loop
ret

main_loop:
  ldi  r18, 41
  ldi  r19, 150
  ldi  r20, 128
  rcall slp ; calculated sleep for 1 second
  
  ldi r24, 0x00
  rcall led
  
  ldi  r18, 41
  ldi  r19, 150
  ldi  r20, 128
  rcall slp ; calculated sleep for 1 second
  
  ldi r24, 0x01
  rcall led
rjmp main_loop



; Define the function led()
led:
cpi r24, 0x00 ; Parameter passed by caller in r24
breq turnoff
sbi 5, 5; 5 = PORTB (0x25 - 0x20). Bit 5 = pin 13
ldi r16, 255
ldi r20, 255
ret
turnoff:
cbi 5, 5; 5 = PORTB (0x25 - 0x20). Bit 5 = pin 13
ldi r16, 255
ldi r20, 255
ret

slp: dec  r20
    brne slp
    dec  r19
    brne slp
    dec  r18
    brne slp
ret
