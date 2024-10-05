bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    ; c-b-(a+a)-b
    a db 10
    b dw 50
    c dd 1000
segment code use32 class=code
    start:
        mov al, [a]
        add al, [a]
        
        cbw 
        
        mov bx, ax ; bx = a+a
        
        mov ax, [b]
        cwde ; b va fi dword in eax
        
        mov ecx, [c]
        
        sub ecx, eax ; ecx = c-b
        
        mov ax, bx
        cwde ; a+a este in eax
        
        sub ecx, eax
        
        mov ax, [b]
        cwde ; b va fi dword in eax
        
        sub ecx, eax
        
        mov eax, ecx
        
        push    dword 0     
        call    [exit]      
