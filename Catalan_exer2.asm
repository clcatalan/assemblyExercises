;Carlos Catalan 
;AB-2L 2012-37801


;----------------------------------------------------------------------------------------------
;Ask for the user's OT hour/s which should only be at most 30. Hours exceeding the maximum will not be accepted. Output the total wage of the user.
;BONUS: Repeatedly ask the user's OT hour/s if he/she gives an invalid input.
;
;INPUT:
;> OT hours (max of 30)
;OUTPUT:
;> Total wage for the month: wage + ( OT hours * OT Pay )
;
;* wage = 7000/mo and OT Pay = 70/hr
;----------------------------------------------------------------------------------------------


section .data

   prompt db 'Enter Overtime Hours: ', 10
   promptLen equ $-prompt
   
   newLine db 10
   newLineLen equ $-newLine   
section .bss
   


        ot2 resb 1
        ot1 resb 1
        
        temp4 resb 1
        temp3 resb 1
        temp2 resb 1
        temp1 resb 1
        
        
        ot resb 1
        otpay resw 1
        wage resw 1
        wage4 resb 1
        wage3 resb 1
        wage2 resb 1
        wage1 resb 1
        rem resw 1
	
	
	
section .text
   global _start
   
_start:


input_hours:
   mov eax, 4	
   mov ebx, 1
   mov ecx, prompt
   mov edx, promptLen
   int 80h
   
   mov eax, 3	; tens digits
   mov ebx, 0
   mov ecx, ot2
   mov edx, 1
   int 80h
      
   mov eax, 3	; ones digits
   mov ebx, 0
   mov ecx, ot1
   mov edx, 2
   int 80h
   
   ;----------- combine the two
   
   mov al, [ot2]        ;3
   sub al, 30h
   mov bl, 10           ;10
   mul bl               ;30

   mov ah, 0
   mov [ot], ax

   mov al, [ot]
   mov bl, [ot1]
   sub bl, 30h
   add al, bl
   mov [ot], al

;---------check if input was correct-----  
 ;  mov ax, [ot]
 ;  mov ah, 0 
 ;  mov bl, 10
 ;  div bl

   

 ;  mov [ot2], al
 ;  mov [ot1], ah
   
 ;  add byte [ot2], 30h
 ;  mov eax, 4	
 ;  mov ebx, 1
 ;  mov ecx, ot2
 ;  mov edx, 1
 ;  int 80h

 ;  add byte [ot1], 30h
 ;  mov eax, 4	
 ;  mov ebx, 1
 ;  mov ecx, ot1
 ;  mov edx, 1
 ;  int 80h
;-----------------------------

checking:
   mov al, [ot] 
   mov bl, 30 
   cmp al, bl ;compare the input to 30
   ja input_hours ;if it is greater, go back to the input, otherwise, continue to compute



compute:

   mov al, [ot]		;30
   mov bl, 70			;70
   mul bl				;70*30
   mov word [otpay], ax	;2100
   
   mov dx, 0
   mov ax, [otpay]		;2100
   
   
;---------check if overtime*70 was correct-----  
;   mov dx, 0
;   mov word [wage], ax	;2100
   
;   mov bx, 1000			;1000
;   div bx					;2100/1000
;   mov byte [wage4], al	;2
;   mov word [rem], dx	;100
   
;   add byte [wage4], 30h
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, wage4			;2
;   mov edx, 1
;   int 80h
   
   ;---------------
;   mov ax, [rem]			;100
;   mov bl, 100				;100
;   div bl					;100/100
   
   
;   mov byte [wage3], al	;1
;   mov [rem], ah			;00
   
;   add byte [wage3], 30h
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, wage3			;1
;   mov edx, 1
;   int 80h
   
   ;--------------
   
  ; mov ah, 0
;   mov al, [rem]			;00
;   mov bl, 10				;10
;   div bl					;00/10
   
   
;   mov byte [wage2], al	;0
;   mov [wage1], ah		;0
   
;   add byte [wage2], 30h
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, wage2			;0
;   mov edx, 1
;   int 80h
   
;   add byte [wage1], 30h
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, wage1			;0
;   mov edx, 1
;   int 80h
   

;   mov eax, 4
;   mov ebx, 1
;   mov ecx, newLine
;   mov edx, newLineLen
;   int 80h
   


;-----------------------------
   
   
;-----------compute full wage--------   
   
   
   mov ax, [otpay]
   mov bx, 7000			;7000
   
   add ax, bx				;2100 + 7000
   mov dx, 0
   mov word [wage], ax	;9100
   
   mov bx, 1000			;1000
   div bx					;9100/1000
   
   ;---------------
   
   mov byte [wage4], al	;9
   mov word [rem], dx	;100
   
   add byte [wage4], 30h
   mov eax, 4
   mov ebx, 1
   mov ecx, wage4			;9
   mov edx, 1
   int 80h
   
   ;---------------
   mov ax, [rem]			;100
   mov bl, 100				;100
   div bl					;100/100
   
   
   mov byte [wage3], al	;1
   mov [rem], ah			;00
   
   add byte [wage3], 30h
   mov eax, 4
   mov ebx, 1
   mov ecx, wage3			;1
   mov edx, 1
   int 80h
   
   ;--------------
   
   ;mov ah, 0
   mov al, [rem]			;00
   mov bl, 10				;10
   div bl					;00/10
   
   
   mov byte [wage2], al	;0
   mov [wage1], ah		;0
   
   add byte [wage2], 30h
   mov eax, 4
   mov ebx, 1
   mov ecx, wage2			;0
   mov edx, 1
   int 80h
   
   add byte [wage1], 30h
   mov eax, 4
   mov ebx, 1
   mov ecx, wage1			;0
   mov edx, 1
   int 80h
   
   mov eax, 4
   mov ebx, 1
   mov ecx, newLine
   mov edx, newLineLen
   int 80h
  



exit:
   mov eax, 1
   mov ebx, 0
   int 80h
