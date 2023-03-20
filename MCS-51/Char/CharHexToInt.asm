;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE HEX CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	C = 0 IF CHARACTER IS HEX
;			A = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT HEX
;			A = 0x00
CHARHEXTOINT:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "0"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x30
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "9"
	MOV		R0, A
	SUBB	A, #0x0A
	JNC		CHARHEXTOINTB
CHARHEXTOINTA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
CHARHEXTOINTB:
	;SUBTRACT 0x07
	MOV		A, R0
	SUBB	A, #0x07
	MOV		R0, A
CHARHEXTOINTC:
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	SUBB	A, #0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	MOV		A, #0x0F
	SUBB	A, R0
	JNC		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	MOV		A, R0
	CLR		C
	SUBB	A, #0x20
	MOV		R0, A
	JC		CHARHEXTOINTD
	;CHECK FOR LESS THAN "A"
	SUBB	A, #0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	MOV		A, R0
	SUBB	A, #0x10
	JC		CHARHEXTOINTA
CHARHEXTOINTD:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
	RET
