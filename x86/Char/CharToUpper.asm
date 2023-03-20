;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A LOWERCASE LETTER TO AN UPPERCASE LETTER
;ON ENTRY:
;	AL = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS LOWERCASE
;		AL = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT LOWERCASE
;		AL = VALUE ON ENTRY
CHARTOUPPER:
	;CHECK FOR LESS THAN "a"
	CMP		AL, 0x61
	JC		CHARTOUPPERB
	;CHECK FOR GREATER THAN "z"
	CMP		AL, 0x7B
	JNC		CHARTOUPPERA
	;CONVERT TO UPPERCASE
	SUB		AL, 0x20
	RET
CHARTOUPPERA:
	STC
CHARTOUPPERB:
	RET
