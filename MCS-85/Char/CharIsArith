;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
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
