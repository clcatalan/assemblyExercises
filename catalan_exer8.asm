;Carlos Catalan 
;AB-2L 2012-37801

;-------------------------------------------------------------------
;Create a program that implements "FLAMES, the Love Calculator."
;Ask for two names, having at most 30 characters each. Display the number of unmatched letters and the status. Create at least two subroutines.
;
;INPUT:
;> Name 1: Rommel Bulalacao
;> Name 2: Caroline Natalie Peralta
;OUTPUT:
;> Unmatched Letters: M M B U I N N T I P T
;> Number of Unmatched Letters: 11
;> Rommel Bulalacao and Caroline Natalie Peralta are engaged.
;--------------------------------------------------------------------
section .data

   prompt db 'Enter Name: ', 10
   promptLen equ $-prompt
   

	friends db 'Friends ', 10
	friendsLen equ $-friends

	lovers db 'Lovers ', 10
	loversLen equ $-lovers

	acquaintance db 'Acquaintances ', 10
	acquaintanceLen equ $-acquaintance

	married db 'Married ', 10
	marriedLen equ $-married

	engaged db 'Engaged ', 10
	engagedLen equ $-engaged

	separated db 'Separated ', 10
	separatedLen equ $-separated

   
   newLine db 10
   newLineLen equ $-newLine
   
        
  
section .bss
   
       name1 resb 30
       name2 resb 30
       temp resb 1
       size resb 1
	   i resb 1
	   j resb 1

	   char1 resb 1
	   char2 resb 1
	   diffCounter resb 1 ;number of unmatched characters
	   flame resb 1

       
section .text
   global _start
   
_start:


    call enter_names


    ;--------------check if input names are correct---------------
    ;mov byte [size], 30
    ;mov esi, name1

    ;check_name1:
    ;    cmp byte [size], 0
    ;    je next

    ;    cld     ;---move forward esi
    ;    lodsb   ;---mov al, [esi]


    ;    mov [temp], al
    ;    mov eax, 4
    ;    mov ebx, 1
    ;    mov ecx, temp
    ;    mov edx, 1
    ;    int 80h     

    ;    dec byte [size]
    ;    jmp check_name1

    
    ;next:
    ;mov eax, 4
    ;mov ebx, 1
    ;mov ecx, newLine
    ;mov edx, newLineLen
    ;int 80h

    
    ;mov byte [size], 30
    ;mov esi, name2

    ;check_name2:

    ;    cmp byte [size], 0
    ;    je exit

    ;    cld     ;---move forward esi
    ;    lodsb   ;---mov al, [esi]

    ;    mov [temp], al
    ;    mov eax, 4
    ;    mov ebx, 1
    ;    mov ecx, temp
    ;    mov edx, 1
    ;    int 80h
        

    ;    dec byte [size]
    ;    jmp check_name2
    ;-------------------------------------------------------------  

	mov byte [diffCounter], 0

	;------------------compare string1 to string2-----------------
    mov byte [i], 0
	mov esi, name1    

    outer_loop:
		
		cmp byte [i], 30
		je cmp_str2_str1

		cld
		lodsb
		mov byte [j], 0		
		mov edi, name2


		inner_loop:

		cmp byte [j], 30
		je unmatched_character

		scasb
		je end_of_outer_loop

		inc byte [j]
		jmp inner_loop
		


	unmatched_character:

	mov [temp], al
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h

	inc byte [diffCounter]

	end_of_outer_loop:
	inc byte [i]
    jmp outer_loop
	;------------------end of compare string 1 and 2------------------


	;-------------------compare string2 and string1--------------------
	cmp_str2_str1:

    mov byte [i], 0
	mov esi, name2    

    outer_loop2:
		
		cmp byte [i], 30
		je determine_flames

		cld
		lodsb
		mov byte [j], 0		
		mov edi, name1


		inner_loop2:

		cmp byte [j], 30	;if you've reached the end of the second string, character does not exist in the second steing
		je unmatched_character2

		scasb
		je end_of_outer_loop2 ;if a character is found in the second string, break the loop

		inc byte [j]
		jmp inner_loop2
		


	unmatched_character2:
	;print the unmatched character and increment diffCounter
	mov [temp], al
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h

	inc byte [diffCounter]

	end_of_outer_loop2:
	inc byte [i]
    jmp outer_loop2


	;------------end of compare string2 and string1--------------------

	determine_flames:
	;modulo operation of the diffCounter to 6 to determine status
	mov ah, 0
	mov al, [diffCounter]
	mov byte bl, 6
	div bl

	mov byte [flame], ah
	
	mov eax, 4
	mov ebx, 1
	mov ecx, newLine
	mov edx, newLineLen
	int 80h


	add byte [diffCounter], 30h
	mov eax, 4
	mov ebx, 1
	mov ecx, diffCounter
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newLine
	mov edx, newLineLen
	int 80h


	call print_flame
	

    exit:


    mov eax, 1
    mov ebx, 0
    int 80h

;------------------------------subroutines------------------
    enter_names:

        mov eax, 4
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, name1
        mov edx, 31
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, name2
        mov edx, 31
        int 80h

        ret


	print_flame:

		mov al, [flame]

		cmp byte al, 1
		je print_friends

		cmp byte al, 2
		je print_lovers

		cmp byte al, 3
		je print_acquaintances

		cmp byte al, 4
		je print_married

		cmp byte al, 5
		je print_engaged

		cmp byte al, 6
		je print_separated


		print_friends:

		mov eax, 4
		mov ebx, 1
		mov ecx, friends
		mov edx, friendsLen
		int 80h
		jmp exit_flames

		print_lovers:

		mov eax, 4
		mov ebx, 1
		mov ecx, lovers
		mov edx, loversLen
		int 80h
		jmp exit_flames

		print_acquaintances:

		mov eax, 4
		mov ebx, 1
		mov ecx, acquaintance
		mov edx, acquaintanceLen
		int 80h
		jmp exit_flames

		print_married:

		mov eax, 4
		mov ebx, 1
		mov ecx, married
		mov edx, marriedLen
		int 80h
		jmp exit_flames

		print_engaged:

		mov eax, 4
		mov ebx, 1
		mov ecx, engaged
		mov edx, engagedLen
		int 80h
		jmp exit_flames

		print_separated:

		mov eax, 4
		mov ebx, 1
		mov ecx, separated
		mov edx, separatedLen
		int 80h
		jmp exit_flames


		exit_flames:
		ret 2






       
             

        
