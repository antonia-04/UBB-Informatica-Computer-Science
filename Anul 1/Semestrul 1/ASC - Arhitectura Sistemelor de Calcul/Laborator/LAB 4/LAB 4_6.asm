;Se da cuvantul A. Sa se obtina numarul intreg n reprezentat de bitii 0-2 ai lui A. Sa se obtina apoi in B cuvântul rezultat prin rotirea spre dreapta (fara carry) a lui A cu n pozitii. Sa se obtina dublucuvantul C:
    ;bitii 8-15 ai lui C sunt 0
    ;bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
    ;bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
    ;bitii 0-7 ai lui C sunt 1
    
bits 32

global  start

extern  exit 
import  exit msvcrt.dll 

segment  data use32 class=data 

    a dw 1101011101101011b
    b dw 0
    c dd 0 ; dublucuvantul C
    n resb 1

segment  code use32 class=code 
    start:
        
        ; obtinem numărul întreg n reprezentat de bitii 0-2 ai lui A
        mov  ax, [a]
        and  ax, 0000000000000111b ; izolăm bitii 0-2 ai lui A
        mov [n], ax  

        ; obținem în B cuvântul rezultat prin rotirea spre dreapta a lui A cu n poziții
        mov  bx, [a] ; bx = A
        mov cl, [n]
        ror  bx, cl; rotirea spre dreapta cu n poziții

        ; obținem dublucuvântul C conform cerințelor 
        mov  edx, [a] ; edx = A
        shl  edx, 9  ; deplasăm bitii 9-15 în pozițiile 16-22
        mov  [c+4], edx ; Salvăm rezultatul în partea superioară a lui C

        mov  edx, [b] ; edx = B
        shl  edx, 2 ; deplasăm bitii 2-9 în pozițiile 16-23
        or   [c+4], edx ; adăugăm rezultatul la partea superioară a lui C

        mov  edx, [a] ; edx = A
        shr  edx, 7  ; deplasăm bitii 7-14 în pozițiile 24-31
        or   [c], edx ; adăugăm rezultatul la partea inferioară a lui C

        or   dword [c], 0000000000000001b ; setăm bitii 0-7 ai lui C cu valoarea 1

        mov  eax, [c] ;eax = C
        
        push dword 0 
        call [exit] 