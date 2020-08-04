;=================================================
; Name:
; Email:
; 
; Lab: lab 4, ex 1
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

	; Instructions
	
	AND R0, R0, x0
	LD R1, COUNTER
	LD R3, DATA_PTR
	
	FILL_LOOP
		ADD R1, R1, #-1
		BRn END_FILL_LOOP
	
		STR R0, R3, #0
		ADD R0, R0, #1
		ADD R3, R3, #1
		BR FILL_LOOP
	END_FILL_LOOP
	
	LD R3, DATA_PTR
	LDR R2, R3, #6
	
	HALT
	
	; Local Data
	
	COUNTER .FILL #10
	DATA_PTR .FILL x4000
	
	; Remote Data
	
	.ORIG x4000
	REMOTEARR .BLKW #10

.END
