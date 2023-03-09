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
    b db 6
    c db 1
    e dd 20
    x dq 1000
  
; our code starts here
segment code use32 class=code
    start:   
        ;a/2 +b*b -a*b*c+e+x signed
        mov eax, 0
		mov al, [a]
        idiv BYTE [2]
		mov bx, ax
		
		mov al, [b]
		imul al 
		add ax, bx 
		mov ebx, 0
		mov bx, ax ; bx=ax=a/2+b*b
        cbw
        cwde
		
		mov al, [a]
		imul BYTE [b]
		mov ecx, 0
		mov cl, [c]
		imul ax
		sub ebx, eax
		push ebx
		
		mov ebx, [x]
		mov ecx, [x+4]
		
		mov eax, [e]
		mov edx, 0
		
		add ebx, eax
		adc ecx, edx
		pop eax
		mov edx, 0
		
		add ebx, eax
		adc ecx, edx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
