;Carlos Catalan 
;AB-2L 2012-37801

;------------------------------------------------------------------------------------------
;Ask for the users name and birthday. Output the information given with the computed age.
;
;INPUT:
;> Name (at most 20 characters)
;> Birthday (month, day, year)
;OUTPUT:
;> Name
;> Birthday
;> Age (for the year 2015)
;------------------------------------------------------------------------------------------

section .data

   nameInput db 'Enter Name: ', 10
   nameInputLen equ $-nameInput
   
   monInput db 'Enter Birth Month: ', 10
   monInputLen equ $-monInput
   
   dayInput db 'Enter Birth Day: ', 10
   dayInputLen equ $-dayInput
   
   yearInput db 'Enter Birth Year: ', 10
   yearInputLen equ $-yearInput
   
   newLine db 10
   newLineLen equ $-newLine
   
    


   
section .bss
   
	name resb 20
	month resb 15
	day resb 2
	
	      age resw 1
		;variable when inputting the year
        year4 resb 1
        year3 resb 1
        year2 resb 1
        year1 resb 1
		;variables after multiplying the digits by 1000, 100, etc
        byear resw 1
        pyear resw 1

        result resw 1
        
      ;digits of the age  
        age4 resb 1
        age3 resb 1
        age2 resb 1
        age1 resb 1

        rem resw 1

        temp resw 1
	
	
	
section .text
   global _start
   
_start:

   mov eax, 4	;enter name
   mov ebx, 1
   mov ecx, nameInput
   mov edx, nameInputLen
   int 80h
   
   mov eax, 3	;scans name
   mov ebx, 0
   mov ecx, name
   mov edx, 20
   int 80h
   
   mov eax, 4	;enter month
   mov ebx, 1
   mov ecx, monInput
   mov edx, monInputLen
   int 80h
   
   mov eax, 3	;scans month
   mov ebx, 0
   mov ecx, month
   int 80h
   
   mov eax, 4	;enter day
   mov ebx, 1
   mov ecx, dayInput
   mov edx, dayInputLen
   int 80h
   
   mov eax, 3	;scans day
   mov ebx, 0
   mov ecx, day
   ;mov edx, 3
   int 80h



;--------------------------------- Do computations
   
   mov eax, 4	;enter year
   mov ebx, 1
   mov ecx, yearInput
   mov edx, yearInputLen
   int 80h

;----get 4th place value   
   mov eax, 3	
   mov ebx, 0
   mov ecx, year4
   mov edx, 1
   int 80h


;-----get 3rd place value
   mov eax, 3	
   mov ebx, 0
   mov ecx, year3
   mov edx, 1
   int 80h


;-----get 2nd place value
   mov eax, 3	
   mov ebx, 0
   mov ecx, year2
   mov edx, 1
   int 80h


;---get 1st place value
   mov eax, 3	
   mov ebx, 0
   mov ecx, year1
   mov edx, 2
   int 80h

 
;----------print details---------------

   mov eax, 4	;print name
   mov ebx, 1
   mov ecx, name
   mov edx, 20
   int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, newLine
  mov edx, newLineLen
  int 80h

   mov eax, 4	;print month
   mov ebx, 1
   mov ecx, month
   mov edx, 15
   int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, newLine
  mov edx, newLineLen
  int 80h

   mov eax, 4	;print day
   mov ebx, 1
   mov ecx, day
   mov edx, 2
   int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, newLine
  mov edx, newLineLen
  int 80h

  
   mov eax, 4	
   mov ebx, 1
   mov ecx, year4
   mov edx, 1
   int 80h

   mov eax, 4	
   mov ebx, 1
   mov ecx, year3
   mov edx, 1
   int 80h

   mov eax, 4	
   mov ebx, 1
   mov ecx, year2
   mov edx, 1
   int 80h

   mov eax, 4	
   mov ebx, 1
   mov ecx, year1
   mov edx, 1
   int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, newLine
  mov edx, newLineLen
  int 80h



;--------------------------------------------


;--------------do computations

;-------------process birth year

     
   mov al, [year4]        ;1 
   mov ah, 0 
   sub ax, 30h      
   mov bx, 1000           ;1000
   mul bx                 ;1000
   mov [byear], ax



    
   mov al, [year3]        ;9
   mov ah, 0
   sub ax, 30h
   mov bx, 100            ;100
   mul bx                ;900

   add [byear], ax 

   

 
  mov al, [year2]         ;9
  mov ah, 0
  sub ax, 30h
  mov bx, 10              ;10
  mul bx                  ;90

    add [byear], ax
      
  

  
  mov al, [year1]         ;6
  mov ah, 0
  sub ax, 30h
  mov bx, 1               ;1
  mul bx                  ;6


  add [byear], ax         ;1990 +6  

;--------end of process birth year-------- 


;-----print for checking
  
;  mov ax, [byear]
;  mov bx, 1000
;  div bx
;  mov ah, 0
;  mov [year4], al
;  mov [rem], dx

; add byte [year4], 30h
; mov eax, 4
; mov ebx, 1
; mov ecx, year4
; mov edx, 1
; int 80h

; mov eax, 4
; mov ebx, 1
; mov ecx, newLine
; mov edx, newLineLen
; int 80h

;-----end of print for checking

;--------------process present year----
   mov al, 2              ;2 
   mov ah, 0 
   ;sub ax, 30h      
   mov bx, 1000           ;1000
   mul bx                 ;2000
   mov [pyear], ax



    
   mov al, 0              ;0
   mov ah, 0
   ;sub ax, 30h
   mov bx, 100            ;100
   mul bx                 ;000

   add [pyear], ax        ;2000 + 000

   

 
  mov al, 1               ;1
  mov ah, 0
  ;sub ax, 30h
  mov bx, 10              ;10
  mul bx                  ;10

    add [pyear], ax       ;2000 + 10
      
  

  
  mov al, 5               ;5
  mov ah, 0
  ;sub ax, 30h
  mov bx, 1               ;1
  mul bx                  ;5


  add [pyear], ax         ;2010 +5

;--------------------------------------

  mov ax, [pyear]
  mov bx, [byear]
  neg bx
  add ax, bx

;-----------print year (age is in bx)---------------

  mov bx, 1000
  div bx
  ;mov dx, 0
  ;mov ah, 0
  mov [year4], ax
  mov [rem], dx

 add byte [year4], 30h
 mov eax, 4
 mov ebx, 1
 mov ecx, year4
 mov edx, 1
 int 80h

  
  mov al, [rem]
  mov bl, 100
  div bl
  ;mov dx, 0
  ;mov ah, 0
  mov [year3], al
  mov [rem], ah

 add byte [year3], 30h
 mov eax, 4
 mov ebx, 1
 mov ecx, year3
 mov edx, 1
 int 80h

  mov al, [rem]
  mov bl, 10
  div bl
  ;mov dx, 0
  ;mov ah, 0
  mov [year2], al
  mov [year1], ah

 add byte [year2], 30h
 mov eax, 4
 mov ebx, 1
 mov ecx, year2
 mov edx, 1
 int 80h

 add byte [year1], 30h
 mov eax, 4
 mov ebx, 1
 mov ecx, year1
 mov edx, 1
 int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, newLine
  mov edx, newLineLen
  int 80h

;-----------------end of print year----------








   mov eax, 1
   mov ebx, 0
   int 80h
