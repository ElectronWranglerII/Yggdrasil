;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LOWERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT A LOWERCASE LETTER
;	CF = 1 IF VALUE IS A LOWERCASE LETTER
CHARISLOWER:
	;CHECK FOR LESS THAN "a"
	CPI		0x61
	JC		CHARISLOWERA
	;CHECK FOR GREATER THAN "z"
	CPI		0x7B
	JC		CHARISLOWERB
CHARISLOWERA:
	ORA		A
	RET
CHARISLOWERB:
	STC
	RET
