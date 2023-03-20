;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS AN UPPERCASE LETTER TO A LOWERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS UPPERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT UPPERCASE
;		A = 0x00
CHARTOLOWER:
	;CHECK FOR LESS THAN "A"
	CP		0x41
	JR		C, CHARTOLOWERA
	;CHECK FOR GREATER THAN "Z"
	CP		0x5B
	JR		NC, CHARTOLOWERA
	;CONVERT TO LOWERCASE
	ADD		A, 0x20
	RET
CHARTOLOWERA:
	XOR		A
	SCF
	RET
