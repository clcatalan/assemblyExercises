;Carlos Catalan 
;AB-2L 2012-37801

;-------------------------------------------------------------
;Create a program that manages a medicine inventory.
;A medicine record contains:
;> Medicine Name (at most 20 characters)
;> Quantity (1-digit; zero quantity means deleted entry)
;> Price (2-digits)
;The medicine inventory has 3 features:
;> Add Medicine - asks for the data needed for the medicine record (max of 5 medicine records)
;> Buy Medicine - displays the list of the medicine records and lets the user choose the medicine and the number of items to buy
;> Replenish Medicine - displays the list of the medicine records and lets the user choose the medicine and replenishes it
;
;=======MENU=======
;[1] Add Medicine
;[2] Buy Medicine
;[3] Replenish Medicine
;[4] Exit
;===================
;Choice:
;--------------------------------------------------------------

section .data

   choice1 db '[1] Add Medicine', 10
   choice1Len equ $-choice1

   choice2 db '[2] Buy Medicine', 10
   choice2Len equ $-choice2

   choice3 db '[3] Replenish Medicine', 10
   choice3Len equ $-choice3

   choice4 db '[4] Exit', 10
   choice4Len equ $-choice4

   prompt db 'Enter Choice: ',
   promptLen equ $-prompt

   namePrompt db 'Enter Name: ',
   namePromptLen equ $-namePrompt

   qtyPrompt db 'Enter Quantity: ',
   qtyPromptLen equ $-qtyPrompt

   pricePrompt db 'Enter Price: ',
   pricePromptLen equ $-pricePrompt

   maxPrompt db 'Max number of records has been reached ', 10
   maxPromptLen equ $-maxPrompt

   notFound db 'Not Found! ', 10
   notFoundLen equ $-notFound

   found db 'Found! ', 10
   foundLen equ $-found
   

   msg db 'message ', 10
   msgLen equ $-msg

 
   newLine db 10
   newLineLen equ $-newLine

    medicine equ 24
    name equ 0
    nameLen equ 20
    qty equ 21
    price equ 22


        
  
section .bss
    flush resb 1
    choice resb 1
    mCount resb 1

    priceTens resb 1
    priceOnes resb 1
    temp resb 1
    i resb 1

    m resb medicine*5

    nameTemp resb 20
    nameFind resb 20
       
section .text
   global _start
   
_start:

    mov byte [choice], 0
    mov byte [mCount], 0

    print_menu:
         

    mov eax, 4
    mov ebx, 1
    mov ecx, choice1
    mov edx, choice1Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, choice2
    mov edx, choice2Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, choice3
    mov edx, choice3Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, choice4
    mov edx, choice4Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, choice
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, flush
    mov edx, 1
    int 80h

    sub byte [choice], 30h

    cmp byte [choice], 1
    je call_add_medicine

    cmp byte [choice], 2
    je call_buy_medicine

    cmp byte [choice], 3
    je call_replenish_medicine

    cmp byte [choice], 4
    je exit

    jmp print_menu


    ;------------------------------
    call_add_medicine:

    cmp byte [mCount], 5
    je max_reached

    
    call addMedicine
    inc byte [mCount]
    jmp print_menu

    max_reached:
    
    mov eax, 4
    mov ebx, 1
    mov ecx, maxPrompt
    mov edx, maxPromptLen
    int 80h
    
    jmp print_menu
    ;------------------------------

    call_buy_medicine:
    
    call buyMedicine
    jmp print_menu

    ;------------------------------

    call_replenish_medicine:

    call replenishMedicine
    jmp print_menu

    ;------------------------------

    exit:
    mov eax, 1
    mov ebx, 0
    int 80h

;------------------subroutines-------------------


    addMedicine:

        mov ebp, esp

        add byte [mCount], 30h
        
        mov eax, 4
        mov ebx, 1
        mov ecx, mCount
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h

        sub byte [mCount], 30h

        mov ah, 0
        mov al, medicine
        mov bl, [mCount]
        mul bl

		mov [i], al
        ;--------------check index of structure--------------
		;mov ah, 0
		;mov al, [temp]
		;mov bl, 10

		;div bl
		;mov [priceTens], al
		;mov [priceOnes], ah

		;add byte [priceTens], 30h
		;add byte [priceOnes], 30h

		;mov eax, 4
		;mov ebx, 1
		;mov ecx, priceTens
		;mov edx, 1
		;int 80h

		;mov eax, 4
		;mov ebx, 1
		;mov ecx, priceOnes
		;mov edx, 1
		;int 80h

		;mov eax, 4
		;mov ebx, 1
		;mov ecx, newLine
		;mov edx, newLineLen
		;int 80h
	    ;-----------------------------------------

        mov eax, 0
        mov al, [i]
		mov esi, eax

		mov eax, 4
		mov ebx, 1
		mov ecx, namePrompt
		mov edx, namePromptLen
		int 80h

		mov eax, 3
		mov ebx, 0
		lea ecx, [m+name+esi]
		mov edx, 21
		int 80h

    	dec eax
    	mov byte [m+nameLen+esi], al

        mov eax, 4
        mov ebx, 1
        mov ecx, qtyPrompt
        mov edx, qtyPromptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        lea ecx, [m+qty+esi]
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, flush
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, pricePrompt
        mov edx, pricePromptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, priceTens
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, priceOnes
        mov edx, 1
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, flush
        mov edx, 1
        int 80h

        ;----------combine priceTens and priceOnes------

        sub byte [priceTens], 30h
        sub byte [priceOnes], 30h

        mov al, [priceTens]
        mov bl, 10
        mul bl

        mov ah, 0
        mov bl, [priceOnes]
        add al, bl

        mov [m+price+esi], al

        ;-----------------------------------------------
        

        ret
        

    buyMedicine:

      
        mov byte [i], 0
       
        print_medicine_record:

        mov al, [i]
        mov bl, [mCount]
        cmp al, bl
        je enter_name_to_buy

        mov eax, 0

        mov al, medicine
        mov bl, [i]
        mul bl

        mov esi, eax
        

        mov eax, 4
        mov ebx, 1
        lea ecx, [m+name+esi]
        mov edx, 20
        int 80h

        mov eax, 4
        mov ebx, 1
        lea ecx, [m+qty+esi]
        mov edx, 1
        int 80h 

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h


        mov al, [m+price+esi]
        mov bl, 10
        div bl

        mov [priceTens], al
        mov [priceOnes], ah

        add byte [priceTens], 30h
        add byte [priceOnes], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, priceTens
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, priceOnes
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, newLine
        mov edx, newLineLen
        int 80h
        

        inc byte [i]
        jmp print_medicine_record
    

        enter_name_to_buy:
        mov byte [i], 0
        mov eax, 4
        mov ebx, 1
        mov ecx, namePrompt
        mov edx, namePromptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, nameFind
        mov edx, 21
        int 80h


        find_medicine_to_buy:

        mov al, [i]
        mov bl, [mCount]
        cmp al, bl
        je not_found

       
        mov eax, 0

        mov al, medicine
        mov bl, [i]
        mul bl
        mov esi, eax

        mov eax, 0
        mov eax, [m+name+esi]

        mov [nameTemp], eax
        mov esi, nameTemp     
        mov edi, nameFind
        cmpsb

        jne next
        jmp found_medicine

        next:
        inc byte [i]
        jmp find_medicine_to_buy


        found_medicine:

        mov eax, 4
        mov ebx, 1
        mov ecx, found
        mov edx, foundLen
        int 80h

        mov al, medicine
        mov bl, [i]
        mul bl
        mov esi, eax

        mov al, [m+qty+esi]
        sub byte al, 30h
        dec al
        add byte al, 30h
        mov [m+qty+esi], al


        jmp end_buy_medicine

        not_found:

        mov eax, 4
        mov ebx, 1
        mov ecx, notFound
        mov edx, notFoundLen
        int 80h
        jmp end_buy_medicine


        end_buy_medicine:
        ret


    replenishMedicine:


        enter_name_to_replenish:
        mov byte [i], 0
        mov eax, 4
        mov ebx, 1
        mov ecx, namePrompt
        mov edx, namePromptLen
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, nameFind
        mov edx, 21
        int 80h


        find_medicine_to_replenish:

        mov al, [i]
        mov bl, [mCount]
        cmp al, bl
        je not_found_replenish

       
        mov eax, 0

        mov al, medicine
        mov bl, [i]
        mul bl
        mov esi, eax

        mov eax, 0
        mov eax, [m+name+esi]

        mov [nameTemp], eax
        mov esi, nameTemp     
        mov edi, nameFind
        cmpsb

        jne next_part
        jmp found_medicine_to_replenish

        next_part:
        inc byte [i]
        jmp find_medicine_to_replenish


        found_medicine_to_replenish:

        mov eax, 4
        mov ebx, 1
        mov ecx, found
        mov edx, foundLen
        int 80h

        mov al, medicine
        mov bl, [i]
        mul bl
        mov esi, eax

        mov al, [m+qty+esi]
        sub byte al, 30h
        inc al
        add byte al, 30h
        mov [m+qty+esi], al


        jmp end_replenish_medicine

        not_found_replenish:

        mov eax, 4
        mov ebx, 1
        mov ecx, notFound
        mov edx, notFoundLen
        int 80h
        jmp end_buy_medicine


        end_replenish_medicine:
        ret

 
        

