;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A NON-PRINTING CHARACTER
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT A NON-PRINTING CHARACTER
;	C = 1 IF VALUE IS A NON-PRINTING CHARACTER
CHARISNPC:
	;CHECK FOR LESS THAN 0x20
	CMP		AL, 0x20
	JC		CHARISNPCA
	;CHECK FOR 0x7F
	CMP		AL, 0x7F
	JZ		CHARISNPCA
	CLC
	RET
CHARISNPCA:
	STC
	RET
