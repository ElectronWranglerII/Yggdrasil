;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
	CP		0x41
	JR		C, CHARISLETTERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		C, CHARISLETTERB
	;CHECK FOR LESS THAN "a"
	CP		0x61
	JR		C, CHARISLETTERA
	;CHECK FOR GREATER THAN "z"
	CP		0x7B
	JR		C, CHARISLETTERB
CHARISLETTERA:
	OR		A
	RET
CHARISLETTERB:
	SCF
	RET
