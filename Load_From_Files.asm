include 'EMU8086.INC'
.model small
.stack 100
.data 
    buff        db  26        ;MAX NUMBER OF CHARACTERS ALLOWED (25).
            db  ?         ;NUMBER OF CHARACTERS ENTERED BY USER.
            db  26 dup(0) ;CHARACTERS ENTERED BY USER.
    fname1 dw "Grades.txt",0
    text db 100  dup(0)     
    fhand dw ?
    var dw ?
    num  dw  410   ; <----- See below
    numS db  6 dup(' '),'$'
.code
    mov ax,@data
    mov ds,ax

    mov ah,3dh
    mov al,0
    MOV DX, OFFSET(fname1)
    ;lea dx,fname1
    int 21h
    mov fhand, ax
    mov si,0
L:                                                      

    mov ah,3fh
    mov bx,fhand
    mov cx,1 
    ;mov dx, offset text+si
    lea dx,text[si]
    int 21h
    cmp ax,0
    JE EXIT
    INC SI
    JMP L

EXIT:

    MOV byte PTR text[si],"$"
    MOV AH,3EH
    INT 21H

    mov ah,9
    lea dx,text
    int 21h  
    printn ""    
    
    ; /* edit in array */
    
           
 ; /* take input */ ;
 
 
;CAPTURE STRING FROM KEYBOARD.                                    
    mov ah, 0Ah ;SERVICE TO CAPTURE STRING FROM KEYBOARD.
    mov dx, offset buff
    int 21h                 

;CHANGE CHR(13) BY '$'.
    mov si, offset buff + 1 ;NUMBER OF CHARACTERS ENTERED.
    mov cl, [ si ] ;MOVE LENGTH TO CL.
      
      
 ; /* Add input in array */ ;
    mov al, buff[2]
    mov text[0], al
    mov al, buff[3]
    mov text[1], al
    printn ""  
    printn ""
    mov ah,9
    lea dx,text
    int 21h
    
    
    xor ax, ax
    mov al, text[0]
    sub ax, 48
    
    mov bx, 10         
    mov si, offset numS+5
    
    cmp ax,0
    jge next
 next:  
    mov dx,0
    div bx
    add dl, 30h
    mov [si],   dl
    dec si
    cmp ax, 0
    jne next
    
    cmp num,0
    jge sof
    mov byte ptr[si],   '-'
    dec si
    
sof:
    inc si
    mov ah, 9
    mov dx, si
    int 21h
    
    mov ah,4ch
    int 21h
end