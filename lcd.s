; Intel 8255 "Programmable Peripheral Interface"
; (occupies the entire I/O address space on MGH80)

PPI_A	=	0x00		; CA80 user 8255 base address 	  (port A)
PPI_B	=	0x01		; CA80 user 8255 base address + 1 (port B)
PPI_C	=	0x02		; CA80 user 8255 base address + 2 (port C)
PPI_M	=	0x03		; CA80 user 8255 control register

; Port A:  E RW RS xx xx xx xx LED
; Port B: D7 D6 D5 D4 D3 D2 D1 D0
; Port C:  x  x  x  x  x  x  x  x

LCD_E = %10000000
LCD_RW = %01000000
LCD_RS = %00100000
LCD_LED = %00000001

; Onboard address decoder:
;    ROM at 0000h - 7FFFh
;    RAM at 8000h - FFFFh
;    IO at 00h (IOPortA)
;    IO at 01h (IOPortB)
;    IO at 02h (IOPortC)
;    IO at 03h (Control)

lcd_init:
    ld a,0x80 ; All ports output
    out (PPI_M), a

; Set mode
    ld a,%00111000 ; 8-bit mode; 2-line 5x8 font
    call lcd_instruction

; Display on/off
    ld a,%00001110 ; Display on ; cursor on ; blink off
    call lcd_instruction

; Entry mode set
    ld a,%00000110 ; I/D: move inc/dec, S: display shift?o
    call lcd_instruction

    ld a,%00000001 ; Clear display
    call lcd_instruction

    ld a,"H"
    call putchar
    ld a,"i"
    call putchar

    ld a, LCD_LED
    out (PPI_A), a

    ret

lcd_instruction:
    push af

    call lcd_wait

    out (PPI_B),a
    ld a, 0 ; Ensure RS/RW/E bits are clear
    out (PPI_A),a
    ld a, LCD_E ; Strobe (E)nable
    out (PPI_A),a
    ld a, 0
    out (PPI_A),a ; Clear RS/RW/E

    pop af
    ret

putchar:
    call lcd_wait
    push af
    out (PPI_B), a
    ld a, LCD_RS
    out (PPI_A), a
    ld a, LCD_RS | LCD_E
    out (PPI_A), a
    ld a, LCD_RS
    out (PPI_A), a

    pop af
    ret

lcd_wait:
    push af
    ld a,0x82 ; All ports output, except B to input
    out (PPI_M), a

lcd_wait_loop:
    ld a, LCD_RW
    out (PPI_A), a
    ld a, LCD_RW | LCD_E
    out (PPI_A), a
    in a, (PPI_B)
    bit 7, a
    jp NZ, lcd_wait_loop ; loop until high bit is clear

    ld a, LCD_RW
    out (PPI_A), a

    ld a,0x80 ; Mode 0, all ports output
    out (PPI_M), a

    pop af
    ret
