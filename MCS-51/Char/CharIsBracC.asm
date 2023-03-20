;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A CLOSING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A CLOSING BRACKET
;	C = 1 IF VALUE IS AN A CLOSING BRACKET
CHARISBRACC:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR ")"
	CLR		C
	MOV		A, #0x29
	SUBB	A, R0
	JZ		CHARISBRACCA
	;CHECK FOR "]"
	CLR		C
	MOV		A, #0x5D
	SUBB	A, R0
	JZ		CHARISBRACCA
	;CHECK FOR "}"
	CLR		C
	MOV		A, #0x7D
	SUBB	A, R0
	JNZ		CHARISBRACCB
CHARISBRACCA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISBRACCB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
