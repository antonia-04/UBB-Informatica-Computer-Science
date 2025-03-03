bits 32 

global start        

extern exit, scanf, printf  
import exit msvcrt.dll  
import scanf msvcrt.dll  
import printf msvcrt.dll

segment data use32 class=data
    nA dd 0
    nB dd 0 ;adresele din memorie
    a db 0 ;octetul
    b dw 0 ; cuvantul
    format db "%d", 0
    format1 db "%s", 0
    yes db 'DA'
    no db  'NU'

segment code use32 class=code
    start:
    ;Sa se citeasca de la tastatura un octet si un cuvant. Sa se afiseze pe ecran daca bitii octetului citit se regasesc consecutiv printre bitii cuvantului.
        push dword nA
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword nB
        push dword format
        call [scanf]
        add esp, 4*2
        
        ;de la adresa nA este a si de la adresa nB este b
        mov eax, 0
        mov al, [nA]
 
       
        mov ebx, 0
        mov bx, [nB]
     
        
        ; 1001 1010 1001 1010
        ; 1101 0100
        ; 0100 1101 0100 1101 = shift la dreapta
        
        ; comparam bitii 
        ; facem un loop care shifteaza la dreapta de 16 ori si verifica daca ultimii 8 biti din bx sunt identici cu cei din 
        mov dx, 16         ; Numărul de deplasări
        shift_loop:
            mov cl, 1
            shr bx, cl        ; Shift la dreapta cu 1 bit
            cmp al, bl        ; Compararea lui al cu cei 8 biți izolați din bx
            je sunt_identici  ; Bitii sunt identici, afisam yes
            jne not_equal     ; Dacă nu sunt egali, sărit la not_equal (eticheta pentru cazul în care nu sunt egali)
            
            not_equal:
                dec dx         ; Scădere la contor
                jnz shift_loop ; Continuare la următoarea iterație dacă nu s-au făcut încă 16 deplasări

            ; Biții nu se potrivesc, așa că afișăm un mesaj corespunzător
            push dword no
            push dword format1
            call [printf]
            add esp, 2 * 4
            jmp end_program
        
        sunt_identici:
            ; Biții s-au potrivit, deci afișăm un mesaj corespunzător
           push dword yes
           push dword format1
           call [printf]
           add esp, 2 * 4
           jmp end_program
           
        end_program:

        push    dword 0      
        call    [exit]      
