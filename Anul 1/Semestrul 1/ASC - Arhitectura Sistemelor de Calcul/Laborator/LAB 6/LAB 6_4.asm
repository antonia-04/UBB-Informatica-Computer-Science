bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s db 5, 25, 55, 127 ; 101, 11001, 110111, 1111111
    len equ $-s
    d times len db ; 2, 3, 5, 7
    
segment code use32 class=code
    start:
        ;4.Se da un sir de octeti s. Sa se construiasca sirul de octeti d, care contine pe fiecare pozitie numarul de biti 1 ai octetului de pe pozitia corespunzatoare din s.
        mov esi, s      ;DS:ESI = s
        mov edi, d      ;ES:EDI = d
        cld             ;parcurgem sirul de la stanga la dreapta (DF=0). 
        mov ecx, len    ;ecx = lungime s
        
        jecxz endFor    ;cand ecx este 0 se opreste loop-ul, adica lungimea este 0
        
        LOOP:
            lodsb
            mov ebx, 0            
            mov edx, 0       
            
            calcul:
                cmp al, 0 ;verif daca octetul este 0
                je sfarsit
                
                mov edx, eax       ; edx = octetul     
                shr al, 1          ; shift la dr ca sa verificam fiecare bit
                and edx, 1         ; verif cel mai mic bit a lui edx
                
                cmp edx, 0        
                jz calcul          ;daca este zero sarim la urmatoarea iteratie
                
                inc bl              ; daca este 1, incremantam contorul de biti
                jmp calcul ; se continua
            sfarsit:
            
            mov al, bl
            stosb                   ; rezultatul e in d[i]
        loop LOOP
        endFor:
        
        push dword 0
        call [exit]