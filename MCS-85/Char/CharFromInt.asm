;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT INTEGER
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS AN INTEGER
;	C = 1 IF VALUE IS NOT AN INTEGER
CHARFROMINT:
	;VALUE > 0x09"
	CPI		0x0A
	JNC		CHARFROMINTA
	;CONVERT TO CHARACTER
	ADI		0x30
	RET
CHARFROMINTA:
	XRA		A
	STC
	RET
