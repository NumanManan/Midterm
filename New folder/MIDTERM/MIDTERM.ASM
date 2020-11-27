#include<p18f4550.inc>

lp_cnt1 	 	set 0x00
lp_cnt2 		set 0x01

			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie
			
			
;delay 10ms

dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm

delay 		MOVLW D'20'
			MOVWF lp_cnt2,A
AGAIN1 		MOVLW D'250'
			MOVWF lp_cnt1,A
AGAIN2 		dup_nop D'217'
			DECFSZ lp_cnt1,F,A
			BRA AGAIN2
			DECFSZ lp_cnt2,F,A
			BRA AGAIN1
			NOP
			RETURN
			
;configure LCD

LCDCmd    	MOVWF PORTB,A        
            BCF PORTC,0,A
            BCF PORTC,1,A
            BSF PORTC,2,A
            CALL delay
            BCF PORTC,2,A
            return

LCDData  	MOVWF PORTB,A        
            BSF PORTC,0,A
            BCF PORTC,1,A
            BSF PORTC,2,A
            CALL delay
            BCF PORTC,2,A
            return
            
LCDCon		MOVLW 0X38
			CALL LCDCmd
			MOVLW 0X0C
			CALL LCDCmd
			MOVLW 0X01
			CALL LCDCmd
			RETURN
			
;ID DISPLAY

ID			MOVLW 0X01
			CALL LCDCmd
			
			MOVLW d'68'
			CALL LCDData
			MOVLW d'69'
			CALL LCDData
			MOVLW d'57'
			CALL LCDData
			MOVLW d'54'
			CALL LCDData
			MOVLW d'54'
			CALL LCDData
			MOVLW d'49'
			CALL LCDData
			MOVLW d'56'
			CALL LCDData
			
			MOVLW 0XC0
			CALL LCDCmd
			RETURN


;NAME

			
NAME		MOVLW 0X01
			CALL LCDCmd
			
			MOVLW d'78'
			CALL LCDData
			MOVLW d'85'
			CALL LCDData
			MOVLW d'96'
			CALL LCDData
			MOVLW d'77'
			CALL LCDData
			MOVLW d'65'
			CALL LCDData
			MOVLW d'78'
			CALL LCDData
			
			MOVLW 0XC0
			CALL LCDCmd
			RETURN
			
;INPUT BUTTON

BUTTON		BTFSC PORTC,6,A
			CALL NAME
			
			BTFSC PORTC,7,A
			CALL ID
			RETURN
			
;KEYPAD NUMBER 			
NUM0		MOVLW d'48'
			CALL LCDData
			RETURN
			
NUM1		MOVLW d'49'
			CALL LCDData
			RETURN
			
NUM2		MOVLW d'50'
			CALL LCDData
			RETURN
			
NUM3		MOVLW d'51'
			CALL LCDData
			RETURN
			
NUM4		MOVLW d'52'
			CALL LCDData
			RETURN
			
NUM5		MOVLW d'53'
			CALL LCDData
			RETURN
			
NUM6		MOVLW d'54'
			CALL LCDData
			RETURN
			
NUM7		MOVLW d'55'
			CALL LCDData
			RETURN
			
NUM8		MOVLW d'56'
			CALL LCDData
			RETURN
			
NUM9		MOVLW d'57'
			CALL LCDData
			RETURN
			
INSTA		MOVLW d'35'
			CALL LCDData
			RETURN
			
BINTANG		MOVLW d'42'
			CALL LCDData
			RETURN
			
			
;INPUT KEYPAD

KEYPAD		BCF PORTD,7,A
			BSF PORTD,4,A
			BTFSC PORTD,0,A
			CALL NUM1			
			BTFSC PORTD,1,A
			CALL NUM2			
			BTFSC PORTD,2,A
			CALL NUM3
			
			BCF PORTD,4,A
			BSF PORTD,5,A
			BTFSC PORTD,0,A
			CALL NUM4			
			BTFSC PORTD,1,A
			CALL NUM5			
			BTFSC PORTD,2,A
			CALL NUM6
			
			BCF PORTD,5,A
			BSF PORTD,6,A
			BTFSC PORTD,0,A
			CALL NUM7			
			BTFSC PORTD,1,A
			CALL NUM8			
			BTFSC PORTD,2,A
			CALL NUM9
			
			BCF PORTD,6,A
			BSF PORTD,7,A
			BTFSC PORTD,0,A
			CALL BINTANG			
			BTFSC PORTD,1,A
			CALL NUM0			
			BTFSC PORTD,2,A
			CALL INSTA
			RETURN

;START

start		CLRF TRISB,A
			MOVLW B'11000000'
			MOVWF TRISC,A
			MOVLW B'00000111'
			MOVWF TRISD,A
			CALL LCDCon
			MOVLW 0XC0
			CALL LCDCmd

check		CALL KEYPAD
			CALL BUTTON
			BRA check
			end