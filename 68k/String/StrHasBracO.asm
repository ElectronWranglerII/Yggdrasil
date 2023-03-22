;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS A OPENING BRACKET
;(")", "]", "}")
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF OPENING BRACKET NOT FOUND
;	D7.B	= 0xFF IF OPENING BRACKET FOUND
STRHASBRACO:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRHASBRACOA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASBRACOC
    ;CHARACTER == "("?
    CMPI.B  #$28, D1
    BEQ     STRHASBRACOB
    ;CHARACTER == "["?
    CMPI.B  #$5B, D1
    BEQ     STRHASBRACOB
    ;CHARACTER == "{"?
    CMPI.B  #$7B, D1
    BNE     STRHASBRACOA
STRHASBRACOB:
    SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASBRACOC:
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
