bits 32 
global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    A db 2, 1, 3, 3, 4, 2, 6
    la equ $-A
    B db 4, 5, 7, 6, 2, 1
    lb equ $-B
    R times la+lb db 0
    
segment code use32 class=code
    start:
        ;Elementele din A multiplu de 3 in ordine inversa
        mov ecx, la
        mov esi, la
        dec esi
        mov edi, 0
        
        jecxz SfarsitA
        
        RepetaA:
            mov al, [A + esi]
            cbw
            mov bl, 3
            idiv bl
            
            cmp ah, 0
            
            jne nuMultiplu
            
            mov al, [A + esi]
            mov [R + edi], al
            inc edi
            
            nuMultiplu:
            
            dec esi
            
        loop RepetaA 
        
        SfarsitA: 
        
        ;Adaugam in ordine elementele din B
        
        mov ecx, lb
        mov esi, 0
        jecxz Sfarsit
        RepetaB:
            mov al, [B + esi]
            mov [R + edi], al
            inc edi
            inc esi

        Sfarsit:
            
        push    dword 0      
        call    [exit]       
