    .org 0
    NOP
    NOP
TU:

    jp start

    .org 0x0101
    .include 'lcd.s'

start:
    ld sp,0x8100
    call lcd_init
loop:
    jp loop


