bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf, convert             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 

global min
global file_name
global file_descriptor
global format_hexa
global access_mode


   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "min.txt", 0
    access_mode db "w", 0 
    file_descriptor dd -1
    format_hexa db "%x", 0
    message db "Cate numere vreti sa cititi ?" , 0
    sir times 100 db 0
    n dd 0
    min dd 9999
    nr db 0
    format db "%d", 0

; our code starts here
segment code use32 class=code
    start:
           
        repeat:
            ; wir lesen Zahlen bis wir 0 treffen
            push dword n 
            push dword format
            call [scanf]
            add esp, 4*2
            
            cmp dword [n], 0
            je final
         
            ;wenn die Zahlen kleiner als min sind, dann min := zahl
            mov eax, [min]
            cmp eax, dword [n]
            jb repeat
            mov eax, [n]
            mov [min], eax
            jmp repeat
        
        ;nachdem wir null getroffen haben, rufen wir die Funktion
        final: 
            call convert
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program