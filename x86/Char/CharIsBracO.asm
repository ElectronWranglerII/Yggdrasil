;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN OPENING BRACKET
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	AL = VALUE ON ENTRY
;	C = 0 IF VALUE IS NOT AN OPENING BRACKET
;	C = 1 IF VALUE IS AN AN OPENING BRACKET
CHARISBRACO:
	;CHECK FOR "("
	CMP		AL, 0x28
	JZ		CHARISBRACOA
	;CHECK FOR "["
	CMP		AL, 0x5B
	JZ		CHARISBRACOA
	;CHECK FOR "{"
	CMP		AL, 0x7B
	JNZ		CHARISBRACOB
CHARISBRACOA:
	STC
	RET
CHARISBRACOB:
	CLC
	RET
