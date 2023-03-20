;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
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
	CPI		0x20
	JC		CHARISNPCA
	;CHECK FOR 0x7F
	CPI		0x7F
	JZ		CHARISNPCA
	ORA		A
	RET
CHARISNPCA:
	STC
	RET
