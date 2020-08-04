;=================================================
; Name:
; Email:
; 
; Lab: lab 5, ex 1
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

; Instructions
	
	LD R0, TWO_TO_ZERO
	LD R1, COUNTER
	LD R3, DATA_PTR
	
	FILL_LOOP
		ADD R1, R1, #-1
		BRn END_FILL_LOOP
	
		STR R0, R3, #0
		ADD R0, R0, R0
		ADD R3, R3, #1
		BR FILL_LOOP
	END_FILL_LOOP
	
	LD R3, DATA_PTR
	LDR R2, R3, #6
	
	LD R1, COUNTER
	OUTPUT_LOOP
		ADD R1, R1, #-1
		BRn END_OUTPUT_LOOP
		
		LDR R0, R3, #0
		LD R6, SUB_PRINT_BINARY_PTR
		JSRR R6
		LD R0, NEWLINE
		OUT
		ADD R3, R3, #1
		BR OUTPUT_LOOP
	END_OUTPUT_LOOP
	
	HALT
	
	; Local Data
	
	TWO_TO_ZERO .FILL #1
	COUNTER .FILL #10
	DATA_PTR .FILL x4000
	NEWLINE .FILL '\n'
	SUB_PRINT_BINARY_PTR .FILl x3200
	
	; Remote Data
	
	.ORIG x4000
	REMOTEARR .BLKW #10
	
;=======================================================================
; Subroutine: SUB_PRINT_BINARY_3200
; Parameter: (R0) Hex value to be printed in binary
; Postcondition: The value stored in R0 is printed to the console in binary
; Return Value: NONE
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_PRINT_BINARY_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		ADD R1, R0, #0			; R1 <-- value to be displayed as binary 
		
		;-------------------------------
		;INSERT CODE STARTING FROM HERE
		;--------------------------------
		
		LD R2, DEC_4_3200
		BIT_LOOP_3200
			LD R3, DEC_4_3200
			
			INNER_BIT_LOOP_3200
				LD R0, HEX_30_3200
				LD R5, LEADING_1_3200
				AND R5, R5, R1
				BRn PRINT_1_3200
				
				PRINT_0_3200
					OUT
					BR END_PRINT_3200
				PRINT_1_3200
					ADD R0, R0, #1
					OUT
				END_PRINT_3200
				
				ADD R1, R1, R1
				ADD R3, R3, #-1
				BRp INNER_BIT_LOOP_3200
			END_INNER_BIT_LOOP_3200

			ADD R2, R2, #-1
			BRz END_SEGMENTS_3200

			LD R0, SPACE_3200
			OUT
			BR BIT_LOOP_3200
		END_SEGMENTS_3200

		LD R0, BACKUP_R0_3200
		LD R1, BACKUP_R1_3200
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

	BACKUP_R0_3200 	.BLKW 	#1
	BACKUP_R1_3200 	.BLKW 	#1
	BACKUP_R2_3200 	.BLKW 	#1
	BACKUP_R3_3200 	.BLKW 	#1
	BACKUP_R4_3200	.BLKW 	#1
	BACKUP_R5_3200	.BLKW 	#1
	BACKUP_R6_3200	.BLKW 	#1
	BACKUP_R7_3200	.BLKW 	#1 
	DEC_4_3200		.FILL 	#4
	SPACE_3200		.FILL 	' '
	TEMP_CHAR_3200	.FILL 	'a'
	HEX_30_3200		.FILL 	x30
	LEADING_1_3200 	.FILL 	x8000

.END
