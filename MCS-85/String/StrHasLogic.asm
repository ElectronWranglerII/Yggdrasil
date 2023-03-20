;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS LOGIC CHARACTERS
;("!", "&", "^", "|")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF LOGIC CHARACTER NOT FOUND
;	CF		= 1 IF LOGIC CHARACTER FOUND
STRHASLOGIC:
	;SAVE REGISTERS
	PUSH	H
STRHASLOGICA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == NOT ("!")?
	CPI		0x21
	JZ		STRHASLOGICB
	;CHARACTER == AND ("&")?
	CPI		0x26
	JZ		STRHASLOGICB
	;CHARACTER == XOR ("^")?
	CPI		0x5E
	JZ		STRHASLOGICB
	;CHARACTER == OR ("|")?
	CPI		0x7C
	JZ		STRHASLOGICB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASLOGICC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASLOGICA
STRHASLOGICB:
	;LOGIC CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASLOGICC:
	;LOGIC CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET
