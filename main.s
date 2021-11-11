; i8255
PORTA = $00
PORTB = $01
PORTC = $02
CONTROL_REGISTER = $03

; SCM
SCM_API = $30
API_INPUT_STATUS = $03
API_DELAY_MS = $0A

    .org $8000
    ld a,$80
    out (CONTROL_REGISTER),a
    ld a,0

loop:
    out (PORTA),a
    inc a
    call delay

.check_exit:
    push af
    ld c,API_INPUT_STATUS
    rst SCM_API
    jp nz,.exit
    pop af
    jp loop
.exit:
    pop af
    ld a,0
    out (PORTA),a
    ret

delay:
    push af
    ld de,50
    ld c,API_DELAY_MS
    rst SCM_API
    pop af
    ret

