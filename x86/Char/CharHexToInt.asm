;* Yggdrasil (TM) Core Operating System (x86): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE HEX CHARACTER IN AL TO AN INTEGER
;ON ENTRY:
;	AL = VALUE
;ON RETURN:
;	C = 0 IF CHARACTER IS HEX
;			AL = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT HEX
;			AL = 0x00
CHARHEXTOINT:
	;CHECK FOR LESS THAN "0"
	SUB		AL, 0x30
	JC		CHARHEXTOINTC
	;CHECK FOR GREATER THAN "9"
	CMP		AL, 0x0A
	JNC		CHARHEXTOINTB
CHARHEXTOINTA:
	CLC
	RET
CHARHEXTOINTB:
	;SUBTRACT 0x07
	SUB		AL, 0x07
	;CHECK FOR LESS THAN "A"
	CMP		AL, 0x0A
	JC		CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CMP		AL, 0x10
	JC		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SUB		AL, 0x20
	JC		CHARHEXTOINTC
	;CHECK FOR LESS THAN "A"
	CMP		AL, 0x0A
	JC		CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CMP		AL, 0x10
	JC		CHARHEXTOINTA
CHARHEXTOINTC:
	XOR		AL, AL
	STC
	RET
