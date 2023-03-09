bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dq 0111011101010111100110111011111011001000111011001000111110111000b
    b dd 0
    n dw 0
    c db 0
segment  code use32 class=code ; code segment
start: 
    ; Given the quadword A, obtain the integer number N represented on the bits 35-37 of A. Then obtain the the doubleword B by rotating the low doubleword of A N positions to the right. Obtain the byte C as follows:
        ;the bits 0-3 of C are the same as the bits 8-11 of B
        ;the bits 4-7 of C are the same as the bits 16-19 of B
     mov ebx, 0
     mov eax, dword [a]
     mov edx, dword [a+4]
     and eax, 00000000000000000000000000111000b
     mov [n], eax
     
     ;mov ebx, dword [a+4]
     mov cl, [n]
     ror edx, cl ; we rotate the low part of a n positions to the right
     mov dword [b], edx ; we obtained the b doubleword
     
     mov eax, 0
     mov eax, dword [b]
     and eax, 00000000000000000000111100000000b ; we isolate bits 8-12 of b which will be bits 0-3 of c
     mov cl, 8
     shr eax, cl
     or ebx, eax ; we put the bits into the result
     
     mov eax, 0
     mov eax, dword [b]
     and eax, 00000000000011110000000000000000b ; we isolate bits 16-19 of b which will be bits 4-7 of c
     mov cl, 12
     shr eax, cl
     or ebx, eax
     
     mov [c], ebx ; we move the result from the register to the result variable
     
     
     
    
      
     

     push dword 0 ;saves on stack the parameter of the function exit
     call [exit] ;function exit is called in order to end the execution of the program	
