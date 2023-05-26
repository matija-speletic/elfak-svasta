;1.zbir el u nizu od k el
;2. zbir el u nizu do 0 

data segment
    NIZ DW 0FFFFh, 83, 9765,7777,3547,0, 7FE8h
    K DB 7
    REZ1 DD ?
    REZ2 DD ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

;1.
    MOV SI, 0
    XOR AX, AX
    XOR DX, DX
    MOV CL, K
    MOV CH, 0

    petlja1:
        ADD AX, NIZ[SI]
        ADC DX, 0
        ADD SI, 2
    LOOP petlja1

    MOV WORD PTR REZ1, AX
    MOV WORD PTR REZ1+2, DX

;2.
    LEA SI, NIZ-2
    XOR AX, AX
    XOR DX, DX
    MOV CL, K
    MOV CH, 0

    petlja2:
        ADD SI, 2
        ADD AX, [SI]
        ADC DX, 0
        CMP WORD PTR [SI], 0
    LOOPNE petlja2

    MOV WORD PTR REZ2, AX
    MOV WORD PTR REZ2+2, DX

    mov ah, 4ch
    int 21h
code ends
end start