;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A STRING TO UPPERCASE
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	A1		= DESTINATION STRING ADDRESS
;	[A0]	= SOURCE STRING
;	[A1]	= DESTINATION STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	A1		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	[A1]	= NEW STRING
;	D7.B	= 0x00
STRTOUPPER:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRTOUPPERA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRTOUPPERC
    ;CHARACTER < "a"?
    CMPI.B  #$61, D1
    BCS     STRTOUPPERB
    ;CHARACTER > "z"?
    CMPI.B  #$7B, D1
    BCC     STRTOUPPERB
	;CONVERT TO UPPERCASE
    SUBI.B  #$20, D1
STRTOUPPERB:
	;STORE CHARACTER
	MOVE.B	D1, (A1)+
	BRA		STRTOUPPERA
STRTOUPPERC:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	CLR.B	D7
	RTS
