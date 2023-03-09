bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 50
    b db 2
    c db 3
    d dw 17

; our code starts here
segment code use32 class=code
    start:
        ;a,b,c - byte, d - word
        ;(10*a-5*b)+(d-5*c)
        mov ax, 0
        mov al, 10 ;al = 10
        mul byte [a] ;ax = al*a = 10*a
        mov bx, ax ;mutam rezultatul in bx
        
        mov ax, 0
        mov al, 5 ;ax = 5
        mul byte [b] ;ax = al*b = 5*b
        
        sub bx, ax; bx = bx-ax = 10*a - 5*b
        
        mov ax, 0
        mov al, 5 ;ax = 5
        mul byte [c] ; ax = al*c = 5*c
        
        mov cx, 0
        mov cx, [d] ; cx = d
        
        sub cx, ax ; cx = cx - ax
        
        add bx, cx ; bx = bx + cx
          
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
