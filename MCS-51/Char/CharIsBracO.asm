;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN OPENING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN OPENING BRACKET
;	C = 1 IF VALUE IS AN AN OPENING BRACKET
CHARISBRACO:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR "("
	CLR		C
	MOV		A, #0x28
	SUBB	A, R0
	JZ		CHARISBRACOA
	;CHECK FOR "["
	CLR		C
	MOV		A, #0x5B
	SUBB	A, R0
	JZ		CHARISBRACOA
	;CHECK FOR "{"
	CLR		C
	MOV		A, #0x7B
	SUBB	A, R0
	JNZ		CHARISBRACOB
CHARISBRACOA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISBRACOB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
