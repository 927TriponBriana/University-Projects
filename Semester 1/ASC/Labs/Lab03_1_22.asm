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
        ; (d+c)-(c+b)-(b+a) unsigned
        mov eax, dword [d]
        mov edx, dword [d+4]
        add eax, dword [c]
        adc edx, dword [c+2] ; calculates d+c in edx:eax
        
        mov ebx, eax
        mov ecx, edx
        
        mov ax, [c]
        mov dx, [c+2] ; dx:ax=c
        push dx
        push ax
        pop eax
        mov edx, 0
        
        add ax, word [b]
        sub ebx, eax
        sub ecx, edx
        
        mov ax, word [b]
        add al, byte [a]
        
        sub ebx, eax
        sub ecx, edx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
