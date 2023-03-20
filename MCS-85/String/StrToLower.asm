;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A STRING TO LOWERCASE
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= NEW STRING
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRTOLOWER:
	;SAVE REGISTERS
	PUSH	H
STRTOLOWERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRTOLOWERC
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRTOLOWERB
	;CHARACTER > "Z"?
	CPI		0x5B
	JNC		STRTOLOWERB
	;CONVERT TO LOWERCASE
	ADI		0x20
STRTOLOWERB:
	;STORE CHARACTER IN DESTINATION
	STAX	D
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRTOLOWERA
STRTOLOWERC:
	;STORE TERMINATOR
	STAX	D
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
