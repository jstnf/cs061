;=================================================
; Name:
; Email:
; 
; Lab: lab 2. ex 2
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions
	
	LDI R3, DEC_65_PTR							; R3 <- MEM[DEC_65_PTR]
	LDI R4, HEX_41_PTR							; R3 <- MEM[HEX_41_PTR]
	
	ADD R3, R3, #1								; R3 <- R3 + 1
	ADD R4, R4, #1								; R4 <- R4 + 1
	
	STI R3, DEC_65_PTR							; MEM[DEC_65_PTR] <- R3
	STI R4, HEX_41_PTR							; MEM[HEX_41_PTR] <- R4
	
	HALT										; Terminate program
	
	; Local data
	
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
	
	; Remote data
	
	.ORIG x4000
	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END
