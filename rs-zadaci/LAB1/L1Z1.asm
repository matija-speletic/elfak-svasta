; Napisati asemblerski program za sabiranje dva osmobitna broja na memorijskim lokacijama podatak1 i podatak2 i rezultat smestiti na memorijsku lokaciju rezultat
name zad1
data segment
    ;PRIMER SA IZLAZNIM PRENOSOM
        podatak1 db 0abh
        podatak2 db 0ffh
    ;PRIMER BEZ IZLAZNOG PRENOSA
        ;podatak1 db 12h
        ;podatak2 db 0abh
    rezultat dw 0
data ends
code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    mov al, podatak1
    mov bl, podatak2
    add al,bl
    mov ah,0
    adc ah,0
    mov rezultat,ax
    mov ax, 4c00H
    int 21h
code ends
end start