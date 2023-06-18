bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1231
    b db 143
    c resd 1

; our code starts here
segment code use32 class=code
    start:
        mov ebx ,0 ; wir berechnen das Ergebnis in ebx
        
        mov eax, 0 ; wir inizialisieren eax mit 0
        mov ax, [a] ; wir stellen dem Wert von a im ax
        cwde ; wir konvertieren ax im eax
        and eax, 000000000000000000000001111000000b ; wir isolieren die Bits 6 - 9 von A
        mov cl, 6  ; wir stellen dem Wert 6 im cl
        ror eax, cl ; wir rotieren 6 Positionen nach rechts
        or ebx, eax ; wir fugen die Bits in das Ergebnis ein
        
        or ebx, 00000000000000000000000000110000b ; wir zwingen den Wert der Bits 4 - 5 des Ergebnisses auf den Wert 1
        
        mov eax , 0 ; wir inizialisieren eax mit 0
        mov al, [b] ; wir stellen dem Wert von B im al
        and eax, 000000000000000000000000000000110b ; wir isolieren die Bits 1 - 2 von B
        mov cl, 5 ; wir stellen dem Wert 5 im cl
        rol eax, cl ; wir rotieren 5 Positionen nach links
        or ebx, eax ; wir fugen die Bits in das Ergebnis ein
        
        mov eax, 0 ; wir inizialisieren eax mit 0
        mov ax, [a] ; wir stellen dem Wert von a im ax
        cwde ; wir konvertieren ax im eax
        mov cl, 8 ; wir stellen dem Wert 8 im cl
        rol eax, cl ; wir rotieren 8 Positionen nach links
        or ebx, eax ; wir fugen die Bits in das Ergebnis ein
        
        mov eax, 0 ; wir inizialisieren eax mit 0
        mov al, [b] ; wir stellen dem Wert von B im al
        mov cl, 23 ; wir stellen dem Wert 23 im cl
        rol eax, cl ; wir rotieren 23 Positionen nach links
        or ebx, eax ; wir fugen die Bits in das Ergebnis ein
        
        mov [c], ebx ; wir fugen das Ergebnis im C 
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
