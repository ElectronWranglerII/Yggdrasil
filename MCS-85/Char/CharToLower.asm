;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
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
;		A = VALUE ON ENTRY
CHARTOLOWER:
	;CHECK FOR LESS THAN "A"
	CPI		0x41
	JC		CHARTOLOWERA
	;CHECK FOR GREATER THAN "Z"
	CPI		0x5B
	JNC		CHARTOLOWERA
	;CONVERT TO LOWERCASE
	ADI		0x20
	RET
CHARTOLOWERA:
	XRA		A
	STC
	RET
