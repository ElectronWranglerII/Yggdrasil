;* Yggdrasil (TM) Core Operating System (MCS-51): Relocatable Code Library
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.

;CALLS A FUNCTION 
;ON ENTRY:
;	[SP]			=	RETURN ADDRESS MSB
;	[SP - 1]	=	RETURN ADDRESS LSB
;	[SP - 2]	=	OFFSET MSB
;	[SP - 3]	=	OFFSET LSB
;ON RETURN:
;	REFER TO FUNCTION BEING CALLED
LRELOCCALL:
  PUSH	ACC
  MOV		A, R0
  PUSH	ACC
  MOV		A, R1
  PUSH	ACC
  PUSH	DPL
  PUSH	DPH
  PUSH	IE
  CLR		EA
  ;CALCULATE STACK ADDRESS OF OFFSET LSB
  MOV		A, SP
  CLR		C
  SUBB	A, #0x09
  MOV		R1, A
  ;RETRIEVE OFFSET FROM STACK
  MOV		A, @R1
  MOV		DPL, A
  INC 	R1
  MOV		A, @R1
  MOV		DPH, A
  ;MOVE RETURN ADDRESS
  INC		R1
  MOV		A, @R1
  DEC		R1
  DEC		R1
  MOV		@R1, A
  INC		R1
  INC		R1
  INC		R1
  MOV		A, @R1
  DEC R1
  DEC R1
  MOV		@R1, A
  ;GET FUNCTION'S ADDRESS
  CALL	LRELOCADDR
  ;STORE FUNCTION'S ADDRESS
  INC		R1
  MOV		A, DPL
  MOV		@R1, A
  INC		R1
  MOV		A, DPH
  MOV		@R1, A
  ;RESTORE REGISTERS
  POP		IE
  POP		DPH
  POP		DPL
  POP		ACC
  MOV		R1, A
  POP		ACC
  MOV		R0, A
  POP		ACC
  ;"CALL" FUNCTION
  RET
