;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LETTER
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A LETTER
;	D7.B = 0xFF IF VALUE IS A LETTER
CHARISLETTER:
    ;CHECK FOR LESS THAN "A"
    CMPI.B  #$41, D0
    BCS     CHARISLETTERA
    ;CHECK FOR GREATER THAN "Z"
    CMPI.B  #$5B, D0
    BCS     CHARISLETTERB
    ;CHECK FOR LESS THAN "a"
    CMPI.B  #$61, D0
    BCS     CHARISLETTERA
    ;CHECK FOR GREATER THAN "z"
    CMPI.B  #$7B, D0
    BCS     CHARISLETTERB
CHARISLETTERA:
    CLR.B   D7
    RTS
CHARISLETTERB:
    MOVE.B  #$FF, D7
    RTS
