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
        message_a db "a=", 0
        message_b db "b=", 0
        format db "%d", 0
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
        idiv ebx ; eax <- edx:eax / ebx , edx <- edx:eax % ebx
        
        ;a/b*k
        mov edx, [k]
        imul edx ; edx:eax <- eax*edx
        
        cmp eax, 0
        jne is_zero
        mov ecx, 0
        mov ecx, 32
        starter_loop2:
            rol edx, 1
            pushad
            jnc ignore_if_not_one ; if the bit is one
                push dword print_message1
            ignore_if_not_one:
            ;popad
            ;pushad
            jc ignore_if_not_zero ; if the bit is zero
                push dword print_message0
            ignore_if_not_zero:
            call [printf]
            add esp, 4 * 1
            popad
        loop starter_loop2
        is_zero:
        
        
        mov ecx, 0
        mov ecx, 32
        starter_loop:
            rol eax, 1
            pushad
            jnc ignore_if_not_one1 ; if the bit is one
                push dword print_message1
            ignore_if_not_one1:
            ;popad
            ;pushad
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
