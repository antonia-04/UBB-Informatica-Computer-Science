bits 32 


global start        

extern exit, fopen, fclose, fscanf, fprintf, fread           
import exit msvcrt.dll   
import fopen msvcrt.dll 
import fprint msvcrt.dll 


segment data use32 class=data
    nume_fisier dd "input.txt", 0
    
    descriptor dd -1
    mod_acces db "r", 0
    
    format dd "%s", 0
    format_caracter db "%c", 0
    format_numar dd "%d", 0


segment code use32 class=code
    start:
        ;fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        ;verificam daca s-a deschis 
        cmp eax, 0
        je eroare_deschidere
        
        ;fscanf(descriptor, format, sir)
        push dword sir
        push dword format
        push dword [descriptor]
        call [fscanf]
        add esp, 4 * 3
        
        ;fprintf(descriptor, format, sir)
        push dword sir
        push dword format
        push dword [descriptor]
        call [fprintf]
        add esp, 3 * 4
        
        ;fread(sir, 1, 100, descriptor)
        push dword [descriptor]
        push dword 100
        push dword 1
        push dword sir
        call [fread]
        add esp, 4 * 4
        
        ;fclose(descriptor)
        push dword [descriptor]
        call [close]
        add esp, 4
        
        eroare_deschidere:
    
        
        push    dword 0      
        call    [exit]       

