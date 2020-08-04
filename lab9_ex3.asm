;=================================================
; Name:
; Email:
; 
; Lab: lab 9, ex 3
; Lab section:
; TA:
; 
;=================================================
; test harness
.ORIG x3000

	LD R4, BASE_PTR
	LD R5, MAX_PTR
	LD R6, TOS_PTR
	
	; First number prompt
	LEA R0, NUMBER_PROMPT
	PUTS
	GETC
	OUT
	
	; Number conversion
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	
	LD R3, SUB_PUSH_PTR
	JSRR R3
	
	LD R0, NEWLINE
	OUT
	
	; Second number prompt
	LEA R0, NUMBER_PROMPT
	PUTS
	GETC
	OUT
	
	; Number conversion
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	
	LD R3, SUB_PUSH_PTR
	JSRR R3
	
	LD R0, NEWLINE
	OUT
	
	; Operation prompt
	LEA R0, OPERATION_PROMPT
	PUTS
	GETC
	OUT
	
	LD R0, NEWLINE
	OUT
	
	; Multiplication and printing
	LD R3, SUB_RPN_MULTIPLY_PTR
	JSRR R3
	LD R3, SUB_POP_PTR
	JSRR R3
	ADD R1, R0, #0
	LD R3, SUB_PRINT_DECIMAL_PTR
	JSRR R3

	HALT
;-----------------------------------------------------------------------------------------------
; test harness local data:
BASE_PTR .FILL xA000
MAX_PTR .FILL xA005
TOS_PTR .FILL xA000
SUB_PUSH_PTR .FILL x3200
SUB_POP_PTR .FILL x3400
SUB_RPN_MULTIPLY_PTR .FILL x3600
SUB_PRINT_DECIMAL_PTR .FILL x4200
NEWLINE .FILL '\n'
NUMBER_PROMPT .STRINGZ "Enter a number (0-9):\n"
OPERATION_PROMPT .STRINGZ "Enter an operation:\n"

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

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
.ORIG x3600

	SUB_RPN_MULTIPLY_3600

		ST R0, BACKUP_R0_3600
		ST R1, BACKUP_R1_3600
		ST R2, BACKUP_R2_3600
		ST R3, BACKUP_R3_3600
		ST R4, BACKUP_R4_3600
		ST R5, BACKUP_R5_3600
		ST R6, BACKUP_R6_3600
		ST R7, BACKUP_R7_3600
		
		LD R3, SUB_POP_PTR_3600
		JSRR R3
		ADD R1, R0, #0
		LD R3, SUB_POP_PTR_3600
		JSRR R3
		LD R3, SUB_MULTIPLY_PTR_3600
		JSRR R3
		LD R3, SUB_PUSH_PTR_3600
		JSRR R3

		LD R0, BACKUP_R0_3600
		LD R1, BACKUP_R1_3600
		LD R2, BACKUP_R2_3600
		LD R3, BACKUP_R3_3600
		LD R4, BACKUP_R4_3600
		LD R5, BACKUP_R5_3600
		LD R7, BACKUP_R7_3600
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
BACKUP_R6_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1 
SUB_PUSH_PTR_3600 .FILL x3200
SUB_POP_PTR_3600 .FILL x3400
SUB_MULTIPLY_PTR_3600 .FILL x3800

;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_MULTIPLY
; Parameter (R0): The first number to multiply
; Parameter (R1): The second number to multiply
; Postcondition: The subroutine has multipled the number in R0 by R1 and placed the value in R1
; Return Value: R0 ← The result from multiplying
;------------------------------------------------------------------------------------------
.ORIG x3800

	SUB_MULTIPLY_3800

		ST R0, BACKUP_R0_3800
		ST R1, BACKUP_R1_3800
		ST R2, BACKUP_R2_3800
		ST R3, BACKUP_R3_3800
		ST R4, BACKUP_R4_3800
		ST R5, BACKUP_R5_3800
		ST R6, BACKUP_R6_3800
		ST R7, BACKUP_R7_3800
		
		ADD R2, R0, #0
		AND R0, R0, x0
		
		MULT_LOOP_3800
			ADD R1, R1, #-1
			BRn END_MULT_LOOP_3800
			
			ADD R0, R0, R2
			BR MULT_LOOP_3800
		END_MULT_LOOP_3800

		LD R1, BACKUP_R1_3800
		LD R2, BACKUP_R2_3800
		LD R3, BACKUP_R3_3800
		LD R4, BACKUP_R4_3800
		LD R5, BACKUP_R5_3800
		LD R6, BACKUP_R6_3800
		LD R7, BACKUP_R7_3800
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R0_3800 .BLKW #1
BACKUP_R1_3800 .BLKW #1
BACKUP_R2_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R4_3800 .BLKW #1
BACKUP_R5_3800 .BLKW #1
BACKUP_R6_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1 

;===============================================================================================

;------------------------------------------------------------------------------------------
; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.
; Inputs: R1, the number to print
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;------------------------------------------------------------------------------------------
.ORIG x4200

	SUB_PRINT_DECIMAL_4200

		ST R0, BACKUP_R0_4200
		ST R1, BACKUP_R1_4200
		ST R2, BACKUP_R2_4200
		ST R3, BACKUP_R3_4200
		ST R4, BACKUP_R4_4200
		ST R5, BACKUP_R5_4200
		ST R6, BACKUP_R6_4200
		ST R7, BACKUP_R7_4200
		
		; Check if negative
		LD R0, NEG_CHECK_4200
		LD R2, BACKUP_R1_4200
		AND R1, R1, R0
		BRz BYPASS_NEG_PRINT_4200
		
		LD R0, NEG_SIGN_4200
		OUT
		
		; If it's negative, we flip to the 2's complement positive
		NOT R2, R2
		ADD R2, R2, #1
		
		BYPASS_NEG_PRINT_4200
		
		ADD R1, R2, #0
		
		AND R3, R3, x0 ; If we've gotten a non-zero, this will be positive
		
		; 10000's
		LD R4, DEC_10000_4200
		AND R2, R2, x0 ; Counter
		DET_10000_LOOP_4200
			ADD R1, R1, R4
			BRn END_DET_10000_LOOP_4200
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_10000_LOOP_4200
		END_DET_10000_LOOP_4200
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRz SKIP_TO_1000_4200
		
		ADD R0, R2, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT

		; 1000's
		SKIP_TO_1000_4200
		LD R4, DEC_1000_4200
		AND R2, R2, x0 ; Counter
		DET_1000_LOOP_4200
			ADD R1, R1, R4
			BRn END_DET_1000_LOOP_4200
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_1000_LOOP_4200
		END_DET_1000_LOOP_4200
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_1000_4200
		
		CHECK_ZERO_1000_4200
		ADD R3, R3, #0
		BRp PRINT_1000_4200
		BR END_PRINT_1000_4200 ; Only print 0 if we have encountered non-zero
		
		PRINT_1000_4200
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_1000_4200
		
		; 100's
		LD R4, DEC_100_4200
		AND R2, R2, x0 ; Counter
		DET_100_LOOP_4200
			ADD R1, R1, R4
			BRn END_DET_100_LOOP_4200
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_100_LOOP_4200
		END_DET_100_LOOP_4200
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_100_4200
		
		CHECK_ZERO_100_4200
		ADD R3, R3, #0
		BRp PRINT_100_4200
		BR END_PRINT_100_4200 ; Only print 0 if we have encountered non-zero
		
		PRINT_100_4200
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_100_4200
		
		; 10's
		LD R4, DEC_10_4200
		AND R2, R2, x0 ; Counter
		DET_10_LOOP_4200
			ADD R1, R1, R4
			BRn END_DET_10_LOOP_4200
			ADD R2, R2, #1
			ADD R3, R3, #1
			BR DET_10_LOOP_4200
		END_DET_10_LOOP_4200
		
		; Get the remainder back in R1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R1, R1, R4
		
		ADD R2, R2, #0
		BRp PRINT_10_4200
		
		CHECK_ZERO_10_4200
		ADD R3, R3, #0
		BRp PRINT_10_4200
		BR END_PRINT_10_4200 ; Only print 0 if we have encountered non-zero
		
		PRINT_10_4200
			ADD R0, R2, #0
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			ADD R0, R0, #12
			OUT
		END_PRINT_10_4200
		
		; Print remaining number in R1
		ADD R0, R1, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT

		LD R0, BACKUP_R0_4200
		LD R1, BACKUP_R1_4200
		LD R2, BACKUP_R2_4200
		LD R3, BACKUP_R3_4200
		LD R4, BACKUP_R4_4200
		LD R5, BACKUP_R5_4200
		LD R6, BACKUP_R6_4200
		LD R7, BACKUP_R7_4200
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_DECIMAL local data
BACKUP_R0_4200 .BLKW #1
BACKUP_R1_4200 .BLKW #1
BACKUP_R2_4200 .BLKW #1
BACKUP_R3_4200 .BLKW #1
BACKUP_R4_4200 .BLKW #1
BACKUP_R5_4200 .BLKW #1
BACKUP_R6_4200 .BLKW #1
BACKUP_R7_4200 .BLKW #1 
REMOVE_NEG_4200 .FILL x7FFF
NEG_CHECK_4200 .FILL x8000
NEG_SIGN_4200 .FILL '-'
DEC_10000_4200 .FILL #-10000
DEC_1000_4200 .FILL #-1000
DEC_100_4200 .FILL #-100
DEC_10_4200 .FILL #-10

;===============================================================================================
