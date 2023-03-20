;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS THE CHARACTER IN A TO AN INTEGER
;ON ENTRY:
;	D0.B = CHARACTER
;ON RETURN:
;	D7.B = 0x00 IF CHARACTER IS AN INTEGER
;			D0.B = INTEGER VALUE
;	D7.B = 0xFF IF CHARACTER IS NOT AN INTEGER
;			D0.B = 0x00
CHARTOINT:
    ;CHECK FOR LESS THAN "0"
    SUBI.B  #$30, D0
    BCS     CHARTOINTA
    ;CHECK FOR GREATER THAN "9"
    CMPI.B  #$0A, D0
    BCC     CHARTOINTA
    CLR.B   D7
    RTS
CHARTOINTA:
    MOVE.B  #$FF, D7
    RTS
