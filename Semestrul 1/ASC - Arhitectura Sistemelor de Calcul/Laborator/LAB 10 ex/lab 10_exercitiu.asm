bits 32 

global start        

extern exit, scanf, fprintf, fopen, fclose             
import exit msvcrt.dll    
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
   
segment data use32 class=data
    a dd 0
    b dd 0
    format1 db '%d', 0x0A, 0
    format db '%d'
    
    nume_fisier db "AdivB.txt", 0
    mod_acces db "w", 0 ; w = scriere, se va crea fisierul daca el nu exista
    descriptor_fisier dd -1 ; variabila in care salvam descriptorul fisierului - pt referire la fisier
    

segment code use32 class=code
    start:
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fisier], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je eroare_deschidere
        
        push dword a
        push dword format
        call [scanf]
        add esp, 2 * 4
        
        push dword b
        push dword format
        call [scanf]
        add esp, 2 * 4
        
        mov ax, [a]
        mov bl, [b]
        
        div bl  ;cat = al, rest = ah
        
        ; mov bl, ah
        
        movzx ebx, ah ;convertim restul in dword
        
        ;convertim catul in dword
        cbw
        cwde
        
        ; cat = eax, rest = ebx
        
        ;afisam 
        
        ;scrierea in fisier fprintf(descriptor_fis,format, text)
        push ebx
        push eax
        push dword format1
        push dword [descriptor_fisier]
        call [fprintf]
        add esp, 4 * 4
        
        ; apelam fclose pentru inchiderea fisierului
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
        
        
        eroare_deschidere:
        push    dword 0      
        call    [exit]       
