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
            
grades         db   3,9,' ',6,3,' ',,8,1,' ', 

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
                    
labx:
            cmp ID[2][si], 029h     ; Compare Bl With Ascii Value of 01
            jle end_2
            inc si        
            loop labx
            
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
            
laby:       
            cmp ID[2][si], 039h     ; Compare Bl With Ascii Value of 09   
            jg end_2
            inc si 
            loop laby     
            
            
            mov si, 0
            mov ch, 0                        
            mov cl,ID_Length
            
            ; convert the 'char digit' to 'intger digit' by sub 48 from it  
labz:  
            mov dl, ID[2][si]
            sub dl,48
            mov ID[2][si], dl
            inc si
            loop labz
            
            jmp dowork_2
         

end_2:
                      mov ax, @data
            mov ds, ax
            mov ah, 09h
            lea dx, Exit_Msg
            int 21h
            mov ah,0x4C     ;DOS "terminate" function
            int 0x21

dowork_2:     
            ; Get the Exact ID's index according to our gradesay of bytes
            mov ax,1
            mov cl,ID_Length
            mov ch,0
            mov bl,10
            
                
            cmp cl,1
            je labb
            sub cl,1
            
            ; 10^x, to transfer the "string" input to real integer value
            push cx     
        laba:
            mul bl
            loop laba
           
            pop cx
            inc cx
             
        labb:    
            mov si,0
            mov dx ,0
           
            ; calculate the ID by multiply each index by 10 power it's weight value
        get_id_2:
            push ax
            mul ID[2][si]
            
            add dl,al
            pop ax
            div bl
            inc si
        
            loop get_id_2
            
            mov ID_Value,dl
            mov al,dl
            mov dl,03
            mul dl
            sub al,03
            
            mov ah,0
            
            mov si, ax
                       
            mov bx,0
            mov bl,grades[si]
            inc si
            mov bh,grades[si]
            jmp end_2
            
            
            
        
        end_2:
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