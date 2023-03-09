bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s dd 12345678h, 1a2b3c4dh, 4E98DC76h 
    len equ ($-s)/4
    ten db 10
    d db 0
    
; our code starts here
segment code use32 class=code
    start:
    ; A string of doublewords is given. Compute the string formed by the high bytes of the low words from the elements of the doubleword string and these bytes should be multiple of 10.
    ; 
	mov esi, s ; in eds:esi we will store the FAR address of the string "s"
	cld ; parse the string from left to right
	mov ecx, len ; we will parse the elements of the string in a loop with len iterations
    mov edx, 0 
    repeta:
        mov eax, 0
		lodsw ; in eax we will have the low word of the current doubleword from the string
		shr ax, 8 ; we shift right 8 positions so that we will have just the high bytes ot the low word
        mov bx, ax
        div byte[ten] ; we check if al is divisible to 10
        cmp ah, 0 ; if the remainder is not 0 we repeat the "repeta" loop, else we put in the memory the high bytes
        jnz notmultiple
        mov byte[d+edx], bl
        inc edx
		
        notmultiple:
        lodsw
	loop repeta ; if there ar still elements we repete the loop

           
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program

        