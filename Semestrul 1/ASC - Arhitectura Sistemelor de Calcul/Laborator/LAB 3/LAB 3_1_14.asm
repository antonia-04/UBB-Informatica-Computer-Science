bits 32 ; assembling for the 32 bits architecture

global start        

extern exit               
import exit msvcrt.dll   
; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
    ;(a+d)-(c-b)+c
    a db 3 ;8 biti
    b dw 12 ;16 biti
    c dd 24 ;32 biti
    d dq 37 ;64 biti

segment code use32 class=code
    start:
        mov al, [a]
        mov ah, 0 ;convertirea byte in word in AX - a, a trebuie sa ajunga in eax
        
        mov dx, 0
        
        push dx
        push ax
        pop eax ; a este pe eax
        
        add eax, [d] ; edx:eax = a+d
        adc edx, 0
        
        push edx
        push eax ; in stiva edx:eax = a+d
        
        ;conv word in dword
        mov ax, [b]
        mov dx, 0
        
        push dx
        push ax
        pop eax ; eax - b dword
        
        mov edx, 0
        
        ;c-b 
        mov edx, [c]
        sub edx, eax ; rezultat in edx
        
        pop eax ; eax = a+d
        
        ;(a+d)-(c-b)
        sub eax, edx
        
        ;(a+d)-(c-b)+c
        add eax, [c]
        
        push    dword 0      
        call    [exit]       
