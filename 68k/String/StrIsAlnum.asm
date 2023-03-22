;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY LETTER AND NUMBER CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-ALPHANUMERIC CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-ALPHANUMERIC CHARACTERS FOUND
STRISALNUM:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRISALNUMA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRISALNUMC
	;CHARACTER < "0"?
	CMPI.B	#$30, D1
	BCS		STRISALNUMB
	;CHARACTER > "z"?
	CMPI.B	#$7B, D1
	BCC		STRISALNUMB
	;CHARACTER > "9"?
	CMPI.B	#$3A, D1
	BCS		STRISALNUMA
	;CHARACTER < "A"?
	CMPI.B	#$41, D1
	BCS		STRISALNUMA
	;CHARACTER > "Z"?
	CMPI.B	#$5B, D1
	BCS		STRISALNUMA
	;CHARACTER < "a"?
	CMPI.B	#$7B, D1
	BCS		STRISALNUMA
STRISALNUMB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
STRISALNUMC:
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
