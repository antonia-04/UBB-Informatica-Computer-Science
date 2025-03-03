bits 32 

global start        

extern exit               
import exit msvcrt.dll   

segment data use32 class=data
    ; a-byte; b-word; c-doubleword; x-qword
    a db 1
    b dw 5
    c dd 10
    x dq 125
segment code use32 class=code
    start:
        ;x+(2-a*b)/(a*3)-a+c 
        ;125 + (2-5)/3 - 1 + 10 = 125 - 1 - 1 + 10 = 133 
        mov al, [a]
        cbw 
        imul word [b] ; ax = a*b
        
        mov bx, 2
        sub bx, ax ; bx = (2-a*b)
        
     ;stiva 
        mov al, [a]
        cbw
        imul ax, 3 ; ax = a*3
        
        mov cx, ax ; cx = ax
        mov ax, bx ; ax = (2-a*b)
        mov bx, cx ; bx = a*3
        
        idiv bx
        
        cwde ; eax = (2-a*b)/(a*3)
        
        mov ebx, [x] 
        mov edx, [x+4]
        
        add ebx, eax
        adc edx, 0 ; edx:ebx = x+(2-a*b)/(a*3)
        
        mov al, [a]
        cbw
        cwde ;eax = a
        
        sub ebx, eax
        sbb edx, 0 ; edx:ebx = x+(2-a*b)/(a*3)-a
        
        mov eax, [c]
        
        add ebx, eax
        adc edx, 0 ; edx:ebx = x+(2-a*b)/(a*3)-a+c
        
        mov eax, ebx ; edx:eax = x+(2-a*b)/(a*3)-a+c
        
        push    dword 0      
        call    [exit]       
