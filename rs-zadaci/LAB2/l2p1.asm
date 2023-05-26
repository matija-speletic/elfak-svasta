;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati izraz
; (BR1 + BR2)*BR3 - BR4/BR5.
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni. 

data segment
    BR1 DB 17
    BR2 DB 150
    BR3 DW 150
    BR4 DW 24570
    BR5 DB 3
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
    MOV AX, BR4
    DIV CX
    MOV CX, AX

    MOV AL, BR1
    MOV AH, 0
    ADD AL, BR2
    ADC AH, 0

    MOV BX, BR3
    MUL BX

    SUB AX, CX
    SBB DX, 0

    mov ah, 4ch
    int 21h
code ends
end start