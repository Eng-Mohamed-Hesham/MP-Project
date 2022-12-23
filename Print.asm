include emu8086.inc
ORG 100h   

.data          
    print1 dw 0AH, 0DH,'the student id => $'
    print2 dw 0AH, 0DH,'his grade => $'
    num_of_students db 5                                           
    array_name db 1, 0, ' ', 2, 2, ' ',  3, 0,' ', 4, 2,' '
.CODE  
    mov ax, @data
    mov ds, ax
    main proc
        
        MOV di, 4   ; set the loop iterations
        LEA SI, array_name        ; load addres of the array of students   ;should be in ASCII
        mov cx, 1
                     
                                
      next_value:
        print "the student id => "
        mov dx, cx  
        add dx, 48
        mov AH, 2
        int 21h
        inc cx
        print " his grade => "
        MOV dx,[SI]
        add dx, 48               ; get value from the array
        mov AH, 02h
        int 21h                 ; to convert to ASCII
        add si, 1
        MOV dx,[SI]
        add dx, 48               ; get value from the array
        mov AH, 02h
        int 21h                        ;print it   what SI point to
        CALL New_line
        dec di
        add si, 2
        cmp di, 0
                                   ; next word
        JNZ next_value             ; CX++
        mov ah, 4ch
        int 21h         

    main ENDP           ; End of the procedure
    
   New_line proc 
    
        MOV DL, 0AH               ; New line
        MOV AH, 02H  
        INT 21H
        MOV DL, 0DH
        MOV AH, 02H  
        INT 21H
    
   New_line ENDP 
   ret
  