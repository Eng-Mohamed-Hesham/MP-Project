printArray proc


mov bx,0000h
printArray:
mov dx,0000h
mov ah, 02h
mov dl,byte ptr[si+bx]
call valueinArray
cmp flag,1
int 21h
mov dl, 20h
int 21h
add bx, 1
add cl, 1
cmp cl,15
jz nextRow
jnz printArray