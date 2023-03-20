;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

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
