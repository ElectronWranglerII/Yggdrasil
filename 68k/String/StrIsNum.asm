;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ONLY NUMERIC CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-NUMERIC CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-NUMERIC CHARACTERS FOUND
STRISNUM:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRISNUMA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRISNUMC
    ;CHARACTER < "0"?
    CMPI.B  #$30, (A0)
    BCS     STRISNUMB
    ;CHECK FOR GREATER THAN "9"
    CMPI.B  #$3A, (A0)+
    BCS     STRISNUMA
STRISNUMB:
    CLR.B   D7
	MOVE.L	(SP)+, A0
    RTS
STRISNUMC:
    SEQ		D7
	MOVE.L	(SP)+, A0
    RTS
