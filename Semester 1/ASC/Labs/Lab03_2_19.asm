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
        ; a - byte, b - word, c - double word, d - qword
        ;(d+a)-(c-b)-(b-a)+(c+d) signed
        mov ax, word [b]
        cwde ; signed conversion from the word ax to the doubleword eax
        mov ebx, dword [c]
        sub ebx, eax
        mov eax, ebx
        cdq ; signed conversion from the doublewordword eax to the qword edx:eax
        mov ebx, eax
        mov ecx, edx
        
        mov al, byte [a]
        cbw ; signed conversion from the byte al to the word ax
        cwde
        cdq
        add eax, dword [d]
        adc edx, dword [d+4]
        
        sub eax, ebx
        sbb edx, ecx
        mov ebx, eax
        mov ecx, edx ; ecx:ebx = (d+a) - (c-b)
        
        mov al, byte [a]
        cbw
        mov dx, word [b]
        sub dx, ax
        mov ax, dx ; ax = b-a
        cwde
        cdq
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx = (d+a) - (c-b) - (b-a)
        
        mov eax, dword [c]
        cdq
        add eax, dword [d]
        adc edx, dword [d+4]
        add ebx, eax
        adc ecx, edx    
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
