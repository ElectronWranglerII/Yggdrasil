;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS PUNCTUATION
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT PUNCTUATION
;	D7.B = 0xFF IF VALUE IS PUNCTUATION
CHARISPUNCT:
    ;CHECK FOR "!"
    CMPI.B  #$21, D0
    BEQ     CHARISPUNCTA
    ;CHECK FOR "."
    CMPI.B  #$2E, D0
    BEQ     CHARISPUNCTA
    ;CHECK FOR "?"
    CMPI.B  #$3F, D0
    BNE     CHARISPUNCTB
CHARISPUNCTA:
    MOVE.B  #$FF, D7
    RTS
CHARISPUNCTB:
    CLR.B   D7
    RTS
