;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE ASCII CHARACTER IN AL TO AN INTEGER
;ON ENTRY:
;	AL = ASCII VALUE
;ON RETURN:
;	C = 0 IF CHARACTER IS A NUMBER
;			AL = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT A NUMBER
;			AL = 0x00
CHARTOINT:
	;CHECK FOR LESS THAN "0"
	SUB		AL, 0x30
	JC		CHARTOINTA
	;CHECK FOR GREATER THAN "9"
	PUSH	AX
	SUB		AL, 0x0A
	POP		AX
	JNC		CHARTOINTA
	CLC
	RET
CHARTOINTA:
	XOR		AL, AL
	STC
	RET
