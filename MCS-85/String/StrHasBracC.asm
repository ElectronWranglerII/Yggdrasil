;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS A CLOSING BRACKET
;(")", "]", "}")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CLOSING BRACKET NOT FOUND
;	CF		= 1 IF CLOSING BRACKET FOUND
STRHASBRACC:
	;SAVE REGISTERS
	PUSH	H
STRHASBRACCA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == ")"?
	CPI		0x29
	JZ		STRHASBRACCB
	;CHARACTER == "]"?
	CPI		0x5D
	JZ		STRHASBRACCB
	;CHARACTER == "}"?
	CPI		0x7D
	JZ		STRHASBRACCB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASBRACCC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASBRACCA
STRHASBRACCB:
	;CLOSING BRACKET FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASBRACCC:
	;CLOSING BRACKET NOT FOUND
	POP		H
	XRA		A
	RET
