;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN ARITHMETIC OPERATOR
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN ARITHMETIC OPERATOR
;	C = 1 IF VALUE IS AN ARITHMETIC OPERATOR
CHARISARITH:
	;CHECK FOR FACTORAL "!"
	CMP		AL, 0x21
	JZ		CHARISARITHA
	;CHECK FOR MODULO "%"
	CMP		AL, 0x25
	JZ		CHARISARITHA
	;CHECK FOR MULTIPLICATION "*"
	CMP		AL, 0x2A
	JZ		CHARISARITHA
	;CHECK FOR ADDITION "+"
	CMP		AL, 0x2B
	JZ		CHARISARITHA
	;CHECK FOR SUBTRACTION "-"
	CMP		AL, 0x2D
	JZ		CHARISARITHA
	;CHECK FOR DIVISION "/"
	CMP		AL, 0x2F
	JZ		CHARISARITHA
	;CHECK FOR EQUALS "="
	CMP		AL, 0x3D
	JZ		CHARISARITHA
	;CHECK FOR EXPONENT "^"
	CMP		AL, 0x5E
	JNZ		CHARISARITHB
CHARISARITHA:
	STC
	RET
CHARISARITHB:
	CLC
	RET
