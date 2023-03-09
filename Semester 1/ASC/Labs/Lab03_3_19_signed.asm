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
    c db -1
    e dd 6
    x dq 10
  
; our code starts here
segment code use32 class=code
    start:
        ; a,b,c-byte; e-doubleword; x-qword
        ;(a+a+b*c*100+x)/(a+10)+e*a signed
        mov al, byte [b]
        imul byte [c] ; ax = al*c = b*c
        mov dx, 100
        imul dx ; dx:ax = ax*dx = b*c*100
        mov bx, ax
        mov cx, dx
        
        mov al, byte [a]
        add al, byte [a]
        cbw
        cwd
        add ax, bx ; ax = ax+bx = a+a+b*c*100
        adc dx, cx
        push dx
        push ax
        pop eax
        cdq
        
        add eax, dword [x] ; edx:eax = edx:eax+x = a+a+b*c*100+x
        adc edx, dword [x+4]
        push eax
        
        mov al, byte [a]
        add al, 10
        cbw
        cwde
        mov ebx, eax
        pop eax
        idiv ebx ; eax = edx:eax/ebx; edx = edx:eax%ebx
        mov ebx, eax
        mov eax, dword [e]
        imul byte [a]
        add eax, ebx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
