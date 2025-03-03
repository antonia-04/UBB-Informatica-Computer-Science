bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll

segment data use32 class=data
    a dw -9
    b dw 5
    format db "%d * %d = %d", 0

segment code use32 class=code
    start:
        ;4. Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
        
        mov ax, [a]
        mov dx, [b]
        imul dx   ;rezultat in dx:ax 
        
        push dx  ; punem cuvantul inferior (dX)
        push ax
        pop eax  ; rezultatul e in eax
        
        push eax ; rezultatul este in stiva acum
        
        ;convertim b in dword si il punem in stiva
        mov ax, [b]
        cwde 
        push eax ; b este in stiva acum
        
        ;convertim a in dword si il punem in stiva
        mov ax, [a]
        cwde 
        push eax ; a este in stiva acum
        
        push dword format
        call [printf]
        
        ; exit(0)
        push    dword 0      
        call    [exit]      
