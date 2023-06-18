bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 2, 3, 4, 5, 6, 7, 8 ; man deklariert die Folge von Bytes
    len equ $ - s ; man berechnet die Lange der Zeichenfolge in len
    d times len db 0 ; man reserviert len Bytes fur den Folge und initialisierte ihn
    i db 1 ; index    
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len/2 ; wur setzen in ecx die Lange len/2, un die Schleife zu machen
        mov esi, 0 ; wir beginnen die Indexierung von 0
        mov edx, 0 ; einen Kontor
        jecxz Sfarsit
       Impar:
            mov al, [s + esi] ; wir setzen im al 1, 3, 5, 7 
            mov [d + edx], al ; wir setzen der Wert im [d + Kontor] eigentlich am die ersten 4 Positionen
            add esi, 2 ; wir addieren 2 damit wir nur die Unpaare Werte nehmen
            inc edx ; wir inkrementieren das Kontor
        loop Impar ; wiederholen
        Sfarsit: ; Ende der Schleife
        
        mov ecx, len/2 ; wir setzen im ecx Wert len/2
        mov esi, 1 ; wir beginnen die Indexierung von 1
        mov edx, len/2 ; einen Kontor
        jecxz Ende
        Par:
            mov al, [s +  esi] ; wir setzen im al 2, 4, 6, 8 
            mov [d + edx], al ; wir setzen der Wert im [d + Kontor] eigentlich am die letzten 4 Positionen
            add esi, 2 ; wir inkrementieren das Kontor
            inc edx ; wiederholen
        loop Par ; Ende der Schleife
        Ende:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
