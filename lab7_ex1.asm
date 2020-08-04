;=================================================
; Name:
; Email:
; 
; Lab: lab 7, ex 1
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

	; Instructions
	
	LD R6, SUB_FILL_REGISTER_PTR
	JSRR R6
	
	ADD R1, R1, #1
	
	LD R6, SUB_PRINT_DECIMAL_PTR
	JSRR R6
	
	HALT
	
	; Remote Data
	SUB_FILL_REGISTER_PTR .FILL x3200
	SUB_PRINT_DECIMAL_PTR .FILL x3400
	
;=======================================================================
; Subroutine: SUB_FILL_REGISTER_3200
; Postcondition: Fill R1 with a hard-coded value in the subroutine data
; Return Value: (R1) The hard-coded value
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_FILL_REGISTER_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		LD R1, THE_VALUE_3200

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
	THE_VALUE_3200 .FILL #0

;=======================================================================
; Subroutine: SUB_PRINT_DECIMAL_3400
; Parameter: (R1) The number to print
; Postcondition: Takes the value in R1 and prints the decimal to console
;=======================================================================
.ORIG x3400

	;========================
	; Subroutine Instructions
	;========================

	SUB_PRINT_DECIMAL_3400

		ST R0, BACKUP_R0_3400
		ST R1, BACKUP_R1_3400
		ST R2, BACKUP_R2_3400
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400
		
		; Check if negative
		LD R0, NEG_CHECK_3400
		LD R2, BACKUP_R1_3400
		AND R1, R1, R0
		BRz BYPASS_NEG_PRINT_3400
		
		LD R0, NEG_SIGN_3400
		OUT
		
		; If it's negative, we flip to the 2's complement positive
		NOT R2, R2
		ADD R2, R2, #1
		
		BYPASS_NEG_PRINT_3400
		
		ADD R1, R2, #0
		
		AND R3, R3, x0 ; If we've gotten a non-zero, this will be positive
		
		; 10000's
		LD R4, DEC_10000_3400
		AND R2, R2, x0 ; Counter
		DET_10000_LOOP_3400
			ADD R1, R1, R4
			BRn END_DET_10000_LOOP_3400
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_10000_LOOP_3400
		END_DET_10000_LOOP_3400
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRz SKIP_TO_1000_3400
		
		ADD R0, R2, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT

		; 1000's
		SKIP_TO_1000_3400
		LD R4, DEC_1000_3400
		AND R2, R2, x0 ; Counter
		DET_1000_LOOP_3400
			ADD R1, R1, R4
			BRn END_DET_1000_LOOP_3400
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_1000_LOOP_3400
		END_DET_1000_LOOP_3400
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_1000_3400
		
		CHECK_ZERO_1000_3400
		ADD R3, R3, #0
		BRp PRINT_1000_3400
		BR END_PRINT_1000_3400 ; Only print 0 if we have encountered non-zero
		
		PRINT_1000_3400
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_1000_3400
		
		; 100's
		LD R4, DEC_100_3400
		AND R2, R2, x0 ; Counter
		DET_100_LOOP_3400
			ADD R1, R1, R4
			BRn END_DET_100_LOOP_3400
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_100_LOOP_3400
		END_DET_100_LOOP_3400
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_100_3400
		
		CHECK_ZERO_100_3400
		ADD R3, R3, #0
		BRp PRINT_100_3400
		BR END_PRINT_100_3400 ; Only print 0 if we have encountered non-zero
		
		PRINT_100_3400
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_100_3400
		
		; 10's
		LD R4, DEC_10_3400
		AND R2, R2, x0 ; Counter
		DET_10_LOOP_3400
			ADD R1, R1, R4
			BRn END_DET_10_LOOP_3400
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_10_LOOP_3400
		END_DET_10_LOOP_3400
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_10_3400
		
		CHECK_ZERO_10_3400
		ADD R3, R3, #0
		BRp PRINT_10_3400
		BR END_PRINT_10_3400 ; Only print 0 if we have encountered non-zero
		
		PRINT_10_3400
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_10_3400
		
		; Print remaining number in R1
		ADD R0, R1, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT

		LD R0, BACKUP_R0_3400
		LD R1, BACKUP_R1_3400
		LD R2, BACKUP_R2_3400
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R6, BACKUP_R6_3400
		LD R7, BACKUP_R7_3400
		RET

	;========================
	; Subroutine Data
	;========================

	BACKUP_R0_3400 .BLKW #1
	BACKUP_R1_3400 .BLKW #1
	BACKUP_R2_3400 .BLKW #1
	BACKUP_R3_3400 .BLKW #1
	BACKUP_R4_3400 .BLKW #1
	BACKUP_R5_3400 .BLKW #1
	BACKUP_R6_3400 .BLKW #1
	BACKUP_R7_3400 .BLKW #1 
	REMOVE_NEG_3400 .FILL x7FFF
	NEG_CHECK_3400 .FILL x8000
	NEG_SIGN_3400 .FILL '-'
	DEC_10000_3400 .FILL #-10000
	DEC_1000_3400 .FILL #-1000
	DEC_100_3400 .FILL #-100
	DEC_10_3400 .FILL #-10

.END
