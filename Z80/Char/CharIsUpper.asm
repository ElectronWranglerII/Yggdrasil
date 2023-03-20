;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
	CP		0x41
	JR		C, CHARISUPPERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		C, CHARISUPPERB
CHARISUPPERA:
	OR		A
	RET
CHARISUPPERB:
	SCF
	RET
