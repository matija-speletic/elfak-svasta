;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati
;izraz
; (BR1 + BR3)* (BR3 + BR4)/BR5
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni

data segment
    BR1 DB -32
    BR2 DB -47
    BR3 DW -15
    BR4 DW -30
    BR5 DB -5
    REZ DD 0
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AL, BR5
    CBW
    MOV CX, AX

    MOV AL, BR1
    CBW
    ADD AX, BR3
    MOV BX, AX

    MOV AX, BR3
    ADD AX, BR4

    IMUL BX

    IDIV CX

    mov ah, 4ch
    int 21h
code ends
end start