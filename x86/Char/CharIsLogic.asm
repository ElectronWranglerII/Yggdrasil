;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LOGICAL OPERATOR
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LOGICAL OPERATOR
;	C = 1 IF VALUE IS AN A LOGICAL OPERATOR
CHARISLOGIC:
	;CHECK FOR NOT "!"
	CMP		AL, 0x21
	JZ		CHARISLOGICA
	;CHECK FOR AND "&"
	CMP		AL, 0x26
	JZ		CHARISLOGICA
	;CHECK FOR XOR "^"
	CMP		AL, 0x5E
	JZ		CHARISLOGICA
	;CHECK FOR OR "|"
	CMP		AL, 0x7C
	JNZ		CHARISLOGICB
CHARISLOGICA:
	STC
	RET
CHARISLOGICB:
	CLC
	RET
