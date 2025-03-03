; programul calculeaza factorialul unui numar si afiseaza in consola rezultatul
; procedura factorial este definita in segmentul de cod si primeste pe stiva ca si parametru un numar
bits 32
global start

extern printf, exit
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
	format_string db "factorial=%d", 10, 13, 0
    
segment code use32 class=code
; urmeaza definirea procedurii
factorial: 
    mov eax, 1
    mov ecx, [esp + 4] 
    ; mov ecx, [esp + 4] scoate de pe stiva parametrul procedurii
    ; ATENTIE!!! in capul stivei este adresa de retur
    ; parametrul procedurii este imediat dupa adresa de retur
    ; a se vedea desenul de mai jos
    ;
    ; stiva
    ;
    ;|--------------|
    ;| adresa retur |  <- [esp]
    ;|--------------|
    ;|  00000006h   |  <- parametrul pasat procedurii, [esp+4]
    ;|--------------|
    ; ....
                
	
    .repet: 
        mul ecx
    loop .repet ; atentie, cazul ecx = 0 nu e tratat!

    ret
       
; programul "principal"       
start:
	push dword 6        ; se salveaza pe stiva numarul (parametrul procedurii)
	call factorial      ; apel procedura

       ; afisare rezultat
	push eax
	push format_string
	call [printf]
	add esp, 4*2

	push 0
	call [exit]
