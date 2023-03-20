;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A NUMBER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NUMBER
;	C = 1 IF VALUE IS A NUMBER
CHARISNUMBER:
	;CHECK FOR LESS THAN "0"
	CP		0x30
	JR		C, CHARISNUMBERA
	;CHECK FOR GREATER THAN "9"
	CP		0x3A
	JR		C, CHARISNUMBERB
CHARISNUMBERA:
	OR		A
	RET
CHARISNUMBERB:
	SCF
	RET
