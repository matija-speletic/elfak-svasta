;Za brojeve zadate na memorijskim lokacijama BR1, BR2, BR3, BR4 i BR5 izra~unati
;izraz
; BR1 + (BR3* BR4) - BR2/BR5
;BR3 i BR4 su 16-bitni, dok su BR1, BR2 je BR5 8-bitni 


data segment
    BR1 DB 125
    BR2 DB -120
    BR3 DW -0FFEh
    BR4 DW 0FFEh
    BR5 DB 2
    REZ DD 0
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV AX, 0FF77h
    CWD
    MOV CX, 0AFACh
    MOV BX, 0F999h
    SUB AX, CX
    SBB DX, BX

    mov ah, 4ch
    int 21h
code ends
end start