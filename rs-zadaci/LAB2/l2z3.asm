;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati
;izraz
; BR1 + (BR3* BR4) - BR2/BR5
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni 


data segment
    BR1 DB 250
    BR2 DB 250
    BR3 DW 41943
    BR4 DW 25
    BR5 DB 2
    REZ DD 0
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AL, BR2
    MOV AH, 0
    DIV BR5
    MOV CL, AL
    MOV CH, 0

    MOV AX, BR3
    MUL BR4

    MOV BL, BR1
    MOV BH, 0
    ADD AX, BX
    ADC DX, 0
    SUB AX, CX
    SBB DX, 0

    mov ah, 4ch
    int 21h
code ends
end start