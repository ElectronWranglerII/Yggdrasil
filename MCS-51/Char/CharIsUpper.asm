;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN UPPERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT AN UPPERCASE LETTER
;	CF = 1 IF VALUE IS AN UPPERCASE LETTER
CHARISUPPER:
	;SAVE REGISTERS
	PUSH	ACC
	XCH		A, R0
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x41
	JC		CHARISUPPERA
	;CHECK FOR LESS THAN "Z"
	SUBB	A, #0x1A
	JNC		CHARISUPPERA
	POP		ACC
	XCH		A, R0
	RET
CHARISUPPERA:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET
