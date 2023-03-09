bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 15
    b dw 5
    c dw 2
    d dw 3

; our code starts here
segment code use32 class=code
    start:
        ;(a-c)+(b-d)
        mov ax, 0
        mov ax, [a] ; punem valoarea de la adresa lui a in ax
        sub ax, [c] ; ax <- ax - valoarea de la adresa lui c
        
        mov bx, 0
        mov bx, [b]
        sub bx, [d]
        add ax, bx ; ax <- ax + bx
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
