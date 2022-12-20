include 'EMU8086.INC'
.MODEL SMALL
.STACK 100H    

.DATA
    CARE  DB 'CARE.txt',0 
    handle DW ?
    ARRAY DW 20 DUP(?)
    
.CODE 

LOAD_FROM-FILE PROC
    MOV AX, @DATA
    MOV DS, AX
 ;----- opening existing file -----;
    MOV AH, 3DH
    MOV DX, OFFSET(CARE)          
    MOV AL, 0 ; => for reading mode
    ;MOV AL, 1 ; => for writing mode
    ;MOV AL, 2 ; => for both modes
    INT 21H
    MOV handle, AX 

;----- reading from file -----;
    MOV AH, 3FH
    MOV BX, handle
    MOV DX, OFFSET(ARRAY)
    MOV CX, 10
    INT 21H


        MOV AX, @DATA
        MOV DS, AX
        ;MOV AH, 09H
        ;MOV DX, OFFSET WELCOME
        ;INT 21H
        ;instead of using these three lines use it;
        PRINTN "START THE PROGRAM: "
        MOV SI, 0
        MOV DI, 1
        
        JUSTLOOP:
            MOV AX, ARRAY[SI]
            CALL PRINTING   
            ADD SI, 2
            ;XOR DX, DX     ;MOV DX, 2CH    ;MOV AH, 02H    ;INT 21H     ;instead of using these three lines use it; 
            PRINT ", "
            DEC DI
            CMP DI, 0
            JNZ JUSTLOOP
        PRINTN ""
        PRINTN "END OF PROGRAM"
        

        
       
    MOV AH, 4CH
    INT 21H
                             
     PRINTING PROC
        MOV CX, 0 ;    intialize the counter;
        MOV DX, 0
        PUSHDIGIT:
            CMP AX, 0
            JZ PRINTNUMBER
            MOV BX, 10
            DIV BX;  --> AX = AX/BX   , DX = AX%BX
            PUSH DX
            INC CX; ---> increament the counter
            XOR DX, DX ;---> MOV DX, 0
            JMP PUSHDIGIT
            
            
        PRINTNUMBER:
            CMP CX, 0
            JZ EXITPRINGING
            XOR DX, DX
            POP DX
            ADD DX, 48 ;--> ;add 48 so that it represents the ASCII value of digit 
        
            MOV AH, 02H
            INT 21H
            DEC CX
            JMP PRINTNUMBER
            
            
        EXITPRINGING:    
            
                PRINTING ENDP                        
                            
      
    RET 
    END LOAD_FROM-FILE
