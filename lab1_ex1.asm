;=================================================
; Name:
; Email:
; 
; Lab: lab 1, ex 1
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

	; Instructions

	AND R1, R1, x0										; Bitwise values at x0000 (all 0) into R1
	LD R2, DEC_12										; Load value at label DEC_12 into R2
	LD R3, DEC_6										; Load value at label DEC_6 into R3
	
	DO_WHILE_LOOP										; Create a branch 'DO_WHILE_LOOP'
		ADD R1, R1, R2									; R1 = R1 + R2
		ADD R3, R3, #-1									; R3 = R3 - 1
		BRp DO_WHILE_LOOP								; Goto the branch DO_WHILE_LOOP if R3 > 0
	END_DO_WHILE_LOOP									; End of branch
	
	HALT												; Terminate program
		
	; Local data
	
	DEC_12	.FILL	#12									; Put decimal number 12 into memory address labelled DEC_12
	DEC_6	.FILL	#6									; Put decimal number 6 into memory address labelled DEC_6
	
.END
