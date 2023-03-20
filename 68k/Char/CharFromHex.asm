;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A SINGLE DIGIT HEX VALUE TO A CHARACTER
;ON ENTRY:
;	D0.B = SINGLE DIGIT HEX VALUE
;ON RETURN:
;	D7.B = 0x00 IF VALUE IS HEXADECIMAL
;		D0.B	= CHARACTER
;	D7.B = 0xFF IF VALUE IS NOT HEXADECIMAL
;		D0.B	= 0x00
CHARFROMHEX:
    ;CHECK FOR GREATER THAN > 0x0F
    CMPI.B  #$10, D0
    BCC     CHARFROMHEXB
    ;CONVERT TO CHARACTER
    ADDI.B  #$30, D0
    ;CHARACTER > "9"?
    CMPI.B  #$3A, D0
    BCS     CHARFROMHEXA
    ;CONVERT TO LETTER
    ADDI.B  #$07, D0
CHARFROMHEXA:
    CLR.B   D7
    RTS
CHARFROMHEXB:
    CLR.B   D0
    MOVE.B  #$FF, D7
    RTS
