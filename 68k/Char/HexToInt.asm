;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS A HEX CHARACTER TO AN INTEGER
;ON ENTRY:
;	D0.B = SINGLE DIGIT HEX CHARACTER
;ON RETURN:
;	D7.B = 0x00 IF CHARACTER IS HEX
;			D0.B = INTEGER VALUE
;	D7.B = 1 IF CHARACTER IS NOT HEX
;			D0.B = 0x00
CHARHEXTOINT:
    ;CHECK FOR LESS THAN "0"
    SUBI.B  #$30, D0
    BCS     CHARHEXTOINTC
    ;CHECK FOR GREATER THAN "9"
    CMPI.B  #$0A, D0
    BCC     CHARHEXTOINTB
CHARHEXTOINTA:
    CLR.B   D7
    RTS
CHARHEXTOINTB:
    ;CONVERT TO LETTER
    SUBI.B  #$07, D0
    ;CHECK FOR LESS THAN "A"
    CMPI.B  #$0A, D0
    BCS     CHARHEXTOINTC
    ;CHECK FOR GREATER THAN "F"
    CMPI.B  #$10, D0
    BCS     CHARHEXTOINTA
    ;CONVERT TO UPPERCASE
    SUBI.B  #$20, D0
    BCS     CHARHEXTOINTC
    ;CHECK FOR LESS THAN "A"
    CMPI.B  #$0A, D0
    BCS     CHARHEXTOINTC
    ;CHECK FOR GREATER THAN "F"
    CMPI.B  #$10, D0
    BCS     CHARHEXTOINTA
CHARHEXTOINTC:
    CLR.B   D0
    MOVE.B  #$FF, D7
    RTS
