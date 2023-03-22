;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;COPIES THE SOURCE STRING TO THE DESTINATION STRING
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
;	[A1]	= EQUAL TO [A0]
STRCOPY:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
	;
	SUBQ.L	#$1, A0
STRCOPYA:
	ADDQ.L	#$1, A0
	;COPY CHARACTER FROM SOURCE TO DESTINATION
	MOVE.B	(A0), (A1)+
	;CHARACTER == TERMINATOR?
	COPY.B	(A0), D0
	BNE		STRCOPYA
STRCOPYB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	RTS
