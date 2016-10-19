;Carlos Catalan 
;AB-2L 2012-37801

;-----------------------------------------------------------------------
;Create a program that sorts and outputs four 2-digit unsigned numbers in ascending order. Create four subroutines:
;(1) input - Gets 2 digits of input and combines them to a 2-digit number
;(2) sort - Sorts four numbers
;(3) swap - Swaps two numbers
;(4) print - Splits, converts and prints four 2-digit numbers
;NOTE: You cannot use memory variables inside subroutines

;INPUT:
;> Number 1: 14
;> Number 2: 13
;> Number 3: 12
;> Number 4: 11
;OUTPUT:
;> Sorted numbers: 11 12 13 14
;-------------------------------------------------------------------------
section .data

   prompt db 'Enter Number: ', 10
   promptLen equ $-prompt
   
   newLine db 10
   newLineLen equ $-newLine
   
   symbol db '*'
   symbolLen equ $-symbol
        

  
section .bss
   
        flush resw 1
        tens resb 1
        ones resb 1

        num1 resw 1
        num2 resw 1
        num3 resw 1
        num4 resw 1
		temp resw 1
		i resb 1
		j resb 1
section .text
   global _start
   
_start:
       
             
        call enter_input




        push word num4
        push word num3
        push word num2
        push word num1



        call sort_numbers


	    ;------------num1---------------
        pop word [num1]
        mov eax, 0
        mov ax, [num1]
        mov bl, 10
        div bl

        mov [ones], ah
        mov [tens], al

        add byte [tens], 30h
        add byte [ones], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, tens
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, ones
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        ;------------num2---------------
		pop word [num2]
        mov eax, 0
        mov ax, [num2]
        mov bl, 10
        div bl

        mov [ones], ah
        mov [tens], al

        add byte [tens], 30h
        add byte [ones], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, tens
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, ones
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        ;------------num3---------------
		pop word [num3]
        mov eax, 0
        mov al, [num3]
        mov bl, 10
        div bl

        mov [ones], ah
        mov [tens], al

        add byte [tens], 30h
        add byte [ones], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, tens
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, ones
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        ;------------num4---------------
		pop word [num4]
        mov eax, 0
        mov al, [num4]
        mov bl, 10
        div bl

        mov [ones], ah
        mov [tens], al

        add byte [tens], 30h
        add byte [ones], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, tens
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, ones
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h
		



	


        mov eax, 1
        mov ebx, 0
        int 80h


enter_input:

        mov ebp, esp
          
        sub esp, 16
        ;-----------------enter number 1----------------
        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h
        
        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-2] ;num1tens
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-4] ;num1ones
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		mov ecx, flush
		mov edx, 1
		int 80h


        ;-----------------enter 2nd number-------------
        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h


        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-6] ;num1tens
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-8] ;num1ones
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		mov ecx, flush
		mov edx, 1
		int 80h

        ;-----------------enter 3rd number-------------
        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h


        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-10] ;num1tens
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-12] ;num1ones
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		mov ecx, flush
		mov edx, 1
		int 80h

        ;-----------------enter 4th number-------------
        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h

        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-14] ;num1tens
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		lea ecx, [ebp-16] ;num1ones
		mov edx, 1
		int 80h

        mov eax, 3	
		mov ebx, 0
		mov ecx, flush
		mov edx, 1
		int 80h

        ;-----------combine the two numbers
        sub byte [ebp-2], 30h
        sub byte [ebp-4], 30h

        sub byte [ebp-6], 30h
        sub byte [ebp-8], 30h

        sub byte [ebp-10], 30h
        sub byte [ebp-12], 30h

        sub byte [ebp-14], 30h
        sub byte [ebp-16], 30h
        
        mov al, [ebp-2]
        mov bl, 10        
        mul bl
        mov bl, [ebp-4]
        add al, bl
        mov [ebp-2], al ;entire 1st input is now here

        mov ah, 0
        mov al, [ebp-6]
        mov bl, 10        
        mul bl
        mov bl, [ebp-8]
        add al, bl
        mov [ebp-4], al ;entire 2nd input is now here

        mov ah, 0
        mov al, [ebp-10]
        mov bl, 10        
        mul bl
        mov bl, [ebp-12]
        add al, bl
        mov [ebp-6], al ;entire 3rd input is now here


        mov ah, 0
        mov al, [ebp-14]
        mov bl, 10        
        mul bl
        mov bl, [ebp-16]
        add al, bl
        mov [ebp-8], al ;entire 4th input is now here

		mov eax, 0
        mov ax, [ebp-2]
        mov [num1], ax


		mov eax, 0
        mov ax, [ebp-4]
        mov [num2], ax


		mov eax, 0
        mov ax, [ebp-6]
        mov [num3], ax


		mov eax, 0
        mov ax, [ebp-8]
        mov [num4], ax

        add esp, 8

        
        
        ;------------------check if input is correct--------------

        ;--------num1----------
        ;mov ah, 0        
        ;mov al, [ebp-2]
        ;mov bl, 10
        ;div bl

        ;mov [ones], ah
        ;mov [tens], al

        ;add byte [tens], 30h
        ;add byte [ones], 30h
        ;mov eax, 4
        ;mov ebx, 1
        ;lea ecx, [tens]
        ;mov edx, 1
        ;int 80h

        ;mov eax, 4
        ;mov ebx, 1
        ;lea ecx, [ones]
        ;mov edx, 1
        ;int 80h

        ;mov eax, 4
        ;mov ebx, 1
        ;mov ecx, newLine
        ;mov edx, newLineLen
        ;int 80h
        ;-------------------end of check if input is correct--------


        add esp, 8
        ret


sort_numbers:
		mov ebp, esp


		mov byte [i], 0

		loop_begin:

			cmp byte [i], 8
			je exit

			mov al, [i]
			inc al
			inc al
			mov [j], al

			inner_loop:

				cmp byte [j], 8
				je end_of_loop_begin

				lea ax, [ebp+4+i]
				lea bx, [ebp+4+j]
			
				cmp ax, bx
				jg swap
				jle continue

				swap:

				mov [temp], ax
				mov [ebp+4+i], bx
				mov ax, [temp]
				mov [ebp+4+j], ax

				continue:
				inc byte [j]
				inc byte [j]
				jmp inner_loop
			

			end_of_loop_begin:

			inc byte [i]
			inc byte [i]
			jmp loop_begin


		exit:

		ret 

		



         

        
