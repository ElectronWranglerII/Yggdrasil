;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY UPPERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-UPPERCASE CHARACTERS FOUND
;	CF		= 1 IF NO NON-UPPERCASE CHARACTERS FOUND
STRISUPPER:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISUPPERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISUPPERD
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRISUPPERC
	;CHARACTER > "Z"?
	CPI		0x5B
	JNC		STRISUPPERC
STRISUPPERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISUPPERA
STRISUPPERC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISUPPERD:
	;R4ESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET
