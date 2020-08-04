;=================================================
; Name:
; Email:
; 
; Lab: lab 5, ex 3
; Lab section:
; TA:
;
; REGISTER USAGE SUMMARY:
; R0 - Output and input validation subroutine parameter
; R1 - Main type loop counter
; R2 - Stores value to print at the end
; R3 - Char validation, reprint character counter and random variable
; R4 - Pointer to ENTRY array
; R5 - Char validation, reprint character counter and random variable
; R6 - JSRR Pointer, otherwise unused by main function
; R7 - Unused by main function
;=================================================
.ORIG x3000
	
	; Instructions
	LD R1, DEC_16
	AND R2, R2, x0
	LEA R4, ENTRY
	
	LD R3, INVERT_CHAR_B
	
	VALIDATE_B
		GETC
		OUT
		; Store first-char in ENTRY for reprint
		STR R0, R4, #0
		; Validate b character
		ADD R0, R0, R3
		BRz BEGIN_BINARY
		; The character was not B
		LD R0, NEWLINE
		OUT
		LEA R0, ERROR_MSG
		PUTS
		BR VALIDATE_B
	
	BEGIN_BINARY
	ADD R4, R4, #1 ; Set R4 ptr to accept 0 and 1 for reprint
	
	TYPE_LOOP
		ADD R2, R2, R2
		
		BR END_TYPE_LOOP_ERROR
		
		TYPE_LOOP_ERROR
			LD R0, NEWLINE
			OUT
			LEA R0, ERROR_CHAR_VALIDATION
			PUTS
			LD R5, NEG_DEC_16
			ADD R5, R5, R1
			
			LEA R3, ENTRY
			REPRINT_CURR_CHARS
				LDR R0, R3, #0
				OUT
				ADD R3, R3, #1
				ADD R5, R5, #1
				BRnz REPRINT_CURR_CHARS
		END_TYPE_LOOP_ERROR
		
		GETC
		OUT
		
		; Validate the input
		LD R6, SUB_VALIDATE_INPUT_PTR
		JSRR R6
		ADD R3, R3, #0
		BRn TYPE_LOOP_ERROR ; Invalid input
		BRz END_TYPE_LOOP_ERROR ; Space
		
		STR R0, R4, #0
		ADD R4, R4, #1
		
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
	NEG_DEC_16 .FILL #-16
	NEWLINE .FILL '\n'
	INVERT_CHAR_B .FILL #-98
	SUB_PRINT_BINARY_PTR .FILL x3200
	SUB_VALIDATE_INPUT_PTR .FILL x3400
	ERROR_MSG .STRINGZ "Error! Please type 'b' to begin conversion!\n"
	ERROR_CHAR_VALIDATION .STRINGZ "Error! You may only type '0', '1', or SPACE!\n"
	ENTRY .BLKW #17
	
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
	
;=======================================================================
; Subroutine: SUB_VALIDATE_INPUT_3400
; Parameter: (R0) ASCII Character entered
; Postcondition: Determine if the character at R0 is either 1, 0, or SPACE
; Return Value: (R3) -1 if not valid, 0 if SPACE, 1 if '0' or '1'
;=======================================================================
.ORIG x3400

	;========================
	; Subroutine Instructions
	;========================

	SUB_VALIDATE_INPUT_3400

		ST R0, BACKUP_R0_3400
		ST R1, BACKUP_R1_3400
		ST R2, BACKUP_R2_3400
		; ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400
		
		; Check if 0 first
		CHECK_0_3400
			LD R2, NEG_CHAR_0_3400
			ADD R0, R0, R2
			BRz ONE_ZERO_CONDITION_3400
		
		; Now, check 1
		CHECK_1_3400
			LD R0, BACKUP_R0_3400
			LD R2, NEG_CHAR_1_3400
			ADD R0, R0, R2
			BRz ONE_ZERO_CONDITION_3400
		
		; Now check space - if false here, then it's invalid
		CHECK_SPACE_3400
			LD R0, BACKUP_R0_3400
			LD R2, NEG_CHAR_SPACE_3400
			ADD R0, R0, R2
			BRz SPACE_CONDITION_3400
			BR FALSE_CONDITION_3400
		
		ONE_ZERO_CONDITION_3400
			AND R3, R3, x0
			ADD R3, R3, #1
			BR END_VALIDATION_3400
		
		SPACE_CONDITION_3400
			AND R3, R3, x0
			BR END_VALIDATION_3400
		
		FALSE_CONDITION_3400
			AND R3, R3, x0
			ADD R3, R3, #-1
		
		END_VALIDATION_3400

		LD R0, BACKUP_R0_3400
		LD R1, BACKUP_R1_3400
		LD R2, BACKUP_R2_3400
		; LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R6, BACKUP_R6_3400
		LD R7, BACKUP_R7_3400
	RET

	;========================
	; Subroutine Data
	;========================

	BACKUP_R0_3400 		.BLKW 	#1
	BACKUP_R1_3400 		.BLKW 	#1
	BACKUP_R2_3400 		.BLKW 	#1
	; BACKUP_R3_3400 	.BLKW 	#1
	BACKUP_R4_3400		.BLKW 	#1
	BACKUP_R5_3400		.BLKW 	#1
	BACKUP_R6_3400		.BLKW 	#1
	BACKUP_R7_3400		.BLKW 	#1 
	NEG_CHAR_SPACE_3400	.FILL	#-32
	NEG_CHAR_0_3400		.FILL	#-48
	NEG_CHAR_1_3400		.FILL	#-49

.END
