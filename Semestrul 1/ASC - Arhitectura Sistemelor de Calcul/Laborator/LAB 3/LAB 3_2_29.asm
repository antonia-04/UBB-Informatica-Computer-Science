bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    ;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    a db 100
    b dw 10
    c dd 15
    d dq 75

segment code use32 class=code
    start:
        ;(a+a)-(b+b)-(c+d)+(d+d) = 240
        mov al, [a]
        add al, [a]
        
        cbw ; converteste al in ax
        
        mov bx, [b]
        add bx, [b]
        
        sub ax, bx ; ax = (a+a)-(b+b)
        cwde ; ax devine in eax
        
        mov ebx, eax ; eax = (a+a)-(b+b)
        
        mov ebx, [c]
        cdq    ;!!!!! conversie cu semn dword in qword
        
        mov eax, [d] 
        mov edx, [d+4]
        
        add eax, ebx
        adc edx, ecx ;edx:eax = c+d
        
        mov ecx, 0 ; ecx:ebx = (a+a)-(b+b)
        
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx = (a+a)-(b+b)-(c+d)
        
        ;sunt libere edx:eax
        mov eax, [d] 
        mov edx, [d+4]
        
        add eax, [d] 
        adc edx, [d+4]
        
        add ebx, eax
        adc ecx, edx
        
        mov eax, ebx
        mov edx, ecx
        
        push    dword 0      
        call    [exit]       
