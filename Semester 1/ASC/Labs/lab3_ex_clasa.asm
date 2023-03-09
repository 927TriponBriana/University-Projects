bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db -4
    b dw 10
    c dw -20
    d dd 30

; our code starts here
segment code use32 class=code
    start:
        ;(a*b)+(c*d) conversie fara semn
        ;movzx ax, byte [a]
        ;mul word [b]
        ;mov bx, ax
        ;movzx eax, word [c]
        ;mul dword [d]
        
        ;(a*b)+(c*d) conversie cu semn
        mov al,0
        mov al, [a]
        cbw 
        imul word [b]
        mov bx, ax
        mov ax, 0
        mov dx, 0
        mov ax, [c]
        cwd
        imul dword [d]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
