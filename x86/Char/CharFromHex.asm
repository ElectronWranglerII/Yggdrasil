;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	AL = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS HEXADECIMAL
;	C = 1 IF VALUE IS NOT HEXADECIMAL
CHARFROMHEX:
	;VALUE > 0x0F?
	CMP		AL, 0x10
	JNC		CHARFROMHEXB
	;CONVERT TO CHARACTER
	ADD		AL, 0x30
	;CHARACTER > "9"?
	CMP		AL, 0x3A
	JC		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	ADD		AL, 0x07
CHARFROMHEXA:
	CLC
	RET
CHARFROMHEXB:
	XOR		AL, AL
	STC
	RET
