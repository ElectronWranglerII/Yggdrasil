;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A NUMBER
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A NUMBER
;	D7.B = 0x00 IF VALUE IS A NUMBER
CHARISNUMBER:
    ;CHECK FOR LESS THAN "0"
    CMPI.B  #$30, D0
    BCS     CHARISNUMBERA
    ;CHECK FOR GREATER THAN "9"
    CMPI.B  #$3A, D0
    BCS     CHARISNUMBERB
CHARISNUMBERA:
    CLR.B   D7
    RTS
CHARISNUMBERB:
    MOVE.B  #$FF, D7
    RTS
