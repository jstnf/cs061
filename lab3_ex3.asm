;=================================================
; Name:
; Email:
; 
; Lab: lab 3, ex 3
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions
	
	LD R2, ARRAY_PTR							; R2 <- ARRAY_PTR
	LD R3, DEC_10								; R3 <- 10
	
	LEA R0, PROMPT								; R0 <- PROMPT ...
	PUTS										; Print string at R0
	
	DO_WHILE
		GETC									; R0 <- char
		STR R0, R2, #0							; MEM[R2] <- R0
		ADD R2, R2, #1							; R2 <- R2 + 1
		ADD R3, R3, #-1							; R3 <- R3 - 1
		BRp DO_WHILE							; DO_WHILE if R3 > 0
	END_DO_WHILE
	
	LD R2, ARRAY_PTR							; R2 <- ARRAY_PTR
	LD R3, DEC_10								; R3 <- 10
	
	DO_WHILE_2
		LDR R0, R2, #0							; R0 <- char
		OUT										; Output character at R0
		LD R0, NEWLINE							; R0 <- NEWLINE
		OUT										; Output character at R0
		ADD R2, R2, #1							; R2 <- R2 + 1
		ADD R3, R3, #-1							; R3 <- R3 - 1
		BRp DO_WHILE_2							; DO_WHILE_2 if R3 > 0
	END_DO_WHILE_2
		
	HALT										; Terminate program
	
	; Local data
	
	PROMPT .STRINGZ "Please enter 10 characters:\n"
	DEC_10 .FILL #10
	ARRAY_PTR .FILL x4000
	NEWLINE .FILL x0A
	
	; Remote data
	
	.ORIG x4000
	ARRAY_1 .BLKW #10
	
.END
