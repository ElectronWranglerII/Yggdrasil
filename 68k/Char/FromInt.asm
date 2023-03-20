;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT INTEGER TO A CHARACTER
;ON ENTRY:
;	D0.B = SINGLE DIGIT INTEGER VALUE
;ON RETURN:
;	D7.B = 0x00 IF VALUE IS INTEGER
;		D0.B	= CHARACTER
;	D7.B = 0xFF IF VALUE IS NOT INTEGER
;		D0.B	= 0x00
CHARFROMINT:
    ;CHECK FOR GREATER THAN > 0x09
    CMPI.B  #$0A, D0
    BCC     CHARFROMINTA
    ;CONVERT TO CHARACTER
    ADDI.B  #$30, D0
    CLR.B   D7
    RTS
CHARFROMINTA:
    CLR.B   D0
    MOVE.B  #$FF, D7
    RTS
