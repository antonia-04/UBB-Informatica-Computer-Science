bits 32 ; assembling for the 32 bits architecture

global start        

extern exit, fopen, fclose, fread           
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll


segment data use32 class=data
    nume_fisier db "input.txt", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    
    text resb 100  
    dimensiune dd 1
    count dd 100
    
    lungime_sir dd 0
    cifra_min db 10
    

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
    
        cmp eax, 0 ;daca nu se deschide corect atunci in eax e 0
        je final
        
        mov [descriptor_fisier], eax
        
        ;operatii - gasim cifra impara minima (asmenator cu ex 4)
        
        
        push dword [descriptor_fisier]
        push dword [count]
        push dword [dimensiune]
        push dword text
        
        call [fread]
        add esp, 4 * 4
        
        mov [lungime_sir], eax
        
        mov esi, text
        mov ecx, [lungime_sir]
        cld
        jecxz finalBucla
        
        bucla:
            lodsb
            sub al, '0'
            
            test al, 1
            jz salt
            
            cmp al, [cifra_min]
            ja salt
            
            
            
            
            loop bucla
        finalBucla
        
        
        ;inchidere fisier
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
        
        final:
        ; exit(0)
        push    dword 0     
        call    [exit]       ; call exit to terminate the program
