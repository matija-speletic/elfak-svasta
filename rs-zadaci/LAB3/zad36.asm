;Dva niza, saberi svaki el sa svakim, nadji min i max
;jedan se zavrsava nulom - tu stani
;zameni im mesta

data segment
    NIZ1 DW 0ABCh, 175h, 220Fh, 345Ah, 0F18h, 0
    NIZ2 DW 0BCDh, 2444h, 55AAh, 123h, 458Bh, 0ABh
    MINEL DW ?
    MAXEL DW ?
    IMIN DW ?
    IMAX DW ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV SI, 0

    petlja:
        CMP NIZ1[SI], 0
        JE ispod

        MOV DX, NIZ2[SI]
        ADD NIZ1[SI], DX
        add si, 2
    JMP petlja
    ispod:

    MOV AX, NIZ1
    MOV BX, AX
    MOV SI, 2
    petlja2:
        CMP NIZ1[SI], 0
        JE kraj
        CMP AX, NIZ1[SI]
        JAE neGr1
            MOV AX, NIZ1[SI]
            MOV CX, SI
            MOV IMAX, CX
        neGr1:

        CMP BX, NIZ1[SI]
        JBE neGr2
            MOV BX, NIZ1[SI]
            ;MOV CX, SI
            MOV IMIN, SI
        neGr2:

        add si, 2
    JMP petlja2
    kraj:

    MOV CX, IMIN
    MOV SI, CX
    MOV NIZ1[SI], AX
    MOV CX, IMAX
    MOV SI, CX
    MOV NIZ1[SI], BX

        
    mov ah, 4ch
    int 21h
code ends
end start
