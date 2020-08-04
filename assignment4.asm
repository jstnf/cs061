;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name:
; Email:
; 
; Assignment name: Assignment 4
; Lab section:
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

.ORIG x3000

	;-------------
	;Instructions
	;-------------

	BR INTRO_PROMPT
	ERROR_PROMPT
	
		LD R0, errorMessagePtr
		PUTS
	
	; output intro prompt
	INTRO_PROMPT
	
		LD R0, introPromptPtr
		PUTS
	
	; Set up flags, counters, accumulators as needed
	AND R0, R0, x0
	AND R1, R1, x0
	AND R2, R2, x0
	AND R3, R3, x0
	AND R4, R4, x0
	ADD R4, R4, #-1
	
	CHARACTER_LOOP
		GETC
		OUT
	
		LD R6, SUB_VALIDATE_INPUT_PTR
		JSRR R6
		
		ADD R3, R3, #0
		BRn END_CHAR_INPUT
		BRz ERROR_PROMPT
		
		ADD R2, R2, #1
		ADD R5, R2, #-5
		BRzp LOOP_SIGN_CHECK
		BR CHARACTER_LOOP
		
		LOOP_SIGN_CHECK
			ADD R4, R4, #0
			BRn END_CHARACTER_LOOP
			
			ADD R5, R2, #-6
			BRn CHARACTER_LOOP
	END_CHARACTER_LOOP
	
	LD R0, NEWLINE
	OUT
	
	END_CHAR_INPUT
	
	NEG_CHECK
		ADD R4, R4, #0
		BRnz END_NEG_CHECK
		; Negative check passed, flip R1 to negative
		NOT R1, R1
		ADD R1, R1, #1
	END_NEG_CHECK
						
	HALT

	;---------------	
	; Program Data
	;---------------

	introPromptPtr		.FILL xA800
	errorMessagePtr		.FILL xA900
	SUB_VALIDATE_INPUT_PTR .FILL x3200
	NEWLINE .FILL '\n'

	;------------
	; Remote data
	;------------
	
	.ORIG xA800			; intro prompt
	.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
	
	
	.ORIG xA900			; error message
	.STRINGZ	"ERROR! invalid input\n"
					
;=======================================================================
; Subroutine: SUB_VALIDATE_INPUT_3200
; Parameter: (R0) The character to validate
;            (R1) The current value we're writing to
;            (R2) The number of characters we've already processed
;            (R4) The sign flag, starts as -1 if no sign has been
;                 entered, 0 if the number is positive, -1 if the number
;                 is negative.
; Postcondition: The subroutine will check for valid characters
;                depending on the number of characters already entered.
;                It will return whether or not the character was valid
;                or if the program should end.
; Return Value: (R1) The new value with the appended character
;               (R3) -1 if the program should end, 0 if an error
;                    occurred and the program should start over,
;                    1 if the program should continue
;               (R4) Sign flag - only updated on first iteration
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_VALIDATE_INPUT_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		ADD R2, R2, #0
		BRnp END_FIRST_CHARACTER_VALIDATION_3200
		FIRST_CHARACTER_VALIDATION_3200
			AND R4, R4, x0
		
			FIRST_ENTER_CHECK_3200
				LD R5, NEWLINE_3200
				NOT R5, R5
				ADD R5, R5, #1
				ADD R0, R0, R5
				BRnp FIRST_NEG_CHECK_3200
				
				AND R3, R3, x0
				ADD R3, R3, #-1
				BR END_VALIDATION_3200
				
			FIRST_NEG_CHECK_3200
				LD R0, BACKUP_R0_3200
				LD R5, NEG_SIGN_3200
				NOT R5, R5
				ADD R5, R5, #1
				ADD R0, R0, R5
				BRnp FIRST_POS_CHECK_3200
				
				ADD R4, R4, #1
				AND R3, R3, x0
				ADD R3, R3, #1
				BR END_VALIDATION_3200
			
			FIRST_POS_CHECK_3200
				LD R0, BACKUP_R0_3200
				LD R5, POS_SIGN_3200
				NOT R5, R5
				ADD R5, R5, #1
				ADD R0, R0, R5
				BRnp END_CHECKS_3200
				
				AND R3, R3, x0
				ADD R3, R3, #1
				BR END_VALIDATION_3200
				
			END_CHECKS_3200
			ADD R4, R4, #-1
			
		END_FIRST_CHARACTER_VALIDATION_3200
		
		ENTER_CHECK_3200
			LD R0, BACKUP_R0_3200
			LD R5, NEWLINE_3200
			NOT R5, R5
			ADD R5, R5, #1
			ADD R0, R0, R5
			BRnp NUMBER_CHECK_3200
			
			; Check if the ENTER is the second character:
			; If it is, we need to check the first character if it was
			; a sign
			ADD R2, R2, #-1
			BRnp VALID_ENTER_INPUT_3200
			
			; If the first character was a sign, then the sign flag
			; should be set to 0 or 1, if not, then -1
			ADD R4, R4, #0
			BRn VALID_ENTER_INPUT_3200
			
			; The first character was a sign, indicate error and end
			AND R3, R3, x0
			BR END_VALIDATION_3200
			
			; Valid ENTER input
			VALID_ENTER_INPUT_3200
			AND R3, R3, x0
			ADD R3, R3, #-1
			BR END_VALIDATION_3200
		
		NUMBER_CHECK_3200
			LD R0, BACKUP_R0_3200
			LD R5, CHAR_0_3200
			NOT R5, R5
			ADD R5, R5, #1
			ADD R0, R0, R5
			BRn NUMBER_CHECK_ERROR_3200
			
			LD R0, BACKUP_R0_3200
			LD R5, CHAR_9_3200
			NOT R5, R5
			ADD R5, R5, #1
			ADD R0, R0, R5
			BRp NUMBER_CHECK_ERROR_3200
			
			ADD R0, R1, #0
			LD R5, DEC_9_3200
			MULTIPLY_10_LOOP_3200
				ADD R1, R0, R1
				ADD R5, R5, #-1
				BRp MULTIPLY_10_LOOP_3200
				
			LD R0, BACKUP_R0_3200
			ADD R0, R0, #-12
			ADD R0, R0, #-12
			ADD R0, R0, #-12
			ADD R0, R0, #-12
			ADD R1, R0, R1
			AND R3, R3, x0
			ADD R3, R3, #1
			BR END_VALIDATION_3200
			
			NUMBER_CHECK_ERROR_3200
				; Output a newline so that error message is on next line
				LD R0, NEWLINE_3200
				OUT
				AND R3, R3, x0
				
		END_VALIDATION_3200

		LD R0, BACKUP_R0_3200
		LD R2, BACKUP_R2_3200
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
	NEWLINE_3200 .FILL '\n'
	NEG_SIGN_3200 .FILL '-'
	POS_SIGN_3200 .FILL '+'
	CHAR_0_3200 .FILL '0'
	CHAR_9_3200 .FILL '9'
	DEC_9_3200 .FILL #9

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
