;* Yggdrasil (TM) Core Operating System (Z80): Character Library
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
	SUB		0x30
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "9"
	CP		0x0A
	JR		NC, CHARHEXTOINTB
CHARHEXTOINTA:
	OR		A
	RET
CHARHEXTOINTB:
	;SUBTRACT 0x07
	SUB		0x07
	;CHECK FOR LESS THAN "A"
	CP		0x0A
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CP		0x10
	JR		C, CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SUB		0x20
	JR		C, CHARHEXTOINTC
	;CHECK FOR LESS THAN "A"
	CP		0x0A
	JR		C, CHARHEXTOINTC
	;CHECK FOR GREATER THAN "F"
	CP		0x10
	JR		C, CHARHEXTOINTA
CHARHEXTOINTC:
	XOR		A
	SCF
	RET
