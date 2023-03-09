bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 14
    b dw 130
    c dd 2000
    d dq 29754

; our code starts here
segment code use32 class=code
    start:
        ; a - byte, b - word, c - double word, d - qword 
        ;(d+d)-(a+a)-(b+b)-(c+c) unsigned
        mov eax, dword [d]
        mov edx, dword [d+4]
        add eax, dword [d]
        adc edx, dword [d+4] ; calculates d+d in edx:eax
        
        mov ebx, eax
        mov ecx, edx
        
        mov al, byte [a]
        add al, byte [a]
        mov ah, 0 ;unsigned conversion from al to ax
        mov dx, 0 ;unsigned conversion from ax to dx:ax
        mov edx, 0 ;unsigned conversion from dx:ax to edx:eax
        
        sub ebx, eax
        sbb ecx, edx
        
        mov ax, word [b]
        add ax, word [b]
        mov dx, 0
        mov edx, 0
        
        sub ebx, eax
        sbb ecx, edx
        
        mov ax, word [c]
        mov dx, word [c+2]
        add ax, word [c]
        adc dx, word [c+2]
        mov edx, 0
        
        sub ebx, eax
        sbb ecx, edx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
