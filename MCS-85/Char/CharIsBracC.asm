;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
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
	CPI		0x29
	JZ		CHARISBRACCA
	;CHECK FOR "]"
	CPI		0x5D
	JZ		CHARISBRACCA
	;CHECK FOR "}"
	CPI		0x7D
	JNZ		CHARISBRACCB
CHARISBRACCA:
	STC
	RET
CHARISBRACCB:
	ORA		A
	RET
