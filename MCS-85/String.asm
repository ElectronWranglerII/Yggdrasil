;* Yggdrasil (TM) Core Operating System (MCS-80/85): String Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.


STR_SUCCESS		EQU	0x00
STR_FAIL		EQU	0x01
STR_EQUAL		EQU	0x02
STR_NOTEQUAL	EQU	0x03
STR_FOUND		EQU	0x04
STR_NOTFOUND	EQU	0x05
STR_TRUE		EQU	0x06
STR_FALSE		EQU	0x07
STR_OVERFLOW	EQU	0x08


;COMPARES TWO STRINGS
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= STRING B ADDRESS
;	HL		= STRING A ADDRESS
;	[DE]	= STRING B
;	[HL]	= STRING A
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	Z		= 0 IF STRINGS UNEQUAL
;	Z		= 1 IF STRINGS EQUAL
STRCMP:
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
STRCMPA:
	;LOAD CHARACTER FROM STRING B
	LDAX	D
	;STRING A CHARACTER == STRING B CHARACTER?
	CMP		M
	JNZ		STRCMPB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRCMPB
	;POINT TO NEXT CHARACTER IN STRING A
	INX		H
	;POINT TO NEXT CHARACTER IN STRING B
	INX		D
	JMP		STRCMPA
STRCMPB:
	POP		H
	POP		D
	MVI		A, 0x00
	RET


;COPIES THE SOURCE STRING TO THE DESTINATION STRING
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[DE]	= DESTINATION STRING
;	[HL]	= SOURCE STRING
;ON RETURN:
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= EQUAL TO [HL]
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRCOPY:
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
STRCOPYA:
	;LOAD CHARACTER FROM SOURCE STRING
	MOV		A, M
	;STORE CHARACTER IN DESTINATION STRING
	STAX	D
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRCOPYB
	;CHARACTER != TERMINATOR
	;POINT TO NEXT CHARACTER OF SOURCE STRING
	INX		H
	;POINT TO NEXT CHARACTER OF DESTINATION STRING
	INX		D
	JMP		STRCOPYA
STRCOPYB:
	;CHARACTER == TERMINATOR
	POP		H
	POP		D
	RET


;COUNTS THE NUMBER OF TIMES A CHARACTER OCCURS WITHIN A STRING
;ON ENTRY:
;	B		= TERMINATOR
;	C		= TARGET CHARACTER
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	B		= VALUE ON ENTRY
;	C		= VALUE ON ENTRY
;	DE		= CHARACTER COUNT
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CHARACTER NOT FOUND
;		A	= 0x00 IF NO ERROR
;		A	= STR_OVERFLOW IF COUNT OVERFLOWED
;	CF		= 1 IF CHARACTER FOUND
;		A	= 0x00
STRCOUNTCHR:
	;SAVE REGISTERS
	PUSH	H
	;ZEROIZE CHARACTER COUNT
	LXI		D, 0x0000
STRCOUNTCHRA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRCOUNTCHRC
	;CHARACTER == TARGET CHARACTER?
	CMP		C
	JNZ		STRCOUNTCHRB
	;INCREMENT CHARACTER COUNT
	INX		D
	;CHARACTER COUNT OVERFLOW?
	MOV		A, D
	ORA		E
	JZ		STRCOUNTCHRE
STRCOUNTCHRB:
	;POINT TO NEXT CHARACTER IN STRING
	INX		H
	JMP		STRCOUNTCHRA
STRCOUNTCHRC:
	;CHARACTER FOUND?
	MOV		A, D
	ORA		E
	JZ		STRCOUNTCHRD
	;
	XRA		A
	STC
STRCOUNTCHRD:
	;RESTORE REGISTERS & RETURN
	POP		H
	RET
STRCOUNTCHRE:
	;RESTORE REGISTERS & RETURN
	POP		H
	MVI		A, STR_OVERFLOW
	ORA		A
	RET


;SEARCHES THE STRING FOR A CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	C		= TARGET CHARACTER
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	C		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CHARACTER NOT FOUND
;		HL		= VALUE ON ENTRY
;	CF		= 1 IF CHARACTER FOUND
;		HL		= ADDRESS OF FOUND CHARACTER
STRFINDCHR:
	;SAVE REGISTERS
	PUSH	H
STRFINDCHRA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRFINDCHRB
	;CHARACTER == TARGET CHARACTER?
	CMP		C
	JZ		STRFINDCHRC
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	JMP		STRFINDCHRA
STRFINDCHRB:
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
STRFINDCHRC:
	;RESTORE REGISTERS & RETURN
	POP		B
	POP		B
	XRA		A
	STC
	RET


;SEARCHES THE STRING THE NTH INSTANCE OF A CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	C		= TARGET CHARACTER
;	DE		= INSTANCE COUNT
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	C		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CHARACTER NOT FOUND
;		HL		= VALUE ON ENTRY
;	CF		= 1 IF CHARACTER FOUND
;		HL		= ADDRESS OF FOUND CHARACTER
STRFINDCHRI:
	;INSTANCE COUNT == 0?
	MOV		A, D
	ORA		E
	JZ		STRFINDCHRID
	;SAVE REGISTERS
	PUSH	D
	PUSH	H
	;ADJUST INSTANCE COUNT
	INX		D
STRFINDCHRIA:
	;DECREMENT INSTANCE COUNT
	DCX		D
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRFINDCHRIB
	;CHARACTER == TARGET CHARACTER?
	CMP		C
	JZ		STRFINDCHRIC
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	JMP		STRFINDCHRIA
STRFINDCHRIB:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		D
	XRA		A
	RET
STRFINDCHRIC:
	;POINT TO NEXT CHARACTER OF STRING
	INX		H
	;INSTANCE COUNT == 0?
	MOV		A, D
	ORA		E
	JNZ		STRFINDCHRIA
STRFINDCHRID:
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		D
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ARITHMETIC CHARACTERS
;("!", "%", "*", "+", "-", "/", "=", "^")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF ARITHMETIC CHARACTER NOT FOUND
;	CF		= 1 IF ARITHMETIC CHARACTER FOUND
STRHASARITH:
	;SAVE REGISTERS
	PUSH	H
STRHASARITHA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == FACTORAL ("!")?
	CPI		0x21
	JZ		STRHASARITHB
	;CHARACTER == MODULO ("%")?
	CPI		0x25
	JZ		STRHASARITHB
	;CHARACTER == MULTIPLICATION ("*")?
	CPI		0x2A
	JZ		STRHASARITHB
	;CHARACTER == ADDITION ("+")?
	CPI		0x2B
	JZ		STRHASARITHB
	;CHARACTER == SUITRACTION ("-")?
	CPI		0x2D
	JZ		STRHASARITHB
	;CHARACTER == DIVISION ("/")?
	CPI		0x2F
	JZ		STRHASARITHB
	;CHARACTER == EQUALS ("=")?
	CPI		0x3D
	JZ		STRHASARITHB
	;CHARACTER == EXPONENT ("^")?
	CPI		0x5E
	JZ		STRHASARITHB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASARITHC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASARITHA
STRHASARITHB:
	;ARITHMETIC CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASARITHC:
	;ARITHMETIC CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS A CLOSING BRACKET
;(")", "]", "}")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF CLOSING BRACKET NOT FOUND
;	CF		= 1 IF CLOSING BRACKET FOUND
STRHASBRACC:
	;SAVE REGISTERS
	PUSH	H
STRHASBRACCA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == ")"?
	CPI		0x29
	JZ		STRHASBRACCB
	;CHARACTER == "]"?
	CPI		0x5D
	JZ		STRHASBRACCB
	;CHARACTER == "}"?
	CPI		0x7D
	JZ		STRHASBRACCB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASBRACCC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASBRACCA
STRHASBRACCB:
	;CLOSING BRACKET FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASBRACCC:
	;CLOSING BRACKET NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS AN OPENING BRACKET
;("(", "[", "{")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF OPENING BRACKET NOT FOUND
;	CF		= 1 IF OPENING BRACKET FOUND
STRHASBRACO:
	;SAVE REGISTERS
	PUSH	H
STRHASBRACOA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == FACTORAL ("(")?
	CPI		0x28
	JZ		STRHASBRACOB
	;CHARACTER == MODULO ("[")?
	CPI		0x5B
	JZ		STRHASBRACOB
	;CHARACTER == MULTIPLICATION ("{")?
	CPI		0x7B
	JZ		STRHASBRACOB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASBRACOC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASBRACOA
STRHASBRACOB:
	;OPENING BRACKET FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASBRACOC:
	;OPENING BRACKET NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS LOGIC CHARACTERS
;("!", "&", "^", "|")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF LOGIC CHARACTER NOT FOUND
;	CF		= 1 IF LOGIC CHARACTER FOUND
STRHASLOGIC:
	;SAVE REGISTERS
	PUSH	H
STRHASLOGICA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == NOT ("!")?
	CPI		0x21
	JZ		STRHASLOGICB
	;CHARACTER == AND ("&")?
	CPI		0x26
	JZ		STRHASLOGICB
	;CHARACTER == XOR ("^")?
	CPI		0x5E
	JZ		STRHASLOGICB
	;CHARACTER == OR ("|")?
	CPI		0x7C
	JZ		STRHASLOGICB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASLOGICC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASLOGICA
STRHASLOGICB:
	;LOGIC CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASLOGICC:
	;LOGIC CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS LOWERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF LOWERCASE LETTER NOT FOUND
;	CF		= 1 IF LOWERCASE LETTER FOUND
STRHASLOWER:
	;SAVE REGISTERS
	PUSH	H
STRHASLOWERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASLOWERD
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRHASLOWERB
	;CHARACTER > "z"?
	CPI		0x7B
	JC		STRHASLOWERC
STRHASLOWERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASLOWERA
STRHASLOWERC:
	;LOWERCASE LETTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASLOWERD:
	;LOWERCASE LETTER NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS NON-PRINTING CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-PRINTING CHARACTER NOT FOUND
;	CF		= 1 IF NON-PRINTING CHARACTER FOUND
STRHASNPC:
	;SAVE REGISTERS
	PUSH	H
STRHASNPCA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER < 0x20?
	CPI		0x20
	JC		STRHASNPCB
	;CHARACTER == 0x7F?
	CPI		0x7F
	JZ		STRHASNPCB
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASNPCC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASNPCA
STRHASNPCB:
	;NON-PRINTING CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASNPCC:
	;NON-PRINTING CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS PUNCTUATION CHARACTERS
;("!", ".", "?")
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF PUNCTUATION CHARACTER NOT FOUND
;	CF		= 1 IF PUNCTUATION CHARACTER FOUND
STRHASPUNCT:
	;SAVE REGISTERS
	PUSH	H
STRHASPUNCTA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == "!"?
	CPI		0x21
	JZ		STRHASPUNCTB
	;CHARACTER == "."?
	CPI		0x2E
	JZ		STRHASPUNCTB
	;CHARACTER == "?"?
	CPI		0x3F
	JZ		STRHASPUNCTB
	;CHARACTER == TERMINATOR
	CMP		B
	JZ		STRHASPUNCTC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASPUNCTA
STRHASPUNCTB:
	;PUNCTUATION CHARACTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASPUNCTC:
	;PUNCTUATION CHARACTER NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS RELATIONAL OPERATORS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF RELATIONAL OPERATOR NOT FOUND
;	CF		= 1 IF RELATIONAL OPERATOR FOUND
STRHASREL:
	;SAVE REGISTERS
	PUSH	H
STRHASRELA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASRELD
	;CHARACTER < "<"?
	CPI		0x3C
	JC		STRHASRELB
	;CHARACTER > ">"?
	CPI		0x3F
	JC		STRHASRELC
STRHASRELB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASRELA
STRHASRELC:
	;RELATIONAL OPERATOR FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASRELD:
	;RELATIONAL OPERATOR NOT FOUND
	POP		H
	XRA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS UPPERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= STRING ADDRESS
;	[HL]	= STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF UPPERCASE LETTER NOT FOUND
;	CF		= 1 IF UPPERCASE LETTER FOUND
STRHASUPPER:
	;SAVE REGISTERS
	PUSH	H
STRHASUPPERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRHASUPPERD
	;CHARACTER < "a"?
	CPI		0x41
	JC		STRHASUPPERB
	;CHARACTER > "z"?
	CPI		0x5B
	JC		STRHASUPPERC
STRHASUPPERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRHASUPPERA
STRHASUPPERC:
	;UPPERCASE LETTER FOUND
	POP		H
	XRA		A
	STC
	RET
STRHASUPPERD:
	;UPPERCASE LETTER NOT FOUND
	POP		H
	XRA		A
	RET


;INVERTS THE CASE OF LETTERS WITHIN A STRING
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= NEW STRING
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRINVCASE:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	D
	PUSH	H
STRINVCASEA:
	;LOAD CHARACTER FROM SOURCE STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRINVCASED
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRINVCASEC
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRINVCASEC
	;CHARACTER > "Z"?
	CPI		0x5B
	JNC		STRINVCASEB
	;CONVERT TO LOWERCASE
	ADI		0x20
	JMP		STRINVCASEC
STRINVCASEB:
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRINVCASEC
	;CONVERT TO UPPERCASE
	SUI		0x20
STRINVCASEC:
	;STORE CHARACTER
	STAX	D
	;POINT TO NEXT SOURCE CHARACTER
	INX		H
	;POINT TO NEXT DESTINATION CHARACTER
	INX		D
	JMP		STRINVCASEA
STRINVCASED:
	;STORE TERMINATOR CHARACTER
	STAX	D
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		D
	POP		PSW
	ORA		A
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY LETTER AND NUMBER CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-ALPHANUMERIC CHARACTERS FOUND
;	CF		= 1 IF NO NON-ALPHANUMERIC CHARACTERS FOUND
STRISALNUM:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISALNUMA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISALNUMD
	;CHARACTER < "0"?
	CPI		0x30
	JC		STRISALNUMC
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRISALNUMC
	;CHARACTER > "9"?
	CPI		0x3A
	JC		STRISALNUMB
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRISALNUMC
	;CHARACTER > "Z"?
	CPI		0x5B
	JC		STRISALNUMB
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRISALNUMC
STRISALNUMB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISALNUMA
STRISALNUMC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISALNUMD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY LETTER CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-LETTER CHARACTERS FOUND
;	CF		= 1 IF NO NON-LETTER CHARACTERS FOUND
STRISALPHA:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISALPHAA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISALPHAD
	;CHARACTER < "A"?
	CPI		0x30
	JC		STRISALPHAC
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRISALPHAC
	;CHARACTER > "Z"?
	CPI		0x5B
	JC		STRISALPHAB
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRISALPHAC
STRISALPHAB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISALPHAA
STRISALPHAC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISALPHAD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY LOWERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-LOWERCASE CHARACTERS FOUND
;	CF		= 1 IF NO NON-LOWERCASE CHARACTERS FOUND
STRISLOWER:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISLOWERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISLOWERD
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRISLOWERC
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRISLOWERC
STRISLOWERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISLOWERA
STRISLOWERC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISLOWERD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY NUMERIC CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-NUMERIC CHARACTERS FOUND
;	CF		= 1 IF NO NON-NUMERIC CHARACTERS FOUND
STRISNUM:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISNUMA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISNUMD
	;CHARACTER < "0"?
	CPI		0x30
	JC		STRISNUMC
	;CHARACTER > "9"?
	CPI		0x3A
	JNC		STRISNUMC
STRISNUMB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISNUMA
STRISNUMC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISNUMD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY PRINTABLE CHARACTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-PRINTABLE CHARACTERS FOUND
;	CF		= 1 IF NO NON-PRINTABLE CHARACTERS FOUND
STRISPRINT:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISPRINTA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISPRINTD
	;CHARACTER < 0x20?
	CPI		0x20
	JC		STRISPRINTC
	;CHARACTER == 0x7F?
	CPI		0x7F
	JZ		STRISPRINTC
STRISPRINTB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISPRINTA
STRISPRINTC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISPRINTD:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS TRUE IF THE STRING CONTAINS ONLY UPPERCASE LETTERS
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NON-UPPERCASE CHARACTERS FOUND
;	CF		= 1 IF NO NON-UPPERCASE CHARACTERS FOUND
STRISUPPER:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
STRISUPPERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRISUPPERD
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRISUPPERC
	;CHARACTER > "Z"?
	CPI		0x5B
	JNC		STRISUPPERC
STRISUPPERB:
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRISUPPERA
STRISUPPERC:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	RET
STRISUPPERD:
	;R4ESTORE REGISTERS & RETURN
	POP		H
	POP		PSW
	XRA		A
	STC
	RET


;RETURNS THE LENGTH OF A STRING, NOT INCLUDING THE TERMINATING CHARACTER
;ON ENTRY:
;	B		= TERMINATOR
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= VALUE ON ENTRY
;	CF		= 0 IF NO ERROR
;		A		= 0x00
;		DE		= CHARACTER COUNT
;	CF		= 1 IF ERROR
;		A		= STR_OVERFLOW
;		DE		= 0x0000
STRLEN:
	;SAVE REGISTERS
	PUSH	H
	;ZEROIZE CHARACTER COUNT
	LXI		D, 0x0000
STRLENA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRLENB
	;INCREMENT CHARACTER COUNT
	INX		D
	;COUNT OVERFLOW?
	MOV		A, D
	ORA		E
	JZ		STRLENC
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRLENA
STRLENB:
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
STRLENC:
	;RESTORE REGISTERS & RETURN
	POP		H
	MVI		A, STR_OVERFLOW
	STC
	RET


;CONVERTS A STRING TO LOWERCASE
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= NEW STRING
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRTOLOWER:
	;SAVE REGISTERS
	PUSH	H
STRTOLOWERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRTOLOWERC
	;CHARACTER < "A"?
	CPI		0x41
	JC		STRTOLOWERB
	;CHARACTER > "Z"?
	CPI		0x5B
	JNC		STRTOLOWERB
	;CONVERT TO LOWERCASE
	ADI		0x20
STRTOLOWERB:
	;STORE CHARACTER IN DESTINATION
	STAX	D
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRTOLOWERA
STRTOLOWERC:
	;STORE TERMINATOR
	STAX	D
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET


;CONVERTS A STRING TO UPPERCASE
;ON ENTRY:
;	B		= TERMINATOR
;	DE		= DESTINATION STRING ADDRESS
;	HL		= SOURCE STRING ADDRESS
;	[HL]	= SOURCE STRING
;ON RETURN:
;	A		= 0x00
;	B		= VALUE ON ENTRY
;	DE		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[DE]	= NEW STRING
;	[HL]	= VALUE ON ENTRY
;	CF		= 0
STRTOUPPER:
	;SAVE REGISTERS
	PUSH	H
STRTOUPPERA:
	;LOAD CHARACTER FROM STRING
	MOV		A, M
	;CHARACTER == TERMINATOR?
	CMP		B
	JZ		STRTOUPPERC
	;CHARACTER < "a"?
	CPI		0x61
	JC		STRTOUPPERB
	;CHARACTER > "z"?
	CPI		0x7B
	JNC		STRTOUPPERB
	;CONVERT TO UPPERCASE
	SUI		0x20
STRTOUPPERB:
	;STORE CHARACTER IN DESTINATION
	STAX	D
	;POINT TO NEXT CHARACTER
	INX		H
	JMP		STRTOUPPERA
STRTOUPPERC:
	;STORE TERMINATOR
	STAX	D
	;RESTORE REGISTERS & RETURN
	POP		H
	XRA		A
	RET
