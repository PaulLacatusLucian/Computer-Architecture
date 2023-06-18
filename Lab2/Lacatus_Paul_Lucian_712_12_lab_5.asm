bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 2181563141
    b resd 1

; our code starts here
segment code use32 class=code
    start:
    mov ebx, 0 ; wir berechnen das Ergebnis in ebx
    
    or ebx, 11110000000000000000000000000000b ; wir zwingen den Wert der Bits 28 - 31 des Ergebnisses auf den Wert 1
    
    mov ax, [a] ; wir stellen den Wert von A im ax
    cwde ; wir konvertieren ax im eax
    and eax, 00000000000000000000001100000000b ; wir isolieren die Bits 8 - 9 von A
    mov cl, 16 ; wir stellen den Wert 16 im cl
    rol eax, cl ; wir rotieren 16 Positionen nach links 
    or ebx , eax ; wir fugen die Bits in das Ergebnis ein
    
    mov cl, 2 ; wir stellen den Wert 2 im cl
    rol eax, cl ; wir rotieren 2 Positionen nach links 
    or ebx, eax ; wir fugen die Bits in das Ergebnis ein
    
    mov ax, [a] ; wir stellen den Wert von A im ax
    cwde ; wir konvertieren ax im eax
    not eax ; wir invertieren den Wert von A
    and eax, 00000000000000000000000000001111b ; wir isolieren die Bits 0 - 3 von A
    mov cl, 20 ; wir stellen den Wert 20 im cl
    rol eax, cl ; wir rotieren 20 Positionen nach links 
    or ebx, eax ; wir fugen die Bits in das Ergebnis ein
    
    mov eax, ebx ; wir stellen den Wert von ebx im eax
    and eax, 11111111111111110000000000000000b ; wir isolieren die Bits 16 - 31
    mov cl, 16 ; wir stellen den Wert 16 im cl
    ror eax, cl ; wir rotieren 16 Positionen nach rechts
    or ebx, eax ; wir fugen die Bits in das Ergebnis ein
    
    mov [b], ebx ; wir fugen das Ergebnis im B
    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
