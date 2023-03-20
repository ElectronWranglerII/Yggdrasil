;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A LETTER
;	C = 1 IF VALUE IS A LETTER
CHARISLETTER:
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARISLETTERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x5B
	JC		CHARISLETTERB
	;CHECK FOR LESS THAN "a"
	CPI		0x61
	JC		CHARISLETTERA
	;CHECK FOR GREATER THAN "z"
	CPI		0x7B
	JC		CHARISLETTERB
CHARISLETTERA:
	ORA		A
	RET
CHARISLETTERB:
	STC
	RET
