;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;CHECK FOR LESS THAN "0"
	CMP		AL, 0x30
	JC		CHARISHEXA
	;CHECK FOR GREATER THAN "9"
	CMP		AL, 0x3A
	JC		CHARISHEXB
	;CHECK FOR LESS THAN "A"
	CMP		AL, 0x41
	JC		CHARISHEXA
	;CHECK FOR GREATER THAN "F"
	CMP		AL, 0x47
	JC		CHARISHEXB
CHARISHEXA:
	CLC
CHARISHEXB:
	RET
