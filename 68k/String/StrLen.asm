;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS THE LENGTH OF A STRING, NOT INCLUDING THE TERMINATING CHARACTER
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NO ERROR
;		D1		= CHARACTER COUNT
;	D7.B	= 0xFF IF STR_OVERFLOW
;		D1		= 0x0000
STRLEN:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	;ZEROIZE CHARACTER COUNT
	MOVE.L	#$00000000, D1
STRLENA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0)+, D0
	BEQ		STRLENB
	;INCREMENT CHARACTER COUNT
	ADDQ.L	#$1, D1
	;COUNT OVERFLOW?
	BCC		STRLENA
	;RESTORE REGISTERS & RETURN
	SCS		D7
	MOVE.L	(SP)+, A0
	RTS
STRLENB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	RTS
