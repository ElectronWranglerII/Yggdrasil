;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

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
