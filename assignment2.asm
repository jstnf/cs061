;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: 
; Email: 
; 
; Assignment name: Assignment 2
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC
OUT

AND R2, R2, x0
ADD R2, R0, #0

LEA R0, newline
PUTS

GETC
OUT

AND R3, R3, x0
ADD R3, R0, #0

LEA R0, newline
PUTS

AND R0, R0, x0
ADD R0, R2, #0
OUT

LEA R0, operation
PUTS

AND R0, R0, x0
ADD R0, R3, #0
OUT

LEA R0, equals
PUTS

ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12

ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12

NOT R3, R3
ADD R3, R3, #1
AND R4, R4, x0
ADD R4, R2, R3

BRzp PRINT_NUM

LEA R0, negative
PUTS
NOT R4, R4
ADD R4, R4, #1
PRINT_NUM


ADD R0, R4, x0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

LEA R0, newline
PUTS

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
operation .STRINGZ " - "
negative .STRINGZ "-"
equals .STRINGZ " = "
newline .FILL '\n'	; newline character - use with LD followed by OUT

;---------------	
;END of PROGRAM
;---------------	
.END
