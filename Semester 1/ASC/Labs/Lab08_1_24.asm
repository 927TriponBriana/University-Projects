bits 32
global start        

; declare extern functions used by the program
extern exit, printf, scanf         ; add printf as extern function            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf can be found in library msvcrt.dll
import scanf msvcrt.dll
                          

segment data use32 class=data
        a dd 0 ; we'll store the value read from keyboard
        b dd 0
        k dd 3
        two dw 2
        ;result times 8 db 0FFh
        message_a db "a=", 0
        message_b db "b=", 0
        format db "%d", 0
        ;print_message db "Nr is %c apples", 0
        print_message1 dw "1", 0
        print_message0 dw "0", 0
        print_empty dw "", 0
        
        
segment  code use32 class=code
    start:
        ;Two numbers a and b are given. Compute the expression value: (a/b)*k, where k is a constant value defined in data segment. Display the expression value (in base 2).
        push dword message_a ; ! on the stack is placed the address of the string, not its value
        call [printf]      ; call function printf for printing 
        add esp, 4 * 1     ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
        ;we call scanf(format, a) which will read a number in variable a
        push dword a 
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        push dword message_b
        call [printf]
        add esp, 4 * 1
        push dword b
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ;a/b
        mov eax, [a]
        mov ebx, [b]
        mov edx, 0
        idiv ebx ; EAX <- EDX:EAX / EBX , EDX <- EDX:EAX % EBX
        
        ;a/b*k
        mov edx, [k]
        imul edx ; EDX:EAX <- EAX*EDX
        
        mov ecx, 0
        mov ecx, 32
        starter_loop2:
            rol edx, 1
            pushad
            jnc ignore_if_not_one ; if the bit is one
                push dword print_message1
            ignore_if_not_one:
            popad
            pushad
            jc ignore_if_not_zero ; if the bit is zero
                push dword print_message0
            ignore_if_not_zero:
            call [printf]
            add esp, 4 * 1
            popad
        loop starter_loop2
        
        mov ecx, 0
        mov ecx, 32
        starter_loop:
            rol eax, 1
            pushad
            jnc ignore_if_not_one1 ; if the bit is one
                push dword print_message1
            ignore_if_not_one1:
            popad
            pushad
            jc ignore_if_not_zero1 ; if the bit is zero
                push dword print_message0
            ignore_if_not_zero1:
            call [printf]
            add esp, 4 * 1
            popad
        loop starter_loop
        

        ; exit(0)
        push dword 0      ; push on stack the parameter for exit
        call [exit]       ; call exit to terminate the programme

        
        
bits 32

global start        

; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf
                          
segment data use32 class=data
	n db  8Bh       ; in this variable we'll store the value read from the keyboard
    ; char strings are of type byte
	message  db "n=", 0  ; char strings for C functions must terminate with 0(value, not char)
	format_r  db "%x", 0  ; %x <=> a exadecimal number (base 16)
    formal_p db "In decimal is: %d", 0 
    
segment code use32 class=code
    start:
        ;Read a hexadecimal number with 2 digits from the keyboard. Display the number in base 10, in both interpretations: as an unsigned number and as a signed number.
        
        push dword message ; on the stack is placed the address of the string, not its value
        call [printf]      
        add esp, 4*1       ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
                                                   
        push dword n       ; address of n, not value
        push dword format_r
        call [scanf]       
        add esp, 4 * 2     ; free parameters on the stack
                           ; 4 = size of a dword; 2 = no of perameters
        
        ; unsigned iterpretation
        ;mov eax, 0
        ;mov eax, [n]
        ;mov dx, 0
        ;mov cx, 10
        ;div cx
        
        mov eax, [n]
        push dword eax
        push dword formal_p
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push dword 0      ; place on stack parameter for exit
        call [exit]       ; call exit to terminate the program