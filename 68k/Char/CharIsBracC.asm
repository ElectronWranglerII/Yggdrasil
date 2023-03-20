;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A CLOSING BRACKET
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A CLOSING BRACKET
;	D7.B = 0xFF IF VALUE IS AN A CLOSING BRACKET
CHARISBRACC:
    ;CHECK FOR ")"
    CMPI.B  #$29, D0
    BEQ     CHARISBRACCA
    ;CHECK FOR "]"
    CMPI.B  #$5D, D0
    BEQ     CHARISBRACCA
    ;CHECK FOR "}"
    CMPI.B  #$7D, D0
    BNE     CHARISBRACCB
CHARISBRACCA:
    MOVE.B  #$FF, D7
    RTS
CHARISBRACCB:
    CLR.B   D7
    RTS
