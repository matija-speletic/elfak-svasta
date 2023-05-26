;(-BR3+BR4*BR5/BR2)/BR1
;3 i 4 su 16bit, ostali su 8bit 

data segment
    BR1 DB 105
    BR2 DB -21
    BR3 DW -7FFFh ;-32767
    BR4 DW 7FFFh  ;32767
    BR5 DB -20
    ;261  i ostatak 1c
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AL, BR2
    CBW
    MOV BX, AX

    MOV AL, BR5
    CBW
    IMUL BR4

    IDIV BX
    CWD
    MOV BX, AX
    MOV CX, DX

    MOV AX, BR3
    NEG AX
    CWD

    ADD BX, AX
    ADC CX, DX
    MOV AL, BR1
    CBW
    MOV DX, CX
    MOV CX, AX
    MOV AX, BX
    IDIV CX

    mov ah, 4ch
    int 21h
code ends
end start