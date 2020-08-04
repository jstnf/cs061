;=================================================
; Name:
; Email:
; 
; Lab: lab 9, ex 1 & 2
; Lab section:
; TA:
; 
;=================================================

; test harness
.ORIG x3000

	LD R4, BASE_PTR
	LD R5, MAX_PTR
	LD R6, TOS_PTR
	
	LD R3, SUB_PUSH_PTR
	
	AND R0, R0, x0
	ADD R0, R0, #6
	PUSH_LOOP
		JSRR R3
	
		ADD R0, R0, #-1
		BRp PUSH_LOOP
	END_PUSH_LOOP
	
	LD R3, SUB_POP_PTR
	
	AND R1, R1, x0
	ADD R1, R1, #6
	POP_LOOP
		JSRR R3
	
		ADD R1, R1, #-1
		BRp POP_LOOP
	END_POP_LOOP

	HALT
;-----------------------------------------------------------------------------------------------
; test harness local data:
BASE_PTR .FILL xA000
MAX_PTR .FILL xA005
TOS_PTR .FILL xA000
SUB_PUSH_PTR .FILL x3200
SUB_POP_PTR .FILL x3400

;===============================================================================================
.ORIG xA000
THE_STACK .BLKW #5


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3200

	SUB_STACK_PUSH_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200

		ADD R1, R6, #0
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R5
		BRnz OF_ERROR_3200
		
		ADD R6, R6, #1
		STR R0, R6, #0
		BR END_OF_ERROR_3200
		
		OF_ERROR_3200
			LEA R0, OVERFLOW_ERR_3200
			PUTS
		END_OF_ERROR_3200

		LD R0, BACKUP_R0_3200
		LD R1, BACKUP_R1_3200
		LD R2, BACKUP_R2_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R5, BACKUP_R5_3200
		LD R7, BACKUP_R7_3200
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1 
OVERFLOW_ERR_3200 .STRINGZ "Overflow error!\n"

;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3400

	SUB_STACK_POP_3400

		ST R0, BACKUP_R0_3400
		ST R1, BACKUP_R1_3400
		ST R2, BACKUP_R2_3400
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400

		ADD R1, R6, #0
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R4
		BRzp UF_ERROR_3400
		
		LDR R0, R6, #0
		ADD R6, R6, #-1
		BR END_UF_ERROR_3400
		
		UF_ERROR_3400
			LEA R0, UNDERFLOW_ERR_3400
			PUTS
		END_UF_ERROR_3400

		LD R1, BACKUP_R1_3400
		LD R2, BACKUP_R2_3400
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R7, BACKUP_R7_3400
		RET

;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1 
UNDERFLOW_ERR_3400 .STRINGZ "Underflow error!\n"

;===============================================================================================
