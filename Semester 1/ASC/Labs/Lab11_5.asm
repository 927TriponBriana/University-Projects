bits  32
global  start

extern  printf, exit, scanf, expression
import  printf msvcrt.dll
import scanf msvcrt.dll
import  exit msvcrt.dll

; Read the signed numbers a, b and c on type byte; calculate and display a+b-c.
segment  data use32 public data
    format_read db "%d", 0
    message_a db "a = ",0
    message_b db "b = ",0
    message_c db "c = ",0
	format_print db  "The result of the expression is = %d", 0
    first_number db 0
    second_number db 0 
    third_number db 0 
    result resd 1
    
segment  code use32 public code

    
start:
    
    push dword message_a ;on the stack is placed the address of the string, not its value
    call [printf]      ; call function printf for printing 
    add esp, 4 * 1
    
    push dword first_number
    push dword format_read
    call [scanf]
    add ESP, 4*2
    
    push dword message_b ;on the stack is placed the address of the string, not its value
    call [printf]      ; call function printf for printing 
    add esp, 4 * 1
    
    push dword second_number
    push dword format_read
    call [scanf]
    add ESP, 4*2
    
    push dword message_c ;on the stack is placed the address of the string, not its value
    call [printf]      ; call function printf for printing 
    add esp, 4 * 1
    
    push dword third_number
    push dword format_read
    call [scanf]
    add ESP, 4*2    
    
    push dword [third_number]
    push dword [second_number]
    push dword [first_number]
   
    call expression
    
    ;printf(format_print, a+b-c)
    push dword EBX
    push dword format_print
    call [printf]
    add ESP, 4*2
    
	push 0
	call [exit]
    
    
