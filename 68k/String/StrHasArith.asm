;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF THE STRING CONTAINS ARITHMETIC CHARACTERS
;("!", "%", "*", "+", "-", "/", "=", "^")
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF ARITHMETIC CHARACTER NOT FOUND
;	D7.B	= 0xFF IF ARITHMETIC CHARACTER FOUND
STRHASARITH:
	;SAVE REGISTERS
	MOVE.L	D0, -(SP)
	MOVE.L	A0, -(SP)
STRHASARITHA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASARITHC
    ;CHECK FOR FACTORAL "!"
    CMPI.B  #$21, D1
    BEQ     STRHASARITHB
    ;CHECK FOR MODULO "%"
    CMPI.B  #$25, D1
    BEQ     STRHASARITHB
    ;CHECK FOR MULTIPLICATION "*"
    CMPI.B  #$2A, D1
    BEQ     STRHASARITHB
    ;CHECK FOR ADDITION "+"
    CMPI.B  #$2B, D1
    BEQ     STRHASARITHB
    ;CHECK FOR SUBTRACTION "-"
    CMPI.B  #$2D, D1
    BEQ     STRHASARITHB
    ;CHECK FOR DIVISION "/"
    CMPI.B  #$2F, D1
    BEQ     STRHASARITHB
    ;CHECK FOR EQUALS "="
    CMPI.B  #$3D, D1
    BEQ     STRHASARITHB
    ;CHECK FOR EXPONENT "^"
    CMPI.B  #$5E, D1
    BNE     STRHASARITHA
STRHASARITHB:
	;RESTORE REGISTERS & RETURN
    SEQ  	D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASARITHC:
	;RESTORE REGISTERS & RETURN
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
