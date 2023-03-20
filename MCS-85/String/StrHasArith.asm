;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ARITHMETIC CHARACTERS
;("!", "%", "*", "+", "-", "/", "=", "^")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF ARITHMETIC CHARACTER NOT FOUND
;	CF		= 1 IF ARITHMETIC CHARACTER FOUND
STRHASARITH:
	;SAVE REGISTERS
	PUSH	H
STRHASARITHA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == FACTORAL ("!")?
	CPI		0x21
	JZ		STRHASARITHB
	;CHARACTER == MODULO ("%")?
	CPI		0x25
	JZ		STRHASARITHB
	;CHARACTER == MULTIPLICATION ("*")?
	CPI		0x2A
	JZ		STRHASARITHB
	;CHARACTER == ADDITION ("+")?
	CPI		0x2B
	JZ		STRHASARITHB
	;CHARACTER == SUITRACTION ("-")?
	CPI		0x2D
	JZ		STRHASARITHB
	;CHARACTER == DIVISION ("/")?
	CPI		0x2F
	JZ		STRHASARITHB
	;CHARACTER == EQUALS ("=")?
	CPI		0x3D
	JZ		STRHASARITHB
	;CHARACTER == EXPONENT ("^")?
	CPI		0x5E
	JZ		STRHASARITHB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASARITHC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASARITHA
STRHASARITHB:
	;ARITHMETIC CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASARITHC:
	;ARITHMETIC CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET
