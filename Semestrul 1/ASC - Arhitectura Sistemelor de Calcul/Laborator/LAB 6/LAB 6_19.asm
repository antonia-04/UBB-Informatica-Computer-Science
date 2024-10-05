bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a db 1, 4, 2, 5, 9, 4, 2, 4, 2, 5
    lena equ $-a
    b db 4, 2, 5
    lenb equ $-b
    sol times lena db 0

segment code use32 class=code
    start:
        ;19. Dandu-se doua siruri de octeti sa se calculeze toate pozitiile unde al doilea sir apare ca subsir in primul sir.
        mov ecx, lena  ;ECX = lungime a
        mov ebx, sol
        mov esi, a  ; DS:ESI = a
        mov edi, b  ; ES:EDI = b
        cld  ; parcurgem de la stânga la dreapta
        
        jecxz endLoop  ; dacă lungimea este zero, ieși din buclă
        
        LOOP1:  ; parcurgem șirul a
            verif: 
                cmpsb  ; compară valoarea curentă din a cu valoarea curentă din b
                dec esi 
                dec edi  
                jne lng  ; dacă nu sunt egale, săriti la eticheta lng
                inc edi  ; EDI++ dacă sunt egale
                je verif  ; continuăm verificarea pentru a verifica dacă apare subsirul
                
                lng:  ; verificăm dacă numărul de comparații este egal cu lungimea subsirului
                mov eax, edi  ; mutam EDI în EAX
                sub eax, b  ; scădem adresa de început a lui b din EAX
                
                cmp eax, lenb  ; comparăm indexul curent pentru b cu lungimea lui b
                jne endL  ; dacă nu sunt egale, mergem la eticheta endL
                
                mov eax, esi  ; mutăm ESI în EAX
                inc eax
                sub eax, a  ; scădem adresa de început a lui a din EAX
                sub eax, lenb  ; scădem lungimea lui b din EAX
                
                ; schimbăm conținutul dintre EBX și EDI
                mov edx, ebx
                mov ebx, edi
                mov edi, edx
                stosb  ; stocăm AL în d
                ; schimbăm înapoi conținutul dintre EBX și EDI
                mov edx, ebx
                mov ebx, edi
                mov edi, edx

                mov edi, b  ; dacă sunt egale, resetăm indexul curent al lui b
                
                endL:  ; sfârșitul verificării
                inc esi  
            loop LOOP1  ; continuăm bucla pentru fiecare octet din a
        endLoop:  ; sf parcurgerii
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program