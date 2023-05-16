;-------------------------------------------------------------------------------
; Flag Mask Tables
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Sub Table
; MASK_TAB[13:11]-REGFIELD[2:0]
; 00-XXX unused
; 01-XXX 80..83
; 10-XXX C0..C1/D0..D4
; 11-XXX F6/F7
;-------------------------------------------------------------------------------
MASK_TAB2	DW		OF+DF+SF+ZF+AF+PF+CF		; 0
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7

			DW		OF+DF+SF+ZF+AF+PF+CF		; 8	ADD
			DW		OF+DF+SF+ZF+PF+CF		; 9	OR 
			DW		OF+DF+SF+ZF+AF+PF+CF		; A	ADC
			DW		OF+DF+SF+ZF+AF+PF+CF		; B	SBB
			DW		OF+DF+SF+ZF+PF+CF		; C	AND
			DW		OF+DF+SF+ZF+AF+PF+CF		; D	SUB
			DW		OF+DF+SF+ZF+PF+CF		; E	XOR
			DW		OF+DF+SF+ZF+AF+PF+CF		; F	CMP

			DW		OF+DF+SF+ZF+AF+PF+CF		; 10 ROL
			DW		OF+DF+SF+ZF+AF+PF+CF		; 11 ROR
			DW		OF+DF+SF+ZF+AF+PF+CF		; 12 RCL
			DW		OF+DF+SF+ZF+AF+PF+CF		; 13 RCR
			DW		OF+DF+SF+ZF+PF+CF		; 14 SAL/SHL
			DW		OF+DF+SF+ZF+PF+CF		; 15 SHR
			DW		OF+DF+SF+ZF+AF+PF+CF		; 16 ---
			DW		OF+DF+SF+ZF+PF+CF		; 17 SAR

			DW		OF+DF+SF+ZF+PF+CF		; 18 Test
			DW		OF+DF+SF+ZF+AF+PF+CF		; 19 --
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1A NOT
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1B NEG
			DW		OF+DF+CF					; 1C MUL
			DW		OF+DF+CF					; 1D IMUL
			DW		DF+IF						; 1E DIV
			DW		DF+IF						; 1F IDIV		

;-------------------------------------------------------------------------------
; Main Table
;-------------------------------------------------------------------------------
MASK_TAB	DW		OF+DF+SF+ZF+AF+PF+CF		; 0
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7
			DW		OF+DF+SF+ZF+PF+CF		; 8
			DW		OF+DF+SF+ZF+PF+CF		; 9
			DW		OF+DF+SF+ZF+PF+CF		; A
			DW		OF+DF+SF+ZF+PF+CF		; B
			DW		OF+DF+SF+ZF+AF+PF+CF		; C
			DW		OF+DF+SF+ZF+AF+PF+CF		; D
			DW		OF+DF+SF+ZF+AF+PF+CF		; E
			DW		OF+DF+SF+ZF+AF+PF+CF		; F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 10
			DW		OF+DF+SF+ZF+AF+PF+CF		; 11
			DW		OF+DF+SF+ZF+AF+PF+CF		; 12
			DW		OF+DF+SF+ZF+AF+PF+CF		; 13
			DW		OF+DF+SF+ZF+AF+PF+CF		; 14
			DW		OF+DF+SF+ZF+AF+PF+CF		; 15
			DW		OF+DF+SF+ZF+AF+PF+CF		; 16
			DW		OF+DF+SF+ZF+AF+PF+CF		; 17
			DW		OF+DF+SF+ZF+AF+PF+CF		; 18
			DW		OF+DF+SF+ZF+AF+PF+CF		; 19
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 1F

			DW		OF+DF+SF+ZF+PF+CF		; 20
			DW		OF+DF+SF+ZF+PF+CF		; 21
			DW		OF+DF+SF+ZF+PF+CF		; 22
			DW		OF+DF+SF+ZF+PF+CF		; 23
			DW		OF+DF+SF+ZF+PF+CF		; 24
			DW		OF+DF+SF+ZF+PF+CF		; 25
			DW		OF+DF+SF+ZF+AF+PF+CF		; 26
			DW		DF+SF+ZF+AF+PF+CF		; 27
			DW		OF+DF+SF+ZF+AF+PF+CF		; 28
			DW		OF+DF+SF+ZF+AF+PF+CF		; 29
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 2E
			DW		DF+SF+ZF+AF+PF+CF		; 2F

			DW		OF+DF+SF+ZF+PF+CF		; 30
			DW		OF+DF+SF+ZF+PF+CF		; 31
			DW		OF+DF+SF+ZF+PF+CF		; 32
			DW		OF+DF+SF+ZF+PF+CF		; 33
			DW		OF+DF+SF+ZF+PF+CF		; 34
			DW		OF+DF+SF+ZF+PF+CF		; 35
			DW		OF+DF+SF+ZF+AF+PF+CF		; 36
			DW		DF+AF+CF		; 37
			DW		OF+DF+SF+ZF+AF+PF+CF		; 38
			DW		OF+DF+SF+ZF+AF+PF+CF		; 39
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 3E
			DW		DF+AF+CF		; 3F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 40
			DW		OF+DF+SF+ZF+AF+PF+CF		; 41
			DW		OF+DF+SF+ZF+AF+PF+CF		; 42
			DW		OF+DF+SF+ZF+AF+PF+CF		; 43
			DW		OF+DF+SF+ZF+AF+PF+CF		; 44
			DW		OF+DF+SF+ZF+AF+PF+CF		; 45
			DW		OF+DF+SF+ZF+AF+PF+CF		; 46
			DW		OF+DF+SF+ZF+AF+PF+CF		; 47
			DW		OF+DF+SF+ZF+AF+PF+CF		; 48
			DW		OF+DF+SF+ZF+AF+PF+CF		; 49
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 4F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 50
			DW		OF+DF+SF+ZF+AF+PF+CF		; 51
			DW		OF+DF+SF+ZF+AF+PF+CF		; 52
			DW		OF+DF+SF+ZF+AF+PF+CF		; 53
			DW		OF+DF+SF+ZF+AF+PF+CF		; 54
			DW		OF+DF+SF+ZF+AF+PF+CF		; 55
			DW		OF+DF+SF+ZF+AF+PF+CF		; 56
			DW		OF+DF+SF+ZF+AF+PF+CF		; 57
			DW		OF+DF+SF+ZF+AF+PF+CF		; 58
			DW		OF+DF+SF+ZF+AF+PF+CF		; 59
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 5F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 60
			DW		OF+DF+SF+ZF+AF+PF+CF		; 61
			DW		OF+DF+SF+ZF+AF+PF+CF		; 62
			DW		OF+DF+SF+ZF+AF+PF+CF		; 63
			DW		OF+DF+SF+ZF+AF+PF+CF		; 64
			DW		OF+DF+SF+ZF+AF+PF+CF		; 65
			DW		OF+DF+SF+ZF+AF+PF+CF		; 66
			DW		OF+DF+SF+ZF+AF+PF+CF		; 67
			DW		OF+DF+SF+ZF+AF+PF+CF		; 68
			DW		OF+DF+CF		; 69
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6A
			DW		OF+DF+CF		; 6B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 6F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 70
			DW		OF+DF+SF+ZF+AF+PF+CF		; 71
			DW		OF+DF+SF+ZF+AF+PF+CF		; 72
			DW		OF+DF+SF+ZF+AF+PF+CF		; 73
			DW		OF+DF+SF+ZF+AF+PF+CF		; 74
			DW		OF+DF+SF+ZF+AF+PF+CF		; 75
			DW		OF+DF+SF+ZF+AF+PF+CF		; 76
			DW		OF+DF+SF+ZF+AF+PF+CF		; 77
			DW		OF+DF+SF+ZF+AF+PF+CF		; 78
			DW		OF+DF+SF+ZF+AF+PF+CF		; 79
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 7F

			DW		SPEC_80+OF+DF+SF+ZF+AF+PF+CF		; 80
			DW		SPEC_80+OF+DF+SF+ZF+AF+PF+CF		; 81
			DW		SPEC_80+OF+DF+SF+ZF+AF+PF+CF		; 82
			DW		SPEC_80+OF+DF+SF+ZF+AF+PF+CF		; 83
			DW		OF+DF+SF+ZF+AF+PF+CF		; 84
			DW		OF+DF+SF+ZF+AF+PF+CF		; 85
			DW		OF+DF+SF+ZF+AF+PF+CF		; 86
			DW		OF+DF+SF+ZF+AF+PF+CF		; 87
			DW		OF+DF+SF+ZF+AF+PF+CF		; 88
			DW		OF+DF+SF+ZF+AF+PF+CF		; 89
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 8F

			DW		OF+DF+SF+ZF+AF+PF+CF		; 90
			DW		OF+DF+SF+ZF+AF+PF+CF		; 91
			DW		OF+DF+SF+ZF+AF+PF+CF		; 92
			DW		OF+DF+SF+ZF+AF+PF+CF		; 93
			DW		OF+DF+SF+ZF+AF+PF+CF		; 94
			DW		OF+DF+SF+ZF+AF+PF+CF		; 95
			DW		OF+DF+SF+ZF+AF+PF+CF		; 96
			DW		OF+DF+SF+ZF+AF+PF+CF		; 97
			DW		OF+DF+SF+ZF+AF+PF+CF		; 98
			DW		OF+DF+SF+ZF+AF+PF+CF		; 99
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9A
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9B
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9C
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9D
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9E
			DW		OF+DF+SF+ZF+AF+PF+CF		; 9F
												   
			DW		OF+DF+SF+ZF+AF+PF+CF		; A0
			DW		OF+DF+SF+ZF+AF+PF+CF		; A1
			DW		OF+DF+SF+ZF+AF+PF+CF		; A2
			DW		OF+DF+SF+ZF+AF+PF+CF		; A3
			DW		OF+DF+SF+ZF+AF+PF+CF		; A4
			DW		OF+DF+SF+ZF+AF+PF+CF		; A5
			DW		OF+DF+SF+ZF+AF+PF+CF		; A6
			DW		OF+DF+SF+ZF+AF+PF+CF		; A7
			DW		OF+DF+SF+ZF+AF+PF+CF		; A8
			DW		OF+DF+SF+ZF+AF+PF+CF		; A9
			DW		OF+DF+SF+ZF+AF+PF+CF		; AA
			DW		OF+DF+SF+ZF+AF+PF+CF		; AB
			DW		OF+DF+SF+ZF+AF+PF+CF		; AC
			DW		OF+DF+SF+ZF+AF+PF+CF		; AD
			DW		OF+DF+SF+ZF+AF+PF+CF		; AE
			DW		OF+DF+SF+ZF+AF+PF+CF		; AF

			DW		OF+DF+SF+ZF+AF+PF+CF		; B0
			DW		OF+DF+SF+ZF+AF+PF+CF		; B1
			DW		OF+DF+SF+ZF+AF+PF+CF		; B2
			DW		OF+DF+SF+ZF+AF+PF+CF		; B3
			DW		OF+DF+SF+ZF+AF+PF+CF		; B4
			DW		OF+DF+SF+ZF+AF+PF+CF		; B5
			DW		OF+DF+SF+ZF+AF+PF+CF		; B6
			DW		OF+DF+SF+ZF+AF+PF+CF		; B7
			DW		OF+DF+SF+ZF+AF+PF+CF		; B8
			DW		OF+DF+SF+ZF+AF+PF+CF		; B9
			DW		OF+DF+SF+ZF+AF+PF+CF		; BA
			DW		OF+DF+SF+ZF+AF+PF+CF		; BB
			DW		OF+DF+SF+ZF+AF+PF+CF		; BC
			DW		OF+DF+SF+ZF+AF+PF+CF		; BD
			DW		OF+DF+SF+ZF+AF+PF+CF		; BE
			DW		OF+DF+SF+ZF+AF+PF+CF		; BF

			DW		SPEC_OFIB+SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; C0
			DW		SPEC_OFIB+SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; C1
			DW		OF+DF+SF+ZF+AF+PF+CF		; C2
			DW		OF+DF+SF+ZF+AF+PF+CF		; C3
			DW		OF+DF+SF+ZF+AF+PF+CF		; C4
			DW		OF+DF+SF+ZF+AF+PF+CF		; C5
			DW		OF+DF+SF+ZF+AF+PF+CF		; C6
			DW		OF+DF+SF+ZF+AF+PF+CF		; C7
			DW		OF+DF+SF+ZF+AF+PF+CF		; C8
			DW		OF+DF+SF+ZF+AF+PF+CF		; C9
			DW		OF+DF+SF+ZF+AF+PF+CF		; CA
			DW		OF+DF+SF+ZF+AF+PF+CF		; CB
			DW		OF+DF+SF+ZF+AF+PF+CF		; CC
			DW		OF+DF+SF+ZF+AF+PF+CF		; CD
			DW		OF+DF+SF+ZF+AF+PF+CF		; CE
			DW		OF+DF+SF+ZF+AF+PF+CF		; CF

			DW		SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; D0
			DW		SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; D1
			DW		SPEC_OFCL+SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; D2
			DW		SPEC_OFCL+SPEC_C0+OF+DF+SF+ZF+AF+PF+CF		; D3
			DW		DF+SF+ZF+PF		; D4
			DW		DF+SF+ZF+PF		; D5
			DW		OF+DF+SF+ZF+AF+PF+CF		; D6
			DW		OF+DF+SF+ZF+AF+PF+CF		; D7
			DW		OF+DF+SF+ZF+AF+PF+CF		; D8
			DW		OF+DF+SF+ZF+AF+PF+CF		; D9
			DW		OF+DF+SF+ZF+AF+PF+CF		; DA
			DW		OF+DF+SF+ZF+AF+PF+CF		; DB
			DW		OF+DF+SF+ZF+AF+PF+CF		; DC
			DW		OF+DF+SF+ZF+AF+PF+CF		; DD
			DW		OF+DF+SF+ZF+AF+PF+CF		; DE
			DW		OF+DF+SF+ZF+AF+PF+CF		; DF

			DW		OF+DF+SF+ZF+AF+PF+CF		; E0
			DW		OF+DF+SF+ZF+AF+PF+CF		; E1
			DW		OF+DF+SF+ZF+AF+PF+CF		; E2
			DW		OF+DF+SF+ZF+AF+PF+CF		; E3
			DW		OF+DF+SF+ZF+AF+PF+CF		; E4
			DW		OF+DF+SF+ZF+AF+PF+CF		; E5
			DW		OF+DF+SF+ZF+AF+PF+CF		; E6
			DW		OF+DF+SF+ZF+AF+PF+CF		; E7
			DW		OF+DF+SF+ZF+AF+PF+CF		; E8
			DW		OF+DF+SF+ZF+AF+PF+CF		; E9
			DW		OF+DF+SF+ZF+AF+PF+CF		; EA
			DW		OF+DF+SF+ZF+AF+PF+CF		; EB
			DW		OF+DF+SF+ZF+AF+PF+CF		; EC
			DW		OF+DF+SF+ZF+AF+PF+CF		; ED
			DW		OF+DF+SF+ZF+AF+PF+CF		; EE
			DW		OF+DF+SF+ZF+AF+PF+CF		; EF

			DW		OF+DF+SF+ZF+AF+PF+CF		; F0
			DW		OF+DF+SF+ZF+AF+PF+CF		; F1
			DW		OF+DF+SF+ZF+AF+PF+CF		; F2
			DW		OF+DF+SF+ZF+AF+PF+CF		; F3
			DW		OF+DF+SF+ZF+AF+PF+CF		; F4
			DW		OF+DF+SF+ZF+AF+PF+CF		; F5
			DW		SPEC_F6+OF+DF+SF+ZF+AF+PF+CF		; F6
			DW		SPEC_F6+OF+DF+SF+ZF+AF+PF+CF		; F7
			DW		OF+DF+SF+ZF+AF+PF+CF		; F8
			DW		OF+DF+SF+ZF+AF+PF+CF		; F9
			DW		OF+DF+SF+ZF+AF+PF+CF		; FA
			DW		OF+DF+SF+ZF+AF+PF+CF		; FB
			DW		OF+DF+SF+ZF+AF+PF+CF		; FC
			DW		OF+DF+SF+ZF+AF+PF+CF		; FD
			DW		OF+DF+SF+ZF+AF+PF+CF		; FE
			DW		OF+DF+SF+ZF+AF+PF+CF		; FF

