;Napisati asemblerski program za sabiranje zadatog 
;{esnaestobitnog broja na memorijskoj lokaciji podatak1 
;i sadr`aja registra CX i rezultat smestiti na memorijsku
;lokaciju rezultat
name zad2
data segment
    ;PRIMER SA IZLAZNIM PRENOSOM
        br1 dw 0efefh
        br2 dw 0ffefh
    ;PRIMER BEZ IZLAZNOG PRENOSA
        ;br1 dw 0abcdh
        ;br2 dw 1234h
    rezultat dw 0
    rezbit17 db 0 ;17ti bit - izlazn prenos
data ends
code segment
assume ds:data
start:
    mov ax,data
    mov ds,ax
    mov ax, br1
    mov bx, br2
    add ax,bx
    mov bl, 0
    adc bl,0
    mov rezultat, ax
    mov rezbit17,bl
    mov ax,4c00h
    int 21h
code ends
end start