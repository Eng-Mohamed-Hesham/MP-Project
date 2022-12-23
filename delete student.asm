include emu8086.inc
ORG 100h   

.data           
    array_name dw 10, 22, 30, 42, 50
.CODE  
    mov ax, @data
    mov ds, ax
    main proc
        mov bx, 2
        
        LEA SI, array_name        ; load addres of the array of students   ;should be in ASCII
        mov [SI+bx], 0
        printn "Student deleted successfully!"
        MOV di, 5   ; set the loop iterations
        mov cx, 1
                     
                                
      next_value:
        print "the student id => "
        mov dx, cx  
        add dx, 48
        mov AH, 2
        int 21h
        inc cx
        print " his grade => "
        push cx
        MOV ax,[SI]               ; get value from the array
        call SplitNum                  ; to convert to ASCII
        add si, 2
       
        CALL New_line
        pop cx  
        dec di
        cmp di, 0
                                   ; next word
        JNZ next_value             ; CX++
        mov ah, 4ch
        int 21h         

    main ENDP           ; End of the procedure
    
    SplitNum PROC		
    	MOV CX,0
    	MOV DX,0
    	pushDigit:
    		CMP AX, 0
    		JZ popDigit	
    		MOV BX, 10	
    		DIV BX				
    		PUSH DX			
    		INC CX			
    		XOR DX, DX
    		JMP pushDigit
    	popDigit:
    		CMP CX,0
    		JZ exit 
    		XOR DX, DX
    		POP DX
    		ADD DX, 48
    		mov AH, 2
            int 21h
    		DEC CX
    		JMP popDigit
    		
    exit:
        SplitNum ENDP
        ret
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
    
    
      