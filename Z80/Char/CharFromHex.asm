;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
;	C = 0 IF VALUE IS HEXADECIMAL
;		A	= CHARACTER
;	C = 1 IF VALUE IS NOT HEXADECIMAL
;		A	= 0x00
CHARFROMHEX:
	;VALUE > 0x0F?
	CP		0x10
	JR		NC, CHARFROMHEXB
	;CONVERT TO CHARACTER
	ADD		A, 0x30
	;CHARACTER > "9"?
	CP		0x3A
	JR		C, CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	ADD		A, 0x07
CHARFROMHEXA:
	OR		A
	RET
CHARFROMHEXB:
	XOR		A
	SCF
	RET
