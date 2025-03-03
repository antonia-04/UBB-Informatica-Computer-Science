bits 32 

global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
    ;d+c-b+(a-c)
    a db 15
    b dw 25
    c dd 10
    d dq 50
    
segment code use32 class=code
    start:
        ;d+c-b+(a-c)
        ;c+d 
        mov eax, [d] 
        mov edx, [d+4]
        
        mov ecx, [c] 
        
        add eax, ecx
        adc edx, 0  ;edx:eax = d+c
        
        push edx
        push eax
        
        ;a-c
        ;transformam byte a in dword
        mov al, [a]
        mov ah, 0   ;ax = a
        
        mov dx, 0
        
        push dx
        push ax
        pop eax
        
        sub eax, [c]
        mov ecx, eax ;ecx = a-c
        
        ; il facem pe b din word in dword
        
        mov ax, [b]
        mov dx, 0
        
        push dx
        push ax
        pop ebx ; b in ebx

        pop eax
        pop edx
        
        sub eax, ebx
        sbb edx, 0
        
        add eax, ecx
        adc edx, 0
        
        
        
        
        
        
        
        
        push    dword 0      
        call    [exit]   
