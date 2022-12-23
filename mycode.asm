.MODEL SMALL
.STACK 100H
include emu8086.inc 
.data
  
    msg1 dw 0AH, 0DH,'1- Add new students. $'
    msg2 dw 0AH, 0DH, '2- Search for a student grade using id. $'
    msg3 dw 0AH, 0DH, '3- Edit student grade. $'
    msg4 dw 0AH, 0DH, '4- Display list of grades. $'
    msg5 dw 0AH, 0DH, '5- Remove a student. $'
    msg10 dw 0AH, 0DH, '6- End the program. $'
    msg11 dw 0AH, 0DH, 'Do you want to continue the program? (Y to CONTINUE) or (any other key to END) $'
    msg12 dw 0AH, 0DH, '## Invalid Entry. ## $'
    msg6 dw 0AH, 0DH, '     --> Enter a valid choice of the above: $'
    msg7 dw 0Ah, 0DH, '         --> Enter a valid number of students (less than 65535): $'
    msg8 dw 0Ah, 0DH, '         --> Enter a valid id (less than 65535): $'
    msg9 dw 0Ah, 0DH, '         --> Enter the updated grade: $'
    
    choice db ?   

.code
    
    mov ax, @data
    mov ds, ax
@Main_func:    
    lea dx, msg1
    mov ah, 9
    int 21h
    lea dx, msg2
    int 21h
    lea dx, msg3
    int 21h
    lea dx, msg4
    int 21h
    lea dx, msg5
    int 21h
    lea dx, msg10
    int 21h
  
    Enter_choice:    
        lea dx, msg6
        mov ah, 9
        int 21h
        mov ah, 1
        int 21h
        cmp al, '1'
        jae Second_cmp1
        lea dx, msg12
        mov ah, 9
        int 21h
        jmp Enter_choice
    
    Second_cmp1:         
        cmp al, '6'
        jbe valid_choice
        lea dx, msg12
        mov ah, 9
        int 21h 
        jmp Enter_choice
    
    valid_choice:
        cmp al, '1'
        je @Add_students
        cmp al, '2'
        je @Search_student
        cmp al, '3'
        je @Edit_grade            
        cmp al, '4'
        je @Display_list_of_grades
        cmp al, '5'
        je @Remove_student
        cmp al, '6'
        je @End_program
        
        
     @Add_students:
        lea dx, msg7
        mov ah, 9
        int 21h
        call SCAN_NUM     
        cmp cx, 01h
        jae Second_cmp2
        jmp @Add_students
     
        Second_cmp2:   
            cmp cx, 0ffffh
            jbe valid_number_of_students
            jmp @Add_students
     
        valid_number_of_students:
            ;// code
            jmp @End_program     
     
     
     @Search_student:
        call ID_input_Validation
        ;// code
        jmp @End_program
        
        
     @Edit_grade:
        call ID_input_Validation
        mov bx, cx
        lea dx, msg9
        mov ah, 9
        int 21h
        call SCAN_NUM
        ;mov arr[bx], cx 
        jmp @End_program
        
        
     @Display_list_of_grades:
        call ID_input_Validation
        call Print_students
        jmp @End_program
;***************************************************************
Print_students PROC
        
        MOV CX, num_of_students   ; set the loop iterations
        LEA SI, array_name        ; load addres of the array of students   ;should be in ASCII
                    
                                
      next_value:
        
        MOV DL,a[SI]              ; get value from the array
        add dl, 48                ; to convert to ASCII
        
        lea dx, print1
        mov ah,  9
        int 21h   
                  
        mov AH, 2
        int 21h                   ;print it
        inc SI
        MOV DL, 0AH               ; New line
        MOV AH, 02H  
        INT 21H
        MOV DL, 0DH
        MOV AH, 02H  
        INT 21H  
                                  ; next BYTE
      LOOP next_value             ; CX++
        
    RET                           ; Return to the caller
    Print_students ENDP           ; End of the procedure
;***************************************************************        
     @Remove_student:
        call ID_input_Validation 
        ;// code
        jmp @End_program
        
        
     @End_program:
          lea dx, msg11
          mov ah, 9
          int 21h
          mov ah, 1
          int 21h
          cmp al, 'y'
          je @Main_func
          jne Else_if
          Else_if:
              cmp al, 'Y'
              je @Main_func
              jne Else
          ELSE:
          ;// Save data code
          mov ah, 04ch
          int 21h
     
      ID_input_Validation proc near
        INPUT: lea dx, msg8
        mov ah, 9
        int 21h
        call SCAN_NUM
        cmp cx, 0h
        jae Second_cmp3
        jmp INPUT
    
        Second_cmp3:         
            cmp cx, 0ffffh
            jbe END_proc 
            jmp INPUT
        
        END_proc:
      ret
      ID_input_Validation endp
        
     
     DEFINE_SCAN_NUM
     DEFINE_PRINT_NUM_UNS              
END   