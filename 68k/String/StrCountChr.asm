;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;COUNTS THE NUMBER OF TIMES A CHARACTER OCCURS WITHIN A STRING
;ON ENTRY:
;	D0.B	= TERMINATOR
;	D1.B	= TARGET CHARACTER
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	D1.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CHARACTER NOT FOUND
;		D2		= 0x00 IF NO ERROR
;		D2		= STR_OVERFLOW IF COUNT OVERFLOWED
;	D7.B	= 0xFF IF CHARACTER FOUND
;		D2	= CHARACTER COUNT
STRCOUNTCHR:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	;ZEROIZE COUNT
	CLR.L	D2
STRCOUNTCHRA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRCOUNTCHRC
	;CHARACTER == TARGET CHARACTER?
	CMP.B	(A0)+, D1
	BNE		STRCOUNTCHRA
	;INCREMENT CHARACTER COUNT
	ADDQ.L	#$1, D2
	;COUNT OVERFLOW?
	BCC		STRCOUNTCHRA
	MOVE.B	#STR_OVERFLOW, D2
	CLR.B	D7
STRCOUNTCHRB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A0
	RTS
STRCOUNTCHRC:
	;CHARACTER FOUND?
	TST		D2
	SNE		D7
	BRA		STRCOUNTCHRB
