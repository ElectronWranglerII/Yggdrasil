;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS A NON-PRINTING CHARACTER
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT A NON-PRINTING CHARACTER
;	D7.B = 0xFF IF VALUE IS A NON-PRINTING CHARACTER
CHARISNPC:
    ;CHECK FOR LESS THAN 0x20
    CMPI.B  #$20, D0
    BCS     CHARISNPCA
    ;CHECK FOR 0x7F
    CMPI.B  #$7F, D0
    BEQ     CHARISNPCA
    CLR.B   D7
    RTS
CHARISNPCA:
    MOVE.B  #$FF, D7
    RTS
