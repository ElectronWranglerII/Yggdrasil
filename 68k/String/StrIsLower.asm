;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY LOWERCASE LETTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-LOWERCASE CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-LOWERCASE CHARACTERS FOUND
STRISLOWER:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRISLOWERA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRISLOWERC
    ;CHARACTER < "a"?
    CMPI.B  #$61, (A0)
    BCS     STRISLOWERB
    ;CHECK FOR GREATER THAN "z"
    CMPI.B  #$7B, (A0)+
    BCS     STRISLOWERA
STRISLOWERB:
    CLR.B   D7
	MOVE.L	(SP)+, A0
    RTS
STRISLOWERC:
    SEQ		D7
	MOVE.L	(SP)+, A0
    RTS
