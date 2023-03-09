bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "lab08.txt", 0   ; filename to be created
    access_mode db "w", 0       ; file access mode:
                                ; w - creates an empty file for writing
    file_descriptor dd -1       ; variable to hold the file descriptor
    text db "Ana are 10 mere, 15 portocale, 21, 323."
    len equ $-text
    res resb len


; our code starts here
segment code use32 class=code
    start:
        ; A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all digits from the text with character 'C'. Create a file with the given name and write the generated text to file.
        ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2 ; clean-up the stack

        mov [file_descriptor], eax ; store the file descriptor returned by fopen
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final
        mov esi, text
        mov edi, res
        mov ecx, len
        jecxz fin
        my_loop:
        mov al, [esi]
        cmp al, '0'
        jb skip
        cmp al, '9'
        ja skip
        
        mov al, 'C'
        ;push 'C'
        
        skip:
        mov [edi], al
        
        inc esi
        inc edi
    loop my_loop
    fin:
        ; write the text to file using fprintf()
        ; fprintf(file_descriptor, text)
        push dword text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2

        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

      final:

        ; exit(0)
        push dword 0      
        call [exit]