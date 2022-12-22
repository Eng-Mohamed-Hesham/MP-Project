include emu8086.inc
ORG 100h   

.data           
        array_name db 1, 0, ' ', 2, 2, ' ',  3, 0,' ', 4, 2,' '
.CODE  
    mov ax, @data
    mov ds, ax
    main proc
        mov bx, 2
        
        LEA SI, array_name        
        mov [SI+bx], 0
        mov [SI+bx+1], 0
        mov [SI+bx+2], 0
        printn "Student deleted successfully!"
        MOV di, 4   ; set the loop iterations
        mov cx, 1
                     
                                
      next_value:
        print "the student id => "
        mov dx, cx  
        add dx, 48
        mov AH, 2
        int 21h
        inc cx
  
        MOV dx,[SI]
        add dx, 48                       ;20
        cmp dx, 0
        jz  sec_check
        jnz cont2 
                    
      sec_check:  
        MOV dx,[SI+1]
        add dx, 48
        cmp dx, 0
        jz  deleted
        jnz cont2
      
      cont2:
        print " has grade => "
        MOV dx,[SI]
        add dx, 48                       
        mov AH, 02h
        int 21h
        MOV dx,[SI+1]
        add dx, 48
        mov AH, 02h
        int 21h
        
        
      next:
                        
        CALL New_line
        dec di
        add si, 3
        cmp di, 0                           
        JNZ next_value
        jz  finish
        
      deleted:
        print " has been deleted! "
        jmp next
        
      finish:           
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
        END main
    
    
      