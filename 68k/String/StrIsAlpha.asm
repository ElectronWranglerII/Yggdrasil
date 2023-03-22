;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY ALPHABETIC CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-ALPHABETIC CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-ALPHABETIC CHARACTERS FOUND
STRISALPHA:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRISALPHAA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRISALPHAC
	;CHARACTER > "z"?
	CMPI.B	#$7B, D1
	BCC		STRISALPHAB
	;CHARACTER < "A"?
	CMPI.B	#$41, D1
	BCS		STRISALPHAB
	;CHARACTER > "Z"?
	CMPI.B	#$5B, D1
	BCS		STRISALPHAA
	;CHARACTER < "a"?
	CMPI.B	#$7B, D1
	BCS		STRISALPHAA
STRISALPHAB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
STRISALPHAC:
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
