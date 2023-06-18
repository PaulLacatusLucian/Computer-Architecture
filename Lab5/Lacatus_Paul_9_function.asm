bits 32
global convert

extern min, file_name, file_descriptor, format_hexa, access_mode
extern fopen, fclose, fprintf             
import fclose msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll


segment code use32 class=code
    convert:
        ;wir ofnen die Datei
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final
        
        ;wir schreiben in der Datei
        push dword [min]
        push dword format_hexa
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        ;wir schliessen die Datei
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

    final:
    
    ret