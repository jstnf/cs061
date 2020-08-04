;=================================================
; Name:
; Email:
; 
; Lab: lab 2. ex 1
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions
	
	LD R3, DEC_65								; Load DEC_65 into R3
	LD R4, HEX_41								; Load HEX_41 into R4
	
	HALT										; Terminate program
	
	; Local data
	
	DEC_65	.FILL	#65							; Put #65 into address with label DEC_65
	HEX_41	.FILL	x41							; Put x41 into address with label HEX_41
	
.END
