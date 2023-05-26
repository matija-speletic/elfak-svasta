name 32bit24bitpreko8bit
data segment
    a dd 01234567ch
    b dd 0fah
    rez dd ?
    rezp db ?
data ends
code segment
assume ds:data,cs:code
start:
    mov ax, data
    mov ds,ax

    mov ax, word ptr a
    mov bx, word ptr b
    add ax,bx
    mov bx, word ptr a+1
    mov cx, word ptr b+1
    adc cx,bx
    mov bl,0
    adc bl,0
    mov word ptr rez,ax
    mov word ptr rez+1,cx
    mov rezp,bl

    mov ah,4ch
    int 21h
code ends
end start