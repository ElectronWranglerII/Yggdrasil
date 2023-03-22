;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;COMPARES TWO STRINGS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING A ADDRESS
;	A1		= STRING B ADDRESS
;	[A0]	= STRING A
;	[A1]	= STRING B
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	A1		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	[A1]	= VALUE ON ENTRY
;	Z		= 0 IF STRINGS UNEQUAL
;	Z		= 1 IF STRINGS EQUAL
STRCMP:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRCMPA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;STRING A CHARACTER == STRING B CHARACTER?
	CMP.B	(A1), D1
	BNE		STRCMPC
	;CHARACTER == TERMINATOR?
	CMP.B	(A1)+, D0
	BNE		STRCMPA
STRCMPB:
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
STRCMPC:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
