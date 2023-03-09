bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2, 1, -3, 3, -4, 2, 6
    a_len equ $-a
    b db 4, 5, 7, 6, 2, 1
    b_len equ $-b
    r resb a_len + b_len 
  
; our code starts here
segment code use32 class=code
    start:   
        ;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A.
        mov eax, a_len
		cmp eax, 0
        jz final
        mov eax, b_len
        cmp eax, 0
        jz final
        
        mov eax, 0
        mov ebx, b_len
        dec ebx
        mov ecx, b_len
        loop_b:         ; loop through all the elements of b in reverse order and put them in r
            mov dl, [b+ebx]
            mov [r+eax], dl ;
            dec ebx
            inc eax
        loop loop_b
        
        mov ecx, a_len
        loop_a:     ; loop through all the elements of a
            mov dh, 0
            mov ebx, a_len
            sub ebx, ecx
            mov dl, [a+ebx]
            test dl, dl
            js signed
                jmp fin
            signed:
                mov [r+eax], dl
                inc eax
            fin:
        loop loop_a
        final
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
