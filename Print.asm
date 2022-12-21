
ORG 100h

.CODE  

    Print_students PROC
        
        MOV CX, num_of_students   ; set the loop iterations
        LEA SI, array_name        ; load addres of the array of students   ;should be in ASCII
                    
                                
      next_value:
        
        MOV DL,a[SI]              ; get value from the array
        mov AH, 2
        int 21h
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
