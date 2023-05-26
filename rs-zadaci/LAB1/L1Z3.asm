;Napisati asemblerski program za sabiranje zadatog osmobitnog broja na memorijskoj lokaciji podatak1 i sadr`aja registra CX i rezultat smestiti na memorijsku lokaciju rezultat. 
name zad2
data segment
    broj db 0abh
    rezultat dw 0
    rez17bit db 0
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov cx,0ffffh ;primer sa izlaznim i medju- prenosom
    ;mov cx,12ffh ;primer sa medjuprenosom
    ;mov cx,1211 ;primer bez prenosa
    mov al,broj
    add cl,al
    adc ch,0;medjuprenos
    mov al,0
    adc al,0;izlazni prenos
    mov rezultat,cx
    mov rez17bit,al;upis izlaznog prenosa
    mov ax,4c00h
    int 21h
code ends
end start