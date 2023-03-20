;* Yggdrasil (TM) Core Operating System (MCS-80/85): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE HEX CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	A = VALUE
;ON RETURN:
;	C = 0 IF CHARACTER IS HEX
;			A = INTEGER VALUE
;	C = 1 IF CHARACTER IS NOT HEX
;			A = 0x00
CHARHEXTOINT:
	;CHECK FOR LESS THAN "0"
	SUI		0x30
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "9"
	CPI		0x0A
	JNC		CHARHEXTOINTB
CHARHEXTOINTA:
	ORA		A
	RET
CHARHEXTOINTB:
	;SUITRACT 0x07
	SUI		0x07
CHARHEXTOINTC:
	;CHECK FOR LESS THAN "A"
	CPI		0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CPI		0x10
	JC		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SUI		0x20
	JC		CHARHEXTOINTD
	;CHECK FOR LESS THAN "A"
	CPI		0x0A
	JC		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CPI		0x10
	JC		CHARHEXTOINTA
CHARHEXTOINTD:
	XRA		A
	STC
	RET
