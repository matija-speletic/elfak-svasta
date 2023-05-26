;MIN MAX, BROJ IZMEDJU 10 I 100
data segment
    NIZ Dw 120,11,45,104,77,5,210,32,47
    N DB 9
    BR DB 0
    MINEL DW ?
    MAXEL DW ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    LEA SI, NIZ
    MOV AX, NIZ
    MOV BX, NIZ
    MOV CL, N
    XOR CH, CH
    XOR DX, DX
    petlja:
        MOV DX, [SI]
        CMP AX, DX
        JAE ispod1
            MOV AX, DX
        ispod1:
        CMP BX, DX
        JBE ispod2
            MOV BX, DX
        ispod2:

        CMP DX, 10
        JB ispod3
        CMP DX, 100
        JA ispod3
            INC BR
        ispod3:
        ADD SI, 2
    LOOP petlja

    MOV DL, BR
    XOR DH, DH
        
    mov ah, 4ch
    int 21h
code ends
end start