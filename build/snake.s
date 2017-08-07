    .align 2
    .global main
main:
    ldr r13, .STACK_START
    b start
.STACK_START:
    .word 0x0203FFF0
end:
    b end
start:
    mov r0, #0x400
    add r0, r0, #3
    mov r1, #0x04000000
    strh r0, [r1]
    mov r11, #4
    mov r10, #2
    mov r9, #2
    eor r0, r0, r0
    mov r1, #0x02000000
    mov r2, #((12 / 2 + 1) << 16)
LS_START1:
    orr r3, r2, #(12 / 2 + 1)
    str r3, [r1], #4
    stmfd r13!, {r0-r3}
    mov r0, r2, lsr #16
    mov r1, #(12 / 2 + 1)
    mov r2, #0xff
    add r2, r2, #0xef00
    bl drawSmallTile
    ldmfd r13!, {r0-r3}
    add r0, r0, #1
    cmp r0, r11
    beq LE_START1
    sub r2, r2, #0x10000
    b LS_START1
 LE_START1:
    b end
drawSmallTile:
    stmfd r13!, {lr}
    bl getTilePos
    orr r5, r2, r2, lsl #16
    add r0, r0, #480
    eor r1, r1, r1
LS_drawSmallTile1:
    mov r3, r0
    lsl r2, r2, #16
    str r2, [r3]
    lsr r2, r2, #16
    eor r4, r4, r4
LS_drawSmallTile2:
    add r3, r3, #4
    str r5, [r3]
    add r4, r4, #1
    cmp r4, #(8 / 2 - 2)
    bne LS_drawSmallTile2
LE_drawSmallTile2:
    add r3, r3, #4
    str r2, [r3]
    add r0, r0, #480
    add r1, r1, #1
    cmp r1, #(8 - 2)
    bne LS_drawSmallTile1
LE_drawSmallTile1:
    ldmfd r13!, {lr}
    bx lr
getTilePos:
    sub r0, r0, #1
    sub r1, r1, #1
    ldr r3, .START_POS
    rsb r1, r1, r1, lsl #4
    lsl r0, r0, #4
    add r0, r0, r1, lsl #8
    add r0, r0, r3
    bx lr
.START_POS:
    .word 0x06000000 + (240 - (8 * 12)) / 2 * 2 + (160 - (8 * 12)) / 2 * 240 * 2
