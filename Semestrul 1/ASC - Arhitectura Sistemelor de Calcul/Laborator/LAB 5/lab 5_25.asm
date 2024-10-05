bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    S1 db '+','4','2','a','8','4','X','5' ; definim sirul S1
    l equ $-S1 ; determinam lungimea sirului S1
    S2 db 'a','4','5'
    r equ $-S2 ; determinam lungimea sirului S2
    D times 20 db 0 ; D: '+', '2', '8', 'X'
    ap resb 1 ;nr aparitii
    cont resb 1

segment code use32 class=code
    start:
        mov ecx, l  ; punem in registrul contor dimensiunea primului sir
        mov esi, 0  ; indicele de la care incepem iterarea
        mov edi, 0  ; indicele din sirul destinatie (D)
        jecxz sf    ; tratam cazul in care ECX e 0
        
        loop_start:
        
            mov al,[S1 + esi]     ;punem in AL elementul curent 0
            mov byte[ap],0      ;initializam [ap] cu 0, intrucat ea va contoriza numarul de aparitii a lui AL in S2
            mov byte[cont],r    ;ne luam o variabila contor, intrucat ECX este ocupat, cu ea implementand o varianta proprie de loop 
            mov ebx,0           ;ebx contor in noul sir 
            strt:
                
                mov dl,[S2 + ebx] ;punem in DL elemntul curent
                
                cmp al, dl       ; verificam egalitatea cu DL
                jne et
                inc byte [ap]    ; daca cele doua sunt egale, incrementam variabila ce retine numarul de aparitii
                
                et:
                
                inc ebx        ;incrementam variabila contor pentru sirul S2
                dec byte [cont]  ;decrementam contorul loop-ului
                cmp byte [cont],0 ;comparam contorul loop-ului cu 0 pentru a vedea daca mai avem de executat pasi
            jne strt
            
            cmp byte[ap],0      ;comparam numarul de aparitii cu 0 pentru a vedea daca exista caracterul cautat in S2
            jne eth
            mov [D + edi], al     ;in cazul in care nu exista punem caracterul in noul sir, cel destinatie, adica D
            inc edi             ;incrementam registrul index pentru sirul D
            eth:
            inc esi            ;incrementam registrul index pentru sirul S1
            
        loop loop_start
        sf:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
