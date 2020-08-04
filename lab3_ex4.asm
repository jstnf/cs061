;=================================================
; Name:
; Email:
; 
; Lab: lab 3, ex 4
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions
	
	LD R2, ARRAY_PTR							; R2 <- ARRAY_PTR
	LD R3, DEC_100								; R3 <- 100
	
	LEA R0, PROMPT								; R0 <- PROMPT ...
	PUTS										; Print string at R0
	
	DO_WHILE
		LD R5, NEG_SENTINEL						; R5 <- NEG_SENTINEL
		GETC									; R0 <- char
		OUT										; Output character at R0
		STR R0, R2, #0							; MEM[R2] <- R0
		ADD R2, R2, #1							; R2 <- R2 + 1
		
		ADD R5, R5, R0							; R5 <- R5 + R0
		BRnp END_SENTINEL_CONDITION				; END_SENTINEL_CONDITION if R5 > 0 || R5 < 0
		
		SENTINEL_CONDITION
			AND R3, R3, x0						; R3 <- 0
		END_SENTINEL_CONDITION
		
		ADD R3, R3, #-1							; R3 <- R3 - 1
		BRp DO_WHILE							; DO_WHILE if R3 > 0
	END_DO_WHILE
	
	LD R2, ARRAY_PTR							; R2 <- ARRAY_PTR
	LD R3, DEC_100								; R3 <- 100
	
	DO_WHILE_2
		LD R5, NEG_SENTINEL						; R5 <- NEG_SENTINEL
		LDR R0, R2, #0							; R0 <- char
		OUT										; Output character at R0
		ADD R2, R2, #1							; R2 <- R2 + 1
		
		ADD R5, R5, R0							; R5 <- R5 + R0
		BRnp END_SENTINEL_CONDITION_2			; END_SENTINEL_CONDITION_2 if R5 > 0 || R5 < 0
		
		SENTINEL_CONDITION_2
			AND R3, R3, x0						; R3 <- 0
		END_SENTINEL_CONDITION_2
		
		ADD R3, R3, #-1							; R3 <- R3 - 1
		BRp DO_WHILE_2							; DO_WHILE_2 if R3 > 0
	END_DO_WHILE_2
		
	HALT										; Terminate program
	
	; Local data
	
	PROMPT .STRINGZ "Enter a string (less than 100 characters) and end with '&':\n"
	DEC_100 .FILL #100
	ARRAY_PTR .FILL x4000
	NEG_SENTINEL .FILL #-38						; '&' character negative complement
	
	; Remote data
	
	.ORIG x4000
	ARRAY_1 .BLKW #100
	
.END
