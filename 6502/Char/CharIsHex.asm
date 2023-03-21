;* Yggdrasil (TM) Core Operating System (65C02): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A HEX CHARACTER
;	C = 1 IF VALUE IS A HEX CHARACTER
CHARISHEX:
	;CHECK FOR LESS THAN "0"
	CMP		#0x30
	BMI		CHARISHEXA	
	;CHECK FOR GREATER THAN "9"
	CMP		#0x3A
	BMI		CHARISHEXB	
	;CHECK FOR LESS THAN "A"
	CMP		#0x41
	BMI		CHARISHEXA	
	;CHECK FOR GREATER THAN "F"
	CMP		#0x47
	BMI		CHARISHEXB	
	;CHECK FOR LESS THAN "a"
	CMP		#0x61
	BMI		CHARISHEXA	
	;CHECK FOR GREATER THAN "f"
	CMP		#0x67
	BMI		CHARISHEXB	
CHARISHEXA:
	CLC
	RTS
CHARISHEXB:
	SEC
	RTS
