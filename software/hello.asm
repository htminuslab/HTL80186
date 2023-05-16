;-------------------------------------------------------------------------------
; Simple Hello World
; Modelsim only, write output to port 0x54
;-------------------------------------------------------------------------------

BITS 16
CPU 186

TXCHAR_P54  EQU     054h                    	; Port54 used for Modelsim TX character 
												; monitor only.	
	   		ORG  	0100h		    			; result in .com start IP=0100

			MOV		AX,CS
			MOV		DS,AX
			MOV		SS,AX
            MOV     BX,TOS                      ; Top of Stack
            MOV     SS,AX
            MOV     SP,BX                       ; Set Stack pointer

			MOV     SI,MESS              			
			CALL	PUTS
			HLT


;----------------------------------------------------------------------
; Write zero terminated string to CONOUT
; String pointed to by [DS:SI]
;----------------------------------------------------------------------
PUTS:       PUSH    SI
            PUSH    AX
            CLD 
PRINT:      LODSB                               ; AL=[DS:SI++]
            OR      AL,AL                       ; Zero?
            JZ      PRINT_X                     ; then exit
            CALL    TXCHAR                          
            JMP     PRINT                       ; Next Character
PRINT_X:    POP     AX
            POP     SI
            RET

;----------------------------------------------------------------------
; Transmit character in AL
;----------------------------------------------------------------------
TXCHAR:		OUT		TXCHAR_P54,AL
            RET

MESS  		DB    	"*** Hello World ***",0Ah,0Dh,0

            TIMES   256 DB 0                  	; Reserve xKbytes for the stack
TOS:        DW      0                           ; Top of stack
