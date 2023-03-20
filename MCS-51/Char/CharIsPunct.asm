;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS PUNCTUATION
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT PUNCTUATION
;	C = 1 IF VALUE IS PUNCTUATION
CHARISPUNCT:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR NOT "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISPUNCTA
	;CHECK FOR "."
	CLR		C
	MOV		A, #0x2E
	SUBB	A, R0
	JZ		CHARISPUNCTA
	;CHECK FOR "?"
	CLR		C
	MOV		A, #0x3F
	SUBB	A, R0
	JNZ		CHARISPUNCTB
CHARISPUNCTA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISPUNCTB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
