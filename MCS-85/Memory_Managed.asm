;* Yggdrasil (TM) Core Operating System (MCS-80/85): Memory Library With Management
;* Copyright (C) DeRemee Systems, IXE Electronics LLC
;* Portions copyright IXE Electronics LLC, Republic Robotics,
;* FemtoLaunch, FemtoSat, FemtoTrack, Weland
;* This work is made available under the Creative Commons
;* Attribution-NonCommercial-ShareAlike 4.0 International License.
;* To view a copy of this license, visit
;* http://creativecommons.org/licenses/by-nc-sa/4.0/.


;+-----------------------------------+
;| MEMORY CONTROL BLOCK (MCB) FORMAT |
;+-----------------------------------+
;|           ENTRY 0 FLAGS           |
;+-----------------------------------+
;|           ENTRY 1 FLAGS           |
;+-----------------------------------+
;|     ENTRY ENTRYCOUNT - 2 FLAGS    |
;+-----------------------------------+
;|     ENTRY ENTRYCOUNT - 1 FLAGS    |
;+-----------------------------------+
;|          ENTRY 0 TASK ID          |
;+-----------------------------------+
;|          ENTRY 1 TASK ID          |
;+-----------------------------------+
;|    ENTRY ENTRYCOUNT - 2 TASK ID   |
;+-----------------------------------+
;|    ENTRY ENTRYCOUNT - 1 TASK ID   |
;+-----------------------------------+

;+-----------------------------------------------+
;|    MEMORY CONTROL BLOCK ENTRY FLAGS FORMAT    |
;+-----------------------------------------------+
;| RES | BSY | CHI | PAR | SWP | REL | FRE | PRS |
;+-----------------------------------------------+
;PRS -	PRESENT. SET IF THE MEMORY FOR THE ENTRY IS PHYSICALLY PRESENT
;SWP -	SWAPPABLE. SET IF THE ENTRY IS SWAPPABLE TO SECONDARY STORAGE
;REL -	RELOCATABLE. SET IF THE ENTRY IS RELOCATABLE WITHIN RAM
;FRE -	FREE. SET IS THE MEMORY ENTRY IS FREE FOR ALLOCATION
;PAR -	PARENT. SET IF THIS ENTRY IS THE PARENT OF ONE OR MORE ENTRIES
;		IMMEDIATELY FOLLOWING IT
;CHI -	CHILD. SET IF THIS ENTRY IS THE CHILD OF THE ENTRY IMMEDIATELY
;		IMMEDIATELY PRECEDING IT OR THAT ENTRY'S PARENT
;BSY -	BUSY. SET IF THE BLOCK IS BEING MANIPULATED BY THE SYSTEM
;RES -	RESERVED. RESERVED FOR FUTURE USE


MEM_OFFS_MCB_FLAGS		EQU	0x00
MEM_OFFS_MCB_TID		EQU	0x01


MEM_MCB_ENTRY_FLAG_PRS	EQU	0x01
MEM_MCB_ENTRY_FLAG_FRE	EQU	0x02
MEM_MCB_ENTRY_FLAG_REL	EQU	0x04
MEM_MCB_ENTRY_FLAG_SWP	EQU	0x08
MEM_MCB_ENTRY_FLAG_PAR	EQU	0x10
MEM_MCB_ENTRY_FLAG_CHI	EQU	0x20
MEM_MCB_ENTRY_FLAG_BSY	EQU	0x40


MEM_MCB_BASE_ADDRESS	EQU	0x0040
MEM_STACK_ADDRESS		EQU	0x0000


;INITIALIZE MEMORY
;ON ENTRY:
;	NONE
;ON RETURN:
;	CF	= 0 IF SUCCESS
;		A	= 0x00
;	CF	= 1 IF ERROR
;		A	= ERROR CODE
MEMINIT:
	;SAVE RETURN ADDRESS
	LXI		H, 0x0000
	DAD		SP
	MOV		C, M
	INX		H
	MOV		B, M
	;CLEAR MEMORY
	XRA		A
	LXI		D, 0x0001
	LXI		H, MEM_MCB_BASE_ADDRESS
MEMINITA:
	MOV		M, A
	DAD		D
	JNC		MEMINITA
	;RESERVE MEMORY FOR RESTART TABLE & MEMORY CONTROL BLOCK
	LXI		H, MEM_MCB_BASE_ADDRESS
	MOV		M, MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_PAR
	INX		H
	MVI		A, MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_CHI
	MOV		M, A
	INX 	H
	MOV		M, A
	INX		H
	;MARK UNALLOCATED MEMORY AS FREE, SWAPPABLE & RELOCATABLE
	MVI		A, MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_SWP + MEM_MCB_ENTRY_FLAG_REL + MEM_MCB_ENTRY_FLAG_FRE
	MVI		D, 0xFB
MEMINITB:
	MOV		M, A
	INX		H
	DCR		D
	JNZ		MEMINITB
	;RESERVE MEMORY FOR STACK
	MOV		M, MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_PAR
	INX		H
	MOV		M, MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_CHI
	;LOAD STACK POINTER
	LXI		SP, MEM_STACK_ADDRESS
	;RETURN TO CALLER
	MOV		H, B
	MOV		L, C
	PCHL


;ALLOCATE MEMORY
;ON ENTRY:
;	BC	= NUMBER OF BYTES TO ALLOCATE
;ON RETURN:
;	BC	= VALUE ON ENTRY
;	CF	= 0 IF SUCCESS
;		A	= 0x00
;		HL	= MEMORY BLOCK BASE ADDRESS
;	CF	= 1 IF FAIL
;		A	= ERROR CODE
;		HL	= 0x0000
MEMALC:
	;SAVE REGISTERS
	PUSH	B
	PUSH	D
	;CALCULATE REQUIRED NUMBER OF MEMORY BLOCKS
	MOV		A, C
	ORA		C
	JZ		MEMALCA
	;ADJUST COUNT FOR FRACTIONS OF 256
	INR		B
MEMALCA:
	;BLOCK COUNT IS VALID?
	MOV		A, B
	ORA		B
	MVI		A, MEM_RET_ERR_INVSIZ
	JZ		MEMALCJ
	;SAVE BLOCK COUNT
	MOV		C, B
	;LOAD MEMORY BLOCK COUNTER
	MVI		E, 0x00
	;LOAD MCB BASE ADDRESS
	LXI		H, MEM_MCB_BASE_ADDRESS
MEMALCB:
	;LOAD MCB ENTRY'S FLAGS
	MOV		A, M
	;ENTRY'S PRESENT & FREE FLAGS SET?
	ANI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	XRI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	JNZ		MEMALCG
	;DECREMENT BLOCK COUNT
	DCR		C
	;BLOCK COUNT == 0?
	JNZ		MEMALCH
	;POINT TO FIRST FREE BLOCK FOUND
	INX		H
	MOV		A, L
	SUB		B
	MOV		L, A
	MOV		A, H
	SBI		0x00
	MOV		H, A
	PUSH	H
	;BLOCK COUNT == 1?
	MOV		A, B
	XRI		0x01
	JZ		MEMALCD
	;MARK FIRST BLOCK AS RESERVED PARENT
	MOV		A, M
	ANI		255 - MEM_MCB_ENTRY_FLAG_FRE
	ORI		MEM_MCB_ENTRY_FLAG_PAR
	MOV		M, A
	INX		H
	;MARK REMAINING BLOCKS AS RESERVED CHILDREN
	MOV		C, B
	DCR		C
MEMALCC:
	MOV		A, M
	ANI		255 - MEM_MCB_ENTRY_FLAG_FRE
	ORI		MEM_MCB_ENTRY_FLAG_CHI
	MOV		M, A
	INX		H
	DCR		C
	JNZ		MEMALCC
	JMP		MEMALCE
MEMALCD:
	;MARK BLOCK AS RESERVED
	MOV		A, M
	ANI		255 - MEM_MCB_ENTRY_FLAG_FRE
	MOV		M, A
MEMALCE:
	;WRITE TASK ID TO MCB ENTRIES
	CALL	TASKCURR
	MOV		C, B
	POP		H
	JC		MEMALCJ
	PUSH	H
	INR		H
MEMALCF:
	MOV		M, A
	INX		H
	DCR		C
	JNZ		MEMALCF
	;CALCULATE BASE ADDRESS
	POP		H
	LXI		D, 0 - MEM_MCB_BASE_ADDRESS
	DAD		D
	MOV		H, L
	MVI		L, 0x00
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		B
	XRA		A
	RET
MEMALCG:
	;RESTORE BLOCK COUNT
	MOV		C, B
MEMALCH:
	;POINT TO NEXT MCB ENTRY
	INX		H
	;DECREMENT MEMORY BLOCK COUNTER
	DCR		E
	JNZ		MEMALCB
MEMALCI:
	;RESTORE REGISTERS & RETURN
	MVI		A, MEM_RET_ERR_NOFREE
MEMALCJ:
	POP		D
	POP		B
	STC
	RET


;RETURNS THE SIZE OF AN ALLOCATED BLOCK, IN BYTES
;ON ENTRY:
;	HL	= BLOCK'S BASE ADDRESS
;ON RETURN:
;	HL	= VALUE ON ENTRY
;	CF	= 0 IF SUCCESS
;		A	= 0x00
;		BC	= BLOCK SIZE
;	CF	= 1 IF FAIL
;		A	= ERROR CODE
;		BC	= 0x0000
MEMBSIZ:
	;SAVE REGISTERS
	PUSH	H
	PUSH	D
	;CALCULATE FIRST ENTRY'S MCB ADDRESS
	MOV		L, H
	MVI		H, 0x00
	LXI		D, MEM_MCB_BASE_ADDRESS
	DAD		D
	;ENTRY IS PRESENT, RESERVED?
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	CPI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	JZ		MEMBSIZZ
	;
	LXI		B, 0x0100
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PAR + MEM_MCB_ENTRY_FLAG_CHI
	;ENTRY IS NEITHER PARENT NOR CHILD?
	JZ		MEMBSIZC
	;ENTRY HAS PARENT AND CHILD FLAGS SET?
	CPI		MEM_MCB_ENTRY_FLAG_PAR + MEM_MCB_ENTRY_FLAG_CHI
	JZ		MEMBSIZD
	;ENTRY IS PARENT?
	CPI		MEM_MCB_ENTRY_FLAG_PAR
	JZ		MEMBSIZA
MEMBSIZZ:
	;RESTORE REGISTERS & RETURN
	MVI		A, MEM_RET_ERR_INVBLK
	LXI		B, 0x0000
	POP		D
	POP		H
	STC
	RET
MEMBSIZA:
	MVI		D, 0xFF
MEMBSIZT:
	;POINT TO NEXT ENTRY
	INX		H
	;ENTRY IS PRESENT, RESERVED?
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	CPI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	JZ		MEMBSIZW
	;LOAD ENTRY'S FLAGS
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PAR + MEM_MCB_ENTRY_FLAG_CHI
	;ENTRY IS CHILD?
	CPI		MEM_MCB_ENTRY_FLAG_CHI
	JNZ		MEMBSIZB
	;INCREMENT BLOCK SIZE
	INR		B
	;INCREMENT D TO PREVENT ERROR
	INR		D
	JMP		MEMBSIZT
MEMBSIZB:
	;ENTRY IS A PARENT AND CHILD?
	CPI		MEM_MCB_ENTRY_FLAG_PAR + MEM_MCB_ENTRY_FLAG_CHI
	JZ		MEMBSIZD
MEMBSIZW:
	;PREVIOUS ENTRY WAS A PARENT?
	INR		D
	JZ		MEMBSIZE
MEMBSIZC:
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		H
	XRA		A
	RET
MEMBSIZD:
	;ERROR: ENTRY HAS BOTH PARENT AND CHILD FLAGS SET
	HLT
MEMBSIZE:
	;ERROR: PREVIOUS ENTRYS PARENT FLAG SET AND THIS ENTRYS CHILD FLAG NOT SET
	HLT


;CLEARS THE BLOCK'S BUSY BITS
;DOES NOT PERFORM VALIDATION OR BLOCK INTEGRITY CHECKS
;ON ENTRY:
;	B	= BLOCK COUNT
;	HL	= BLOCK BASE ADDRESS
;ON RETURN:
;	PSW		= DESTROYED
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= BUSY BITS OF BLOCKS CLEAR
MEMBUSYCLR:
	;SAVE REGISTERS
	PUSH	B
	PUSH	H
	PUSH	D
	;CALCULATE ADDRESS OF FIRST ENTRY'S FLAGS
	MOV		L, H
	MVI		H, 0x00
	LXI		D, MEM_MCB_BASE_ADDRESS
	DAD		D
	POP		D
MEMBUSYCLRA:
	;LOAD ENTRY'S FLAGS
	MOV		A, M
	;CLEAR BUSY FLAG
	ANI		255 - MEM_MCB_ENTRY_FLAG_BSY
	;STORE ENTRY'S FLAGS
	MOV		M, A
	;POINT TO NEXT ENTRY
	INX		H
	;DECREMENT BLOCK COUNT
	DCR		B
	;COUNTER == 0?
	JNZ		MEMBUSYCLRA
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		B
	RET


;SETS THE BLOCK'S BUSY BITS
;DOES NOT PERFORM VALIDATION OR BLOCK INTEGRITY CHECKS
;ON ENTRY:
;	B	= BLOCK COUNT
;	HL	= BLOCK BASE ADDRESS
;ON RETURN:
;	PSW		= DESTROYED
;	B		= VALUE ON ENTRY
;	HL		= VALUE ON ENTRY
;	[HL]	= BUSY BITS OF BLOCKS SET
MEMBUSYSET:
	;SAVE REGISTERS
	PUSH	B
	PUSH	H
	PUSH	D
	;CALCULATE ADDRESS OF FIRST ENTRY'S FLAGS
	MOV		L, H
	MVI		H, 0x00
	LXI		D, MEM_MCB_BASE_ADDRESS
	DAD		D
	POP		D
MEMBUSYSETA:
	;LOAD ENTRY'S FLAGS
	MOV		A, M
	;SET BUSY FLAG
	ORI		MEM_MCB_ENTRY_FLAG_BSY
	;STORE ENTRY'S FLAGS
	MOV		M, A
	;POINT TO NEXT ENTRY:
	INX		H
	;DECREMENT BLOCK COUNT
	DCR		B
	;COUNTER == 0?
	JNZ		MEMBUSYSETA
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		B
	RET


;RETURNS TRUE IF ANY ENTRY IN THE BLOCK HAS ITS BUSY BIT SET
;DOES NOT PERFORM VALIDATION OR BLOCK INTEGRITY CHECKS
;ON ENTRY:
;	B	= BLOCK COUNT
;	HL	= BLOCK BASE ADDRESS
;ON RETURN:
;	A	= 0x00
;	B	= VALUE ON ENTRY
;	HL	= VALUE ON ENTRY
;	CF	= 0 IF NO ENTRIES IN BLOCK ARE BUSY
;	CF	= 1 IF ANY ENTRY IN BLOCK IS BUSY
MEMBUSYTST:
	;SAVE REGISTERS
	PUSH	B
	PUSH	H
	PUSH	D
	;CALCULATE ADDRESS OF FIRST ENTRY'S FLAGS
	MOV		L, H
	MVI		H, 0x00
	LXI		D, MEM_MCB_BASE_ADDRESS
	DAD		D
	POP		D
MEMBUSYTSTA:
	;LOAD ENTRY'S FLAGS
	MOV		A, M
	;BUSY FLAG SET?
	ANI		MEM_MCB_ENTRY_FLAG_BSY
	JNZ		MEMBUSYTSTB
	;POINT TO NEXT ENTRY
	INX		H
	;DECREMENT COUNTER
	DCR		B
	;COUNTER == 0?
	JNZ		MEMBUSYTSTA
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		B
	XRA		A
	RET
MEMBUSYTSTB:
	;RESTORE REGISTERS & RETURN
	POP		H
	POP		B
	XRA		A
	STC
	RET


;CHECKS THE MEMORY CONTROL BLOCK'S INTEGRITY
;ON ENTRY:
;	NONE
;ON RETURN:
;	CF	= 0 IF INTEGRITY GOOD
;		A	= 0x00
;	CF	= 1 IF INTEGRITY BAD
;		A	= ERROR CODE
MEMCHK:
	;LOAD MCB ADDRESS
	LXI		H, MCB_BASE_ADDRESS
	;ZEROIZE ENTRY COUNT
	MVI		C, 0x00
	;SET PREVIOUS PARENT (PP) AND CHILD MODE (CM) TO FALSE
	LXI		D, 0xFFFF
MEMCHKA:
	;LOAD ENTRY'S FLAGS
	MOV		A, M
	;ALL FLAGS ZERO?
	ORA		A
	JNZ		MEMCHKC
MEMCHKB:
	;SET CM TO FALSE
	MVI		E, 0xFF
MEMCHKW:
	;POINT TO NEXT ENTRY
	INX		H
	;INCREMENT ENTRY COUNT
	INR		C
	;ENTRY COUNT OVERFLOW?
	JNZ		MEMCHKA
	;PP == TRUE?
	INR		D
	JNZ		ERROR : CHILDLESS PARENT FOUND
	;RESTORE REGISTERS & RETURN
	XRA		A
	RET
MEMCHKC:
	;ENTRY PRESENT?
	RAR
	JNC		ENTRYNOTPRESENT
	;FREE FLAG == 1?
	RAR
	JNC		MEMCHKD
	;PP == TRUE?
	MOV		B, A
	MOV		A, D
	CPI		0xFF
	MOV		A, B
	JNZ		ERROR : CHILDLESS PARENT FOUND
	;PARENT FLAG == 1?
	RAR
	RAR
	RAR
	JC		ERROR : PARENT FLAG SET WITH ENTRY FREE
	;CHILD FLAG == 1?
	RAR
	JNC		MEMCHKB
	JMP		ERROR : CHILD FLAG SET WITH ENTRY FREE
MEMCHKD:
	;PARENT FLAG == 1?
	RAR
	RAR
	RAR
	JNC		MEMCHKF
	;CHILD FLAG == 1?
	RAR
	JC		ERROR : PARENT AND CHILD FLAGS BOTH SET
	;PP == TRUE? (ALSO SETS PP TO TRUE IF CURRENTLY FALSE)
	INR		D
	JZ		MEMCHKB
	JMP		ERROR :CHILDLESS PARENT FOUND
MEMCHKF:
	;CHILD FLAG == 1?
	RAR
	JC		MEMCHKG
	;PP == TRUE?
	MOV		B, A
	MOV		A, D
	CPI		0xFF
	MOV		A, B
	JZ		MEMCHKB
	JMP		ERROR : CHILDLESS PARENT FOUND
MEMCHKG:
	;CM == TRUE?
	MOV		B, A
	MOV		A, E
	CPI		0xFF
	MOV		A, B
	JNZ		MEMCHKW
	;PP == TRUE? (ALSO SETS PP TO TRUE IF CURRENTLY FALSE)
	INR		D
	JNZ		ERROR :PARENTLESS CHILD FOUND
	;SET CM TO TRUE
	INR		E
	JMP		MEMCHKW
ENTRY_NOT_PRESENT:
	;ENTRY FREE?
	RAR
	JC		ERROR : FREE FLAG SET WITH ENTRY NOT PRESENT
	;ENTRY RELOCATABLE?
	RAR
	JC		ERROR : RELOCATABLE FLAG SET WITH ENTRY NOT PRESENT
	;ENTRY SWAPPABLE?
	RAR
	JC		ERROR : SWAPPABLE FLAG SET WITH ENTRY NOT PRESENT
	;ENTRY IS PARENT?
	RAR
	JC		ERROR : PARENT FLAG SET WITH ENTRY NOT PRESENT
	;ENTRY IS CHILD?
	RAR
	JC		ERROR : CHILD FLAG SET WITH ENTRY NOT PRESENT
	;ERROR : UNRECOGNIZED FLAG CONFIGURATION
	HLT
MEM


;COPIES THE CONTENTS OF THE SOURCE MEMORY TO THE DESTINATION MEMORY
;ON ENTRY:
;	DE	= DESTINATION ADDRESS
;	HL	= SOURCE ADDRESS
;ON RETURN:
;	DE	= VALUE ON ENTRY
;	HL	= VALUE ON ENTRY
;	CF	= 0 IF SUCCESS
;		A	= 0x00
;	CF	= 1 IF FAIL
;		A	= ERROR CODE
MEMCOPY:
	;SAVE REGISTERS
	PUSH	B
	PUSH	H
	PUSH	D
	;GET SOURCE BLOCK'S SIZE
	CALL	MEMBSIZ
	JC		MEMCOPYC
	PUSH	B
	;GET DESTINATION BLOCK'S SIZE
	XCHG
	CALL	MEMBSIZ
	JC		MEMCOPYC
	;SOURCE SIZE == DESTINATION SIZE?
	XTHL
	MOV		A, H
	XRA		B
	XRA		L
	XRA		C
	MVI		A, MEM_RET_ERR_INVSIZ
	JNZ		MEMCOPYB
	;
	POP		H
	PUSH	B
	;DESTINATION BLOCK'S BUSY FLAG SET?
	CALL	MEMBUSYTST
	MVI		A, MEM_RET_ERR_BLKBSY
	JC		MEMCOPYB
	;SOURCE BLOCK'S BUSY FLAG SET?
	XCHG
	CALL	MEMBUSYTST
	MVI		A, MEM_RET_ERR_BLKBSY
	JC		MEMCOPYB
	;SET SOURCE BLOCK'S BUSY FLAG
	CALL	MEMBUSYSET
	;SET DESTINATION BLOCK'S BUSY FLAG
	XCHG
	CALL	MEMBUSYSET
	XCHG
MEMCOPYA:
	;COPY MEMORY
	MOV		A, M
	STAX	D
	INX		H
	INX		D
	DCX		B
	MOV		A, B
	ORA		C
	JNZ		MEMCOPYA
	POP		B
	;CLEAR DESTINATION BLOCK'S BUSY FLAG
	POP		H
	CALL	MEMBUSYCLR
	;CLEAR SOURCE BLOCK'S BUSY FLAG
	POP		D
	XCHG
	CALL	MEMBUSYCLR
	;RESTORE REGISTERS & RETURN
	POP		B
	XRA		A
	RET
MEMCOPYB:
	POP		D
MEMCOPYC:
	POP		D
	POP		H
	POP		B
	STC
	RET


;FILLS A MEMORY BLOCK WITH A VALUE
;ON ENTRY:
;	A	= FILL VALUE
;	HL	= MEMORY BLOCK BASE ADDRESS
;ON RETURN:
;	HL	= VALUE ON ENTRY
;	C	= 0 IF SUCCESS
;		A	= 0x00
;	C	= 1 IF FAIL
;		A	= ERROR CODE
MEMFILL:
	;SAVE REGISTERS
	PUSH	B
	PUSH	PSW
	;GET BLOCK'S SIZE
	CALL	MEMBSIZ
	;ERROR?
	JC		MEMFILLC
	;BLOCK'S BUSY FLAG SET?
	CALL	MEMBUSYTST
	MVI		A, MEM_RET_ERR_BLKBSY
	JC		MEMFILLC
	;SET BLOCK'S BUSY FLAG
	CALL	MEMBUSYSET
	;
	POP		PSW
	PUSH	D
	PUSH	H
	PUSH	B
	MOV		D, B
	MOV		E, C
	LXI		B, 0xFFFF
MEMFILLA:
	;DECREMENT COUNTER
	XCHG
	DAD		B
	XCHG
	;COUNTER UNDERFLOW?
	JNC		MEMFILLB
	;WRITE VALUE TO MEMORY LOCATION
	MOV		M, A
	;POINT TO NEXT MEMORY LOCATION
	INX		H
	JMP		MEMFILLA	
MEMFILLB:
	;CLEAR BLOCK'S BUSY FLAG
	POP		B
	POP		H
	CALL	MEMBUSYCLR
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		B
	XRA		A
	RET
MEMFILLC:
	;RESTORE REGISTERS & RETURN
	POP		B
	POP		B
	STC
	RET


;RETURNS THE AMOUNT OF FREE MEMORY, IN BYTES
;ON ENTRY:
;	NONE
;ON RETURN:
;	BC	= AMOUNT OF FREE MEMORY
MEMFREE:
	;SAVE REGISTERS
	PUSH	PSW
	PUSH	H
	;LOAD MCB BASE ADDRESS
	LXI		H, MEM_MCB_BASE_ADDRESS
	;CLEAR FREE MEMORY COUNTER & LOAD BLOCK COUNTER
	LXI		B, 0x0000
MEMFREEA:
	;LOAD MCB ENTRY'S FLAGS
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	XRI		MEM_MCB_ENTRY_FLAG_PRS + MEM_MCB_ENTRY_FLAG_FRE
	JNZ		MEMFREEB
	;INCREMENT FREE MEMORY COUNTER
	INR		B
MEMFREEB:
	;POINT TO NEXT MCB ENTRY
	INX		H
	;DECREMENT BLOCK COUNTER
	DCR		C
	JNZ		MEMFREEA
	;RESTORE REGISTERS & RETURN
	MVI		C, 0x00
	POP		H
	POP		PSW
	XRA		A
	RET


;RELEASE ALLOCATED MEMORY BLOCK
;ON ENTRY:
;	HL	= MEMORY BLOCK BASE ADDRESS
;ON RETURN:
;	HL	= 0x0000
;	CF	= 0 IF SUCCESS
;		A	= 0x00
;	CF	= 1 IF FAIL
;		A	= ERROR CODE
MEMREL:
	;SAVE REGISTERS
	PUSH	B
	PUSH	D
	;CALCULATE FIRST ENTRY'S MCB ADDRESS
	MOV		L, H
	MVI		H, 0x00
	LXI		D, MEM_MCB_BASE_ADDRESS
	DAD		D
	;MARK FIRST BLOCK AS FREE
	MOV		A, M
	ANI		MEM_MCB_ENTRY_FLAG_PAR
	
MEMRELB:
	;MARK BLOCKS AS FREE
	MOV		A, M
	ANI		255 - (MEM_MCB_ENTRY_FLAG_PAR + MEM_MCB_ENTRY_FLAG_CHI)
	ORI		MEM_MCB_ENTRY_FLAG_FRE
	MOV		M, A
	INX		H
	DCR		B
	JNZ		MEMRELB
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		B
	XRA		A
	RET
MEMRELC:
	;RESTORE REGISTERS & RETURN
	POP		D
	POP		B
	MVI		A, MEM_RET_ERR_INVSIZ
	STC
	RET
