;LABORATOR 2 TEMA
bits 32 ; assembling for the 32 bits architecture


global start        

extern exit               
import exit msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;2.14
    ; a DB 12  
    ; b DB 3
    ; c DB 5
    ; d DB 1
    
    ;3.14
    ; a DW 100
    ; b DW 12
    ; c DW 6
    ; d DW 2
    
    ;4.14
    ; a DB 10
    ; b DB 2
    ; c DB 5
    ; d DW 100
    
    ;5.14 a,b,c,d-byte, e,f,g,h-word
    ; a DB 10
    ; b DB 2
    ; c DB 4
    ; d DB 6
    ; e DW 100
    ; f DW 25
    ; g DW 12
    ; h DW 10    
    
    
    
    

; our code starts here
segment code use32 class=code
    start:
        ; EXERCITIILE 14, 29
        
        ;1.14
        ; mov ax, 0
        ; mov bl, 5
        ; mov al, -2
        ; imul bl ;imul - inmultire cu numar negativ                    - La tema asta era indicat sa folosesti mul, tocmai ca sa observi diferenta intre interpretarea cu semn si cea fara semn
        
        ;1.29
        ; mov ax, 14
        ; mov cl, 6
        ; div cl
        
        ;2.14 byte = AL (a+d-c)-(b+b)
        ; mov al, [a] ;prima paranteza in al
        ; add al, [d]
        ; sub al, [c]
        
        ; mov bl, [b]
        ; add bl, [b]
        
        ; sub al, bl
        
        ;2.29 byte = AL (b+c)+(a+b-d)
        ; mov al, [b]
        ; add al, [c]
        
        ; mov bl, [a]
        ; add bl, [b]
        ; sub bl, [d]
        
        ; add al, bl
         
        ;3.14 - word (c+d)+(a-b)+a //
        ; mov ax, [c]
        ; add ax, [d]
        
        ; mov bx, [a]
        ; sub bx, [b]
        
        ; add ax, bx
        ; add ax, [a]
        
        ;3.39 (d-a)+(b+b+c)
        ; mov ax, [d]
        ; sub ax, [a]
        
        ; mov bx, [b]
        ; add bx, [b]
        ; add bx, [c]
        ; mov dx, 0
        
        ; add dx, ax
        
        ;4.14 (d-b*c+b*2)/a
        ;a-
        ; mov bl, [b]
        ; add bl, [c] ; in bl = b*c          - Aici nu ai facut inmultire... si rezultatul ar merge oricum in AX
        
        ; mov ax, [b]
        ; imul ax, 2 ; in al = b*2           - AX se ia implicit, nu se specifica... scris asa iti da eroare de compilare
        
        ; mov ecx, [d]                       - d e word (16 biti), dar ECX are 32 de biti. Scriind instructiunea asa, se va prelua automat dimensiunea lui ECX si se va lucra cu ea. Deci, din memorie se vor lua 32 de biti incepand cu adresa "d", dar tu ai definit doar 16 biti. Prin urmare, restul de 16 biti nu sunt definiti si e posibil sa fie valori gresite (nu ai garantia ca e 0 acolo)
        ; sub ecx, ebx                       - in EBX nu ai valori corecte...
        ; add ecx, eax ;paranteza
        
        ; mov ax, [a]                        - a e byte, patesti la fel ca la linia 109 (se pun in AX un octet de la a, unul de la b). Trebuia sa folosesti un registru de 8 biti (ex AL)
        ; div ecx                            - div-ul asta imparte combinatia EDX:EAX la ECX
        
        ;4.29 [d-(a+b)*2]/c
        ; mov eax, 0
        ; mov al, [a]    
        ; add al, [b]    ; al - (a+b)
        
        
        ; mov bl, 2
        ; imul bl ; rezultat in ax
       
        ; mov bx, ax
        ; mov eax, 0
        ; mov ax, bx
        
        ; mov edx, [d]                       - Aceeasi problema ca la linia 109... d putea fi pus in DX si atunci nu te mai chinuiai nici sa umplii cu 0 in EAX
        ; sub edx, eax ;paranteza e in edx, eax liber
        
        ; mov eax, edx
        ; mov edx, 0
        
        ; mov ecx, 0
        ; mov cl, [c]
        
        ; div ecx ;se va imparti mereu edx:eax deci mutam in registrii aia
        ; ;cat in eax, rest in edx
        
        ;5.14 a*d*e/(f-5)     a,b,c,d-byte, e,f,g,h-word
        ; mov edx, 0
        ; mov eax, 0 ; ca sa fie libere pt imp.
        
        ; mov ebx, 0
        ; mov bx, f
        ; sub bx, 5 ; f-5
        
        ; mov al, [a]
        ; mov cl, [d]
        ; mul cl ; rezultat in ax
        
        ; mov cx, [e]
        ; mul cx ; rezultat in dx:ax -> s-a efectuat a*d*e  
        
        ; div ebx ; se imparte registrii edx:eax la ebx           - Nu e nevoie sa imparti la EBX, era suficient div BX si impartea exact DX:AX (unde ai rezultatul inmultirilor)
        
        ;5.29 [b*c-(e+f)]/(a+d)       a,b,c,d-byte, e,f,g,h-word
        ; mov eax, 0 ;paranteza va fi in eax
        ; mov al, [b]
        ; ;!!!!INMULTIM REGISTRII NU [] ->bx liber, bx il va contine pe c
        ; mov bl, [c]
        ; mul bl ; rezultat in ax
        
        ; ;e+f in bx
        ; mov bx, [e]
        ; add bx, [f]
        
        ; sub ax, bx ; paranteza []
        ; ;ax/cx?
        
        ; ;impartitorul (a+d) in cx
        ; mov cx, [a]                 - a e byte, trebuia pus intr-un registru de 8 biti (ex AL), aceeasi problema ca la linia 109...
        ; add cx, [d]              
        
        ; div cx             - Se imparte DX:AX la CX. Nu se stie ce valori ai in DX, deci rezultatul poate fi gresit. Un div CL ar fi rezolvat (impartea pe AX la CL)
        
        
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
