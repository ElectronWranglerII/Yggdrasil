;* Yggdrasil (TM) Core Operating System (65C02): Character Library
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
	SEC
	SBC		#0x30
	BMI		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "9"
	CMP		#0x0A
	BPL		CHARHEXTOINTB
CHARHEXTOINTA:
	CLC
	RTS
CHARHEXTOINTB:
	;SUBTRACT 0x07
	SBC		#0x07
CHARHEXTOINTC:
	;CHECK FOR LESS THAN "A"
	CMP		#0x0A
	BMI		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CMP		#0x10
	BMI		CHARHEXTOINTA
	;CONVERT TO UPPERCASE
	SBC		#0x20
	BMI		CHARHEXTOINTD
	;CHECK FOR LESS THAN "A"
	CMP		#0x0A
	BMI		CHARHEXTOINTD
	;CHECK FOR GREATER THAN "F"
	CMP		#0x10
	BMI     CHARHEXTOINTA
CHARHEXTOINTD:
	LDA		#0x00
	SEC
	RTS
