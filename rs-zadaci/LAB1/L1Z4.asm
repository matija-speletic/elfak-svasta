;Napisati asemblerski program za sabiranje sadr`aja registara AX i CX i rezultat smestiti na memorijsku lokaciju rezultat. 
name zad4
data segment
    rezultat dd 0
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    ;PRIMER SA IZLAZNIM PRENOSOM
        mov ax,0ababh
        mov cx,0fffeh
    add ax,cx
    mov cl,0
    adc cl,0
    mov word ptr rezultat,ax
    mov byte ptr rezultat+2,cl
    mov ax,4c00h
    int 21h
code ends
end start