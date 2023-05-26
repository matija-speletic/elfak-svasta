;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati
;izraz
; (BR1 - BR2)/BR3 + BR4*BR5
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni

data segment
    BR1 DB 10
    BR2 DB 25
    BR3 DW 3
    BR4 DW -8
    BR5 DB 3
    REZ DD 0
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AL, BR2
    CBW
    MOV CX, AX 
    MOV AL, BR1
    CBW
    SUB AX, CX

    CWD
    IDIV BR3
    MOV CX, AX
    
    MOV AL, BR5
    CBW
    IMUL BR4

    ADD AX, CX
    ADC DX, 0; ne sme, mora i cx da se konvertuje u 32bit, ali ovde ne treba

    mov ah, 4ch
    int 21h
code ends
end start