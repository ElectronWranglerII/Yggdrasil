;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "0"
	CLR		C
	MOV		A, #0x2F
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "9"
	CLR		C
	MOV		A, #0x39
	SUBB	A, R0
	JNC		CHARISHEXA
	;CHECK FOR LESS THAN "A"
	CLR		C
	MOV		A, #0x40
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "F"
	CLR		C
	MOV		A, #0x46
	SUBB	A, R0
	JNC		CHARISHEXA
	;CHECK FOR LESS THAN "a"
	CLR		C
	MOV		A, #0x60
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "f"
	CLR		C
	MOV		A, #0x66
	SUBB	A, R0
	JC		CHARISHEXB
CHARISHEXA:
	SETB	C
	POP		ACC
	XCH		A, R0
	RET
CHARISHEXB:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET
