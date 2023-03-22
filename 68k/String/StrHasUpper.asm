;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS UPPERCASE LETTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF UPPERCASE LETTER NOT FOUND
;	D7.B	= 0xFF IF UPPERCASE LETTER FOUND
STRHASUPPER:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRHASUPPERA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASUPPERC
    ;CHARACTER < "A"?
    CMPI.B  #$41, D1
    BCS     STRHASUPPERA
    ;CHECK FOR GREATER THAN "Z"
    CMPI.B  #$5B, D1
    BCC     STRHASUPPERA
STRHASUPPERB:
	SCS		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASUPPERC:
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
