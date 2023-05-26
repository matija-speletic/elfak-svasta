;2. Odrediti zbiru elemenata niza zadatog na memorijskoj adresi niz32, pri ~emu je broj
;elemenata niza dat na lokaciji broj. Elementi niza su 32-bitni. Zbir elemenata treba smestiti na
;memorijskoj adresi zbir

data segment
    NIZ DD 0FFFFFFFFh,0F4FF3h,0DCBAE71h,0FEABCD24h
    N DB 4
    ZBIR DW 3 DUP(?)
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    ;DX:BX:AX <- REZULTAT
    XOR AX, AX
    XOR BX, BX
    XOR DX, DX
    MOV CL, N
    MOV CH, 0
    MOV SI, 0

    petlja:
        ADD AX, WORD PTR NIZ[SI]
        ADC BX, WORD PTR NIZ[SI+2]
        ADC DX, 0
        ADD SI, 4
    LOOP petlja

    MOV ZBIR, AX
    MOV ZBIR+2, BX
    MOV ZBIR+4, DX
        
    mov ah, 4ch
    int 21h
code ends
end start