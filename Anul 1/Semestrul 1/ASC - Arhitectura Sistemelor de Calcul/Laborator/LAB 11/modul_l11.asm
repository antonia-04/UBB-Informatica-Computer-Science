bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global suma       

; a + b = ebx+ecx
;(a+b)-c = ebx-ecx
segment code use32 public code
    suma:
        sub ebx,ecx 
		ret 
       
