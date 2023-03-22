;* Yggdrasil (TM) Core Operating System (68K): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.


;COMPARES TWO STRINGS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING A ADDRESS
;	A1		= STRING B ADDRESS
;	[A0]	= STRING A
;	[A1]	= STRING B
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	A1		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	[A1]	= VALUE ON ENTRY
;	Z		= 0 IF STRINGS UNEQUAL
;	Z		= 1 IF STRINGS EQUAL
STRCMP:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRCMPA:
	;STRING A CHARACTER == STRING B CHARACTER?
	CMPM.B	(A0)+, (A1)+
	BNE		STRCMPB
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BNE		STRCMPA
STRCMPB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	RTS


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


;COUNTS THE NUMBER OF TIMES A CHARACTER OCCURS WITHIN A STRING
;ON ENTRY:
;	D0.B	= TERMINATOR
;	D1.B	= TARGET CHARACTER
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	D1.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CHARACTER NOT FOUND
;		D2		= 0x00 IF NO ERROR
;		D2		= STR_OVERFLOW IF COUNT OVERFLOWED
;	D7.B	= 0xFF IF CHARACTER FOUND
;		D2	= CHARACTER COUNT
STRCOUNTCHR:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	;ZEROIZE COUNT
	CLR.L	D2
STRCOUNTCHRA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRCOUNTCHRC
	;CHARACTER == TARGET CHARACTER?
	CMP.B	(A0)+, D1
	BNE		STRCOUNTCHRA
	;INCREMENT CHARACTER COUNT
	ADDQ.L	#$1, D2
	;COUNT OVERFLOW?
	BCC		STRCOUNTCHRA
	MOVE.B	#STR_OVERFLOW, D2
	CLR.B	D7
STRCOUNTCHRB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A0
	RTS
STRCOUNTCHRC:
	;CHARACTER FOUND?
	TST		D2
	SNE		D7
	BRA		STRCOUNTCHRB


;SEARCHES THE STRING FOR A CHARACTER
;ON ENTRY:
;	D0.B	= TERMINATOR
;	D1.B	= TARGET CHARACTER
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	D1.B	= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CHARACTER NOT FOUND
;		A0		= VALUE ON ENTRY
;	D7.B	= 0xFF IF CHARACTER FOUND
;		A0		= ADDRESS OF FOUND CHARACTER
STRFINDCHR:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRFINDCHRA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRFINDCHRB
	;CHARACTER == TARGET CHARACTER?
	CMP.B	(A0)+, D1
	BNE		STRFINDCHRA
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	SUBQ.L	#$1, A0
	ADDQ.L	#$4, SP
	RTS
STRFINDCHRB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	RTS


;SEARCHES THE STRING THE NTH INSTANCE OF A CHARACTER
;ON ENTRY:
;	D0.B	= TERMINATOR
;	D1.B	= TARGET CHARACTER
;	D2		= INSTANCE COUNT
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	D1.B	= VALUE ON ENTRY
;	D2		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CHARACTER NOT FOUND
;		A0		= VALUE ON ENTRY
;	D7.B	= 0xFF IF CHARACTER FOUND
;		A0		= ADDRESS OF FOUND CHARACTER
STRFINDCHRI:
	;INSTANCE COUNT == 0?
	TST.L	D2
	BEQ		STRFINDCHRIC
	;SAVE REGISTERS
	MOVE.L	D2, -(SP)
	MOVE.L	A0, -(SP)
STRFINDCHRIA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRFINDCHRIB
	;CHARACTER == TARGET CHARACTER?
	CMP.B	(A0)+, D1
	BNE		STRFINDCHRIA
	;DECREMENT INSTANCE COUNT
	SUBQ.L	#$1, D2
	BNE		STRFINDCHRIA
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	SUBQ.L	#$1, A0
	ADDQ.L	#$4, SP
	MOVE.L	(SP)+, D2
	RTS
STRFINDCHRIB:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D2
STRFINDCHRIC:
	CLR.B	D7
	RTS
	

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


;RETURNS TRUE IF THE STRING CONTAINS A CLOSING BRACKET
;(")", "]", "}")
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF CLOSING BRACKET NOT FOUND
;	D7.B	= 0xFF IF CLOSING BRACKET FOUND
STRHASBRACC:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRHASBRACCA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASBRACCC
    ;CHARACTER == ")"?
    CMPI.B  #$29, D1
    BEQ     STRHASBRACCB
    ;CHARACTER == "]"?
    CMPI.B  #$5D, D1
    BEQ     STRHASBRACCB
    ;CHARACTER == "}"?
    CMPI.B  #$7D, D1
    BNE     STRHASBRACCA
STRHASBRACCB:
    SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASBRACCC:
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS


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


;RETURNS TRUE IF THE STRING CONTAINS LOGIC CHARACTERS
;("!", "&", "^", "|")
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF LOGIC CHARACTER NOT FOUND
;	D7.B	= 0xFF IF LOGIC CHARACTER FOUND
STRHASLOGIC:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRHASLOGICA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASLOGICC
    ;CHECK FOR NOT "!"
    CMPI.B  #$21, D1
    BEQ     STRHASLOGICB
    ;CHECK FOR AND "&"
    CMPI.B  #$26, D1
    BEQ     STRHASLOGICB
    ;CHECK FOR XOR "^"
    CMPI.B  #$5E, D1
    BEQ     STRHASLOGICB
    ;CHECK FOR OR "|"
    CMPI.B  #$7C, D1
    BNE     STRHASLOGICA
STRHASLOGICB:
    SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASLOGICC:
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS


;RETURNS TRUE IF THE STRING CONTAINS LOWERCASE LETTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF LOWERCASE LETTER NOT FOUND
;	D7.B	= 0xFF IF LOWERCASE LETTER FOUND
STRHASLOWER:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRHASLOWERA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASLOWERC
    ;CHARACTER < "a"?
    CMPI.B  #$61, D1
    BCS     STRHASLOWERA
    ;CHECK FOR GREATER THAN "z"
    CMPI.B  #$7B, D1
    BCC     STRHASLOWERA
STRHASLOWERB:
	SCS		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASLOWERC:
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS


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


;RETURNS TRUE IF THE STRING CONTAINS RELATIONAL OPERATORS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= STRING ADDRESS
;	[A0]	= STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF RELATIONAL OPERATOR NOT FOUND
;	D7.B	= 0xFF IF RELATIONAL OPERATOR FOUND
STRHASREL:
	;SAVE REGISTERS
	MOVE.L	D1,	-(SP)
	MOVE.L	A0, -(SP)
STRHASRELA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRHASRELB
    ;CHECK FOR LESS THAN "<"
    CMPI.B  #$3C, D1
    BCS     STRHASRELA
    ;CHECK FOR GREATER THAN ">"
    CMPI.B  #$3F, D1
    BCC     STRHASRELA
	;RESTORE REGISTERS & RETURN
    MOVE.B  #$FF, D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS
STRHASRELB:
	;RESTORE REGISTERS & RETURN
    CLR.B   D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
    RTS


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


;INVERTS THE CASE OF LETTERS WITHIN A STRING
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
;	[A1]	= NEW STRING
STRINVCASE:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRINVCASEA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRINVCASED
	;CHARACTER < "A"?
	CMPI.B	#$41, D1
	BCS		STRINVCASEC
	;CHARACTER > "z"?
	CMPI.B	#$7B, D1
	BCC		STRINVCASEC
	;CHARACTER > "Z"?
	CMPI.B	#$5B, D1
	BCC		STRINVCASEB
	;CONVERT TO LOWERCASE
	ADDI.B	#$20, D1
	BRA		STRINVCASEC
STRINVCASEB:
	;CHARACTER < "a"?
	CMPI.B	#$41, D1
	BCS		STRINVCASEC
	;CONVERT TO UPPERCASE
	SUBI.B	#$20, D1
STRINVCASEC:
	;STORE CHARACTER
	MOVE.B	D1, (A1)+
	BRA		STRINVCASEA
STRINVCASED:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS


;RETURNS TRUE IF THE STRING CONTAINS ONLY LETTER AND NUMBER CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-ALPHANUMERIC CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-ALPHANUMERIC CHARACTERS FOUND
STRISALNUM:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
STRISALNUMA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRISALNUMC
	;CHARACTER < "0"?
	CMPI.B	#$30, D1
	BCS		STRISALNUMB
	;CHARACTER > "z"?
	CMPI.B	#$7B, D1
	BCC		STRISALNUMB
	;CHARACTER > "9"?
	CMPI.B	#$3A, D1
	BCS		STRISALNUMA
	;CHARACTER < "A"?
	CMPI.B	#$41, D1
	BCS		STRISALNUMA
	;CHARACTER > "Z"?
	CMPI.B	#$5B, D1
	BCS		STRISALNUMA
	;CHARACTER < "a"?
	CMPI.B	#$7B, D1
	BCS		STRISALNUMA
STRISALNUMB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS
STRISALNUMC:
	;RESTORE REGISTERS & RETURN
	SEQ		D7
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	RTS


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


;RETURNS TRUE IF THE STRING CONTAINS ONLY PRINTABLE CHARACTERS
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NON-PRINTABLE CHARACTERS FOUND
;	D7.B	= 0xFF IF NO NON-PRINTABLE CHARACTERS FOUND
STRISPRINT:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
STRISPRINTA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0), D0
	BEQ		STRISPRINTC
    ;CHARACTER < 0x20?
    CMPI.B  #$20, (A0)
    BCS     STRISPRINTB
    ;CHECK FOR 0x7F
    CMPI.B  #$7F, (A0)+
    BNE     STRISPRINTA
STRISPRINTB:
	;RESTORE REGISTERS & RETURN
    CLR.B	D7
	MOVE.L	(SP)+, A0
    RTS
STRISPRINTC:
	;RESTORE REGISTERS & RETURN
    SEQ		D7
	MOVE.L	(SP)+, A0
    RTS


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


;RETURNS THE LENGTH OF A STRING, NOT INCLUDING THE TERMINATING CHARACTER
;ON ENTRY:
;	D0.B	= TERMINATOR
;	A0		= SOURCE STRING ADDRESS
;	[A0]	= SOURCE STRING
;ON RETURN:
;	D0.B	= VALUE ON ENTRY
;	A0		= VALUE ON ENTRY
;	[A0]	= VALUE ON ENTRY
;	D7.B	= 0x00 IF NO ERROR
;		D1		= CHARACTER COUNT
;	D7.B	= 0xFF IF STR_OVERFLOW
;		D1		= 0x0000
STRLEN:
	;SAVE REGISTERS
	MOVE.L	A0, -(SP)
	;ZEROIZE CHARACTER COUNT
	MOVE.L	#$00000000, D1
STRLENA:
	;CHARACTER == TERMINATOR?
	CMP.B	(A0)+, D0
	BEQ		STRLENB
	;INCREMENT CHARACTER COUNT
	ADDQ.L	#$1, D1
	;COUNT OVERFLOW?
	BCC		STRLENA
	;RESTORE REGISTERS & RETURN
	SCS		D7
	MOVE.L	(SP)+, A0
	RTS
STRLENB:
	;RESTORE REGISTERS & RETURN
	CLR.B	D7
	MOVE.L	(SP)+, A0
	RTS


;CONVERTS A STRING TO LOWERCASE
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
;	[A1]	= NEW STRING
;	D7.B	= 0x00
STRTOLOWER:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRTOLOWERA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRTOLOWERC
    ;CHARACTER < "A"?
    CMPI.B  #$41, D1
    BCS     STRTOLOWERB
    ;CHARACTER > "Z"?
    CMPI.B  #$5B, D1
    BCC     STRTOLOWERB
	;CONVERT TO LOWERCASE
    ADDI.B  #$20, D1
STRTOLOWERB:
	;STORE CHARACTER
	MOVE.B	D1, (A1)+
	BRA		STRTOLOWERA
STRTOLOWERC:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	CLR.B	D7
	RTS


;CONVERTS A STRING TO UPPERCASE
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
;	[A1]	= NEW STRING
;	D7.B	= 0x00
STRTOUPPER:
	;SAVE REGISTERS
	MOVE.L	D1, -(SP)
	MOVE.L	A0, -(SP)
	MOVE.L	A1, -(SP)
STRTOUPPERA:
	;LOAD CHARACTER
	MOVE.B	(A0)+, D1
	;CHARACTER == TERMINATOR?
	CMP.B	D0, D1
	BEQ		STRTOUPPERC
    ;CHARACTER < "a"?
    CMPI.B  #$61, D1
    BCS     STRTOUPPERB
    ;CHARACTER > "z"?
    CMPI.B  #$7B, D1
    BCC     STRTOUPPERB
	;CONVERT TO UPPERCASE
    SUBI.B  #$20, D1
STRTOUPPERB:
	;STORE CHARACTER
	MOVE.B	D1, (A1)+
	BRA		STRTOUPPERA
STRTOUPPERC:
	;RESTORE REGISTERS & RETURN
	MOVE.L	(SP)+, A1
	MOVE.L	(SP)+, A0
	MOVE.L	(SP)+, D1
	CLR.B	D7
	RTS
