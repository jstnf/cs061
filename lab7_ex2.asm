;=================================================
; Name:
; Email:
; 
; Lab: lab 7, ex 2
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

	; Instructions
	LEA R0, PROMPT
	PUTS
	
	GETC
	OUT
	
	LD R6, SUB_CHARACTER_ONES_PTR
	JSRR R6
	
	ADD R2, R0, #0
	LD R0, NEWLINE
	OUT
	LEA R0, OUTPUT_PART1
	PUTS
	ADD R0, R2, #0
	OUT
	LEA R0, OUTPUT_PART2
	PUTS
	ADD R0, R1, #0
	ADD R0, R0, #12
	ADD R0, R0, #12
	ADD R0, R0, #12
	ADD R0, R0, #12
	OUT
	
	HALT
	
	; Remote data
	PROMPT .STRINGZ "Input a character:\n"
	NEWLINE .FILL '\n'
	OUTPUT_PART1 .STRINGZ "The number of 1's in '"
	OUTPUT_PART2 .STRINGZ "' is: "
	SUB_CHARACTER_ONES_PTR .FILL x3200
	
;=======================================================================
; Subroutine: SUB_CHARACTER_ONES_3200
; Parameter: (R0) The character to check
; Postcondition: This subroutine will do a parity check on the character
;                stored in R0, and then return the number of 1's in its
;                binary form
; Return Value: (R1) The number of 1's in the character
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_CHARACTER_ONES_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		LD R2, CHECK_SPOTS_3200
		AND R1, R1, x0
		AND R3, R3, x0
		ADD R3, R3, #1
		
		CHECK_LOOP_3200
			LD R0, BACKUP_R0_3200
			AND R0, R0, R3
			BRnz BYPASS_ADD_3200
			ADD R1, R1, #1
			BYPASS_ADD_3200
			ADD R3, R3, R3
			ADD R2, R2, #-1
			BRp CHECK_LOOP_3200
		END_CHECK_LOOP_3200

		LD R0, BACKUP_R0_3200
		LD R2, BACKUP_R2_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R5, BACKUP_R5_3200
		LD R6, BACKUP_R6_3200
		LD R7, BACKUP_R7_3200
		RET

	;========================
	; Subroutine Data
	;========================

	BACKUP_R0_3200 .BLKW #1
	BACKUP_R1_3200 .BLKW #1
	BACKUP_R2_3200 .BLKW #1
	BACKUP_R3_3200 .BLKW #1
	BACKUP_R4_3200 .BLKW #1
	BACKUP_R5_3200 .BLKW #1
	BACKUP_R6_3200 .BLKW #1
	BACKUP_R7_3200 .BLKW #1 
	CHECK_SPOTS_3200 .FILL #8


.END
