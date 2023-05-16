;-------------------------------------------------------------------------------
; HTL80186                                                                   
;                                      
; ------------------------------------------------------------------------------
;
; CPU Test HT-LAB 2008
; Display 8086/186 behaviour
;
; Version 0.1 Modelsim only, write output to port 0x54
;-------------------------------------------------------------------------------
BITS 16
CPU 8086
    
            ORG     0100h                       ; result in .com start IP=0100

            CLI
            CLD

            XOR     AX,AX                       ; Segment=0000
            MOV     DS,AX      
            
            MOV     WORD [DS:0], INT0           ; Div0 handler 
            MOV     WORD [DS:2], CS                 

            MOV     WORD [DS:(6*4)], INT6       ; INT6 handler, illegal instructions
            MOV     WORD [DS:(6*4)+2], CS       ; supported in 80186+

            MOV     AX,CS
            MOV     DS,AX
            MOV     ES,AX
            MOV     SS,AX
            MOV     AX,TOS                      ; Top of Stack
            MOV     SP,AX                       ; Set Stack pointer
                                                                                                                   
            MOV     SI,WELCOME_MESS             ;  -> SI
            CALL    PUTS                        ; String pointed to by DS:[SI]

;-----------------------------------------------------------------------------
; Flag test
; For 808x/8018x MS 4bits are stuck at 1
;-----------------------------------------------------------------------------
TEST1:      MOV     SI,TEST1_MESS               ; Check Flag behaviour
            CALL    PUTS                        ; Expect MSB 4 bits to be stuck at 1
            XOR     AX,AX
            PUSH    AX
            POPF                                
            PUSHF
            POP     AX
            AND     AX,0F000H
            CMP     AX,0F000H
            JNZ     FAIL1
            MOV     SI,OK_MESS
            JMP     DISPTEST1
FAIL1:      MOV     SI,FAIL_MESS
DISPTEST1:  CALL    PUTS


;-----------------------------------------------------------------------------
; Stack Push Test
;
; 8086/80186            80286+
; {                     {
;   SP    = SP - 2          TEMP = SP
;   SS:SP = SP              SP   = SP - 2
; }                         SS:SP = TEMP
;                       }
;-----------------------------------------------------------------------------
TEST2:      MOV     SI,TEST2_MESS               ; Check Stack behaviour
            CALL    PUTS                        

            PUSH    SP                          ; save SP on stack to look at
            POP     BX                          ; get SP saved on stack
            CMP     BX,SP                       ; if 8086/8088, these values will differ
            JZ      FAIL2                       ; Not different, not 8086/186
            MOV     SI,OK_MESS
            JMP     DISPTEST2
FAIL2:      MOV     SI,FAIL_MESS
DISPTEST2:  CALL    PUTS


;-----------------------------------------------------------------------------
; Check Address wrap
; When a word write is performed at offset FFFFh in a segment, the 8086 will 
; write one byte at offset FFFFh, and the other at offset 0, while an 80186 
; processor will write one byte at offset FFFFh, and the other at offset 10000h 
;-----------------------------------------------------------------------------
TEST3:      MOV     SI,TEST3_MESS               ; Check Address Wrap behaviour
            CALL    PUTS                        
            
            MOV     BX,[DS:0FFFFh]              ; get original data
            MOV     WORD [DS:0FFFFh],0AAAAh     ; write signature at test location
            CMP     BYTE [DS:0],0AAh            ; 8086?
            MOV     [DS:0FFFFh],BX              ; restore
            
            JE      MESS86      
            MOV     SI,OK186_MESS
            JMP     DISPTEST3
MESS86:     MOV     SI,OK86_MESS
DISPTEST3:  CALL    PUTS

;-----------------------------------------------------------------------------
; The 8088/8086 skips the byte after the unsupported INSB instruction, The V20
; and 80186 support these.  
;-----------------------------------------------------------------------------
TEST4:      MOV     SI,TEST4_MESS               ; Check INSB Instruction    
            CALL    PUTS                        

TEST_V20:   MOV     BH,20                       ; Assume NEC V20
            MOV     DI,[TEST_V20]               ; Overwrite 1st byte of this code with port
            XOR     DX,DX                       ; Port 0
            DB      6Ch                         ; Port 0 into ES:[DI] if not 8088, else skip
            INC     DX                          ; Skip this if 8088, leave DX = 0
            TEST    DX,DX                       ; Else set DX = 1 if INSB supported
            JZ      MESST86
            
            MOV     SI,OK186_MESS
            JMP     DISPTEST4
MESST86:    MOV     SI,OK86_MESS
DISPTEST4:  CALL    PUTS
            
;-----------------------------------------------------------------------------
; The 80186 traps illegal instructions via INT6, the 8086 should ignore it
;-----------------------------------------------------------------------------
TEST5:      MOV     SI,TEST5_MESS               ; Check Illegal Instruction 
            CALL    PUTS                        
            XOR     DX,DX

            DB      064h                        ; Stop ISS186 using illegal instruction
                                                ; INT6 increases DX 
            TEST    DX,DX
            JZ      MESSR86

            MOV     SI,OK186_MESS
            JMP     DISPTEST5
MESSR86:    MOV     SI,OK86_MESS
DISPTEST5:  CALL    PUTS


;-----------------------------------------------------------------------------
; Test 8088/8086 based upon prefetch queue length.  8088 = 4-byte, 8086= 6-byte.
; Code modified from Szilagyi, EDN Design Ideas, Apr 26, 1990, pg 232.
;-----------------------------------------------------------------------------
TEST6:      MOV     SI,TEST6_MESS               ; Check Prefetch queue  
            CALL    PUTS                        

            MOV     BH,8                        ; Assume 8088
            MOV     SI,[QUE_CODE + 1]           ; Target code ahead of or in queue
            JMP     SHORT $+2                   ; Reset que (important!)
            MOV     [SI],BH                     ; 2 bytes.  Modify targ if 8088,not if 8086
            NOP                                 ; 1 byte
            NOP                                 ; 1 byte - end of 8088 queue

QUE_CODE:   MOV     BH,6                        ; 6 is outside 8088 queue, just inside 8086
            MOV     AL,BH
            CALL    PUTHEX1


;-----------------------------------------------------------------------------
; Test Shift Instructions
;-----------------------------------------------------------------------------
TEST7:      MOV     SI,TEST7_MESS               ; Check shift instruction   
            CALL    PUTS                        

            MOV     AX,1
            MOV     CL,64                       ; try to shift further than size of ax
            SHR     AX,CL
            OR      AX,AX
            JZ      MESSP86                     ; 186 ignores the upper bits of cl
            
            MOV     SI,OK186_MESS
            JMP     DISPTEST7
MESSP86:    MOV     SI,OK86_MESS
DISPTEST7:  CALL    PUTS

;-----------------------------------------------------------------------------
; Divide exceptions  
; On 8086, 8088, 80186, and 80188 processors, the return address on the stack 
; points at the next instruction after the divide instruction.
;-----------------------------------------------------------------------------
TEST8:      MOV     SI,TEST8_MESS               ; Check div 
            CALL    PUTS                        
            MOV     AX,1
            XOR     DX,DX
            DIV     DL                          ; INT0, BL+1 if INT0->DIV Instruction
            NOP
            TEST    DL,DL      
            JZ      MESSL86                     
            
            MOV     SI,FAIL_MESS
            JMP     DISPTEST8
MESSL86:    MOV     SI,OK_MESS
DISPTEST8:  CALL    PUTS
            

            MOV     SI,DONE_MESS
            CALL    PUTS
            HLT                                 ; End of Test
    

;----------------------------------------------------------------------
; INT0 Divide Interrupt.
; IP point to the next instruction for 8086/186 and the same for
; 286+
; DX++ if 286+
;----------------------------------------------------------------------
INT0:       PUSH    BP
            MOV     BP,SP       
            
            MOV     BX,[BP+2]   
            CMP     BYTE [BX],0F6h              ; [BX] point to DIV Instruction?
            JNE     INT086
            ADD     WORD [BP+2],2               ; point past invalid opcode

            INC     DX      
            
INT086:     POP     BP
            IRET

;----------------------------------------------------------------------
; INT6 Unknown instruction.
; IP point to unknown instruction
; DX modified
;----------------------------------------------------------------------
INT6:       PUSH    BP
            MOV     BP,SP
                
            INC     DX
            ADD     WORD [SS:BP+2],1            ; point past invalid opcode

            POP     BP
            IRET

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

;------------------------------------------------------------------------------
; Transmit character 
;------------------------------------------------------------------------------
TXCHAR:     OUT     054h,AL                     ; Modelsim only
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


WELCOME_MESS DB     0Ah,0Dh," **** Check CPU Behaviour ****"
            DB      0Ah,0Dh,"       (c)HT-Lab 2002",0Ah,0Dh,0

TEST1_MESS  DB      0Ah,0Dh,"Checking Flag Register   : ",0
TEST2_MESS  DB      0Ah,0Dh,"Checking Stack           : ",0
TEST3_MESS  DB      0Ah,0Dh,"Checking Address Wrap    : ",0
TEST4_MESS  DB      0Ah,0Dh,"Checking INSB Inst.      : ",0
TEST5_MESS  DB      0Ah,0Dh,"Checking Illegal Instr.  : ",0
TEST6_MESS  DB      0Ah,0Dh,"Checking Prefetch Queue  :  -> 808",0
TEST7_MESS  DB      0Ah,0Dh,"Checking Shift>31        : ",0
TEST8_MESS  DB      0Ah,0Dh,"Checking divide 0 intr.  : ",0

FAIL_MESS   DB      " -> *** Does not behave like a 8086/186 ***",0
OK_MESS     DB      " -> Behaves like 8086/80186",0
OK186_MESS  DB      " -> Behaves like 80186",0
OK86_MESS   DB      " -> Behaves like 8086",0
DONE_MESS  DB       0Ah,0Dh,"Test Done.............",0Ah,0Dh,0


            TIMES   256 DB 0                  ; Reserve xKbytes for the stack
TOS:        DW      0                           ; Top of stack
