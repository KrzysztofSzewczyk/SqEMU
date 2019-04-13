; Subleq emulator in asm2bfv1b
; Copyright (C) by Krzysztof Palaiologos Szewczyk
; Licensed under MIT license.
; Short version.

org 0
stk 1

lbl 1
    mov r2, 0
    rcl r1, r2
    mov r2, 2
    jz_ r1, r2
    jmp 4
lbl 2
    inc r4, 1
    in_ r1
    mov r3, r1
    mov r2, 5
    jz_ r1, r2
lbl 3
    mov r2, 4
    jz_ r1, r2
    in_ r2
    sto r2, r1
    dec r1
    jmp 3
lbl 4
    inc r1
    eq_ r1, r4
    mov r2, 6
    jz_ r1, r2
    clr r4
    jmp 7
lbl 6
    clr r4
    mov r3, 8
    le_ r4, r1
    jnz r3
    jmp 5
lbl 7
    rcl r1, r4
    rcl r2, r3
    swp r1, r2
    sto r1, r4
    sto r2, r3
    mov r4, r2
    mov r3, r1
    sub r1, r2
    mov r2, 1
    eq_ r1, r2
    mov r2, 6
    jnz r1, r2
    jmp 7
lbl 8
    rcl r2, r1
    inc r1
    clr r3
    dec r3
    mov r4, 9
    eq_ r3, r2
    jnz r3, r4
    rcl r3, r1
    inc r1
    clr r4
    dec r4
    eq_ r4, r3
    mov r3, 10
    jnz r4, r3
    dec r1
    dec r1
    rcl r2, r1
    inc r1
    rcl r3, r1
    sub r3, r2
    clr r4
    mov r3, 11
    le_ r4, r3
    inc r1
    jnz r3
    jmp 6
lbl 9
    rcl r2, r1
    inc r1
    out r2
    inc r1
    jmp 8
lbl 10
    dec r1
    in_ r2
    sto r1, r2
    inc r1
    inc r1
    jmp 8
lbl 11
    rcl r4, r1
    mov r1, r4
    jmp 8
lbl 5
    end
    
