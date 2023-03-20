;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CONVERTS AN UPPERCASE LETTER TO A LOWERCASE LETTER
;ON ENTRY:
;	D0.B = CHARACTER
;ON RETURN:
;	D7.B = 0x00 IF CHARACTER WAS UPPERCASE
;		D0.B = CONVERTED VALUE
;	D7.B = 0xFF IF CHARACTER WAS NOT UPPERCASE
;		D0.B = 0x00
CHARTOLOWER:
    ;CHECK FOR LESS THAN "A"
    CMPI.B  #$41, D0
    BCS     CHARTOLOWERA
    ;CHECK FOR GREATER THAN "Z"
    CMPI.B  #$5B, D0
    BCC     CHARTOLOWERA
    ADDI.B  #$20, D0
    CLR.B   D7
    RTS
CHARTOLOWERA:
    MOVE.B  #$FF, D7
    RTS
