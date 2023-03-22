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
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRCMPA:
	;STRING A CHARACTER == STRING B CHARACTER?
	CMPM.B	(A0)+, (A1)+
	BNE		STRCMPB
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BNE		STRCMPA
STRCMPB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	RTS
