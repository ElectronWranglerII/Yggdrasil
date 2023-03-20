;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A RELATIONAL OPERATOR
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A RELATIONAL OPERATOR
;	D7.B = 0xFF IF VALUE IS A RELATIONAL OPERATOR
CHARISREL:
    ;CHECK FOR LESS THAN "<"
    CMPI.B  #$3C, D0
    BCS     CHARISRELA
    ;CHECK FOR GREATER THAN ">"
    CMPI.B  #$3F, D0
    BCS     CHARISRELB
CHARISRELA:
    CLR.B   D7
    RTS
CHARISRELB:
    MOVE.B  #$FF, D7
    RTS
