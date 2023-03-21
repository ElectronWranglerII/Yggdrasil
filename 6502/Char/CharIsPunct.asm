;* Yggdrasil (TM) Core Operating System (65C02): Character Library
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
	CMP		#0x21
	BEQ		CHARISPUNCTA
	;CHECK FOR "."
	CMP		#0x2E
	BEQ		CHARISPUNCTA
	;CHECK FOR "?"
	CMP		#0x3F
	BNE		CHARISPUNCTB
CHARISPUNCTA:
	SEC
	RTS
CHARISPUNCTB:
	CLC
	RTS
