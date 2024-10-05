bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "input4.txt", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    
    dimensiune dd 1
    count dd 100
    
    sir resb 100
    lungime_sir dd 0
    nr_cifre dw 0
    
    format_afisare db "%d", 0
    

; our code starts here
segment code use32 class=code
    start:
    ;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de cifre impare si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.

        ; FILE * fopen(const char* nume_fisier, const char * mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final    ; Nu s-a putut deschide fisierul
        
        ; Salvam descriptorul pentru a-l utiliza mai tarziu
        mov [descriptor_fisier], eax
        
        ; Din acest punct avem acces la continutul fisierului, putem efectua operatii
        
        ; int fread(void * str, int size, int count, FILE * stream)
        push dword [descriptor_fisier]
        push dword [count]
        push dword [dimensiune]
        push dword sir
        call [fread]
        add esp, 4 * 4
        
        ; Zona de memorie 'text' a fost populata cu continutul fisierului
        ; Contorizarea numarului de cifre impare
        
        mov [lungime_sir], eax
        
        mov esi, sir
        mov ecx, [lungime_sir]
        cld
        jecxz finalBucla
        
        LOOP1:
            lodsb  
            sub AL, '0'
            
            test AL, 1 ;verifica daca e impara
            jz salt    ; daca nu e impara sare la urmatoarea cifra
            
            ;incrementeaza contorul
            inc word [nr_cifre]

            salt:
            loop LOOP1
        
        finalBucla:
        
        
        mov EAX, 0
        mov AL, [nr_cifre]
        
        push EAX
        push dword format_afisare
        call [printf]
        add esp, 4*2
        
        ; int fclose(FILE * descriptor)
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
        
        final:
        ; exit(0)
        push    dword 0      
        call    [exit]       
        
        
        
        
        