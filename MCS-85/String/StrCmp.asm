;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;COMPARES TWO STRINGS
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= STRING B ADDRESS
;	HL		= STRING A ADDRESS
;	[DE]	= STRING B
;	[HL]	= STRING A
;ON RETURN:
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	Z		= 0 IF STRINGS UNEQUAL
;		A	= STR_NOTEQUAL
;	Z		= 1 IF STRINGS EQUAL
;		A	= STR_EQUAL
STRCMP:
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
STRCMPA:
	;LOAD CHARACTER FROM STRING B
	LDAX	D
	;STRING A CHARACTER == STRING B CHARACTER?
	CMP		M
	JNZ		STRCMPB
	;STRING A CHARACTER == STRING B CHARACTER
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRCMPC
	;CHARACTER != TERMINATOR
	;POINT TO NEXT CHARACTER IN STRING A
	INX		H
	;POINT TO NEXT CHARACTER IN STRING B
	INX		D
	JMP		STRCMPA
STRCMPB:
	;STRING A CHARACTER != STRING B CHARACTER
	POP		H
	POP		D
	MVI		A, STR_NOTEQUAL
	RET
STRCMPC:
	;CHARACTER == TERMINATOR
	POP		H
	POP		D
	MVI		A, STR_EQUAL
	RET
