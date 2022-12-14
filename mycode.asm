.MODEL SMALL
.STACK 100H
include emu8086.inc 
.data
  
    msg1 dw ' 1- Add new students. $'
    msg2 dw 0AH, 0DH, '2- Search for a student grade using id. $'
    msg3 dw 0AH, 0DH, '3- Edit student grade. $'
    msg4 dw 0AH, 0DH, '4- Edit student id. $'
    msg5 dw 0AH, 0DH, 'Enter a valid choice of the above: $'
    msg6 dw 0Ah, 0DH, 'Enter a valid number of students (less than 255): $'
    msg7 dw 0Ah, 0DH, 'Enter a valid id (less than 255): $'
    msg8 dw 0Ah, 0DH, 'valid id $'
    choice db ?

;struct :
    ;dw id
    ;dw grade    
    

.code
    mov ax, @data
    mov ds, ax
    lea si, msg1
    mov ah, 9
    int 21h
    lea dx, msg2
    int 21h
    lea dx, msg3
    int 21h
    lea dx, msg4
    int 21h
    
    Enter_choice:    
        lea dx, msg5
        mov ah, 9
        int 21h
        mov ah, 1
        int 21h
        cmp al, '1'
        jae Second_cmp1
        jmp Enter_choice
    
    Second_cmp1:         
        cmp al, '4'
        jbe valid_choice 
        jmp Enter_choice
    
    valid_choice:
        cmp al, '1'
        je @Add_students
        cmp al, '2'
        je @Search_student
        cmp al, '3'
        je @Edit_grade
        cmp al, '4'
        je @Edit_id
        
        
     @Add_students:
        lea dx, msg6
        mov ah, 9
        int 21h
        call SCAN_NUM     
        cmp cx, 01h
        jae Second_cmp2
        jmp @Add_students
     
        Second_cmp2:   
            cmp cx, 0ffh
            jbe valid_number_of_students
            jmp @Add_students
     
        valid_number_of_students:
            ;// code
     
     
     @Search_student:
        call ID_input_Validation
        lea dx, msg8
        mov ah, 9
        int 21h  
     
     
     @Edit_grade:
        call ID_input_Validation
        ;//code
     
     @Edit_id:
        call ID_input_Validation
        ;//code 
     
     
     
     ID_input_Validation proc near
        INPUT: lea dx, msg7
        mov ah, 9
        int 21h
        call SCAN_NUM
        cmp cx, 0h
        jae Second_cmp3
        jmp INPUT
    
        Second_cmp3:         
            cmp cx, 0ffh
            jbe END_proc 
            jmp INPUT
        
        END_proc:
            ret
      ID_input_Validation endp
        
     
     DEFINE_SCAN_NUM   
        
     
END   