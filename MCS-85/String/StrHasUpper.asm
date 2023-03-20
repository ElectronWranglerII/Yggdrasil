;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS UPPERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF UPPERCASE LETTER NOT FOUND
;	CF		= 1 IF UPPERCASE LETTER FOUND
STRHASUPPER:
	;SAVE REGISTERS
	PUSH	H
STRHASUPPERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASUPPERD
	;CHARACTER < "a"?
	CPI		0x41
	JC		STRHASUPPERB
	;CHARACTER > "z"?
	CPI		0x5B
	JC		STRHASUPPERC
STRHASUPPERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASUPPERA
STRHASUPPERC:
	;UPPERCASE LETTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASUPPERD:
	;UPPERCASE LETTER NOT FOUND
	POP		H
	XRA		A
	RET
