;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS AN OPENING BRACKET
;("(", "[", "{")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF OPENING BRACKET NOT FOUND
;	CF		= 1 IF OPENING BRACKET FOUND
STRHASBRACO:
	;SAVE REGISTERS
	PUSH	H
STRHASBRACOA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == FACTORAL ("(")?
	CPI		0x28
	JZ		STRHASBRACOB
	;CHARACTER == MODULO ("[")?
	CPI		0x5B
	JZ		STRHASBRACOB
	;CHARACTER == MULTIPLICATION ("{")?
	CPI		0x7B
	JZ		STRHASBRACOB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASBRACOC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASBRACOA
STRHASBRACOB:
	;OPENING BRACKET FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASBRACOC:
	;OPENING BRACKET NOT FOUND
	POP		H
	XRA		A
	RET
