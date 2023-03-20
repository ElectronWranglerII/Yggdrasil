;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;SEARCHES THE STRING FOR A CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	C		= TARGET CHARACTER
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	C		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CHARACTER NOT FOUND
;		HL		= VALUE ON ENTRY
;	CF		= 1 IF CHARACTER FOUND
;		HL		= ADDRESS OF FOUND CHARACTER
STRFINDCHR:
	;SAVE REGISTERS
	PUSH	H
STRFINDCHRA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRFINDCHRB
	;CHARACTER != TERMINATOR
	;CHARACTER == TARGET CHARACTER?
	CMP		C
	JZ		STRFINDCHRC
	;CHARACTER != TARGET CHARACTER
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	JMP		STRFINDCHRA
STRFINDCHRB:
	;CHARACTER == TERMINATOR
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
STRFINDCHRC:
	;CHARACTER == TARGET CHARACTER
	POP		B
	POP		B
	XRA		A
	STC
	RET
