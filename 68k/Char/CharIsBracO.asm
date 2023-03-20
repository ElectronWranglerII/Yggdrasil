;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.


;RETURNS TRUE IF VALUE IS AN OPENING BRACKET
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT AN OPENING BRACKET
;	D7.B = 0xFF IF VALUE IS AN AN OPENING BRACKET
CHARISBRACO:
    ;CHECK FOR "("
    CMPI.B  #$28, D0
    BEQ     CHARISBRACOA
    ;CHECK FOR "["
    CMPI.B  #$5B, D0
    BEQ     CHARISBRACOA
    ;CHECK FOR "{"
    CMPI.B  #$7B, D0
    BNE     CHARISBRACOB
CHARISBRACOA:
    MOVE.B  #$FF, D7
    RTS
CHARISBRACOB:
    CLR.B   D7
    RTS
