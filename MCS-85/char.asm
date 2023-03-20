;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.


;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS HEXADECIMAL
;	C = 1 IF VALUE IS NOT HEXADECIMAL
CHARFROMHEX:
	;VALUE > 0x0F?
	CPI		0x10
	JNC		CHARFROMHEXB
	;CONVERT TO CHARACTER
	ADI		0x30
	;CHARACTER > "9"?
	CPI		0x3A
	JC		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	ADI		0x07
CHARFROMHEXA:
	ORA		A
	RET
CHARFROMHEXB:
	XRA		A
	STC
	RET


;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS AN INTEGER
;	C = 1 IF VALUE IS NOT AN INTEGER
CHARFROMINT:
	;VALUE > 0x09"
	CPI		0x0A
	JNC		CHARFROMINTA
	;CONVERT TO CHARACTER
	ADI		0x30
	RET
CHARFROMINTA:
	XRA		A
	STC
	RET
	
	
;CONVERTS THE HEX CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	C = 0 IF CHARACTER IS HEX
;			A = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT HEX
;			A = 0x00
CHARHEXTOINT:
	;CHECK FOR LESS THAN "0"
	SUI		0x30
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "9"
	CPI		0x0A
	JNC		CHARHEXTOINTB
CHARHEXTOINTA:
	ORA		A
	RET
CHARHEXTOINTB:
	;SUITRACT 0x07
	SUI		0x07
CHARHEXTOINTC:
	;CHECK FOR LESS THAN "A"
	CPI		0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CPI		0x10
	JC		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SUI		0x20
	JC		CHARHEXTOINTD
	;CHECK FOR LESS THAN "A"
	CPI		0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CPI		0x10
	JC		CHARHEXTOINTA
CHARHEXTOINTD:
	XRA		A
	STC
	RET


;RETURNS TRUE IF VALUE IS AN ARITHMETIC OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN ARITHMETIC OPERATOR
;	C = 1 IF VALUE IS AN ARITHMETIC OPERATOR
CHARISARITH:
	;CHECK FOR FACTORAL "!"
	CPI		0x21
	JZ		CHARISARITHA
	;CHECK FOR MODULO "%"
	CPI		0x25
	JZ		CHARISARITHA
	;CHECK FOR MULTIPLICATION "*"
	CPI		0x2A
	JZ		CHARISARITHA
	;CHECK FOR ADDITION "+"
	CPI		0x2B
	JZ		CHARISARITHA
	;CHECK FOR SUITRACTION "-"
	CPI		0x2D
	JZ		CHARISARITHA
	;CHECK FOR DIVISION "/"
	CPI		0x2F
	JZ		CHARISARITHA
	;CHECK FOR EQUALS "="
	CPI		0x3D
	JZ		CHARISARITHA
	;CHECK FOR EXPONENT
	CPI		0x5E
	JNZ		CHARISARITHB
CHARISARITHA:
	STC
	RET
CHARISARITHB:
	ORA		A
	RET


;RETURNS TRUE IF VALUE IS A CLOSING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A CLOSING BRACKET
;	C = 1 IF VALUE IS AN A CLOSING BRACKET
CHARISBRACC:
	;CHECK FOR "("
	CPI		0x29
	JZ		CHARISBRACCA
	;CHECK FOR "["
	CPI		0x5D
	JZ		CHARISBRACCA
	;CHECK FOR "{"
	CPI		0x7D
	JNZ		CHARISBRACCB
CHARISBRACCA:
	STC
	RET
CHARISBRACCB:
	ORA		A
	RET


;RETURNS TRUE IF VALUE IS AN OPENING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN OPENING BRACKET
;	C = 1 IF VALUE IS AN AN OPENING BRACKET
CHARISBRACO:
	;CHECK FOR "("
	CPI		0x28
	JZ		CHARISBRACOA
	;CHECK FOR "["
	CPI		0x5B
	JZ		CHARISBRACOA
	;CHECK FOR "{"
	CPI		0x7B
	JNZ		CHARISBRACOB
CHARISBRACOA:
	STC
	RET
CHARISBRACOB:
	ORA		A
	RET


;RETURNS TRUE IF VALUE IS A CONTROL CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A CONTROL CHARACTER
;	C = 1 IF VALUE IS A CONTROL CHARACTER
CHARISCTRL:
	;CHECK FOR LESS THAN 0x20
	CPI		0x20
	JC		CHARISCTRLA
	;CHECK FOR 0x7F
	CPI		0x7F
	JZ		CHARISCTRLA
	ORA		A
	RET
CHARISCTRLA:
	STC
	RET


;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;CHECK FOR LESS THAN "0"
	CPI		0x30
	JC		CHARISHEXA
	;CHECK FOR GREATER THAN "9"
	CPI		0x3A
	JC		CHARISHEXB
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARISHEXA
	;CHECK FOR GREATER THAN "F"
	CPI		0x47
	JC		CHARISHEXB
	;CHECK FOR LESS THAN "a"
	CPI		0x61
	JC		CHARISHEXA
	;CHECK FOR GREATER THAN "f"
	CPI		0x67
	JC		CHARISHEXB
CHARISHEXA:
	ORA		A
	RET
CHARISHEXB:
	STC
	RET


;RETURNS TRUE IF VALUE IS A LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LETTER
;	C = 1 IF VALUE IS A LETTER
CHARISLETTER:
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARISLETTERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x5B
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "a"
	CPI		0x61
	JC		CHARISLETTERA
	;CHECK FOR GREATER THAN "z"
	CPI		0x7B
	JC		CHARISLETTERB
CHARISLETTERA:
	ORA		A
	RET
CHARISLETTERB:
	STC
	RET


;RETURNS TRUE IF VALUE IS A LOGICAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LOGICAL OPERATOR
;	C = 1 IF VALUE IS AN A LOGICAL OPERATOR
CHARISLOGIC:
	;CHECK FOR NOT "!"
	CPI		0x21
	JZ		CHARISLOGICA
	;CHECK FOR AND "&"
	CPI		0x26
	JZ		CHARISLOGICA
	;CHECK FOR XOR "^"
	CPI		0x5E
	JZ		CHARISLOGICA
	;CHECK FOR OR "|"
	CPI		0x7C
	JNZ		CHARISLOGICB
CHARISLOGICA:
	STC
	RET
CHARISLOGICB:
	ORA		A
	RET


;RETURNS TRUE IF VALUE IS A LOWERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT A LOWERCASE LETTER
;	CF = 1 IF VALUE IS A LOWERCASE LETTER
CHARISLOWER:
	;CHECK FOR LESS THAN "a"
	CPI		0x61
	JC		CHARISLOWERA
	;CHECK FOR GREATER THAN "z"
	CPI		0x7B
	JC		CHARISLOWERB
CHARISLOWERA:
	ORA		A
	RET
CHARISLOWERB:
	STC
	RET


;RETURNS TRUE IF VALUE IS A NUMBER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NUMBER
;	C = 1 IF VALUE IS A NUMBER
CHARISNUMBER:
	;CHECK FOR LESS THAN "0"
	CPI		0x30
	JC		CHARISNUMBERA
	;CHECK FOR GREATER THAN "9"
	CPI		0x3A
	JC		CHARISNUMBERB
CHARISNUMBERA:
	ORA		A
	RET
CHARISNUMBERB:
	STC
	RET


;RETURNS TRUE IF VALUE IS PUNCTUATION
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT PUNCTUATION
;	C = 1 IF VALUE IS PUNCTUATION
CHARISPUNCT:
	;CHECK FOR "!"
	CPI		0x21
	JZ		CHARISPUNCTA
	;CHECK FOR "."
	CPI		0x2E
	JZ		CHARISPUNCTA
	;CHECK FOR "?"
	CPI		0x3F
	JNZ		CHARISPUNCTB
CHARISPUNCTA:
	STC
	RET
CHARISPUNCTB:
	ORA		A
	RET


;RETURNS TRUE IF VALUE IS A RELATIONAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A RELATIONAL OPERATOR
;	C = 1 IF VALUE IS A RELATIONAL OPERATOR
CHARISREL:
	;CHECK FOR LESS THAN "<"
	CPI		0x3C
	JC		CHARISRELA
	;CHECK FOR GREATER THAN ">"
	CPI		0x3F
	JC		CHARISRELB
CHARISRELA:
	ORA		A
	RET
CHARISRELB:
	STC
	RET


;RETURNS TRUE IF VALUE IS AN UPPERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT AN UPPERCASE LETTER
;	CF = 1 IF VALUE IS AN UPPERCASE LETTER
CHARISUPPER:
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARISUPPERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x5B
	JC		CHARISUPPERB
CHARISUPPERA:
	ORA		A
	RET
CHARISUPPERB:
	STC
	RET


;CONVERTS THE CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER IS AN INTEGER
;			A = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT AN INTEGER
;			A = 0x00
CHARTOINT:
	;CHECK FOR LESS THAN "0"
	SUI		0x30
	JC		CHARTOINTA
	;CHECK FOR GREATER THAN "9"
	CPI		0x0A
	JNC		CHARTOINTA
	ORA		A
	RET
CHARTOINTA:
	XRA		A
	STC
	RET


;CONVERTS AN UPPERCASE LETTER TO A LOWERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS UPPERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT UPPERCASE
;		A = VALUE ON ENTRY
CHARTOLOWER:
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARTOLOWERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x5B
	JNC		CHARTOLOWERA
	;CONVERT TO LOWERCASE
	ADI		0x20
	RET
CHARTOLOWERA:
	XRA		A
	STC
	RET


;CONVERTS A LOWERCASE LETTER TO AN UPPERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS LOWERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT LOWERCASE
;		A = VALUE ON ENTRY
CHARTOUPPER:
	;CHECK FOR LESS THAN "A"
	CPI		0x61
	JC		CHARTOUPPERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x7B
	JNC		CHARTOUPPERA
	;CONVERT TO LOWERCASE
	SUI		0x20
	RET
CHARTOUPPERA:
	XRA		A
	STC
	RET
