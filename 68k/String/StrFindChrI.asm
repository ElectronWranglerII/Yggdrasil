;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;SEARCHES THE STRING THE NTH INSTANCE OF A CHARACTER
;ON ENTRY:
;	D0.B	= TERMINATOR
;	D1.B	= TARGET CHARACTER
;	D2		= INSTANCE COUNT
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	D1.B	= VALUE ON ENTRY
;	D2		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CHARACTER NOT FOUND
;		A0		= VALUE ON ENTRY
;	D7.B	= 0xFF IF CHARACTER FOUND
;		A0		= ADDRESS OF FOUND CHARACTER
STRFINDCHRI:
	;INSTANCE COUNT == 0?
	TST.L	D2
	BEQ		STRFINDCHRIC
	;SAVE REGISTERS
	MOVE.L	D2, -(SP)
	MOVE.L	A0, -(SP)
STRFINDCHRIA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRFINDCHRIB
	;CHARACTER == TARGET CHARACTER?
	CMP.B	(A0)+, D1
	BNE		STRFINDCHRIA
	;DECREMENT INSTANCE COUNT
	SUBQ.L	#$1, D2
	BNE		STRFINDCHRIA
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	SUBQ.L	#$1, A0
	ADDQ.L	#$4, SP
	MOVE.L	(SP)+, D2
	RTS
STRFINDCHRIB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D2
STRFINDCHRIC:
	CLR.B	D7
	RTS
