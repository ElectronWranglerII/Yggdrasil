;* Yggdrasil (TM) Core Operating System (65C02): Character Library
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
	CMP		#0x21
	BEQ		CHARISARITHA	
	;CHECK FOR MODULO "%"
	CMP		#0x25
	BEQ		CHARISARITHA	
	;CHECK FOR MULTIPLICATION "*"
	CMP		#0x2A
	BEQ		CHARISARITHA	
	;CHECK FOR ADDITION "+"
	CMP		#0x2B
	BEQ		CHARISARITHA
	;CHECK FOR SUBTRACTION "-"
	CMP		#0x2D
	BEQ		CHARISARITHA
	;CHECK FOR DIVISION "/"
	CMP		#0x2F
	BEQ		CHARISARITHA
	;CHECK FOR EQUALS "="
	CMP		#0x3D
	BEQ		CHARISARITHA
	;CHECK FOR EXPONENT "^"
	CMP		#0x5E
	BNE		CHARISARITHB
CHARISARITHA:
	SEC
	RTS
CHARISARITHB:
	CLC
	RTS
