;* Yggdrasil (TM) Core Operating System (65C02): Character Library
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
;		A = VALUE ON ENTRY
CHARTOUPPER:
	;CHECK FOR LESS THAN "a"
	CMP		#0x61
	BMI		CHARTOUPPERA
	;CHECK FOR GREATER THAN "z"
	CMP		#0x7B
	BPL		CHARTOUPPERA
	;CONVERT TO UPPERCASE
	SEC
	SBC		#0x20
	CLC
	RTS
CHARTOUPPERA:
	SEC
	RTS
