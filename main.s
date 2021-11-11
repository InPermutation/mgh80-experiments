; i8255
PORTA = $00
PORTB = $01
PORTC = $02
CONTROL_REGISTER = $03

    .org $8000
    ld a,$80
    out (CONTROL_REGISTER),a
    ld a, 0

loop:
    out (PORTA),a
    inc a
    call delay
    jp loop

delay:
    push af
    ld de,50
    ld c, $0A ; Delay $DE ms
    rst $30
    pop af
    ret

