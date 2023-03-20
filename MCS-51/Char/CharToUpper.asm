;* Yggdrasil (TM) Core Operating System (MCS-51): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A LOWERCASE LETTER TO AN UPPERCASE LETTER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS LOWERCASE
;		A = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT LOWERCASE
;		A = 0x00
CHARTOUPPER:
	;CHECK FOR LESS THAN "a"
	CLR		C
	SUBB	A, #0x61
	JC		CHARTOUPPERA
	;CHECK FOR GREATER THAN "z"
	SUBB	A, #0x1A
	JNC		CHARTOUPPERA
	ADD		A, #0x5B
	CLR		C
	RET
CHARTOUPPERA:
	CLR		A
	SETB	C
	RET
