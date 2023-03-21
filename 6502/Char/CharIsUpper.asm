;* Yggdrasil (TM) Core Operating System (65C02): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN UPPERCASE LETTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	CF = 0 IF VALUE IS NOT AN UPPERCASE LETTER
;	CF = 1 IF VALUE IS AN UPPERCASE LETTER
CHARISUPPER:
	;CHECK FOR LESS THAN "A"
	CMP		#0x41
	BMI		CHARISUPPERA
	;CHECK FOR GREATER THAN "Z"
	CMP		#0x5B
	BMI		CHARISUPPERB
CHARISUPPERA:
	CLC
	RTS
CHARISUPPERB:
	SEC
	RTS
