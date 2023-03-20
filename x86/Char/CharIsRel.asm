;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A RELATIONAL OPERATOR
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A RELATIONAL OPERATOR
;	C = 1 IF VALUE IS A RELATIONAL OPERATOR
CHARISREL:
	;CHECK FOR LESS THAN "<"
	CMP		AL, 0x3C
	JC		CHARISRELA
	;CHECK FOR GREATER THAN ">"
	CMP		AL, 0x3F
	JNC		CHARISRELB
	RET
CHARISRELA:
	CLC
CHARISRELB:
	RET
