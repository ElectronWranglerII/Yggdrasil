;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS LOWERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF LOWERCASE LETTER NOT FOUND
;	CF		= 1 IF LOWERCASE LETTER FOUND
STRHASLOWER:
	;SAVE REGISTERS
	PUSH	H
STRHASLOWERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASLOWERD
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRHASLOWERB
	;CHARACTER > "z"?
	CPI		0x7B
	JC		STRHASLOWERC
STRHASLOWERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASLOWERA
STRHASLOWERC:
	;LOWERCASE LETTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASLOWERD:
	;LOWERCASE LETTER NOT FOUND
	POP		H
	XRA		A
	RET
