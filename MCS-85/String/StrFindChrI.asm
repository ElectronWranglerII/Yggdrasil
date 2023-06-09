;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;SEARCHES THE STRING THE NTH INSTANCE OF A CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	C		= TARGET CHARACTER
;	DE		= INSTANCE COUNT
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	C		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CHARACTER NOT FOUND
;		HL		= VALUE ON ENTRY
;	CF		= 1 IF CHARACTER FOUND
;		HL		= ADDRESS OF FOUND CHARACTER
STRFINDCHRI:
	;INSTANCE COUNT == 0?
	MOV		A, D
	ORA		E
	JZ		STRFINDCHRID
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
	;ADJUST INSTANCE COUNT
	INX		D
STRFINDCHRIA:
	;DECREMENT INSTANCE COUNT
	DCX		D
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRFINDCHRIB
	;CHARACTER == TARGET CHARACTER?
	CMP		C
	JZ		STRFINDCHRIC
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	JMP		STRFINDCHRIA
STRFINDCHRIB:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		D
	XRA		A
	RET
STRFINDCHRIC:
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	;INSTANCE COUNT == 0?
	MOV		A, D
	ORA		E
	JNZ		STRFINDCHRIA
STRFINDCHRID:
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		D
	XRA		A
	STC
	RET
