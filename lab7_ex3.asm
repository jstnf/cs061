;=================================================
; Name:
; Email:
; 
; Lab: lab 7, ex 3
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

	; Instructions
	
	LD R0, NUM_TO_SHIFT
	
	LEA R6, SUB_SHIFT_RIGHT_PTR
	JSRR R6
	
	HALT
	
	; Remote data
	NUM_TO_SHIFT .FILL xFFFF
	SUB_SHIFT_RIGHT_PTR .FILL x3200
	
;=======================================================================
; Subroutine: SUB_SHIFT_RIGHT_3200
; Parameter: (R0) Number to shift
; Postcondition: The subrouting shifts the bits in R0 to the right,
;                appending R0 as the most significant bit
; Return Value: (R1) The number in R0, shifted 1 bit right
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_SHIFT_RIGHT_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		LD R2, NUM_BITS_3200
		AND R1, R1, x0
		
		PARITY_LOOP_3200
			LD R3, PARITY_CHECKER_3200
			ADD R1, R1, R1
			AND R3, R0, R3
			BRz BYPASS_APPEND_1_3200
			ADD R1, R1, #1
			BYPASS_APPEND_1_3200
			ADD R0, R0, R0
			ADD R2, R2, #-1
			BRp PARITY_LOOP_3200
		END_PARITY_LOOP_3200

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
	PARITY_CHECKER_3200 .FILL x8000
	NUM_BITS_3200 .FILL #15


.END
