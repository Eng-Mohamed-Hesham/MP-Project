.MODEL SMALL
.STACK 100H

.DATA
    fname  DB 'grades.txt', 0
    handle DW ?
    arr    DB 4, 7, ' ', 5, 2, ' ', 6, 3, ' ', 5, 8, ' ', 2, 1, ' '
    digit  DB ?
    space  DB 20H
     
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX 
        
        CALL Open
        
        MOV SI, 0     
        MOV DI, 15
        
        loopArr:
            CMP DI, 0
            JZ  endloop 
            MOV AL, arr[SI] 
            MOV AH, 40H
            MOV BX, handle
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
                JMP loopArr
            
        endloop:     
            CALL Close

        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
        
    Open PROC  
        MOV AH, 3DH
        MOV DX, OFFSET(fname)      
        MOV AL, 1
        INT 21H
        MOV handle, AX
    Open ENDP
    RET
    
    Close PROC
        MOV AH, 3EH
        MOV DX, handle
        INT 21H
    Close ENDP
    RET
    
    END MAIN  