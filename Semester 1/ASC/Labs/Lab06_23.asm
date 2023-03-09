bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s db 2, 4, 2, 5, 2, 2, 4, 4 ; => 0402h, 0304h, 0105h
    len equ $-s
    r resw len
    
; our code starts here
segment code use32 class=code
    start:
    ; Being given a string of bytes, build a string of words which contains in the low bytes of the words the set of distinct characters from the given string and in the high byte of a word it contains the number of occurrences of the low byte of the word in the given byte string.
        mov esi, s ; load the offset of the string s in esi
        mov edi, r ; load the offset of the string r in edi
        cld ; parse the string from left to right, DF=0
        mov ecx, len ; we parse the elements of the string in a loop with len iterations
        repeta:
            lodsb ; load the byte from the address <DS:ESI> into AL
            mov ebx, len
            sub ebx, ecx
            add ebx, 1
            push ecx
            mov ecx, len
            sub ecx, ebx
            mov bx, 1
            mov dl, al
            repeta2:
                
                lodsb 
                cmp dl, al
                jne notequal
                add bx, 1
                notequal:
            loop repeta2
            pop ecx
            mov ax, bx
            stosb 
            mov al, dl
            stosb
            
            ;resetez esi 
            mov ebx, len
            sub ebx, ecx
            add ebx, 1
            push ecx
            mov ecx, len
            sub ecx, ebx
            repeta3:
                dec(ESI)
            loop repeta3
            pop ecx
        loop repeta

        
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program

        