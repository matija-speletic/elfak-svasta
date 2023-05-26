name mul3232
data segment
    b1 dd 11111111h
    b2 dd 0f111f111h
    pr dw 4 dup (?)
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds,ax

    mov ax, word ptr b1
    mul  word ptr b2
    mov pr, ax
    mov pr+2, dx

    mov ax, word ptr b1
    mul word ptr b2+2
    add pr+2, ax
    adc dx, 0 ;nema prob jer se max dobije fffe za dx
    mov pr+4, dx

    mov ax, word ptr b1+2
    mul word ptr b2+2
    add pr+2,ax
    adc pr+4, dx
    mov ax, 0
    adc ax, 0
    mov pr+6,ax

    mov ax, word ptr b1+2
    mul word ptr b2+2
    add pr+4,ax
    adc pr+6,dx
code ends
end start