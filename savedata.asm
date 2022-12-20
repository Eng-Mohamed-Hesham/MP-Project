.MODEL SMALL
.STACK 100H

.DATA

fname  DB 'grades.txt',0
handle DW ?
arr    DW 40, 42, 63, 58, 21
space  DB 20H

.CODE

MAIN PROC
    ; initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Open File for write mode
    CALL Open
    MOV SI, OFFSET arr
    MOV DI, 5
     
    loopArr:
        CMP DI, 0
        JZ  endloop
        CALL Write 
        ADD SI, 2
        DEC DI
        
    endloop:     
        CALL Close
        
    ;----- exiting -----;
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    
Open PROC  
    XOR AH, AH
    MOV AH, 3DH
    MOV DX, OFFSET(fname)      
    MOV AL, 1 ; => for writing mode
    INT 21H
    MOV handle, AX
Open ENDP
RET
    
Write PROC
    XOR AH, AH
    MOV AH, 40H
    MOV BX, handle
    MOV CX, 2
    MOV DX, [SI]
    INT 21H
    MOV CX, 1
    MOV DX, OFFSET space
    INT 21H
Write ENDP
RET

Close PROC
    MOV AH, 3EH
    MOV DX, handle
    INT 21H
Close ENDP
RET

END MAIN  