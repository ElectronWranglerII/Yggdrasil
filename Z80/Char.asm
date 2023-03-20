;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
;	C = 0 IF VALUE IS HEXADECIMAL
;		A	= CHARACTER
;	C = 1 IF VALUE IS NOT HEXADECIMAL
;		A	= 0x00
CHARFROMHEX:
	;VALUE > 0x0F?
	CP		0x10
	JR		NC, CHARFROMHEXB
	;CONVERT TO CHARACTER
	ADD		A, 0x30
	;CHARACTER > "9"?
	CP		0x3A
	JR		C, CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	ADD		A, 0x07
CHARFROMHEXA:
	OR		A
	RET
CHARFROMHEXB:
	XOR		A
	SCF
	RET


;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	C = 0 IF VALUE IS AN INTEGER
;		A	= CHARACTER
;	C = 1 IF VALUE IS NOT AN INTEGER
;		A	= 0x00
CHARFROMINT:
	;VALUE > 0x09"
	CP		0x0A
	JR		NC, CHARFROMINTA
	;CONVERT TO CHARACTER
	ADD		A, 0x30
	RET
CHARFROMINTA:
	XOR		A
	SCF
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
	SUB		0x30
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "9"
	CP		0x0A
	JR		NC, CHARHEXTOINTB
CHARHEXTOINTA:
	OR		A
	RET
CHARHEXTOINTB:
	;SUBTRACT 0x07
	SUB		0x07
	;CHECK FOR LESS THAN "A"
	CP		0x0A
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CP		0x10
	JR		C, CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SUB		0x20
	JR		C, CHARHEXTOINTC
	;CHECK FOR LESS THAN "A"
	CP		0x0A
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CP		0x10
	JR		C, CHARHEXTOINTA
CHARHEXTOINTC:
	XOR		A
	SCF
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
	CP		0x21
	JR		Z, CHARISARITHA
	;CHECK FOR MODULO "%"
	CP		0x25
	JR		Z, CHARISARITHA
	;CHECK FOR MULTIPLICATION "*"
	CP		0x2A
	JR		Z, CHARISARITHA
	;CHECK FOR ADDITION "+"
	CP		0x2B
	JR		Z, CHARISARITHA
	;CHECK FOR SUBTRACTION "-"
	CP		0x2D
	JR		Z, CHARISARITHA
	;CHECK FOR DIVISION "/"
	CP		0x2F
	JR		Z, CHARISARITHA
	;CHECK FOR EQUALS "="
	CP		0x3D
	JR		Z, CHARISARITHA
	;CHECK FOR EXPONENT
	CP		0x5E
	JR		NZ, CHARISARITHB
CHARISARITHA:
	SCF
	RET
CHARISARITHB:
	OR		A
	RET


;RETURNS TRUE IF VALUE IS A CLOSING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A CLOSING BRACKET
;	C = 1 IF VALUE IS AN A CLOSING BRACKET
CHARISBRACC:
	;CHECK FOR ")"
	CP		0x29
	JR		Z, CHARISBRACCA
	;CHECK FOR "]"
	CP		0x5D
	JR		Z, CHARISBRACCA
	;CHECK FOR "}"
	CP		0x7D
	JR		NZ, CHARISBRACCB
CHARISBRACCA:
	SCF
	RET
CHARISBRACCB:
	OR		A
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
	CP		0x28
	JR		Z, CHARISBRACOA
	;CHECK FOR "["
	CP		0x5B
	JR		Z, CHARISBRACOA
	;CHECK FOR "{"
	CP		0x7B
	JR		NZ, CHARISBRACOB
CHARISBRACOA:
	SCF
	RET
CHARISBRACOB:
	OR		A
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
	CP		0x20
	JR		C, CHARISCTRLA
	;CHECK FOR 0x7F
	CP		0x7F
	JR		Z, CHARISCTRLA
	OR		A
	RET
CHARISCTRLA:
	SCF
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
	CP		0x30
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "9"
	CP		0x3A
	JR		C, CHARISHEXB
	;CHECK FOR LESS THAN "A"
	CP		0x41
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "F"
	CP		0x47
	JR		C, CHARISHEXB
	;CHECK FOR LESS THAN "a"
	CP		0x61
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "f"
	CP		0x67
	JR		C, CHARISHEXB
CHARISHEXA:
	OR		A
	RET
CHARISHEXB:
	SCF
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
	CP		0x41
	JR		C, CHARISLETTERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		C, CHARISLETTERB
	;CHECK FOR LESS THAN "a"
	CP		0x61
	JR		C, CHARISLETTERA
	;CHECK FOR GREATER THAN "z"
	CP		0x7B
	JR		C, CHARISLETTERB
CHARISLETTERA:
	OR		A
	RET
CHARISLETTERB:
	SCF
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
	CP		0x21
	JR		Z, CHARISLOGICA
	;CHECK FOR AND "&"
	CP		0x26
	JR		Z, CHARISLOGICA
	;CHECK FOR XOR "^"
	CP		0x5E
	JR		Z, CHARISLOGICA
	;CHECK FOR OR "|"
	CP		0x7C
	JR		NZ, CHARISLOGICB
CHARISLOGICA:
	SCF
	RET
CHARISLOGICB:
	OR		A
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
	CP		0x61
	JR		C, CHARISLOWERA
	;CHECK FOR GREATER THAN "z"
	CP		0x7B
	JR		C, CHARISLOWERB
CHARISLOWERA:
	OR		A
	RET
CHARISLOWERB:
	SCF
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
	CP		0x30
	JR		C, CHARISNUMBERA
	;CHECK FOR GREATER THAN "9"
	CP		0x3A
	JR		C, CHARISNUMBERB
CHARISNUMBERA:
	OR		A
	RET
CHARISNUMBERB:
	SCF
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
	CP		0x21
	JR		Z, CHARISPUNCTA
	;CHECK FOR "."
	CP		0x2E
	JR		Z, CHARISPUNCTA
	;CHECK FOR "?"
	CP		0x3F
	JR		NZ, CHARISPUNCTB
CHARISPUNCTA:
	SCF
	RET
CHARISPUNCTB:
	OR		A
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
	CP		0x3C
	JR		C, CHARISRELA
	;CHECK FOR GREATER THAN ">"
	CP		0x3F
	JR		C, CHARISRELB
CHARISRELA:
	OR		A
	RET
CHARISRELB:
	SCF
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
	CP		0x41
	JR		C, CHARISUPPERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		C, CHARISUPPERB
CHARISUPPERA:
	OR		A
	RET
CHARISUPPERB:
	SCF
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
	SUB		0x30
	JR		C, CHARTOINTA
	;CHECK FOR GREATER THAN "9"
	CP		0x0A
	JR		NC, CHARTOINTA
	OR		A
	RET
CHARTOINTA:
	XOR		A
	SCF
	RET


;CONVERTS AN UPPERCASE LETTER TO A LOWERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS UPPERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT UPPERCASE
;		A = 0x00
CHARTOLOWER:
	;CHECK FOR LESS THAN "A"
	CP		0x41
	JR		C, CHARTOLOWERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		NC, CHARTOLOWERA
	;CONVERT TO LOWERCASE
	ADD		A, 0x20
	RET
CHARTOLOWERA:
	XOR		A
	SCF
	RET


;CONVERTS A LOWERCASE LETTER TO AN UPPERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS LOWERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT LOWERCASE
;		A = 0x00
CHARTOUPPER:
	;CHECK FOR LESS THAN "A"
	CP		0x61
	JR		C, CHARTOUPPERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x7B
	JR		NC, CHARTOUPPERA
	;CONVERT TO LOWERCASE
	SUB		0x20
	RET
CHARTOUPPERA:
	XOR		A
	SCF
	RET
