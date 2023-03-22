;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS PUNCTUATION CHARACTERS
;("!", ".", "?")
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF PUNCTUATION CHARACTER NOT FOUND
;	D7.B	= 0xFF IF PUNCTUATION CHARACTER FOUND
STRHASPUNCT:
	;SAVE REGISTERS
	MOVE.L	D1,	-(SP)
	MOVE.L	A0, -(SP)
STRHASPUNCTA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASPUNCTC
    ;CHARACTER == "!"?
    CMPI.B  #$21, D1
    BEQ     STRHASPUNCTB
    ;CHARACTER == "."?
    CMPI.B  #$2E, D1
    BEQ     STRHASPUNCTB
    ;CHARACTER == "?"?
    CMPI.B  #$3F, D1
    BNE     STRHASPUNCTA
STRHASPUNCTB:
	;RESTORE REGISTERS & RETURN
    SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASPUNCTC:
	;RESTORE REGISTERS & RETURN
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
