bits 32 ; assembling for the 32 bits architecture

global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               
import exit msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll 
import fprintf msvcrt.dll

segment data use32 class=data
    text dd '1234567abc12'
    len equ $-text
    suma dd '', 0 ; suma o sa fie stocata aici
    
    nume_fisier db "Suma.txt", 0
    mod_acces db "w", 0 ; w = scriere, se va crea fisierul daca el nu exista
    descriptor_fisier dd -1 ; variabila in care salvam descriptorul fisierului - pt referire la fisier
    
    format db "%d", 0
    
segment code use32 class=code
    start:
        ; Se dau in segmentul de date un nume de fisier si un text (poate contine orice tip de caracter). Sa se calculeze suma cifrelor din text. Sa se creeze un fisier cu numele dat si sa se scrie suma obtinuta in fisier.
        
        
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fisier], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je eroare_deschidere
        
        ;parcurgem text-ul
        mov eax, 0 ; suma va fi in eax pt ca trebuie pusa pe stiva (nu mai avem nevoie de descriptor in eax deci e liber eax)
        mov ecx, 0
        mov ecx, len ; ecx = lungime sir
        cld ; parcurgem de la stanga la dreapta
        mov esi, 0 ;esi = iteratorul
        
        jecxz Sfarsit ;loop-ul se termina cand ecx e zero
        ; ASCII pt cifre de la 48 la 57
        Loop1:
            cmp [text + esi], byte '0'
            jb nu_este_cifra ; daca rezultatul scaderii este sub 0 atunci nu e cifra si va sari
            
            cmp [text + esi], byte '9'
            ja nu_este_cifra ; daca rezultatul scaderii este peste 9 atunci nu este cifra
            
            ; se continua daca e cifra
            mov ebx, 0
            mov bl, [text + esi]
            sub bl, 48 ; converteste bl care este char in int
            add al, bl ; in al va fi suma
            nu_este_cifra:
            
            inc esi ;trecem la urmatoarea
            loop Loop1
            
        Sfarsit:
        mov [suma], eax ; mutam in suma 
        
        
        ;scrierea in fisier fprintf(descriptor_fis,format, text)
        push dword [suma]
        push dword format
        push dword [descriptor_fisier]
        call [fprintf]
        add esp, 4 * 3
        
        ; apelam fclose pentru inchiderea fisierului
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
        
        
        eroare_deschidere:
    
        ; exit(0)
        push    dword 0   
        call    [exit]       
