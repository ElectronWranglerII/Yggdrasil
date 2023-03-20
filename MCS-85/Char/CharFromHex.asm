;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS HEXADECIMAL
;	C = 1 IF VALUE IS NOT HEXADECIMAL
CHARFROMHEX:
	;VALUE > 0x0F?
	CPI		0x10
	JNC		CHARFROMHEXB
	;CONVERT TO CHARACTER
	ADI		0x30
	;CHARACTER > "9"?
	CPI		0x3A
	JC		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	ADI		0x07
CHARFROMHEXA:
	ORA		A
	RET
CHARFROMHEXB:
	XRA		A
	STC
	RET
