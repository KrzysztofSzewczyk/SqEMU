; Subleq emulator in asm2bfv1b
; Copyright (C) by Krzysztof Palaiologos Szewczyk
; Licensed under MIT license.

org 0
stk 1

; Application entry point (1).
lbl 1
    ; Read cell 0 from memory
    mov r2, 0
    rcl r1, r2

    ; If the cell is equal to zero, jump to 2 (read)
    mov r2, 2
    jz_ r1, r2

    ; Else, jump to 4 (execute)
    jmp 4
lbl 2
    ; Ensure that r4 is 1.
    inc r4, 1

    ; Trash all the registers here.
    in_ r1
    mov r3, r1

    ; Nothing to read, jump to 5 (end)
    mov r2, 5
    jz_ r1, r2
lbl 3
    ; Start reading. Current index: r1
    ; First, check is r1 equal to 0. If so, go to 4 (execute).
    mov r2, 4
    jz_ r1, r2
    
    ; Note that reading is done in inverse order.
    in_ r2
    sto r2, r1

    ; Decrement r1 and loop
    dec r1
    jmp 3
lbl 4
    ; Execution loop.
    ; If r4 is equal to 1, we need to reverse the memory.
    ; R3 is keeping copy of ending index.
    ; R2 contains some crap now.
    ; R1 is equal to zero.

    inc r1
    eq_ r1, r4
    
    ; Now, r1 is 0 if there is nothing to change.
    mov r2, 6
    jz_ r1, r2
    clr r4
    jmp 7
lbl 5
    end
lbl 6
    ; Normal execution of code.
    ; Let's assume all registers are trashed now.

    ; while(ip <= 0)
    clr r4
    mov r3, 8
    le_ r4, r1
    jnz r3
    jmp 5
lbl 7
    ; Reverse memory from 0 to r3 and jump to 6.
    
    ; r4 = current start index
    ; r3 = current end index
    ; r2 and r1 are spare!

    rcl r1, r4
    rcl r2, r3
    swp r1, r2
    sto r1, r4
    sto r2, r3

    ; So now two values are swapped.
    ; First, check difference between r3 and r4.
    ; Whenever it's 1, swapping finished.
    ; If it's bigger, increment r4 and decrement r3

    mov r4, r2
    mov r3, r1
    sub r1, r2
    mov r2, 1

    ; Now r1 is 1 or bigger
    eq_ r1, r2

    ; If r1 is 1, done reversing.
    mov r2, 6
    jnz r1, r2
    jmp 7

lbl 8
    ; Main execution loop
    ; r1 - IP

    ; r2 = a
    rcl r2, r1
    inc r1

    ; r3 = -1
    clr r3
    dec r3

    ; r4 = lbl 9
    mov r4, 9

    ; A = -1?
    eq_ r3, r2
    jnz r3, r4

    ; Let's check for B
    rcl r3, r1
    inc r1
    clr r4
    dec r4
    eq_ r4, r3
    mov r3, 10
    jnz r4, r3

    ; We are here for C.
    
    ; Point context A
    dec r1
    dec r1
    rcl r2, r1
    inc r1
    rcl r3, r1
    sub r3, r2

    ; Only r3 is needed now.
    clr r4
    mov r3, 11
    le_ r4, r3
    
    ; Critical point, increment r1 (don't forget about it, we need to point C!)
    inc r1

    ; Continue the jump
    jnz r3

    ; No branches, loop!
    jmp 6

lbl 9
    ; load context B
    rcl r2, r1
    inc r1

    ; Print it out
    out r2

    ; Increment (to point context C)
    inc r1
    jmp 8

lbl 10
    ; point context A
    dec r1

    ; read and load to context A
    in_ r2
    sto r1, r2

    ; point context B
    inc r1

    ; Increment (to point context C)
    inc r1
    jmp 8

lbl 11
    ; r1 = [r1], when r1 points C.
    rcl r4, r1
    mov r1, r4
    jmp 8
    
