;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;CHECK FOR LESS THAN "0"
	CP		0x30
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "9"
	CP		0x3A
	JR		C, CHARISHEXB
	;CHECK FOR LESS THAN "A"
	CP		0x41
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "F"
	CP		0x47
	JR		C, CHARISHEXB
	;CHECK FOR LESS THAN "a"
	CP		0x61
	JR		C, CHARISHEXA
	;CHECK FOR GREATER THAN "f"
	CP		0x67
	JR		C, CHARISHEXB
CHARISHEXA:
	OR		A
	RET
CHARISHEXB:
	SCF
	RET
