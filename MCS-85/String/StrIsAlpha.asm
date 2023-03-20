;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY LETTER CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-LETTER CHARACTERS FOUND
;	CF		= 1 IF NO NON-LETTER CHARACTERS FOUND
STRISALPHA:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISALPHAA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISALPHAD
	;CHARACTER < "A"?
	CPI		0x30
	JC		STRISALPHAC
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRISALPHAC
	;CHARACTER > "Z"?
	CPI		0x5B
	JC		STRISALPHAB
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRISALPHAC
STRISALPHAB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISALPHAA
STRISALPHAC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISALPHAD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET
