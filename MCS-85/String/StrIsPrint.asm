;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY PRINTABLE CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-PRINTABLE CHARACTERS FOUND
;	CF		= 1 IF NO NON-PRINTABLE CHARACTERS FOUND
STRISPRINT:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISPRINTA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISPRINTD
	;CHARACTER < 0x20?
	CPI		0x20
	JC		STRISPRINTC
	;CHARACTER == 0x7F?
	CPI		0x7F
	JZ		STRISPRINTC
STRISPRINTB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISPRINTA
STRISPRINTC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISPRINTD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET
