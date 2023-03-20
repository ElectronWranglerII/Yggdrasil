;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF CALUE IS NOT A LETTER
;	C = 1 IF VALUE IS A LETTER
CHARISLETTER:
	;SAVE REGISTERS
	PUSH	ACC
	XCH		A, R0
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x41
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "Z"
	SUBB	A, #0x1A
	JC		CHARISLETTERA
	;CHECK FOR LESS THAN "a"
	SUBB	A, #0x06
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "z"
	SUBB	A, #0x1A
	JNC		CHARISLETTERB
CHARISLETTERA:
	POP		ACC
	XCH		A, R0
	RET
CHARISLETTERB:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET
