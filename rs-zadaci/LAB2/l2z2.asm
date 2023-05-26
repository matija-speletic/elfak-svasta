;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati
;izraz
; (BR1 + BR3)* (BR3 + BR4)/BR5
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni

data segment
    BR1 DB 86
    BR2 DB 150
    BR3 DW 1504
    BR4 DW 180
    BR5 DB 250
    REZ DD 0
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV CL, BR1
    MOV AX, BR3
    ADD AL, CL
    ADC AH, 0

    MOV CX, BR3
    MOV BX, BR4
    ADD BX, CX

    MUL BX
    MOV CL, BR5
    MOV CH, 0
    DIV CX

    mov ah, 4ch
    int 21h
code ends
end start