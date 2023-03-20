;* Yggdrasil (TM) Core Operating System (Z80): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	C = 0 IF VALUE IS AN INTEGER
;		A	= CHARACTER
;	C = 1 IF VALUE IS NOT AN INTEGER
;		A	= 0x00
CHARFROMINT:
	;VALUE > 0x09?
	CP		0x0A
	JR		NC, CHARFROMINTA
	;CONVERT TO CHARACTER
	ADD		A, 0x30
	RET
CHARFROMINTA:
	XOR		A
	SCF
	RET
