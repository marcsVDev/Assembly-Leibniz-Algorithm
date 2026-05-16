section .data 
    cls db "clear", 0
    pmsg db "PI: %f", 10, 0
    one dq  1.0
    qua dq  4.0
    pi dq   0.0
    i dq    0

section .text
    global main
    extern printf
    extern system

main: 
    call loop

    mov RAX, 0x3c
    xor RDI, RDI
    syscall

loop:
    ; clear terminal
    mov RDI, cls
    xor RAX, RAX
    call system
    
    ; printf
    movsd XMM0, [pi]
    movsd XMM1, [qua]
    mulsd XMM1, XMM0
    movsd XMM0, XMM1

    mov RDI, pmsg
    mov RAX, 1          
    call printf
 
    ; term: 1.0 / (2 * i + 1)
    mov RAX, [i]
    mov RBX, 0x02
    mul RBX
    add RAX, 0x01

    cvtsi2sd XMM0, RAX ; convert

    movsd XMM1, [one]
    divsd XMM1, XMM0 ; term: XMM1

    mov RAX, 0x01
    and RAX, [i]

    cmp RAX, 0x01
    je odd

    movsd XMM0, [pi]
    addsd XMM0, XMM1
    movsd [pi], XMM0
 
    add qword [i], 0x01
    jmp loop
 
 odd:    
    movsd XMM0, [pi]
    subsd XMM0, XMM1
    movsd [pi], XMM0
    
    add qword [i], 0x01
    jmp loop
