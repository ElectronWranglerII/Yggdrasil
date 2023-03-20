;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A RELATIONAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A RELATIONAL OPERATOR
;	C = 1 IF VALUE IS A RELATIONAL OPERATOR
CHARISREL:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "<"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x3C
	JC		CHARISRELA
	;CHECK FOR GREATER THAN ">"
	MOV		A, #0x3E
	SUBB	A, R0
	JC		CHARISRELA
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISRELA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
