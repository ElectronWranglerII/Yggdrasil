;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS AN UPPERCASE LETTER TO AN LOWERCASE LETTER
;ON ENTRY:
;	AL = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER WAS UPPERCASE
;		AL = CONVERTED VALUE
;	C = 1 IF CHARACTER WAS NOT UPPERCASE
;		AL = VALUE ON ENTRY
CHARTOLOWER:
	;CHECK FOR LESS THAN "A"
	CMP		AL, 0x41
	JC		CHARTOLOWERB
	;CHECK FOR GREATER THAN "Z"
	CMP		AL, 0x5B
	JNC		CHARTOLOWERA
	;CONVERT TO LOWERCASE
	ADD		AL, 0x20
	RET
CHARTOLOWERA:
	STC
CHARTOLOWERB:
	RET
