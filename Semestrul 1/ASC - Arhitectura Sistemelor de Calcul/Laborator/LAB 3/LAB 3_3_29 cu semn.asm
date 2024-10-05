bits 32 

global start        

extern exit               
import exit msvcrt.dll   

segment data use32 class=data
    ; a,b,c-byte; d-doubleword; x-qword
    a db 1
    b db 2
    c db 5
    d dd 11
    x dq -60
segment code use32 class=code
    start:
        ;(a+b)/(c-2)-d+2-x = 52
        mov al, [a]
        add al, [b]
        
        cbw ; ax = a+b
        
        mov bl, [c]
        sub bl, 2
        
        idiv bl ; ax = (a+b)/(c-2)
        cwde ; eax = (a+b)/(c-2)
        
        mov ebx, [d]
        
        sub eax, ebx
        add eax, 2  ; eax = ;(a+b)/(c-2)-d+2
        
        cdq
        
        sub eax, [x] 
        sbb edx, [x+4]
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
