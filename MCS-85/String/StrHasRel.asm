;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS RELATIONAL OPERATORS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF RELATIONAL OPERATOR NOT FOUND
;	CF		= 1 IF RELATIONAL OPERATOR FOUND
STRHASREL:
	;SAVE REGISTERS
	PUSH	H
STRHASRELA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASRELD
	;CHARACTER < "<"?
	CPI		0x3C
	JC		STRHASRELB
	;CHARACTER > ">"?
	CPI		0x3F
	JC		STRHASRELC
STRHASRELB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASRELA
STRHASRELC:
	;RELATIONAL OPERATOR FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASRELD:
	;RELATIONAL OPERATOR NOT FOUND
	POP		H
	XRA		A
	RET
