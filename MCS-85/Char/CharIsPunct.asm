;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS PUNCTUATION
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT PUNCTUATION
;	C = 1 IF VALUE IS PUNCTUATION
CHARISPUNCT:
	;CHECK FOR "!"
	CPI		0x21
	JZ		CHARISPUNCTA
	;CHECK FOR "."
	CPI		0x2E
	JZ		CHARISPUNCTA
	;CHECK FOR "?"
	CPI		0x3F
	JNZ		CHARISPUNCTB
CHARISPUNCTA:
	STC
	RET
CHARISPUNCTB:
	ORA		A
	RET
