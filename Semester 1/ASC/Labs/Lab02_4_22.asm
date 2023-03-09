bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4
    b db 5
    c db 2
    d dw 10

; our code starts here
segment code use32 class=code
    start:
        ; [(10+d)-(a*a-b*2)]/c
        mov ax, 0 ; ax=0
        mov ax, 10 ; ax=10
        add ax, [d] ; ax=ax+d=10+d
        mov bx, ax ; bx=ax=10+d
        
        mov al, [a] ; al=a
        mul byte [a] ; ax=al*a=a*a
        mov cx,ax ; cx=ax=a*a
        
        mov al, [b] ; al=b
        mov ah, 2 ; ah=2
        mul ah ; ax=al*ah=b*2
        sub cx,ax ; cx=cx-ax=a*a-b*2
        sub bx,cx ; bx=bx-cx=(10+d)-(a*a-b*2)
        
        mov ax, bx; ax=bx=(10+d)-(a*a-b*2)
        div byte [c] ; ax=ax/c=[(10+d)-(a*a-b*2)]/c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
