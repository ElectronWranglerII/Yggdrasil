;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS THE LENGTH OF A STRING, NOT INCLUDING THE TERMINATING CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NO ERROR
;		A		= 0x00
;		DE		= CHARACTER COUNT
;	CF		= 1 IF ERROR
;		A		= STR_OVERFLOW
;		DE		= 0x0000
STRLEN:
	;SAVE REGISTERS
	PUSH	H
	;ZEROIZE CHARACTER COUNT
	LXI		D, 0x0000
STRLENA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRLENB
	;INCREMENT CHARACTER COUNT
	INX		D
	;COUNT OVERFLOW?
	MOV		A, D
	ORA		E
	JZ		STRLENC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRLENA
STRLENB:
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
STRLENC:
	;RESTORE REGISTERS & RETURN
	POP		H
	MVI		A, STR_OVERFLOW
	STC
	RET
