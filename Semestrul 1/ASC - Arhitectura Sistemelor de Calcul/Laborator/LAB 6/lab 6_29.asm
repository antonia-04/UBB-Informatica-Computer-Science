;Se dau doua siruri de octeti. Sa se parcurga cel mai scurt sir dintre cele doua siruri si sa se construiasca un al treilea sir care va contine cel mai mare element de acelasi rang din cele doua siruri, iar pana la lungimea celui mai lung sir, sirul al treilea se va completa alternativ cu valoarea 1 respectiv 0.

bits 32

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    s1 db 2, 3, 9, 5, 6
    l1 equ $-s1
    s2 db 4, 5, 6, 4, 8, 9, 20
    l2 equ $-s2
    d times (l1+l2) db 0
    
segment code use32 class=code
    start:
        mov dl, l1
        cmp dl, l2
        
        ja  l1MaiMare       ;l1 > l2
        ;l1 < l2
        mov ecx, l1
        mov esi, s1
        mov edi, s2
        
        jmp dupa_comparatie
        
        l1MaiMare:
        ;l1 > l2
        mov ecx, l2
        mov esi, s2
        mov edi, s1
        
        dupa_comparatie:
        mov ebx, 0
        cld
        repeta:
            lodsb
            scasb
            ja maxim_in_al
                mov al, [edi - 1]
            
            maxim_in_al:
            
            mov [d + ebx], al
            inc ebx
        loop repeta
        
        push    dword 0      
        call    [exit]       
