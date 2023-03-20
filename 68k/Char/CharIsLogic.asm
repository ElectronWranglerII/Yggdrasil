;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A LOGICAL OPERATOR
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A LOGICAL OPERATOR
;	D7.B = 0xFF IF VALUE IS AN A LOGICAL OPERATOR
CHARISLOGIC:
    ;CHECK FOR NOT "!"
    CMPI.B  #$21, D0
    BEQ     CHARISLOGICA
    ;CHECK FOR AND "&"
    CMPI.B  #$26, D0
    BEQ     CHARISLOGICA
    ;CHECK FOR XOR "^"
    CMPI.B  #$5E, D0
    BEQ     CHARISLOGICA
    ;CHECK FOR OR "|"
    CMPI.B  #$7C, D0
    BNE     CHARISLOGICB
CHARISLOGICA:
    MOVE.B  #$FF, D7
    RTS
CHARISLOGICB:
    CLR.B   D7
    RTS
