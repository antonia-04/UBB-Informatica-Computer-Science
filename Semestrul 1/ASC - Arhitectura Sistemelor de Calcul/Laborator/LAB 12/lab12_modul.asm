bits 32

global _suma

;a+b-c
segment data use32 class = data

segment code use32 class=code
    _suma:
        ;creez noul cadru de stiva
        push ebp
        mov ebp,esp
        
        ;obtin valorile argumentelor de pe stiva
        mov eax, [ebp+8] ; a
        mov ebx,[ebp+12] ; b
        mov edx,[ebp+16] ; c
        
        add eax,ebx ; eax = a+b
        sub eax,edx ; eax = a+b-c
        
        ;refac cadrul de stiva
        mov esp,ebp
        pop ebp
        
        ret
        
        