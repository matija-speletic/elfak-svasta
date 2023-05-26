name random
data segment
    dw br1 4c8h
    dw br2 1aabh
    dw rez ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax,data
    mov ds,ax

    mov ax,br1
    mov bx br2
    add ax,bx
    mov rez,ax