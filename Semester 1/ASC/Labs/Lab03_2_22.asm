bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 16
    b dw 1302
    c dd 7000
    d dq 1000

; our code starts here
segment code use32 class=code
    start:
        ; c+b-(a+d+b) signed
        mov ax, 0
        mov ax, [b]
        cwde
        add eax, dword [c]
        adc edx, dword [c+2]
        mov ebx, eax
        mov ecx, edx
        mov al, [a]
        cbw
        add ax, [b]
        cwde
        cdq
        
        add eax, dword [d]
        adc edx, dword [d+4]
     
        sbb ebx, eax
        sbb ecx, edx
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
