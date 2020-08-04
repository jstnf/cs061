;=================================================
; Name:
; Email:
; 
; Lab: lab 1, ex 0
; Lab section:
; TA:
; 
;=================================================

.ORIG x3000

; Instructions

	LEA R0, MSG_TO_PRINT 								; Load data into R0 (register 0), from the memory address labelled MSG_TO_PRINT
	PUTS												; Print the string at MSG_TO_PRINT since it's stored in R0 (TRAP x22)
	
	HALT												; Terminate
	
; Local data

	MSG_TO_PRINT	.STRINGZ	"Hello world!!!\n"		; Store the character 'H' in memory at the label MSG_TO_PRINT
														; Subsequent characters are in subsequent memory addresses
														
.END
