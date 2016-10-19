;Carlos Catalan 
;AB-2L 2012-37801

;-------------------------------------------------------
;Create a program that implements Binary Search algorithm.
;Ask the user for 10 1-digit signed numbers (in ascending order) and store them in an array. Ask the user for a number and search for that number in the array using Binary Search algorithm. If found, output that the number is found, otherwise output that it's not found. Output the mid value every iteration
;Create two subroutines:
;(1) Binary Search algo
;(2) Print mid value
;-------------------------------------------------------



section .data

   prompt db 'Enter Number: ', 10
   promptLen equ $-prompt
   
   prompt2 db 'Enter Number to search: ', 10
   prompt2Len equ $-prompt2

   prompt3 db 'Number not found ', 10
   prompt3Len equ $-prompt3

   prompt4 db ' found ', 10
   prompt4Len equ $-prompt4   


   symbol db '* '
   symbolLen equ $-symbol

   positive db '+'
   positiveLen equ $-positive

   negative db '-'
   negativeLen equ $-negative
   
   newLine db 10
   newLineLen equ $-newLine
   
        
  
section .bss
   
       array resb 10
       num resb 1
       sign resb 1
       flush resb 1
       search resb 1
       mid resb 1

       temp resb 1
       val resb 1
       
section .text
   global _start
   
_start:

    mov esi, 0
   

    input_numbers:
        cmp esi, 10
        je enter_search_value     
        ;je check_array
        mov eax, 4
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptLen
        int 80h


        mov eax, 3
        mov ebx, 0
        mov ecx, sign
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, num
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 1
        mov ecx, flush
        mov edx, 1
        int 80h

        sub byte [num], 30h

        cmp byte [sign], '+'        
        je put_in_array


        neg byte [num]

        ;------------put negated or positive value in the array
        put_in_array:
        mov al, [num]
        mov [array+esi], al

        inc esi
        jmp input_numbers      

		;-------------------------------
		;--checks the inputs in the array
    	;check_array:
        ;mov esi, 0

        ;print_loop:
        ;cmp esi, 5
		;je enter_search_value

        ;cmp byte [array+esi], 0
        ;jl negate
        ;jge positive_no
        
        ;negate:        
        ;neg byte [array+esi]

        ;mov eax, 4
        ;mov ebx, 1
        ;mov ecx, negative
        ;mov edx, negativeLen
        ;int 80h

        ;jmp print


        ;positive_no:
        ;mov eax, 4
        ;mov ebx, 1
        ;mov ecx, positive
        ;mov edx, positiveLen
        ;int 80h
        ;jmp print
		
        ;print:
		;add byte [array+esi], 30h
		;mov eax, 4
		;mov ebx, 1
		;lea ecx, [array+esi]
		;mov edx, 1
		;int 80h


		
		;inc esi
		;jmp print_loop
		;--------------------------------



		
		;-----------enter search value--------
		enter_search_value:

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h


		mov eax, 4
		mov ebx, 1
		mov ecx, prompt2
		mov edx, prompt2Len
		int 80h
		
		mov eax, 3
		mov ebx, 0
		mov ecx, sign
		mov edx, 1
		int 80h
		
		mov eax, 3
		mov ebx, 0
		mov ecx, search
		mov edx, 1
		int 80h
		
		mov eax, 3
		mov ebx, 0
		mov ecx, flush
		mov edx, 1
		int 80h
		
		;-----check if value is positive
        sub byte [search], 30h
		cmp byte [sign], '+'
				
		je search_number ;if it is proceed to binary search
		;-------------check search value------------        
		;je positive_search        

        neg byte [search]
		;mov eax, 4
		;mov ebx, 1
		;mov ecx, negative
		;mov edx, negativeLen
		;int 80h
		;neg byte [search]
		;jmp print_search

		;positive_search:

		;mov eax, 4
		;mov ebx, 1
		;mov ecx, positive
		;mov edx, positiveLen
		;int 80h


		;print_search:
		;add byte [search], 30h
		;mov eax, 4
		;mov ebx, 1
		;mov ecx, search
		;mov edx, 1
		;int 80h

		;mov eax, 4
		;mov ebx, 1
		;mov ecx, newLine
		;mov edx, newLineLen
		;int 80h
		

        search_number:

        push array
        call binarySearch

		end:
		mov eax, 1
		mov ebx, 0
		int 80h


        binarySearch:

        ;----------initialize first last and mid----------
        mov ebp, esp
        sub esp, 6

        mov byte [ebp-2], 0  ;---first = 0
        mov byte [ebp-4], 9  ;---last = 4

        mov al, [ebp-2]
        mov bl, [ebp-4]
        add al, bl
        mov bl, 2
        mov ah, 0
        div bl

        mov [ebp-6], al ;----mid = first+last/2
        
        
        mov al, [ebp-6]
        mov [temp], al

        mov edi, [ebp+4]
        add edi, [temp]

        mov al, [edi]   ;---al = array[mid]
		  mov [temp], al
		  
		  
		  cmp al, 0
		  jg pos_mid
		  

		  
		  neg_mid:
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, negative
		  mov edx, negativeLen
		  int 80h
		  
		  neg byte [temp]
		  jmp print_mid1

		  pos_mid:
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, positive
		  mov edx, positiveLen
		  int 80h
		  		  
		  
		  
		  print_mid1:
		  add byte [temp], 30h
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, temp
		  mov edx, 1
		  int 80h
		  
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, newLine
		  mov edx, newLineLen
		  int 80h
        ;-------------------------------------------------


        ;---------------------binary search loop-----------------

        loop_begin2:
        mov al, [ebp-2]
        mov bl, [ebp-4]
        cmp al, bl
        jg not_found
        


        mov al, [ebp-6]
        mov [temp], al

        mov edi, [ebp+4]
        add edi, [temp]

        mov al, [edi]   ;---al = array[mid]
        cmp al, [search]
        jl cond1_true
        jg cond3_true
        je cond2_true


        
        cond1_true:

        mov al, [ebp-6]
        inc al
        mov [ebp-2], al
        jmp end_of_loop_begin2

        cond3_true:

        mov al, [ebp-6]
        dec al
        mov [ebp-4], al
        jmp end_of_loop_begin2


        cond2_true:
        mov [temp], al

        cmp byte [temp], 0
        jg positive_mid

        mov eax, 4
        mov ebx, 1
        mov ecx, negative
        mov edx, negativeLen
        int 80h

        neg byte [temp]
		  jmp print_mid

        positive_mid:
        mov eax, 4
        mov ebx, 1
        mov ecx, positive
        mov edx, positiveLen
        int 80h

        print_mid:
        add byte [temp], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, temp
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        jmp exit


        end_of_loop_begin2:
        ;----------compute for new mid----------
        mov al, [ebp-2]
        mov bl, [ebp-4]
        add al, bl
        mov bl, 2
        mov ah, 0
        div bl

        mov [ebp-6], al
        
        mov al, [ebp-6]
        mov [temp], al

        mov edi, [ebp+4]
        add edi, [temp]

        mov al, [edi]   ;---al = array[mid]
		  mov [temp], al
		  
		  
		  cmp al, 0
		  jg pos_mid2
		  

		  
		  neg_mid2:
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, negative
		  mov edx, negativeLen
		  int 80h
		  
		  neg byte [temp]
		  jmp print_mid2

		  pos_mid2:
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, positive
		  mov edx, positiveLen
		  int 80h
		  		  
		  
		  
		  print_mid2:
		  add byte [temp], 30h
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, temp
		  mov edx, 1
		  int 80h
		  
		  mov eax, 4
		  mov ebx, 1
		  mov ecx, newLine
		  mov edx, newLineLen
		  int 80h
        
        
        jmp loop_begin2


        not_found:

        mov eax, 4
        mov ebx, 1
        mov ecx, prompt3
        mov edx, prompt3Len
        int 80h
        jmp exit



        
        exit:
        add esp, 6
        ret 2
    
       
             

        
