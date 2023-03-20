;* Yggdrasil (TM) Core Operating System (68K): Character Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;RETURNS TRUE IF VALUE IS AN ARITHMETIC OPERATOR
;ON ENTRY:
;	D0.B = VALUE
;ON RETURN:
;	D0.B = VALUE ON ENTRY
;	D7.B = 0x00 IF VALUE IS NOT AN ARITHMETIC OPERATOR
;	D7.B = 0xFF IF VALUE IS AN ARITHMETIC OPERATOR
CHARISARITH:
    ;CHECK FOR FACTORAL "!"
    CMPI.B  #$21, D0
    BEQ     CHARISARITHA
    ;CHECK FOR MODULO "%"
    CMPI.B  #$25, D0
    BEQ     CHARISARITHA
    ;CHECK FOR MULTIPLICATION "*"
    CMPI.B  #$2A, D0
    BEQ     CHARISARITHA
    ;CHECK FOR ADDITION "+"
    CMPI.B  #$2B, D0
    BEQ     CHARISARITHA
    ;CHECK FOR SUBTRACTION "-"
    CMPI.B  #$2D, D0
    BEQ     CHARISARITHA
    ;CHECK FOR DIVISION "/"
    CMPI.B  #$2F, D0
    BEQ     CHARISARITHA
    ;CHECK FOR EQUALS "="
    CMPI.B  #$3D, D0
    BEQ     CHARISARITHA
    ;CHECK FOR EXPONENT "^"
    CMPI.B  #$5E, D0
    BNE     CHARISARITHB
CHARISARITHA:
    MOVE.B  #$FF, D7
    RTS
CHARISARITHB:
    CLR.B   D7
    RTS
