;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LOGICAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LOGICAL OPERATOR
;	C = 1 IF VALUE IS AN A LOGICAL OPERATOR
CHARISLOGIC:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR NOT "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR AND "&"
	CLR		C
	MOV		A, #0x26
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR XOR "^"
	CLR		C
	MOV		A, #0x5E
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR OR "|"
	CLR		C
	MOV		A, #0x7C
	SUBB	A, R0
	JNZ		CHARISLOGICB
CHARISLOGICA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISLOGICB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
