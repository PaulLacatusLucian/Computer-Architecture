bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4
    b dd 3
    c dq 14

; our code starts here
segment code use32 class=code
    start:
    mov eax, 0 ; Ich habe alle 32 Bits Registern mit 0 initialisiert, da es schon andere Werte dort gespeichert waren 
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov al, [a] ; Wert 5 wird im al gespeichert
    mul al ; AX = AL * AL, AX = 5*5, AX = 25
    
    mov dx, 0 ; Umwandlung im EAX
    sub eax, [b] ; EAX = EAX - [B], EAX = 25 - 4, EAX = 21
    add eax, 7 ; EAX = EAX + 7, EAX = 21 + 7, EAX = 28
        
    mov bl, [a] ; BL = 5
    add bl, 2 ; BL = BL + 2, BL = 5 + 2; BL = 7
    mov bh, 0 ; Umwandlung im BX
    div bx ; EAX = EAX / BX, AX = EAX // BX, AX = 28/7, AX = 4, DX = EAX % BX, DX = 28 % 7, DX = 0
     
    mov dx, 0 ; Umwandlung im EAX
    mov edx, 0 ; Umwandlung im EDX:EAX
    mov ebx, [c+0] 
    mov ecx, [c+4]
    add eax,ebx ; EAX = EAX + EBX, EAX = 4 + 14, EAX = 18
    adc edx,ecx ; EDX = EDX + ECX, EDX = 0 + 0, EDX = 0
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
