            .model small

            .stack 100h

            .data
ID_Msg      db  0dh,0ah, "Enter Student ID:  $"
Exit_Msg    db 'Wrong Value for Index, Please Try Again.$'
St_ID1      db 'The Student with ID: $'
St_ID2      db '  Has Grade Value:  $'
Exit        db 'Prgoram has Finished Successfully$'
ID_Length         db  ?
ID_Value          db  0
 
            
ID          db  4            ;Max Nnumber of Characters Allowed (3).
            db  ?            ;Number of Characters Entered by User.
            db  4 dup(0)    ;Characters Entered by User. 
            
Arr         db   3,9,' ',6,3,' ',,8,1,' ', 

            .code
main proc                      
            mov ax, @data               ; Making the "DS" Pointing to our Data Segment 
            mov ds, ax              
            
            mov ah,09h
            lea dx,ID_Msg
            int 21h   
            
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
            
            ; convert the 'char digit' to 'intger digit' by sub 48 from it  
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
            ; Get the Exact ID's index according to our Array of bytes
            mov ax,1
            mov cl,ID_Length
            mov ch,0
            mov bl,10
            
                
            cmp cl,1
            je La2
            sub cl,1
            
            ; 10^x, to transfer the "string" input to real integer value
            push cx     
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
            
            mov ID_Value,dl
            mov al,dl
            mov dl,03
            mul dl
            sub al,03
            
            mov ah,0
            
            mov si, ax
                       
            mov bx,0
            mov bl,Arr[si]
            inc si
            mov bh,Arr[si]
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
            
main endp