include 'EMU8086.INC'
.model small
.stack 100
.data 

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
    
    mov ah,4ch
    int 21h
end