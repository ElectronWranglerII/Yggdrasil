;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY UPPERCASE LETTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-UPPERCASE CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-UPPERCASE CHARACTERS FOUND
STRISUPPER:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRISUPPERA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRISUPPERC
    ;CHARACTER < "A"?
    CMPI.B  #$41, (A0)
    BCS     STRISUPPERB
    ;CHECK FOR GREATER THAN "Z"
    CMPI.B  #$5B, (A0)+
    BCS     STRISUPPERA
STRISUPPERB:
    CLR.B   D7
	MOVE.L	(SP)+, A0
    RTS
STRISUPPERC:
    SEQ		D7
	MOVE.L	(SP)+, A0
    RTS
