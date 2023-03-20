;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS HEXADECIMAL
;	C = 1 IF VALUE IS NOT HEXADECIMAL
CHARFROMHEX:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;VALUE > 0x0F?
	CLR		C
	MOV		A, #0x0F
	SUBB	A, R0
	JC		CHARFROMHEXB
	;CONVERT TO CHARACTER
	MOV		A, #0x30
	ADD		A, R0
	MOV		R0, A
	;CHARACTER > "9"?
	MOV		A, #0x39
	SUBB	A, R0
	JNC		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	MOV		A, #0x07
	ADD		A, R0
	MOV		R0, A
CHARFROMHEXA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
CHARFROMHEXB:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
	RET
