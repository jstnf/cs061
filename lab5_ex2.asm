;=================================================
; Name:
; Email:
; 
; Lab: lab 5, ex 2
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000
	
	; Instructions
	
	AND R2, R2, x0
	LD R1, DEC_16
	
	GETC
	OUT
	
	TYPE_LOOP
		ADD R2, R2, R2
		GETC
		OUT
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R0, R0, #-12
		ADD R2, R2, R0
		ADD R1, R1, #-1
		BRp TYPE_LOOP
	
	LD R0, NEWLINE
	OUT
	LD R6, SUB_PRINT_BINARY_PTR
	JSRR R6
	
	HALT
	
	; Local Data
	DEC_16 .FILL #16
	NEWLINE .FILL '\n'
	SUB_PRINT_BINARY_PTR .FILL x3200
	
;=======================================================================
; Subroutine: SUB_PRINT_BINARY_3200
; Parameter: (R2) Hex value to be printed in binary
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
		
		ADD R1, R2, #0			; R1 <-- value to be displayed as binary 
		
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
