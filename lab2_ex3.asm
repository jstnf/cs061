;=================================================
; Name:
; Email:
; 
; Lab: lab 2. ex 3
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions
	
	LD R5, DEC_65_PTR							; R5 <- DEC_65_PTR
	LD R6, HEX_41_PTR							; R6 <- HEX_41_PTR
	
	LDR R3, R5, #0								; R3 <- MEM[R5]
	LDR R4, R6, #0								; R4 <- MEM[R6]
	
	ADD R3, R3, #1								; R3 <- R3 + 1
	ADD R4, R4, #1								; R4 <- R4 + 1
	
	STR R3, R5, #0								; MEM[R5] <- R3
	STR R4, R6, #0								; MEM[R6] <- R4
	
	HALT										; Terminate program
	
	; Local data
	
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
	
	; Remote data
	
	.ORIG x4000
	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END
