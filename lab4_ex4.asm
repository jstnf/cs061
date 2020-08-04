;=================================================
; Name:
; Email:
; 
; Lab: lab 4, ex 4
; Lab section:
; TA:
; 
;=================================================
.ORIG x3000

	; Instructions
	
	LD R0, TWO_TO_ZERO
	LD R1, COUNTER
	LD R3, DATA_PTR
	
	FILL_LOOP
		ADD R1, R1, #-1
		BRn END_FILL_LOOP
	
		STR R0, R3, #0
		ADD R0, R0, R0
		ADD R3, R3, #1
		BR FILL_LOOP
	END_FILL_LOOP
	
	LD R3, DATA_PTR
	LDR R2, R3, #6
	
	LD R1, COUNTER
	OUTPUT_LOOP
		ADD R1, R1, #-1
		BRn END_OUTPUT_LOOP
		
		LDR R0, R3, #0
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		ADD R0, R0, #12
		OUT
		LD R0, NEWLINE
		OUT
		ADD R3, R3, #1
		BR OUTPUT_LOOP
	END_OUTPUT_LOOP
	
	HALT
	
	; Local Data
	
	TWO_TO_ZERO .FILL #1
	COUNTER .FILL #10
	DATA_PTR .FILL x4000
	NEWLINE .FILL '\n'
	
	; Remote Data
	
	.ORIG x4000
	REMOTEARR .BLKW #10

.END
