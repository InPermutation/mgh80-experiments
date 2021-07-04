PIO_A	=	0x00		; CA80 user 8255 base address 	  (port A)
PIO_B	=	0x01		; CA80 user 8255 base address + 1 (port B)
PIO_C	=	0x02		; CA80 user 8255 base address + 2 (port C)
PIO_M	=	0x03		; CA80 user 8255 control register

    .org 0
    NOP
    NOP
TU:

    jp START

    .org 0x0101

START:
    ; main program

    ld sp,0x8100		; set stack


    ld A,0x080 			; configure, all ports Output
    out (PIO_M),A		;

INIT:	ld A,0x00		; load 00 to port A register (LED OFF)
    out (PIO_A),A

    call pause			; delay

    ld A,0xFF			; load 0FFh to port A register (LED ON)
    out (PIO_A),A

    call pause			; delay

    jp INIT				; repeat

pause:
    LD BC, 0x01            ; delay multiplier
Outer:
    LD DE, 0x3000
Inner:
    DEC DE                  	;Decrements DE
    LD A, D                 	;Copies D into A
    OR E                    	;Bitwise OR of E with A (now, A = D | E)
    JP NZ, Inner            	;Jumps back to Inner: label if A is not zero
    DEC BC                  	;Decrements BC
    LD A, B                 	;Copies B into A
    OR C                    	;Bitwise OR of C with A (now, A = B | C)
    JP NZ, Outer            	;Jumps back to Outer: label if A is not zero
    RET                     	;Return from call to this subroutine	
