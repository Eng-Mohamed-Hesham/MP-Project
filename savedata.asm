.MODEL SMALL
.STACK 100H

.DATA
    fname  DB 'grades.txt',0
    handle DW ?
    arr    DW 47, 52, 63, 58, 21
    space  DB 20H
    V      DW DUP(0)
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
            XOR AX, AX
            MOV AX, [SI]
            CALL SplitNum  
            
            MOV AH, 40H
            XOR BX, BX
            MOV BX, handle
            MOV CX, 1
            MOV DX, OFFSET space
            INT 21H  
            
            ADD SI, 2
            DEC DI 
            JMP loopArr
            
        endloop:     
            CALL Close
            
        ;----- exiting -----;
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
        
    Open PROC  
        MOV AH, 3DH
        MOV DX, OFFSET(fname)      
        MOV AL, 1 ; => for writing mode
        INT 21H
        MOV handle, AX
    Open ENDP
    RET
        
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
    		MOV OFFSET V, DX
    		PUSH CX
    		MOV AH, 40H
            XOR BX, BX
            MOV BX, handle
            MOV CX, 1
            MOV DX, OFFSET V
            INT 21H 
            POP CX
    		DEC CX
    		JMP popDigit
    		
    exit:
        SplitNum ENDP
        ret
    
    Close PROC
        MOV AH, 3EH
        MOV DX, handle
        INT 21H
    Close ENDP
    RET
    
    END MAIN  