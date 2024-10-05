bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start 
extern suma       

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
   format db "%d",0
   a dd 0
   b dd 0
   c dd 0
   rezultat dd 0
   var1 dd 0
   var2 dd 0
   var3 dd 0

; Se cere se se citeasca numerele a, b si c ; sa se calculeze si sa se afiseze a+b-c.
segment code use32 class=code
    start:  
	
        push dword a
        push dword format
        call [scanf]
        add esp,4*2
        mov ebx,0
        mov ebx,[a]
        mov [var1],ebx
		
        push dword b
        push dword format
        call [scanf]
        add esp,4*2
        mov ecx,0
        mov ecx,[b]
        mov [var2],ecx
		
        ;add ebx,ecx
        ;call suma
		
		push dword c
        push dword format
        call [scanf]
        add esp,4*2
        mov ecx,0
        mov ecx,[c]
		mov [var3],ecx
        
        
        mov ebx,[var1]
        mov ecx,[var2]
        add ebx,ecx
        mov ecx, [var3]
        ;sub ebx,ecx ; ebx = a+b-c
		call suma 
		
        mov [rezultat],ebx
        
        push dword [rezultat]
        push dword format
        call [printf]
        add esp,4*2
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        