;5. Odrediti broj pojavljivanja broja 25 u nizu elemenata, zadatom na lokaciji niz i zameniti
;sva ta pojavljivanja brojem 50. Elementi niza su 16-bitni.

data segment
    NIZ Dw 0ABCh,25,0A36h,25,25,893h, 0FFFFh
    N DB 7
    BR DB ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    XOR SI, SI
    MOV cl, N
    XOR CH, CH
    XOR BL, BL

    petlja:
        MOV AX, NIZ[SI]
        CMP AX, 25
        JNE ispod
            INC BL
            MOV NIZ[SI], 50
        ispod:
        ADD SI, 2
    LOOP petlja

    MOV BR, BL
        
    mov ah, 4ch
    int 21h
code ends
end start