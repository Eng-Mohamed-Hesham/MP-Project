include 'emu8086.inc'
.MODEL SMALL
.STACK 100H
 
.DATA
    msg1   dw 0AH, 0DH,'1- Add/Edit students. $'
    msg2   dw 0AH, 0DH, '2- Search for a student grade using id. $'
    msg4   dw 0AH, 0DH, '3- Display list of grades. $'
    msg5   dw 0AH, 0DH, '4- Remove a student. $'
    msg10  dw 0AH, 0DH, '5- End the program. $'
    msg11  dw 0AH, 0DH, 'Do you want to continue the program? (Y to CONTINUE) or (any other key to END) $'
    msg12  dw 0AH, 0DH, '## Invalid Entry. ## $'
    msg6   dw 0AH, 0DH, ' --> Enter a valid choice of the above: $'
    msg7   dw 0Ah, 0DH, ' --> Enter a valid number of students (less than 65535): $'
    msg8   dw 0Ah, 0DH, ' --> Enter a valid id (less than 65535): $'
    msg9   dw 0Ah, 0DH, ' --> Enter grade: $'  
    Grade_Msg   db  0dh,0ah, "Enter New Student Grade:  $"
    ID_Msg      db  0dh,0ah, "Enter New Student ID:  $"
    Exit_Msg    db 'Wrong Value! Please Try Again$'
    Exit        db 'The New Student Has Added Successfully$' 
    St_ID1      db 'The Student with ID: $'
    St_ID2      db '  Has Grade Value:  $'
    print1 dw 0AH, 0DH,'the student id => $'
    print2 dw 0AH, 0DH,'his grade => $'
    fname dw "Grades.txt",0 
    digit  DB ?
    space  DB 20H  
    fhand dw ? 
    Grade_Length      db  ?
    ID_Length         db  ?
    ID_Value          db  0
    New_Grade   db  3           ;Max Nnumber of Characters Allowed (3).
                db  ?           ;Number of Characters Entered by User.
                db  3 dup(0)    ;Characters Entered by User. 
                
    ID          db  4       
                db  ?         
                db  4 dup(0)
            
    grades DB 255 DUP(?)   

.CODE
    mov AX, @DATA
    mov DS, AX 
    
    mov ah,3dh
    mov al,0
    MOV DX, OFFSET(fname)
    int 21h
    mov fhand, ax
    mov si,OFFSET grades  
    
    loadagain: 
        XOR AX, AX
        mov ah,3fh
        mov bx,fhand 
        mov cx, 1                                                      
        lea dx, [si]
        int 21h
        SUB [si], 48
        cmp ax, 0
        JE @Main_func
        INC SI
        JMP loadagain 
        
@Main_func:
    PRINTN ""     
    MOV AH, 09H
    MOV DX, OFFSET msg1
    INT 21H 
    MOV DX, OFFSET msg2
    INT 21H
    MOV DX, OFFSET msg4
    INT 21H
    MOV DX, OFFSET msg5
    INT 21H
    MOV DX, OFFSET msg10
    INT 21H
    PRINTN ""
  
    Enter_choice:    
        PRINT "--> Enter a valid choice of the above: "
        mov ah, 1
        int 21h
        cmp al, '1'
        jae Second_cmp1
        lea dx, msg12
        mov ah, 9
        int 21h
        PRINTN ""
        jmp Enter_choice
    
    Second_cmp1:         
        cmp al, '5'
        jbe valid_choice
        lea dx, msg12
        mov ah, 9
        int 21h 
        PRINTN ""
        jmp Enter_choice
    
    valid_choice:
        cmp al, '1'
        je @Add_Edit
        cmp al, '2'
        je @Search
        cmp al, '3'
        je @Display
        cmp al, '4'
        je @Remove_student 
        cmp al, '5'
        je @End_program
        
        
     @Add_Edit:
            PRINTN ""
            PRINT "Enter New Student Grade: "
                                        ;Capture String From Keyboard.                                    
            mov ah, 0Ah                 ;Service to Capture String from Keyboard.
            mov dx, offset New_Grade
            int 21h
            PRINTN "" 
            PRINT "Enter New Student ID: "
                                         ;Capture String From Keyboard.                                    
            mov ah, 0Ah                 ;Service to Capture String from Keyboard.
            mov dx, offset ID
            int 21h                                  
            PRINTN ""                                                                                                            
            mov si, offset New_Grade + 1    ;Number Of Characters Entered 
            mov cl, [si]                    ;Move Length to Cl.
            mov ch,0                       ;Cear Ch to use Cx. 
            mov Grade_Length, cl                       
            mov si, 0
            mov bx,cx
                     
    lab1:                                ; Compare Bl With Ascii Value of 01
            cmp New_Grade[2][si], 030h     
            jle EndPrgm_1
            inc si        
            loop lab1
            mov si, 0
            mov cx,bx
            
    lab2:                                ; Compare Bl With Ascii Value of 09 
            cmp New_Grade[2][si], 039h       
            jg EndPrgm_1
            inc si 
            loop lab2     
            mov cx,bx
            mov si, 0
                        ; convert the 'char digit' to 'intger digit' by sub 48 from it    
    lab3:  
            mov dl, New_Grade[2][si]
            sub dl, 48
            mov New_Grade[2][si], dl
            inc si
            loop lab3
            mov si, offset ID + 1           ;Number Of Characters Entered 
            mov cl, [si]                    ;Move Length to Cl.
            mov ch,0                        ;Cear Ch to use Cx. 
            mov ID_Length, cl               ;Cear Ch to use Cx. 
                                     
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
                    
    lab4:
            cmp ID[2][si], 029h     ; Compare Bl With Ascii Value of 01
            jle EndPrgm_1
            inc si        
            loop lab4
            
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
            
    lab5:       
            cmp ID[2][si], 039h     ; Compare Bl With Ascii Value of 09   
            jg EndPrgm_1
            inc si 
            loop lab5     

            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
              
    lab6:  
            mov dl, ID[2][si]
            sub dl,48
            mov ID[2][si], dl
            inc si
            loop lab6
            
            jmp dowork_1
         

    EndPrgm_1:
            PRINTN "Wrong Value ! Please Try Again!"
            JMP @Main_func

    dowork_1:     
            mov ax,1
            mov cl,ID_Length
            mov ch,0
            mov bl,10
            
            cmp cl,1
            je lab8
            sub cl,1
            
            push cx
            ; 10^x, to transfer the "string" input to real integer value     
        lab7:
            mul bl
            loop lab7
            pop cx
            inc cx
        lab8:    
            mov si,0
            mov dx ,0
           
           ; calculate the ID by multiply each index by 10 power it's weight value 
        get_id_1:
            push ax
            mul ID[2][si]
            add dl,al
            pop ax
            div bl
            inc si
            loop get_id_1
            
            ; Get the Exact ID's index according to our gradesay of bytes
            mov al, dl
            mov dl,03
            mul dl
            sub al,03
            
            cmp Grade_Length,1
            je lab10
            jne lab9
  
        lab9: 
            mov ah,0
            mov si, ax
            mov al,New_Grade[2][0]
            mov grades[si],al
            inc si
            mov al, New_Grade[2][1]
            mov grades[si],al
            jmp end_1
             
        lab10: 
            mov ah,0
            mov si, ax
            mov al,0
            mov grades[si],al     
            inc si
            mov al, New_Grade[2][0]
            mov grades[si],al
            jmp end_1
            
        end_1:
            ; Print New Line 
            mov dx,13
            mov ah,2
            int 21h  
            mov dx,10
            mov ah,2
            int 21h
            mov ah, 09h
            lea dx, Exit
            int 21h    
        jmp @Main_func     
     

     @Search:
        ;call ID_input_Validation
        PRINTN ""
        PRINTN "Enter Student ID: "   
        
                                    ;Capture String From Keyboard.                                    
        mov ah, 0Ah                 ;Service to Capture String from Keyboard.
        mov dx, offset ID
        int 21h                                  
                                                                                                                   
        mov si, offset ID + 1    ;Number Of Characters Entered 
        mov cl, [si]                    ;Move Length to Cl.
        mov ch,0                       ;Cear Ch to use Cx. 
        mov ID_Length, cl                       ;Cear Ch to use Cx. 
                                 
        mov si, 0
        mov ch, 0                        
        mov cl,ID_Length
                
    labx:
        cmp ID[2][si], 029h     ; Compare Bl With Ascii Value of 01
        jle end_2
        inc si        
        loop labx
        
        mov si, 0
        mov ch, 0                        
        mov cl,ID_Length
        
    laby:       
        cmp ID[2][si], 039h     ; Compare Bl With Ascii Value of 09   
        jg end_2
        inc si 
        loop laby     

        mov si, 0
        mov ch, 0                        
        mov cl,ID_Length
        
        ; convert the 'char digit' to 'intger digit' by sub 48 from it  
    labz:  
        mov dl, ID[2][si]
        sub dl,48
        mov ID[2][si], dl
        inc si
        loop labz
        
        jmp dowork_2
     

    end_2:
        mov ah, 09h
        lea dx, Exit_Msg
        int 21h
        mov ah,0x4C     ;DOS "terminate" function
        int 0x21

    dowork_2:     
        ; Get the Exact ID's index according to our gradesay of bytes
        mov ax,1
        mov cl,ID_Length
        mov ch,0
        mov bl,10

        cmp cl,1
        je labb
        sub cl,1
        
        ; 10^x, to transfer the "string" input to real integer value
        push cx     
    laba:
        mul bl
        loop laba
       
        pop cx
        inc cx
         
    labb:    
        mov si,0
        mov dx ,0
       
        ; calculate the ID by multiply each index by 10 power it's weight value
    get_id_2:
        push ax
        mul ID[2][si]
        
        add dl,al
        pop ax
        div bl
        inc si
    
        loop get_id_2
        
        mov ID_Value,dl
        mov al,dl
        mov dl,03
        mul dl
        sub al,03
        
        mov ah,0
        
        mov si, ax
                   
        mov bx,0
        mov bl,grades[si]
        inc si
        mov bh,grades[si]
        jmp end_3

    end_3:
        ; Print New Line 
        mov dx,13
        mov ah,2
        int 21h  
        mov dx,10
        mov ah,2
        int 21h
        
        mov cl,al
        mov ch,ah
        ; Print Message Num1
        mov ah,09h
        lea dx,St_ID1
        int 21h
        
        mov ah, 02h      ;DOS Character Output
        mov dl, ID_Value
        add dl,48
        int 21h   

        ; Print Message Num2
        mov dx,13
        mov ah,09h
        lea dx,St_ID2
        int 21h
         
        mov ah, 02h      ;DOS Character Output
        mov dl, bl
        add dl,48
        int 21h    
        mov ah, 02h      ;DOS Character Output
        mov dl, bh
        add dl,48
        int 21h
         
        ; Print New Line    
        mov dx,13
        mov ah,2
        int 21h  
        mov dx,10
        mov ah,2
        int 21h
 
        mov ah, 09h
        lea dx, Exit
        int 21h
        jmp @Main_func
         
        
     @Display:
        MOV di, 85   ; set the loop iterations
        LEA SI, grades        ; load addres of the gradesay of students   ;should be in ASCII
        mov cx, 1
                     
                                
      next_value:
        MOV DL, [SI]
        MOV DH, [SI+1]
        CMP DX, 0
        JE continue 
        CALL New_line
        print "the student id => "  
        ; handle multiple id digits ;
        mov dx, cx  
        add dx, 48
        mov AH, 2
        int 21h 
        ; end ;
        print " his grade => "
        MOV dx,[SI]
        add dx, 48               ; get value from the gradesay
        mov AH, 02h
        int 21h 
        MOV dx,[SI+1]
        add dx, 48               ; get value from the gradesay
        mov AH, 02h
        int 21h                        ;print it   what SI point to
        CALL New_line
        continue:
            dec di 
            inc cx
            add si, 3
            cmp di, 0
                                   ; next word
        JNZ next_value             ; CX++
        mov ah, 4ch
        int 21h
        jmp @Main_func
        
        
     @Remove_student:
        call ID_input_Validation 
        ;// code
        jmp @Main_func
        
        
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
              CALL Open
        
                MOV SI, 0     
                MOV DI, 255
                
                loopgrades:
                    CMP DI, 0
                    JZ  endloop 
                    MOV AL, grades[SI] 
                    MOV AH, 40H
                    MOV BX, fhand
                    MOV CX, 1 
                    CMP AL, ' ' 
                    JZ takespace
                        ADD AL, 48 
                        MOV OFFSET(digit), AL 
                        MOV DX, OFFSET(digit)
                        JMP CONT 
                    takespace:
                        MOV DX, OFFSET(space)
                    CONT: 
                        INT 21H
                        INC SI 
                        DEC DI 
                        JMP loopgrades
                    
                endloop:     
                    CALL Close
          
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

New_line proc 
    
        MOV DL, 0AH               ; New line
        MOV AH, 02H  
        INT 21H
        MOV DL, 0DH
        MOV AH, 02H  
        INT 21H
    
New_line ENDP 
ret   

Open PROC  
    MOV AH, 3DH
    MOV DX, OFFSET(fname)      
    MOV AL, 1
    INT 21H
    MOV fhand, AX
Open ENDP
RET

Close PROC
    MOV AH, 3EH
    MOV DX, fhand
    INT 21H
Close ENDP
RET
        
     
     DEFINE_SCAN_NUM
     DEFINE_PRINT_NUM_UNS
     DEFINE_PRINT_NUM              
END   