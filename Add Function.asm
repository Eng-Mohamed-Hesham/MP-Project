            .model small

            .stack 100h

            .data
Grade_Msg   db  0dh,0ah, "Enter New Student Grade:  $"
ID_Msg      db  0dh,0ah, "Enter New Student ID:  $"
Exit_Msg    db 'Wrong Value for Index, Please Try Again$'
Exit        db 'The New Student Has Added Successfully$'
Grade_Length      db  ?
ID_Length         db  ?

New_Grade   db  3           ;Max Nnumber of Characters Allowed (3).
            db  ?           ;Number of Characters Entered by User.
            db  3 dup(0)    ;Characters Entered by User. 
            
ID          db  4       
            db  ?         
            db  4 dup(0)
            
Arr         db  99 dup(0)  

            .code
main proc                      
            mov ax, @data               ; Making the "DS" Pointing to our Data Segment 
            mov ds, ax              
            
            mov ah,09h
            lea dx,Grade_Msg
            int 21h 
            
;Capture String From Keyboard.                                    
            mov ah, 0Ah                 ;Service to Capture String from Keyboard.
            mov dx, offset New_Grade
            int 21h
            
            mov ah,09h
            lea dx,ID_Msg
            int 21h   
            
;Capture String From Keyboard.                                    
            mov ah, 0Ah                 ;Service to Capture String from Keyboard.
            mov dx, offset ID
            int 21h                                  
                                                                                                                        


            mov si, offset New_Grade + 1    ;Number Of Characters Entered 
            mov cl, [si]                    ;Move Length to Cl.
            mov ch,0                       ;Cear Ch to use Cx. 
            mov Grade_Length, cl
                                   
            mov si, 0
            mov bx,cx
                     
Check1:
            cmp New_Grade[2][si], 030h     ; Compare Bl With Ascii Value of 01
            jle EndPrgm
            inc si        
            loop Check1
            
            mov si, 0
            mov cx,bx
            
Check2:       
            cmp New_Grade[2][si], 039h     ; Compare Bl With Ascii Value of 09   
            jg EndPrgm
            inc si 
            loop Check2     
            
            
            mov cx,bx
            mov si, 0
           
           ; convert the 'char digit' to 'intger digit' by sub 48 from it    
To_Digits:  
            mov dl, New_Grade[2][si]
            sub dl,48
            mov New_Grade[2][si], dl
            inc si
            loop To_Digits
            
            
            
            mov si, offset ID + 1    ;Number Of Characters Entered 
            mov cl, [si]                    ;Move Length to Cl.
            mov ch,0                       ;Cear Ch to use Cx. 
            mov ID_Length, cl                       ;Cear Ch to use Cx. 
                                     
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
                    
Check3:
            cmp ID[2][si], 029h     ; Compare Bl With Ascii Value of 01
            jle EndPrgm
            inc si        
            loop Check3
            
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
            
Check4:       
            cmp ID[2][si], 039h     ; Compare Bl With Ascii Value of 09   
            jg EndPrgm
            inc si 
            loop Check4     
            
            
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
              
To_Digits2:  
            mov dl, ID[2][si]
            sub dl,48
            mov ID[2][si], dl
            inc si
            loop To_Digits2
            
            jmp DoWork
         

EndPrgm:
                      mov ax, @data
            mov ds, ax
            mov ah, 09h
            lea dx, Exit_Msg
            int 21h
            mov ah,0x4C     ;DOS "terminate" function
            int 0x21

DoWork:     
            mov ax,1
            mov cl,ID_Length
            mov ch,0
            mov bl,10
            
            
            cmp cl,1
            je La2
            sub cl,1
            
            push cx
            ; 10^x, to transfer the "string" input to real integer value     
        L:
            mul bl
            loop L
           
            pop cx
            inc cx
             
        La2:    
            mov si,0
            mov dx ,0
           
           ; calculate the ID by multiply each index by 10 power it's weight value 
        Get_ID:
            push ax
            mul ID[2][si]
            
            add dl,al
            pop ax
            div bl
            inc si
        
            loop Get_ID
            
            ; Get the Exact ID's index according to our Array of bytes
            mov al,dl
            mov dl,03
            mul dl
            sub al,03
            
            cmp Grade_Length,1
            je L1
            jne L2
           
               
        l2: 
            mov ah,0
            mov si, ax
            mov al,New_Grade[2][0]
            mov Arr[si],al
            inc si
            mov al, New_Grade[2][1]
            mov Arr[si],al
            jmp End_Msg
            
            
            
        L1: 
            mov ah,0
            mov si, ax
            mov al,0
            mov Arr[si],al     
            inc si
            mov al, New_Grade[2][0]
            mov Arr[si],al
            jmp End_Msg
            
            
        
        End_Msg:
            mov ax, @data
            mov ds, ax
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
            
main endp
                     