bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b db 3
    c db 1
    e dd 6
    x dq 10
  
; our code starts here
segment code use32 class=code
    start:
        ; a,b,c-byte; e-doubleword; x-qword
        ;(a+a+b*c*100+x)/(a+10)+e*a unsigned
        mov al, byte [b]
        mul byte [c] ; ax = al*c = b*c
        mov dx, 100
        mul dx ; dx:ax = ax*dx = b*c*100
        
        mov bl, byte [a]
        add bl, byte [a]
        mov bh, 0 ;unsigned conversion from bl to bx
        mov cx, 0 ;unsigned conversion from bx to cx:bx
        add bx, ax ; bx = bx+ax = a+a+b*c*100
        mov ax, bx
        mov ebx, 0 ;unsigned conversion from bx to ebx
        mov bx, ax
        
        add ebx, dword [x] ; ecx:ebx = ecx:ebx+x = a+a+b*c*100+x
        add ecx, dword [x+4]
        mov eax, ebx
        push eax
        
        mov bl, byte [a]
        add bl, 10
        mov bh, 0
        mov cx, 0
        mov cx, bx
        mov ebx, 0
        mov bx, cx
        pop eax
        div ebx
        mov ebx, eax
        mov eax, dword [e]
        mul byte [a]
        add eax, ebx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
