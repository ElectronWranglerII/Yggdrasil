;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
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
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;VALUE > 0x0F?
	CLR		C
	MOV		A, #0x0F
	SUBB	A, R0
	JC		CHARFROMHEXB
	;CONVERT TO CHARACTER
	MOV		A, #0x30
	ADD		A, R0
	MOV		R0, A
	;CHARACTER > "9"?
	MOV		A, #0x39
	SUBB	A, R0
	JNC		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	MOV		A, #0x07
	ADD		A, R0
	MOV		R0, A
CHARFROMHEXA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
CHARFROMHEXB:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
	RET


;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS AN INTEGER
;	C = 1 IF VALUE IS NOT AN INTEGER
CHARFROMINT:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;VALUE > 0x09
	CLR		C
	MOV		A, #0x09
	SUBB	A, R0
	JC		CHARFROMINTA
	;CONVERT TO CHARACTER
	MOV		A, #0x30
	ADD		A, R0
	MOV		R0, A
	POP		ACC
	XCH		A, R0
	RET
CHARFROMINTA:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
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
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "0"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x30
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "9"
	MOV		R0, A
	SUBB	A, #0x0A
	JNC		CHARHEXTOINTB
CHARHEXTOINTA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET
CHARHEXTOINTB:
	;SUBTRACT 0x07
	MOV		A, R0
	SUBB	A, #0x07
	MOV		R0, A
CHARHEXTOINTC:
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	SUBB	A, #0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	MOV		A, #0x0F
	SUBB	A, R0
	JNC		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	MOV		A, R0
	CLR		C
	SUBB	A, #0x20
	MOV		R0, A
	JC		CHARHEXTOINTD
	;CHECK FOR LESS THAN "A"
	SUBB	A, #0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	MOV		A, R0
	SUBB	A, #0x10
	JC		CHARHEXTOINTA
CHARHEXTOINTD:
	POP		ACC
	XCH		A, R0
	CLR		A
	SETB	C
	RET


;RETURNS TRUE IF VALUE IS AN ARITHMETIC OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN ARITHMETIC OPERATOR
;	C = 1 IF VALUE IS AN ARITHMETIC OPERATOR
CHARISARITH:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR FACTORAL "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR MODULO "%"
	CLR		C
	MOV		A, #0x25
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR MULTIPLICATION "*"
	CLR		C
	MOV		A, #0x2A
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR ADDITION "+"
	CLR		C
	MOV		A, #0x2B
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR SUITRACTION "-"
	CLR		C
	MOV		A, #0x2D
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR DIVISION "/"
	CLR		C
	MOV		A, #0x2F
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR EQUALS "="
	CLR		C
	MOV		A, #0x3D
	SUBB	A, R0
	JZ		CHARISARITHA
	;CHECK FOR EXPONENT
	CLR		C
	MOV		A, #0x5E
	SUBB	A, R0
	JNZ		CHARISARITHB
CHARISARITHA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISARITHB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS A CLOSING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A CLOSING BRACKET
;	C = 1 IF VALUE IS AN A CLOSING BRACKET
CHARISBRACC:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR ")"
	CLR		C
	MOV		A, #0x29
	SUBB	A, R0
	JZ		CHARISBRACCA
	;CHECK FOR "]"
	CLR		C
	MOV		A, #0x5D
	SUBB	A, R0
	JZ		CHARISBRACCA
	;CHECK FOR "}"
	CLR		C
	MOV		A, #0x7D
	SUBB	A, R0
	JNZ		CHARISBRACCB
CHARISBRACCA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISBRACCB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS AN OPENING BRACKET
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN OPENING BRACKET
;	C = 1 IF VALUE IS AN AN OPENING BRACKET
CHARISBRACO:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR "("
	CLR		C
	MOV		A, #0x28
	SUBB	A, R0
	JZ		CHARISBRACOA
	;CHECK FOR "["
	CLR		C
	MOV		A, #0x5B
	SUBB	A, R0
	JZ		CHARISBRACOA
	;CHECK FOR "{"
	CLR		C
	MOV		A, #0x7B
	SUBB	A, R0
	JNZ		CHARISBRACOB
CHARISBRACOA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISBRACOB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS A NON-PRINTING CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NON-PRINTING CHARACTER
;	C = 1 IF VALUE IS A NON-PRINTING CHARACTER
CHARISNPC:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN 0x20
	MOV		A, R0
	CLR		C
	SUBB	A, #0x20
	JC		CHARISNPCA
	;CHECK FOR 0x7F
	MOV		A, #0x7F
	XRL		A, R0
	JZ		CHARISNPCA
	POP		ACC
	XCH		A, R0
	RET
CHARISNPCA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET


;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "0"
	CLR		C
	MOV		A, #0x2F
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "9"
	CLR		C
	MOV		A, #0x39
	SUBB	A, R0
	JNC		CHARISHEXA
	;CHECK FOR LESS THAN "A"
	CLR		C
	MOV		A, #0x40
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "F"
	CLR		C
	MOV		A, #0x46
	SUBB	A, R0
	JNC		CHARISHEXA
	;CHECK FOR LESS THAN "a"
	CLR		C
	MOV		A, #0x60
	SUBB	A, R0
	JNC		CHARISHEXB
	;CHECK FOR GREATER THAN "f"
	CLR		C
	MOV		A, #0x66
	SUBB	A, R0
	JC		CHARISHEXB
CHARISHEXA:
	SETB	C
	POP		ACC
	XCH		A, R0
	RET
CHARISHEXB:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET


CHARISLETTER:
	;SAVE REGISTERS
	PUSH	ACC
	XCH		A, R0
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x41
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "Z"
	SUBB	A, #0x1A
	JC		CHARISLETTERA
	;CHECK FOR LESS THAN "a"
	SUBB	A, #0x06
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "z"
	SUBB	A, #0x1A
	JNC		CHARISLETTERB
CHARISLETTERA:
	POP		ACC
	XCH		A, R0
	RET
CHARISLETTERB:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET


;RETURNS TRUE IF VALUE IS A LOGICAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LOGICAL OPERATOR
;	C = 1 IF VALUE IS AN A LOGICAL OPERATOR
CHARISLOGIC:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR NOT "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR AND "&"
	CLR		C
	MOV		A, #0x26
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR XOR "^"
	CLR		C
	MOV		A, #0x5E
	SUBB	A, R0
	JZ		CHARISLOGICA
	;CHECK FOR OR "|"
	CLR		C
	MOV		A, #0x7C
	SUBB	A, R0
	JNZ		CHARISLOGICB
CHARISLOGICA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISLOGICB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS A LOWERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT A LOWERCASE LETTER
;	CF = 1 IF VALUE IS A LOWERCASE LETTER
CHARISLOWER:
	;SAVE REGISTERS
	PUSH	ACC
	XCH		A, R0
	;CHECK FOR LESS THAN "a"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x61
	JC		CHARISLOWERA
	;CHECK FOR LESS THAN "z"
	SUBB	A, #0x1A
	JNC		CHARISLOWERA
	POP		ACC
	XCH		A, R0
	RET
CHARISLOWERA:
	CLR		C
	POP		ACC
	XCH		A, R0
	RET


;RETURNS TRUE IF VALUE IS A NUMBER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NUMBER
;	C = 1 IF VALUE IS A NUMBER
CHARISNUMBER:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "0"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x30
	JC		CHARISNUMBERA
	;CHECK FOR GREATER THAN "9"
	MOV		A, #0x39
	SUBB	A, R0
	JC		CHARISNUMBERA
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISNUMBERA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS PUNCTUATION
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT PUNCTUATION
;	C = 1 IF VALUE IS PUNCTUATION
CHARISPUNCT:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR NOT "!"
	CLR		C
	MOV		A, #0x21
	SUBB	A, R0
	JZ		CHARISPUNCTA
	;CHECK FOR "."
	CLR		C
	MOV		A, #0x2E
	SUBB	A, R0
	JZ		CHARISPUNCTA
	;CHECK FOR "?"
	CLR		C
	MOV		A, #0x3F
	SUBB	A, R0
	JNZ		CHARISPUNCTB
CHARISPUNCTA:
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISPUNCTB:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS A RELATIONAL OPERATOR
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A RELATIONAL OPERATOR
;	C = 1 IF VALUE IS A RELATIONAL OPERATOR
CHARISREL:
	;SAVE REGISTERS
	XCH		A, R0
	PUSH	ACC
	;CHECK FOR LESS THAN "<"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x3C
	JC		CHARISRELA
	;CHECK FOR GREATER THAN ">"
	MOV		A, #0x3E
	SUBB	A, R0
	JC		CHARISRELA
	POP		ACC
	XCH		A, R0
	SETB	C
	RET
CHARISRELA:
	POP		ACC
	XCH		A, R0
	CLR		C
	RET


;RETURNS TRUE IF VALUE IS AN UPPERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT AN UPPERCASE LETTER
;	CF = 1 IF VALUE IS AN UPPERCASE LETTER
CHARISUPPER:
	;SAVE REGISTERS
	PUSH	ACC
	XCH		A, R0
	;CHECK FOR LESS THAN "A"
	MOV		A, R0
	CLR		C
	SUBB	A, #0x41
	JC		CHARISUPPERA
	;CHECK FOR LESS THAN "Z"
	SUBB	A, #0x1A
	JNC		CHARISUPPERA
	POP		ACC
	XCH		A, R0
	RET
CHARISUPPERA:
	CLR		C
	POP		ACC
	XCH		A, R0
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
	CLR		C
	SUBB	A, #0x30
	JC		CHARTOINTA
	;CHECK FOR GREATER THAN "9"
	SUBB	A, #0x0A
	JNC		CHARTOINTA
	ADD		A, #0x0A
	CLR		C
	RET
CHARTOINTA:
	CLR		A
	SETB	C
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
	CLR		C
	SUBB	A, #0x41
	JC		CHARTOLOWERA
	;CHECK FOR GREATER THAN "Z"
	SUBB	A, #0x1A
	JNC		CHARTOLOWERA
	ADD		A, #0x7B
	CLR		C
	RET
CHARTOLOWERA:
	CLR		A
	SETB	C
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
	;CHECK FOR LESS THAN "a"
	CLR		C
	SUBB	A, #0x61
	JC		CHARTOUPPERA
	;CHECK FOR GREATER THAN "z"
	SUBB	A, #0x1A
	JNC		CHARTOUPPERA
	ADD		A, #0x5B
	CLR		C
	RET
CHARTOUPPERA:
	CLR		A
	SETB	C
	RET