;
; AssemblerApplication1.asm
;
; Created: 8/31/2021 6:34:08 PM
; Author : rodri
;

.INCLUDE "./m328pdef.inc"
.ORG 0x00

setup:
	LDI r20, 0xFF 
	LDI r21, 0x00 ; Prende todo los leds/Activa la sirena
	OUT DDRB, r20 ; Setea el DDRB como output
	OUT DDRD, r20 ; Setea el DDRD como output
	LDI r16,0b11011111 ; Cargo el valor 11011111 en el registro 16 para que luego cuando cargo en DDR5 sea out
	LDI r17,0b11101111 ; PIN 04
	LDI r18,0b11110111 ; PIN 03
	LDI r19,0b11111011 ; PIN 02	

	OUT PORTB, r20 ; Apaga todos los leds/Tweet
	OUT PORTD, r20 ; El tweet se encuentra en el pin 03

main:
	CALL AutoIncreible
	;CALL Sirena

	RJMP main

Sirena:
	CALL retardo1/4s
	OUT PORTB,r21
	;OUT PORTD,r18
	CALL retardo1/4s
	OUT PORTB,r20
	;OUT PORTD,r20
	RET

AutoIncreible:
	CALL retardo1/4s
	OUT PORTB,r16
	CALL retardo1/4s
	OUT PORTB,r17
	CALL retardo1/4s
	OUT PORTB,r18
	CALL retardo1/4s
	OUT PORTB,r19
	CALL retardo1/4s
	OUT PORTB,r18
	CALL retardo1/4s
	OUT PORTB,r17
	;retardo
	;OUT PORTB,r16
	RET
	

retardo1/4s:
	LDI r30, 0x00
	LDI r28, 0x00
	LDI r29, 0x00
	
	; Los clocks de los loops anidados se multiplican
	loop0:
		loop1:
			loop2:
				INC r30
				CPI r30, 215 ;255
				BRNE loop2
			INC r29
			CPI r29, 108 ;100
			BRNE loop1
		INC r28
		CPI r28, 35 ;60
		BRNE loop0
	RET
