;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS NON-PRINTING CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-PRINTING CHARACTER NOT FOUND
;	CF		= 1 IF NON-PRINTING CHARACTER FOUND
STRHASNPC:
	;SAVE REGISTERS
	PUSH	H
STRHASNPCA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER < 0x20?
	CPI		0x20
	JC		STRHASNPCB
	;CHARACTER == 0x7F?
	CPI		0x7F
	JZ		STRHASNPCB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASNPCC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASNPCA
STRHASNPCB:
	;NON-PRINTING CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASNPCC:
	;NON-PRINTING CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET
