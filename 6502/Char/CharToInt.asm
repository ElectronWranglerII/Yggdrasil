;* Yggdrasil (TM) Core Operating System (65C02): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	A = CHARACTER
;ON RETURN:
;	C = 0 IF CHARACTER IS AN INTEGER
;			A = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT AN INTEGER
;			A = 0x00
CHARTOINT:
	;CHECK FOR LESS THAN "0"
	SEC
	SBC		#0x30
	BMI		CHARTOINTA	
	;CHECK FOR GREATER THAN "9"
	CMP		#0x0A
	BPL		CHARTOINTA	
	CLC
	RTS
CHARTOINTA:
	LDA		#0x00
	SEC
	RTS
