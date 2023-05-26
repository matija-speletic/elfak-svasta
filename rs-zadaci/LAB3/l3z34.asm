;3. Odrediti maksimalan element u nizu zadatom na lokaciji niz, pri ~emu je broj elemenata
;dat na lokaciji broj . Elementi niza su 16-bitni. 
;4. Odrediti minimalan element u nizu zadatom na lokaciji niz, pri ~emu je broj elemenata
;dat na lokaciji broj. Elementi niza su 16-bitni. 

data segment
    NIZ Dw 120,11,45,104,77,5,210,32,47
    N DB 9
    MINEL DW ?
    MAXEL DW ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV CL, N
    MOV CH, 0
    DEC CX
    XOR SI, SI
    ADD SI, 2
    MOV AX, NIZ
    MOV BX, AX

    petlja:
        MOV DX, NIZ[SI]
        
        CMP AX, DX
        JAE ispod1
            MOV AX, DX
        ispod1:
        
        CMP BX, DX
        JBE ispod2
            MOV BX, DX
        ispod2:

        ADD SI, 2
    LOOP petlja

    MOV MINEL, BX
    MOV MAXEL, AX
        
    mov ah, 4ch
    int 21h
code ends
end start