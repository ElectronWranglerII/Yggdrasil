;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS AN INTEGER
;	C = 1 IF VALUE IS NOT AN INTEGER
CHARFROMINT:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;VALUE > 0x09
	CLR		C
	MOV		A, #0x09
	SUBB	A, R0
	JC		CHARFROMINTA
	;CONVERT TO CHARACTER
	MOV		A, #0x30
	ADD		A, R0
	MOV		R0, A
	POP		ACC
	XCH		A, R0
	RET
CHARFROMINTA:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
	RET
