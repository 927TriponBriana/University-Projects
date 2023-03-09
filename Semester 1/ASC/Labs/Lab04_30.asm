bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1111100111110001b
    b dd 0
  
; our code starts here
segment code use32 class=code
    start:
        ;Given the word A,obtain the doubleword B as follows:
        ;the bits 0-3 of B are the same as the bits 1-4 of the result A XOR 0Ah
        ;the bits 4-11 of B are the same as the bits 7-14 of A
        ;the bits 12-19 of B have the value 0
        ;the bits 20-25 of B have the value 1
        ;the bits 26-31 of C are the same as the bits 3-8 of A complemented
        mov ebx, 0 ;compute the result in ebx
        mov eax, 0 
        mov eax, [a]
        xor eax, 0Ah ; ax = ax xor 0Ah = a xor 10= 1111100111110011b
        and eax, 0000000000011110b ; we isolate the sbits 1-4 of the result a XOR 0Ah
        shr eax, 1 ; we shift 1 position to the right
        or ebx, eax ; we put the bits into the result
        
        mov eax, 0
        mov eax, [a]
        and eax, 0111111110000000b ; we isolate the bits 7-14 of a
        shr eax, 3 ; we shift 3 positions to the right
        or ebx, eax ; we put the bits into the result
        
        and ebx, 11111111111100000000111111111111b ;we make the bits 12-19 of the result to have the value 0

        or ebx, 00000011111100000000000000000000b ;we force the value of bits 20-25 of the result to the value 1
        
        mov eax, 0
        mov edx, 0
        mov eax, [a]
        mov edx, 1111111111111111b
        sub edx, eax ; we compute the complementary of a
        mov eax, edx
        and eax, 0000000111111000b ; we isolate the bits 3-8 of a
        shl eax, 23 ; we shift 23 positions to the left
        or ebx, eax
        
        mov [b], ebx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
