;Carlos Catalan
; AB-2L 2012-37801

;-----------------------------------------------------------------------------------------------
;Ask the user for the pattern and its size. Output the specified pattern with the appropriate size. (Run the executable file to view example)
;
;===MENU===
;[1] A
;[2] Z
;[3] Exit
;==========
;Choice:
;------------------------------------------------------------------------------------------------

section .data

   prompt db 'Enter size: ', 10
   promptLen equ $-prompt

   prompt2 db '[1] A', 10
   prompt2Len equ $-prompt2

   prompt3 db '[2] Z', 10
   prompt3Len equ $-prompt3

   prompt4 db '[3] Exit', 10
   prompt4Len equ $-prompt4
   
   newLine db 10
   newLineLen equ $-newLine 
  
   symbol db '*'
   symbolLen equ $-symbol

   whiteSpace db ' '
   whiteSpaceLen equ $-whiteSpace

  
    i db 0
    j db 0
section .bss
   

	choice resb 1
    size resb 1
    end resb 1
    sizeCmp resb 1	
    mid resb 1	
    temp1 resb 1
    temp2 resb 2

	
section .text
   global _start


_start:



    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, prompt2Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, prompt3Len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt4
    mov edx, prompt4Len
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, choice
    mov edx, 2
    int 80h

    sub byte [choice], 30h
    cmp byte [choice], 1
    je print_A
    cmp byte [choice], 2
    je print_Z
    cmp byte [choice], 3
    je exit


print_A:

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, size
    mov edx, 2
    int 80h

  
    sub byte [size], 30h


    ;--------------compute for "end"----------

      mov al, [size]
      mov bl, 2
      mul bl
      mov [end], ax
      
      mov al, [end]
      mov bl, 2
      sub al, bl
      mov [end], al

    ;  add byte [end], 30h
    ;  mov eax, 4
    ;  mov ebx, 1
    ;  mov ecx, end
    ;  mov edx, 1
    ;  int 80h



    ;-----------------------------------------


    ;----------------compute for "mid"---------
        mov ah, 0
        mov al, [size]
        mov bl, 2
        div bl

        mov [mid], al

    ;    add byte [mid], 30h
    ;    mov eax, 4
    ;    mov ebx, 1
    ;    mov ecx, mid
    ;    mov edx, 1
    ;    int 80h

              

    ;------------------------------------------
    outer_loop:
        
        mov al, [i]

        cmp al, [size]
        je exit

        mov byte [j], 0

        inner_loop:  

        mov al, [j]
        cmp al, [end]
        ja end_of_outer_loop


          ;------------------------------condition1 ===> if(j==(size-1-i)||j==(size-1+i)||(i==mid)&&(j>(size-1-i))&&(j<(size-1+i))) print *
          mov al, [size]
          mov [sizeCmp], al ;this value is used for comparison

          ;--------------------------------------------------1st part of condition1
          dec byte [sizeCmp]         ;(size-1)
          mov al, [sizeCmp]          
          mov bl, [i] 
          sub al, bl                 ;(size-1-i)
          cmp byte al, [j]
          mov [temp1], al            ;--used for 3rd part of condition2
          je print_x                 ;if(j==(size-1-i)) then print *
          ;------------------------------------------------------------------------

          ;-------------------2nd part of condition1 (if 1st part of 1st condition didn't work)

          mov al, [size]
          mov [sizeCmp], al ;this value is used for comparison
          
          dec byte [sizeCmp]         ;(size-1)
          mov al, [sizeCmp]          
          mov bl, [i] 
          add al, bl                 ;(size-1+i)
          cmp byte al, [j]
          mov [temp2], al            ;--used for 3rd part of condition1
          je print_x                 ;if(j==(size-1+i)) then print *
          ;------------------------------------------------------------------------

          ;--------------3rd part of condition1 (if 1st or 2nd condition didn't work)

          mov al, [i]
          cmp al, [mid]
          je p2_c1                 ;(i==mid)
          jne condition2        ;if not, try condition2

          p2_c1:
          mov al, [j]
          cmp al, [temp1]
          ja p3_c1                 ;(j>(size-1-i))
          jmp condition2        ;if not, try condition2

          p3_c1:
          mov al, [j]
          cmp al, [temp2]       ;j<(size-1+i)
          jb print_x            ; if all three are satisfied, print *
          jmp condition2        ;if not, try condition2

          ;------------------------------condition2 ===> else if((i==mid)&&(j<(size-1-i))&&(j>(size-1+i))) print " "
          condition2:                                                       

          mov al, [i]
          cmp al, [mid]
          je p2_c2                 ;(i==mid)
          jne condition3       ;if not, try condition3

          p2_c2:
          mov al, [j]
          cmp al, [temp1]
          jb p3_c3                 ;(j<(size-1-i))
          jmp condition3        ;if not, try condition3

          p3_c3:
          mov al, [j]
          cmp al, [temp2]       ;j>(size-1+i)
          ja print_whitespace            ; if all three are satisfied, print *
          jmp condition3        ;if not, try condition3

          ;------------------------------condition3 ===> else print " "

          condition3:
          jmp print_whitespace




        print_x:
        mov eax, 4
        mov ebx, 1
        mov ecx, symbol
        mov edx, symbolLen
        int 80h
        jmp end_of_inner_loop

        print_whitespace:
        mov eax, 4
        mov ebx, 1 
        mov ecx, whiteSpace
        mov edx, whiteSpaceLen
        int 80h 
        jmp end_of_inner_loop


        end_of_inner_loop:
        inc byte [j]
        jmp inner_loop

  

    end_of_outer_loop:

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h  

    inc byte [i]    
    jmp outer_loop


print_Z:

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, size
    mov edx, 2
    int 80h

  
    sub byte [size], 30h

    outer_loop_z:
        
        mov al, [i]

        cmp al, [size]
        je exit

        mov byte [j], 0
        inner_loop_z:  

        mov al, [j]
        cmp al, [size]
        je end_of_outer_loop_z

        ;----------------------if(i==0) print *
        cmp byte [i], 0
        je print_symbol
       
        ;----------------------if(i+j==(size-1)) print *
        mov al, [size]
        mov [sizeCmp], al

        mov al, [i]
        mov bl, [j]
        add al, bl
        mov [temp1], al

        mov al, [temp1]
        dec byte [sizeCmp]
        mov bl, [sizeCmp]
        cmp al, bl
        je print_symbol

        ;----------------------if(i==(size-1)) print *
        mov al, [size]
        mov [sizeCmp], al
        dec byte [sizeCmp]
        mov al, [sizeCmp]
        mov bl, [i]
        cmp al, bl
        je print_symbol
        
        ;-----------------------else print " " 
        jmp print_space

        print_symbol:
        mov eax, 4
        mov ebx, 1
        mov ecx, symbol
        mov edx, symbolLen
        int 80h
        jmp end_of_inner_loop_z

        print_space:
        mov eax, 4
        mov ebx, 1
        mov ecx, whiteSpace
        mov edx, whiteSpaceLen
        int 80h

        end_of_inner_loop_z:    
        inc byte [j]
        jmp inner_loop_z

  

    end_of_outer_loop_z:

    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 80h  

    inc byte [i]    
    jmp outer_loop_z


exit:
    mov eax, 1
    mov ebx, 0
    int 80h








