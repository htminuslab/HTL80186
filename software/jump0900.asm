;------------------------------------------------------------------------------------
; Reset Vector
; Jump to 0080:0100
;------------------------------------------------------------------------------------
		; ORG 0FF0h
		TIMES 0FF0h-($-$$) db 0

  		MOV 	AX,0080h
  		MOV     DS,AX
  		MOV     ES,AX
  		MOV     SS,AX							
		DB      0EAh
       	DW      0100h							
       	DW	    0080h		   