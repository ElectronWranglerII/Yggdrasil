;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS RELATIONAL OPERATORS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF RELATIONAL OPERATOR NOT FOUND
;	D7.B	= 0xFF IF RELATIONAL OPERATOR FOUND
STRHASREL:
	;SAVE REGISTERS
	MOVE.L	D1,	-(SP)
	MOVE.L	A0, -(SP)
STRHASRELA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASRELB
    ;CHECK FOR LESS THAN "<"
    CMPI.B  #$3C, D1
    BCS     STRHASRELA
    ;CHECK FOR GREATER THAN ">"
    CMPI.B  #$3F, D1
    BCC     STRHASRELA
	;RESTORE REGISTERS & RETURN
    MOVE.B  #$FF, D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASRELB:
	;RESTORE REGISTERS & RETURN
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
