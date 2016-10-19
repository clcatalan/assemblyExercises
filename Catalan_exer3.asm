;Carlos Catalan 
;AB-2L 2012-37801

;----------------------------------------------------------------------------------------
; Ask the user for three 2-digit signed numbers. Sort and output them in ascending order.
;----------------------------------------------------------------------------------------



section .data

   prompt db 'Enter Number with sign: ', 10
   promptLen equ $-prompt

   negative db 'Negative: ', 10
   negativeLen equ $-negative

   positive db 'Positive: ', 10
   positiveLen equ $-positive
   
   newLine db 10
   newLineLen equ $-newLine   
section .bss
   

		sign1 resb 1
		first2 resb 1
		first1 resb 1
		first resb 1
		
		sign2 resb 1
		second2 resb 1
		second1 resb 1
		second resb 1
		
		sign3 resb 1
		third2 resb 1
		third1 resb 1
		third resb 1
	
	
	
section .text
   global _start
   
_start:





;-----------------------FIRST NUMBER----------------------- 

        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h
  
		mov eax, 3	; tens digits
		mov ebx, 0
		mov ecx, sign1
		mov edx, 1
		int 80h
		   
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, first2
		mov edx, 1
		int 80h
		
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, first1
		mov edx, 2
		int 80h
		
		;----------- combine the two
		
		mov al, [first2]        
		sub al, 30h
		mov bl, 10           
		mul bl               

		mov ah, 0
		mov [first], ax

		mov al, [first]
		mov bl, [first1]
		sub bl, 30h
		add al, bl
		mov [first], al

	;---------check if input was correct-----  
	;   mov ax, [first]
	;   mov ah, 0 
	;   mov bl, 10
	;   div bl

		

	;   mov [first2], al
	;   mov [first1], ah
		
	;   add byte [first2], 30h
	;   mov eax, 4	
	;   mov ebx, 1
	;   mov ecx, first2
	;   mov edx, 1
	;   int 80h

	;   add byte [first1], 30h
	;   mov eax, 4	
	;   mov ebx, 1
	;   mov ecx, first1
	;   mov edx, 1
	;   int 80h
	;-----------------------------


;---------------------------------------------------------- 


;--------------------------SECOND NUMBER-------------------

        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h
  
		mov eax, 3	; tens digits
		mov ebx, 0
		mov ecx, sign2
		mov edx, 1
		int 80h
		   
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, second2
		mov edx, 1
		int 80h
		
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, second1
		mov edx, 2
		int 80h

		;----------- combine the two
		
		mov al, [second2]        
		sub al, 30h
		mov bl, 10           
		mul bl               

		mov ah, 0
		mov [second], ax

		mov al, [second]
		mov bl, [second1]
		sub bl, 30h
		add al, bl
		mov [second], al

	;---------check if input was correct-----  
	 ;  mov ax, [second]
	 ;  mov ah, 0 
	 ;  mov bl, 10
	 ;  div bl

		

	 ;  mov [second2], al
	 ;  mov [second1], ah
		
	 ;  add byte [second2], 30h
	 ;  mov eax, 4	
	 ;  mov ebx, 1
	 ;  mov ecx, second2
	 ;  mov edx, 1
	 ;  int 80h

	 ;  add byte [second1], 30h
	 ;  mov eax, 4	
	 ;  mov ebx, 1
	 ;  mov ecx, second1
	 ;  mov edx, 1
	 ;  int 80h
	;-----------------------------


;----------------------------------------------------------


;-----------------------THIRD NUMBER-----------------------

        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h
  
		mov eax, 3	; tens digits
		mov ebx, 0
		mov ecx, sign3
		mov edx, 1
		int 80h
		   
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, third2
		mov edx, 1
		int 80h
		
		mov eax, 3	; ones digits
		mov ebx, 0
		mov ecx, third1
		mov edx, 2
		int 80h

		;----------- combine the two
		
		mov al, [third2]        
		sub al, 30h
		mov bl, 10           
		mul bl               

		mov ah, 0
		mov [third], ax

		mov al, [third]
		mov bl, [third1]
		sub bl, 30h
		add al, bl
		mov [third], al

	;---------check if input was correct-----  
	;   mov ax, [third]
	;   mov ah, 0 
	;   mov bl, 10
	;   div bl

		

	;   mov [third2], al
	;   mov [third1], ah
		
	;   add byte [third2], 30h
	;   mov eax, 4	
	;   mov ebx, 1
	;   mov ecx, third2
	;   mov edx, 1
	;   int 80h

	;   add byte [third1], 30h
	;   mov eax, 4	
	;   mov ebx, 1
	;   mov ecx, third1
	;   mov edx, 1
	;   int 80h
	;-----------------------------



;----------------------------------------------------------


;-----------------check for negative numbers----------------

    cmp byte [sign1], '-'
    je negate_num1
    jne check_num2


    negate_num1:
    neg byte [first]


    check_num2:

    cmp byte [sign2], '-'
    je negate_num2
    jne check_num3

    negate_num2:
    neg byte [second]

    check_num3:
    
    cmp byte [sign3], '-'
    je negate_num3
    jne sort_numbers

    negate_num3:
    neg byte [third]

;--------------------------------------------------------

;---------------------sort numbers------------------------

sort_numbers:
    mov byte al, [first]
    mov byte bl, [second]
 
    cmp byte al, bl ;compare a and b
    jg a_greater_than_b  ; if a > b
    jl a_less_than_b  ; if a < b

        a_less_than_b:
            mov byte bl, [third]
            cmp byte al, bl ; compare a and c
            jg  print_c_a_b  ;if a > c
            jl  a_less_than_c ;if a < c

            
            a_less_than_c:
                mov byte al, [second]
                cmp byte al, bl ;compare b and c
                jg print_a_c_b   ;if b > c
                jl print_a_b_c   ;if b < c


        a_greater_than_b:

            mov byte al, [second]
            mov byte bl, [third]
            cmp al, bl
            jg print_c_b_a
            jl b_less_than_c

            b_less_than_c:
                mov byte al, [first]
                cmp al, bl  ;compare a and c
                jg  print_b_c_a
                jl  print_b_a_c
        

;------------------------------------------------------------

;-------------------------print in order---------------------

print_c_a_b:
    
    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h


    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h



    jmp exit
    
print_a_c_b:

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    jmp exit

print_a_b_c:

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    jmp exit

print_c_b_a:

    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h    

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h
    
    jmp exit

print_b_c_a:

    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h 

    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    jmp exit

print_b_a_c:
    
    ;---------second number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, second1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h 

    ;-------first number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, first1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    ;------third number

    mov eax, 4
    mov ebx, 1
    mov ecx, sign3
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, third1
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h

    jmp exit


exit:

   mov eax, 1
   mov ebx, 0
   int 80h
