;* Yggdrasil (TM) Core Operating System (65C02): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	A = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	A = VALUE ON ENTRY
;	C = 0 IF VALUE IS HEXADECIMAL
;	C = 1 IF VALUE IS NOT HEXADECIMAL
CHARFROMHEX:
	;VALUE > 0x0F?
	CMP		#0x10
	BPL		CHARFROMHEXB
	;CONVERT TO CHARACTER
	CLC
	ADC		#0x30
	;CHARACTER > "9"?
	CMP		#0x3A
	BMI		CHARFROMHEXA
	;ADD 0x07 TO CHARACTER
	CLC
	ADC		#0x07
CHARFROMHEXA:
	RTS
CHARFROMHEXB:
	LDA		#0x00
	RTS
