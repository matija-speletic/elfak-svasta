;sabiranje 3 16bit broja sacuvanih u memorii, rezultat sacuvati u memoriji

name sab3br
data segment
    BR1 DW 0FFFAh
    BR2 DW 0FCFCh
    BR3 DW 0ABCDh

    REZ DW ?
    REZP DB ?
data ends
code segment
    assume CS:code, DS:data
start:
    MOV AX,data
    MOV DS,AX

    MOV AX,BR1
    MOV BX,BR2
    ADD AX,BX
    MOV CL,0
    ADC CL,0
    MOV BX,BR3
    ADD AX,BX
    ADC CL,0
    MOV REZ,AX
    MOV REZP,CL

    MOV AH,4Ch
    INT 21h
code ends
end start