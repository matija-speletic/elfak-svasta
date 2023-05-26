;Napisati program na asemblerskom jeziku u kome se zbir dva osmobitna broja zadata na lokacijama BR1 i BR2 množi njihovom razlikom.
;(BR1-BR2)^3 / (BR1+BR2)^2

data segment
;PRIMER1 - program radi kako treba
    ;BR1 DB 10
    ;BR2 DB 7
    ;REZ1 DW ?
    ;REZ2 DW ?
    ;OST2 DW ?
    ;rezultat je 0, ostatak je 1Bh, upisuje se u memoriju

;PRIMER1.2 - program radi kako treba
    ;BR1 DB 30
    ;BR2 DB 3
    ;REZ1 DW ? ;37Bh
    ;REZ2 DW ?
    ;OST2 DW ?
    ;rezultat je 12h, ostatak je 51h

;PRIMER2 - ne radi kako treba jer izlazi iz opsega 8bit brojeva BR1+BR2
    BR1 DB 255
    BR2 DB 3
    REZ1 DW ?
    REZ2 DW ?
    OST2 DW ?
    ;program ne uspeva da se izvrsi do kraja
    ;dolazi do greske kod operacije deljenja

data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

;Prvi deo
    ;AL<-BR1+BR2
    MOV AL, BR1
    ADD AL, BR2

    ;BL<-BR1-BR2
    MOV BL, BR1
    SUB BL, BR2

    ;AX<-(BR1+BR2) * (BR1-BR2)
    MUL BL

    MOV REZ1, AX  ;upis u mem

;Drugi deo
    ;treba imati u vidu da je u BL vec sacuvano BR1-BR2

    ;DX:BX <- (BR1-BR2)^3
    MOV AL, BL
    MUL BL
    MOV BH, 0
    MUL BX
    MOV BX, AX

    ;CX <- (BR1+BR2)^2
    MOV AL, BR1
    ADD AL, BR2
    MOV CL, AL
    MUL CL
    MOV CX, AX

    ;AX <- (BR1-BR2)^3 / (BR1+BR2)^2,  DX <- ostatak
    MOV AX, BX
    DIV CX

    ;upis u mem
    MOV REZ2, AX
    MOV OST2, DX

    mov ah, 4ch
    int 21h
code ends
end start