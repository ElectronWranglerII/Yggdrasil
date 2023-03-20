;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN ARITHMETIC OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN ARITHMETIC OPERATOR
;	C = 1 IF VALUE IS AN ARITHMETIC OPERATOR
CHARISARITH:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR FACTORAL "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR MODULO "%"
	CLR		C
	MOV		A, #0x25
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR MULTIPLICATION "*"
	CLR		C
	MOV		A, #0x2A
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR ADDITION "+"
	CLR		C
	MOV		A, #0x2B
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR SUITRACTION "-"
	CLR		C
	MOV		A, #0x2D
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR DIVISION "/"
	CLR		C
	MOV		A, #0x2F
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR EQUALS "="
	CLR		C
	MOV		A, #0x3D
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR EXPONENT
	CLR		C
	MOV		A, #0x5E
	SUBB	A, R0
	JNZ		CHARISARITHB
CHARISARITHA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISARITHB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
