;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;COPIES THE SOURCE STRING TO THE DESTINATION STRING
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[DE]	= DESTINATION STRING
;	[HL]	= SOURCE STRING
;ON RETURN:
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= EQUAL TO [HL]
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRCOPY:
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
STRCOPYA:
	;LOAD CHARACTER FROM SOURCE STRING
	MOV		A, M
	;STORE CHARACTER IN DESTINATION STRING
	STAX	D
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRCOPYB
	;CHARACTER != TERMINATOR
	;POINT TO NEXT CHARACTER OF SOURCE STRING
	INX		H
	;POINT TO NEXT CHARACTER OF DESTINATION STRING
	INX		D
	JMP		STRCOPYA
STRCOPYB:
	;CHARACTER == TERMINATOR
	POP		H
	POP		D
	RET
