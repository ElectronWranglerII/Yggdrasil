;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
