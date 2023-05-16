;-------------------------------------------------------------------------------
; HTL80186                                                                   
;                                    
; ------------------------------------------------------------------------------
;
; Trace Example
;
; Version 0.1 Modelsim only, write output to port 0x54
;-------------------------------------------------------------------------------
BITS 16
CPU 186

CR     		EQU     0Dh                     
LF     		EQU     0Ah       

;-------------------------------------------------------------------------------
; Flag Masks
;-------------------------------------------------------------------------------
SPEC_80		EQU		01000h
SPEC_C0		EQU		02000h
SPEC_F6		EQU		03000h
SPEC_OFCL	EQU		04000h						; Used for D2/D3, Check CL
SPEC_OFIB   EQU		08000h						; Used for C0/C1 Imm8

OF			EQU		00800h
DF			EQU		00400h
IF			EQU		00200h
TF			EQU		00100h
SF			EQU		00080h
ZF			EQU		00040h
AF			EQU		00010h
PF			EQU		00004h
CF			EQU		00001h        

%macro		WRSPACE	 0						   	; Write space character to console
			MOV     AL,' '
			CALL    TXCHAR
%endmacro

%macro		WREQUAL	 0							; Write '=' character to console
			MOV     AL,'='
			CALL    TXCHAR
%endmacro
             		
	   		ORG  	0100h		    			; result in .com start IP=0100			
			CLI
            
;-------------------------------------------------------------------------------
; Set Divide by zero and Trace interrupt
;-------------------------------------------------------------------------------
			XOR     AX,AX                       ; Segment=0000
			MOV     DS,AX                         
			                                                             
			MOV     WORD [DS:0], INT0_ISR		; Div0 handler 
			MOV     WORD [DS:2], CS

            MOV     WORD [DS:(1*4)], INT1_ISR	; INT1 Trace handler
			MOV     WORD [DS:(1*4)+2], CS		
            
            MOV     WORD [DS:(5*4)], INT5_ISR	; INT5 Bound handler
			MOV     WORD [DS:(5*4)+2], CS		

;-------------------------------------------------------------------------------
; Set segment pointers to centre of 128KByte Random data area
;-------------------------------------------------------------------------------
			MOV		AX,CS						; Restore sregs
			MOV		DS,AX
			MOV		ES,AX
			MOV		SS,AX
			MOV		AX,TOS
			MOV		SP,AX

			MOV		AX,CS						; Get CS					
			MOV		[UDS],AX
			MOV		[UES],AX
			MOV		[USS],AX
			MOV		WORD [USP],0100h
			MOV		WORD [UFL],0

            MOV     SI,WELCOME_MESS      		;  -> SI
            CALL    PUTS                        ; String pointed to by DS:[SI]

;------------------------------------------------------------------------------
; Enable Trace
;------------------------------------------------------------------------------
TRACEPROG:  MOV		AX,STARTTEST
            MOV     [UIP],AX                    ; Init test program IP
            MOV     AX,CS
            MOV     [UCS],AX					; and CS
			

TRACENEXT:	OR		WORD [UFL],0100h            ; set TF

 			MOV     AX,[UAX]                    ; Restore Registers
            MOV     BX,[UBX]            
            MOV     CX,[UCX]            
            MOV     DX,[UDX]
            MOV     BP,[UBP]                        
            MOV     SI,[USI]             
            MOV     DI,[UDI]
                                                         
            MOV     ES,[UES]
            CLI                                 
            MOV     SS,[USS]                    ; Change to User Stack!!    
            MOV     SP,[USP]
            
            PUSH    WORD [UFL]					; Push on user stack!!!
            PUSH    WORD [UCS]                   
            PUSH    WORD [UIP]       
            MOV     DS,[UDS]
            IRET                                ; Execute!


EXITTRACE:  HLT									; Terminate program


;==============================================================================
;------------------------------------------------------------------------------
; Trace Interrupt Handler
; Restore All instructions
; Display Registers                
;------------------------------------------------------------------------------
INT1_ISR:	POP		WORD [CS:UIP]				; Save User NEXT CS/IP/Flags
			POP		WORD [CS:UCS]				; Note DS=CS (debug.COM)
			POP		WORD [CS:UFL]				; need 3 pops to restore user SP

		   	MOV		[CS:USS],SS					; Save stack position
		   	MOV		[CS:USP],SP

			MOV		[CS:UAX],AX					; Save user registers
			MOV		[CS:UBX],BX
			MOV		[CS:UCX],CX
			MOV		[CS:UDX],DX
			MOV		[CS:UBP],BP
			MOV		[CS:USI],SI
			MOV		[CS:UDI],DI
			MOV		[CS:UDS],DS
			MOV		[CS:UES],ES
			
			MOV		BX,SP
			MOV		WORD [SS:BX-2],0			; Clear flag stored in memory????

			MOV     AX,CS                       ; Restore local settings
			MOV		ES,AX
            MOV     DS,AX
            MOV     SS,AX
            MOV     AX,TOS               		; Top of Stack            						
            MOV     SP,AX                       ; Restore Monitor Stack pointer

;------------------------------------------------------------------------------
; Display Registers	executed instruction
;
; AX   BX   CX   DX   SP   BP   SI   DI   DS   ES   SS   CS   IP   
; 0001 0002 0003 0004 0005 0006 0007 0008 0009 000A 000B 000C 0100  
;------------------------------------------------------------------------------
DISPREG:    CALL    NEWLINE
            LEA     DI,[UAX]

            MOV     CX,13
NEXTDR1:    MOV     AX,[DI]                     ; DI points to AX value
            CALL    PUTHEX4                     ; Display AX value
			WRSPACE
            ADD     DI,2                        ; Point to BX value
            LOOP    NEXTDR1                     ; etc

;------------------------------------------------------------------------------
; Display Flags After masking
;------------------------------------------------------------------------------
			MOV		BX,[UMSK]					; Get Mask from Previous decode
			AND		[UFL],BX					; Mask Stored flags

			MOV		AX,[UFL]					; Display Flags					
            CALL    PUTHEX3                     		
			WRSPACE
			MOV		AX,BX						; Display Mask
            CALL    PUTHEX3                     		
			WRSPACE

;------------------------------------------------------------------------------
; Display Next Opcode (not yet executed)
; Instruction = [SI+BP]
; 2065 00001184 3E6279F4   db		03eh,062h,079h,0f4h			; bound di, [ds:bx+di-0xc] lst=11A8, n=4
; 2066 00001188 90         NOP
; 2067 00001189 3E8D69F4   db		03eh,08dh,069h,0f4h			; lea bp, [ds:bx+di-0xc] lst=11AD, n=4
; 2068 0000118D 3E8B4600   MOV		AX,[DS:BP]
; 2069 00001191 3E8B4602   MOV		AX,[DS:BP+2]
;------------------------------------------------------------------------------
            XOR		BP,BP						; Offset Opcode
            MOV     SI,[UIP]                    ; SI point to opcode

			MOV		AL,[SI+BP]					; Get Opcode
			AND		AL,0E7h						; Check SEG OR
			CMP		AL,26h
			JNE		NOSEGOR	

		   	INC		BP							; Indicate SEG OR
			MOV		AL,'+'						
			CALL	TXCHAR

NOSEGOR:	MOV		AX,[SI+BP]					; Get Opcode

			CMP		AL,0F4h						; HALT Instruction?
			JE 		EXITTRACE					; yes, then exit test

			MOV		BL,AL						; Save copy
			MOV		CL,AH						; Store second opcode byte
			XCHG	AL,AH
			CALL	PUTHEX4						; Display it, opcode first then second byte

;------------------------------------------------------------------------------
; Determine Mask for next opcode and store in UMSK
;------------------------------------------------------------------------------
			MOV		DI,MASK_TAB            		; Point to first Mask Table
			XOR		BH,BH						; 00BL, BL=Opcode
			SHL		BX,1						; Change to word offset
			MOV		AX,[DI+BX]	  				; Get flag mask value
			MOV		DX,AX						; Make copy
            CMP		AX,0FFFh					; Special?
			JA		MSKSPECIAL					; Yes

			MOV		[UMSK],AX					; Store Mask for next trace
			JMP 	TRACENEXT			   		; Next trace

;------------------------------------------------------------------------------
; Special Instructions 
; 80..83/F6/F7/SegmOR/REP/C0/C1/D0..D3/F2/F3/FE/FF
; AX/DX=Main Mask
;------------------------------------------------------------------------------
MSKSPECIAL:	SHR 	AX,9 						; Take ms 2 bits of flag
			AND		AL,18h
            MOV     BL,CL  		                ; Get Second Opcode byte
			SHR		BL,3
			AND		BL,7						; BL=reg
			OR		BL,AL						; BL is FLAG[13:12]-REGFIELD
			XOR		BH,BH
			SHL		BX,1						; Change to word offset
			MOV		DI,MASK_TAB2				
			MOV		AX,[DI+BX]	  				; Get special flag mask value
            MOV		[UMSK],AX					; Store Mask for next trace
			
;------------------------------------------------------------------------------
; Before returning check if Shift/Rotate CL/IB instruction 
; BP contains SEGOR count (0/1)
; DX= Main mask
;------------------------------------------------------------------------------
			TEST	DX,SPEC_OFCL				; Shift/Rotate with CL?
			JZ		NOCHECKIB					; No, then check IB
			
			MOV		AL,'c'						; Debug only
			CALL    TXCHAR
			CMP		BYTE [UCX],1				; CL=1?
			JNE		REMOFFLAG					; No, remove OF flag
			JMP 	TRACENEXT			   		; Next trace

NOCHECKIB:	TEST	DX,SPEC_OFIB				; Shift/Rotate with IB?
			JZ		EXITOFCHK					; No, then exit
			
			MOV		AL,'i'						; Debug only
			CALL    TXCHAR

			MOV		AL,[SI+BP+1]				; Get Instruction MOD/RM into AH
			AND		AL,0C7h						; Mask MOD and RM bits			
			CMP		AL,6						; 00-XXX-110?
			JE		ADDFOUR
			AND		AL,0C0h						; Only check top 2 bits
			JZ		ADDTWO						; 00-XXX-000?
			CMP		AL,40h						; 01-XXX-XXX
			JE		ADDTHREE
			CMP		AL,80h
			JE		ADDFOUR
			JMP		ADDTWO

ADDTHREE	ADD		BP,1
			JMP		ADDTWO
ADDFOUR:	ADD		BP,2
ADDTWO:		ADD		BP,2						; AL=offset
			
			MOV		AX,BP
			CALL	PUTHEX1
			MOV		AL,','
			CALL	TXCHAR
			MOV		AL,[SI+BP]					; Write Imm8
			CALL	PUTHEX2
			WRSPACE
			MOV		AL,[SI+BP]					; Get Imm8
			AND		AL,01Fh						; Mask 31 bits
			CMP		AL,1						; Imm8=1?
			JE		EXITOFCHK					; Yes then do nothing
			
REMOFFLAG:	AND		WORD [UMSK],07FFh			; Clear OF flag
EXITOFCHK:	JMP		TRACENEXT					; Next Trace
            

;------------------------------------------------------------------------------
; Interrupts
;------------------------------------------------------------------------------        	
INT0_ISR:	INC		BX							; Simple INT0 handler
			MOV		AL,'@'
			CALL	TXCHAR
			IRET
         	    
;------------------------------------------------------------------------------
; BOUNDS interrupt        	
; db		062h,025h					; bound sp, [di] 0F46
; db		062h,03eh,0a5h,0a2h			; bound di, [0xa2a5] 0F4A
; db		062h,05fh,013h				; bound bx, [bx+0x13] 0F4D
; db		062h,08ah,0f1h,0e9h			; bound cx, [bp+si+0xe9f1] 0F54
; db		36h,062h,09eh,0a5h,07eh	 	; bound bx, [DS:bp+0x7ea5] 
;------------------------------------------------------------------------------        	
INT5_ISR:	PUSH	BP							; Simple INT5 handler, CS:IP point to BOUND instruction
			MOV		BP,SP	
			
			XOR		BX,BX						; Used for IP Offset
					
			MOV		SI,[SS:BP+2]				; Get pointer to IP 
			MOV		AL,[CS:SI]	  				; Read Instruction
			AND		AL,0E7h						; Check SEG OR
			CMP		AL,26h
			JNE		NO5SEGOR	
		   	INC		BX							; Indicate SEG OR

NO5SEGOR:	MOV		AL,[CS:SI+BX+1]	  			; Read MODRM Byte
		   	AND		AL,0C7h						; Mask MOD and RM bi

			CMP		AL,6						; 00-XXX-110?
			JE		ADDBX4
			AND		AL,0C0h						; Only check top 2 bits
			JZ		ADDBX2						; 00-XXX-000?
			CMP		AL,40h						; 01-XXX-XXX
			JE		ADDBX3
			JMP		ADDBX4						; Only valid left 10-XXX-XXX

ADDBX3		ADD		BX,1
			JMP		ADDBX2
ADDBX4:		ADD		BX,2
ADDBX2:		ADD		BX,2						; AL=offset
			
			ADD		WORD [SS:BP+2],BX			; Correct IP to point to following instruction
			
			POP		BP
			IRET
	
;------------------------------------------------------------------------------
; Transmit character 
;------------------------------------------------------------------------------
TXCHAR:     OUT     054h,AL                     ; Modelsim only
            RET

;----------------------------------------------------------------------
; Write newline
;----------------------------------------------------------------------
NEWLINE:    PUSH    AX
            MOV     AL,CR
            CALL    TXCHAR
            MOV     AL,LF
            CALL    TXCHAR
            POP     AX
            RET

;------------------------------------------------------------------------------
; Display AX[11:0] in HEX
;------------------------------------------------------------------------------
PUTHEX3:    XCHG    AL,AH                       ; Write AX in hex
            CALL    PUTHEX1
            XCHG    AL,AH
            CALL    PUTHEX2
            RET

;------------------------------------------------------------------------------
; Display AX in HEX
;------------------------------------------------------------------------------
PUTHEX4:    XCHG    AL,AH                       ; Write AX in hex
            CALL    PUTHEX2
            XCHG    AL,AH
            CALL    PUTHEX2
            RET

;------------------------------------------------------------------------------
; Display AL in HEX
;------------------------------------------------------------------------------
PUTHEX2:    PUSH    AX                          ; Save the working register
            SHR     AL,1
            SHR     AL,1
            SHR     AL,1
            SHR     AL,1
            CALL    PUTHEX1                     ; Output it
            POP     AX                          ; Get the LSD
            CALL    PUTHEX1                     ; Output
            RET

PUTHEX1:    PUSH    AX                          ; Save the working register
            AND     AL, 0Fh                     ; Mask off any unused bits
            CMP     AL, 0Ah                     ; Test for alpha or numeric
            JL      NUMERIC                     ; Take the branch if numeric
            ADD     AL, 7                       ; Add the adjustment for hex alpha
NUMERIC:    ADD     AL, '0'                     ; Add the numeric bias
            CALL    TXCHAR                      ; Send to the console
            POP     AX
            RET

;----------------------------------------------------------------------
; Write zero terminated string to CONOUT
; String pointed to by DS:[SI]
;----------------------------------------------------------------------
PUTS:       PUSH    SI
            PUSH    AX
            CLD 
PRINT:      LODSB                               ; AL=DS:[SI++]
            OR      AL,AL                       ; Zero?
            JZ      PRINT_X                     ; then exit
            CALL    TXCHAR                          
            JMP     PRINT                       ; Next Character
PRINT_X:    POP     AX
            POP     SI
            RET

WELCOME_MESS DB  	CR,LF,"TRACE186 ver 0.1",CR,LF
			DB  	" AX   BX   CX   DX   SP   BP   SI   DI   DS   ES   SS   CS   IP  FLG MSK N-OP",0
CHKSUM_MESS	DB	    CR,LF,"Checksum:",0

;-------------------------------------------------------------------------------
; Flag Mask Table
;-------------------------------------------------------------------------------
%include "masktab.asm"

;----------------------------------------------------------------------
; Save Register values
;----------------------------------------------------------------------
UAX       	DW      00h                         ; AX
UBX        	DW      01h                         ; BX
UCX        	DW      02h                         ; CX
UDX        	DW      03h                         ; DX
USP        	DW      0100h                       ; SP
UBP        	DW      05h                         ; BP
USI        	DW      06h                         ; SI
UDI        	DW      07h                         ; DI
UDS        	DW      00h                			; DS
UES        	DW     	00h                			; ES
USS        	DW      00h                			; SS
UCS        	DW      00h                			; CS
UIP        	DW      0100h                       ; IP
UFL        	DW      0F03Ah                      ; flags
UMSK		DW      0ED5h						; Flag Mask value

            TIMES   256 DB 0                    ; Reserve bytes for the stack
TOS:        DW      0                           ; Top of stack


;-------------------------------------------------------------------------------
; User Program executed by Trace
;-------------------------------------------------------------------------------
align 16
STARTTEST: 	NOP

			MOV		AX,1234h
			MOV		BX,5678h
			MOV		CX,9ABCDh
			JMP		SKIP
			MOV		AX,0
SKIP:		MOV		DX,0EF01h
			HLT

DEADLOCK:	JMP		DEADLOCK