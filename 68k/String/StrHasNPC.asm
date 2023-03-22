;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS NON-PRINTING CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-PRINTING CHARACTER NOT FOUND
;	D7.B	= 0xFF IF NON-PRINTING CHARACTER FOUND
STRHASNPC:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRHASNPCA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRHASNPCC
    ;CHARACTER < 0x20?
    CMPI.B  #$20, (A0)
    BCS     STRHASNPCB
    ;CHECK FOR 0x7F
    CMPI.B  #$7F, (A0)+
    BNE     STRHASNPCA
STRHASNPCB:
	;RESTORE REGISTERS & RETURN
    MOVE.B  #$FF, D7
	MOVE.L	(SP)+, A0
    RTS
STRHASNPCC:
	;RESTORE REGISTERS & RETURN
    CLR.B   D7
	MOVE.L	(SP)+, A0
    RTS
