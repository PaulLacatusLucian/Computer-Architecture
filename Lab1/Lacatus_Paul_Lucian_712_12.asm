bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
   a db 3
   b dw 8
   c db 2
   d dd 10
   x dq 123

segment code use32 class=code
    start:
    mov eax, 0 ; Ich habe alle 32 Bits Register mit 0 initialisiert, weil es dort schon Werte gespeichert waren 
    mov ebx, 0 
    mov ecx, 0
    mov edx, 0
    mov al, [a] ; Es wird das Wert 3 im AL gespeichert 
    cbw ; Konvertierung von Byte zu Wort
    mov bx, [b]; Es wird das Wert 8 im BX gespeichert 
    imul bx ; EAX = AX*BX , EAX = 3 * 8, EAX = 24
    add eax, 2 ; EAX = EAX + 2, EAX = 24 + 2, EAX = 26

    mov bl, [a] ; Es wird das Wert 3 im BL gespeichert 
    add bl, 7 ; BL = BL + 7, BL = 3 + 7, BL = 10
    sub bl, [c] ; BL = BL - C, BL = 10 - 2, BL = 8
    cbw ; Konvertierung von Byte zu Wort
    idiv bx ; AX = EAX // BX, AX = 3, DX = EAX % BX, DX = 2
    
    cwd ; Konvertierung von Wort zu Doublewort
    add eax, [d] ; EAX = EAX + D, EAX = 3 + 10, EAX = 13
    cdq ; Konvertierung von Doublewort zu Quadwort
    
    mov ebx, [x+0] ; EBX = [X+0]
    mov ecx, [x+4] ; ECX = [X+4]
    add eax,ebx ; EAX = EAX + EBX , EAX = 13 + 123, EAX = 136
    adc edx,ecx ; EDX = EDX + ECX , EDX = 0 + 0, EDX = 0 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
