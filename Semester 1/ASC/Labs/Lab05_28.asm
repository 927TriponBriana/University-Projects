bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    s1_len equ $-s1
    s2 db 'a', '4', '5'
    s2_len equ $-s2
    d resb s1_len + s2_len 
  
; our code starts here
segment code use32 class=code
    start:   
        ;Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on the positions multiple of 3 from S1 and the elements of S2 in reverse order.
        
        mov esi, 0
        mov ecx, s1_len
        jecxz final1
        loop_s1:
            
            mov eax, s1_len
            sub eax, ecx
            cmp eax, 0
            je not_multiple
            mov edx, 0
            mov bx, 3
            div bx
            cmp edx, 0
            je multiple
                jmp fin
            multiple:
                mov eax, s1_len
                sub eax, ecx
                mov dl, [s1+eax]
                mov [d+esi], dl
                inc esi
            fin:
            not_multiple:
        loop loop_s1
        final1:
        
        ;mov esi, 0
        ;inc esi
        mov edi, s2_len
        dec edi
        mov ecx, s2_len
        jecxz final
        loop_s2:         ; loop through all the elements of s2 in reverse order and put them in d
            mov dl, [s2+edi]
            mov [d+esi], dl 
            dec edi
            inc esi
        loop loop_s2
        final:
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
