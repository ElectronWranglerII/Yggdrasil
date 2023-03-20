;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A HEX CHARACTER
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A HEX CHARACTER
;	D7.B = 0xFF IF VALUE IS A HEX CHARACTER
CHARISHEX:
    ;CHECK FOR LESS THAN "0"
    CMPI.B  #$30, D0
    BCS     CHARISHEXB
    ;CHECK FOR GREATER THAN "9"
    CMPI.B  #$3A, D0
    BCS     CHARISHEXA
    ;CHECK FOR LESS THAN "A"
    CMPI.B  #$41, D0
    BCS     CHARISHEXB
    ;CHECK FOR GREATER THAN "F"
    CMPI.B  #$47, D0
    BCS     CHARISHEXA
    ;CHECK FOR LESS THAN "a"
    CMPI.B  #$61, D0
    BCS     CHARISHEXB
    ;CHECK FOR GREATER THAN "f"
    CMPI.B  #$67, D0
    BCC     CHARISHEXB
CHARISHEXA:
    MOVE.B  #$FF, D7
    RTS
CHARISHEXB:
    CLR.B   D7
    RTS
