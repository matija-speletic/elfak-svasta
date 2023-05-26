;(BR1 - BR3*BR4)/(BR4 - BR5*BR2)
;3 i 4 su 16bit, ostali su 8bit 

data segment
    BR1 DB 10
    BR2 DB -12
    BR3 DW -27
    BR4 DW 50
    BR5 DB 21
    ;4 sa ostatkom 98
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AL, BR1
    CBW
    CWD
    MOV CX, DX
    MOV BX, AX

    MOV AX, BR3
    IMUL BR4

    SUB BX, AX
    SBB CX, DX

    MOV AL, BR5
    IMUL BR2

    MOV DX, BR4
    SUB DX, AX

    MOV AX, BX
    MOV BX, DX
    MOV DX, CX
    IDIV BX

    mov ah, 4ch
    int 21h
code ends
end start