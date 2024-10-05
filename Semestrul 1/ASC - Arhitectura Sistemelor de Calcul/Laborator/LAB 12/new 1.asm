bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf,fopen,fread,fopen,fclose          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fread msvcrt.dll
segment data use32 class=data
    nume_fisier dd 0
    format_citire_fisier db "%s",0

    

; our code starts here
segment code use32 class=code
    start:
    
    ;scanf(nume,format)
    push dword nume_fisier
    push dword format_citire_fisier
    call [scanf]
    add esp,4*2
    
    ;printf(format,valoare)
    push dword nume_fisier
    push dword format_citire_fisier
    call[printf]
    add esp,4*2

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the progra