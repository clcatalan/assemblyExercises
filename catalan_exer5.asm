;Carlos Catalan 
;AB-2L 2012-37801

;------------------------------------------------------------------------------
;Create a program that prints all prime numbers from 1 to n, where n is a 2-digit number which will be asked from the user.
;Create three subroutines for:
;(1) getting the input
;(2) finding the prime numbers
;(3) printing number/s
;NOTE: You cannot use 'global' variables
;
;INPUT:
;> n: 20
;OUTPUT:
;> Prime numbers: 2  3   5   7   11  13  17  19
;--------------------------------------------------------------------------------


section .data

   prompt db 'Enter Number: ', 10
   promptLen equ $-prompt
   
   newLine db 10
   newLineLen equ $-newLine
   

        temp dw 0

  
section .bss
   
        flush resw 1


section .text
   global _start
   
_start:
       
             
        call enter_input

        mov eax, 1
        mov ebx, 0
        int 80h


enter_input:

        mov ebp, esp
          
        sub esp, 4

        mov eax, 4	
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h
        
        mov eax, 3	
	mov ebx, 0
	lea ecx, [ebp-2] ;tens
	mov edx, 1
	int 80h

        mov eax, 3	
	mov ebx, 0
	lea ecx, [ebp-4] ;ones
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
        
        mov al, [ebp-2]
        mov bl, 10        
        mul bl
        mov bl, [ebp-4]
        add al, bl

        mov [ebp-2], al ;entire input is now here
        
        ;------------------check if input is correct--------------
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
        ;-------------------end of check if input is correct--------


        call begin      ;actual computation for the prime numbers

        add esp, 4      ;returns to _start at the end of all the computations
        ret

        begin:

        mov ebp, esp
        sub esp, 4
        
        mov byte [ebp-2], 0     ;i is initialized to 0
        mov byte [ebp-4], 2     ;c is initialized to 2


        loop_begin:             ;------------while(i <= n){... }
       
        mov byte [ebp-4], 2
        mov al, [ebp-2]
        cmp byte al, [ebp+6]
        ja exit

        inner_loop:
        ;----------------------------------|
        ;for ( c = 2 ; c <= i ; c++ ){     |
        ;         if ( i%c == 0 )          |
        ;            break;                |
        ;      }                           |
        ;----------------------------------|

        mov al, [ebp-4] ;c is inside al
        cmp al, [ebp-2] ;compare c to i
        ja next_part

        mov ah, 0
        mov al, [ebp-2] ;--- i
        mov bl, [ebp-4] ;--- c
        div bl          ;--- i / c
        cmp byte ah, 0       ;is i%c = 0?
        je next_part         ;if it is, jump to the next part


        inc byte [ebp-4]        ;increment c
        jmp inner_loop          ;begin inner_loop again
        

        next_part:
        ;--------------------------------;
        ;       if ( c == i ){           ;
        ;        printf("%d\n",i);       ;
        ;                                ;
        ;       }                        ;
        ;--------------------------------;

        mov al, [ebp-2]
        cmp al, [ebp-4]
        jne end_of_loop_begin

        ;-------this prints the number if it is prime------
        
        ;----------print i (the prime number)
        


        call print_number
       

        ;--------------------------------------------------

        ;sub byte [ebp-2], 30h
        
        end_of_loop_begin:        
        inc byte [ebp-2]         ;------------- i++
        jmp loop_begin           ;repeat loop again

        exit:
        add esp, 4
        ret


        print_number:

        
        sub esp, 4

        mov ah, 0
        mov al, [ebp-2]
        mov bl, 10
        div bl

        mov [ebp-10], ah ;ones
        mov [ebp-12], al ;tens
        
   
        add byte [ebp-12], 30h
        mov eax, 4
        mov ebx, 1
        lea ecx, [ebp-12]
        mov edx, 1
        int 80h

        add byte [ebp-10], 30h
        mov eax, 4
        mov ebx, 1
        lea ecx, [ebp-10]
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        add esp, 4
        ret


