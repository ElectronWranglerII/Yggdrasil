;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

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
