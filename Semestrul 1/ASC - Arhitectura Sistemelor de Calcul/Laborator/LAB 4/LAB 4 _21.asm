;Se dau cuvintele A si B. Se cere dublucuvantul C:
    ;bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
    ;bitii 4-10 ai lui C sunt invers fata de bitii 0-6 ai lui B
    ;bitii 11-18 ai lui C sunt 1
    ;bitii 19-31 ai lui C coincid cu bitii 3-15 ai lui B

bits 32

global start
extern exit
import exit msvcrt.dll

section data use32 class=data
    A dw 0111011101010111b
    B dw 1001101110111110b
    C dd 0                

section code use32 class=code
start:
    xor eax, eax
    ; izolare biti 5-8 ai lui B si copierea lor in bitii 0-3 ai lui C
    mov ax, [B]
    and ax, 0000000011100000b ; bitii 5-8
    mov cl, 5 ; 0000000000000111b
    shr ax, cl                ; shift la dr pt a aduce bitii în poziția 0-3
    cwde
    or dword [C], eax          ; adăugare la C

    ; inversarea bitilor 0-6 ai lui B și copierea lor în bitii 4-10 ai lui C
    mov ax, [B]
    not ax                     ; inversare biti
    and ax, 0000000001111111b ; izolare bitii 0-6
    mov cl, 4 
    shl ax, cl                ; shift la st pt a aduce bitii în poziția 4-10
    cwde
    or dword [C], eax          ; adaugam la C

    ; bitii 11-18 ai lui C vor fi valoarea 1
    or dword [C], 00000000000001111111100000000000b 

    ; izolare biti 3-15 ai lui B și copierea lor în bitii 19-31 ai lui C
    mov ax, [B]
    and ax, 1111111111111000b ; izolare biti 3-15
    mov cl, 3
    shr ax, cl ; shift la dr pentru a aduce bitii în poziția 19-31
    mov [C+4], ax    

    mov ebx, [C] ; EBX = C


    push dword 0
    call [exit]
