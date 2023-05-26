;1. Odrediti zbir elemenata niza 16-bitnih elemenata zadatog na memorijskoj adresi niz, pri
;~emu je dato da se niz zavr{ava elementom “#”. Elementi niza su 16-bitni. Istovremeno treba
;odrediti i broj elemenata niza koji se nalaze izme|u dekadnih brojeva 5  i 77. Zbir elemenata i
;tra`eni broj elemenata treba smestiti na memorijske adrese zbir i broj. 

data segment
    NIZ1 DW 0FFFFh,43,71,24, 83FFh, 9765h, 7777h, 3547h, 0FEFEh, '#'
    ZBIR DD ?
    NUM DW ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    XOR AX, AX
    XOR DX, DX
    XOR BX, BX
    LEA SI, NIZ1

    ;while(niz(i)!='#')
    petlja1:
        MOV CX, WORD PTR [SI]
        CMP CX, '#'
        JE kraj1
        ADD AX, CX
        ADC DX, 0
        ADD SI, 2

        ;if(cx>5&&cx<77) bx++;
        CMP CX, 5
        JBE kraj2
        CMP CX, 77
        JAE kraj2
            INC BX
        kraj2:
        JMP petlja1
    kraj1:

    MOV WORD PTR ZBIR, AX
    MOV WORD PTR ZBIR+2, DX
    MOV NUM, BX
        
    mov ah, 4ch
    int 21h
code ends
end start