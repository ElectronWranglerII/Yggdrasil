;* Yggdrasil (TM) Core Operating System (65C02): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A NON-PRINTING CHARACTER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NON-PRINTING CHARACTER
;	C = 1 IF VALUE IS A NON-PRINTING CHARACTER
CHARISNPC:
	;CHECK FOR LESS THAN 0x20
	CMP		#0x20
	BMI		CHARISNPCA	
	;CHECK FOR 0x7F
	CMP		#0x7F
	BEQ		CHARISNPCA	
	CLC
	RTS
CHARISNPCA:
	SEC
	RTS
