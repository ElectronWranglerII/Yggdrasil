;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS PUNCTUATION CHARACTERS
;("!", ".", "?")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF PUNCTUATION CHARACTER NOT FOUND
;	CF		= 1 IF PUNCTUATION CHARACTER FOUND
STRHASPUNCT:
	;SAVE REGISTERS
	PUSH	H
STRHASPUNCTA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == "!"?
	CPI		0x21
	JZ		STRHASPUNCTB
	;CHARACTER == "."?
	CPI		0x2E
	JZ		STRHASPUNCTB
	;CHARACTER == "?"?
	CPI		0x3F
	JZ		STRHASPUNCTB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASPUNCTC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASPUNCTA
STRHASPUNCTB:
	;PUNCTUATION CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASPUNCTC:
	;PUNCTUATION CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET
