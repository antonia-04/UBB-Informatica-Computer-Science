bits 32 

global start        

extern exit              
import exit msvcrt.dll    

segment data use32 class=data
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    l1 equ $ - s1;
    s2 db 'a', '4', '5'
    l2 equ $ - s2;
    d times l1 + l2 db 0; va fi max dim s1 + s2 '5', '4', 'a', '2','b', '6', '8'


segment code use32 class=code
    start:
        ;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor sirului S2 in ordine inversa cu elementele de pe pozitiile pare din sirul S1.
        
        mov ecx, l2
        mov esi, l2-1; esi ultima poz din s2
        mov ebx, 0; ebx contor de poz in s1
        
        jecxz endloop1
        repeat1: ; scadem poz in s2 cu 1 si adaugam in d elem din s2
            mov al, [s2 + esi]
            mov [d + ebx], al
            inc ebx
            dec esi
        loop repeat1       
        endloop1:

        mov ecx, l1/2; ecx = dim s1/2 pt ca avem nevoie doar de poz pare 
        mov esi, 1; esi = 1 pt ca indexarea este de la 0
        jecxz endLoop2
        repeat2:; scadem poz in s1 cu 2 si adaugam in D 
        
            mov al, [s1 + esi]
            mov [d + ebx], al
            add esi, 2
            inc ebx
        loop repeat2      
        endLoop2:
        
        push    dword 0     
        call    [exit]      