bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "Aufgabe2.txt", 0   ; numele fisierului careva fi deschis
    mod_acces db "r", 0             ; modul de deschidere afisierului; r - pentru scriere. fisierul trebuie sa existe
    descriptor_fis dd -1            ; variabila in care vomsalva descriptorul fisierului - necesar pentru a putea facereferire la fisier
    len equ 100                     ; numarul maxim deelemente citite din fisier intr-o etapa
    buffer resb len                 ; sirul in care se va cititextul din fisier
    

; our code starts here
segment code use32 class=code
    start:
    
    mov dx, 0 ; nr de consoane citite
    ; apelam fopen pentru a deschide fisierul
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
    ; verificam daca functia fopen a creat cu succesfisierul
        cmp eax, 0
        je final
        
        mov [descriptor_fis], eax   ; salvam valoareareturnata de fopen in variabila descriptor_fis
        
        bucla:
            ; citim o parte (100 caractere) din textul infisierul deschis folosind functia fread
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0          ; daca numarul de caracterecitite este 0, am terminat de parcurs fisierul
            je cleanup
            

            mov ebx, -1
            repeta:
                inc ebx
                cmp ebx, eax
                je bucla
                mov al, 'a'
                cmp [buffer + ebx], al
                je repeta
                mov al, 'e'
                cmp [buffer + ebx], al
                je repeta
                mov al, 'i'
                cmp [buffer + ebx], al
                je repeta
                mov al, 'o'
                cmp [buffer + ebx], al
                je repeta
                mov al, 'u'
                cmp [buffer + ebx], al
                je repeta
                inc dx
                jmp repeta
            
            jmp bucla
        
        cleanup:
            push dword [descriptor_fis]
            call [fclose]
            add esp, 4
            
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
