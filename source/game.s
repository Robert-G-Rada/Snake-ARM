start:
    // turn on video mode 3 and BG2
    // INPUT: NULL
    // OUTPUT: NULL
    // USED: r0-r3, r9-r11
    
    mov     r0, #0x400
    add     r0, r0, #3
    mov     r1, #REG_DISPCNT
    strh    r0, [r1]
    
    bl      drawBorder
    
    mov     r11, #4             // load snake_size
    mov     r10, #DIR_RIGHT     // load new_direction
    mov     r9, #DIR_RIGHT      // load direction
    
    // load snake tile positions
    // r0 = loop counter
    eor     r0, r0, r0
    mov     r1, #SNAKE_HEAD
    mov     r2, #((WINDOW_WIDTH / 2 + 1) << 16)
    
LS_START1:
    orr     r3, r2, #(WINDOW_HEIGHT / 2 + 1)
    str     r3, [r1], #4
    
    stmfd   r13!, {r0-r3}
    mov     r0, r2, lsr #16
    mov     r1, #(WINDOW_HEIGHT / 2 + 1)
    mov     r2, #0xff
    add     r2, r2, #0xef00
    bl      drawSmallTile
    ldmfd   r13!, {r0-r3}
    
    add     r0, r0, #1
    cmp     r0, r11
    beq     LE_START1
    
    sub     r2, r2, #0x10000
    b       LS_START1
LE_START1:
 
GAME_LOOP:
    mov     r1, #0x04000000
    add     r1, r1, #6
    ldrh    r0, [r1]
    cmp     r0, #160
    bhs     GAME_LOOP
WAIT_VBLANK:
    ldrh    r0, [r1]
    cmp     r0, #160
    blo     WAIT_VBLANK

// END START
    
update:

checkInput:
    mov     r1, #0x04000000
    add     r1, r1, #0x130
    ldrh    r0, [r1]
    mvn     r0, r0
    
    and     r2, r0, #KEY_UP
    cmp     r2, #KEY_UP
    bne     ELSE_UPD_1
    cmp   r9, #DIR_DOWN
    movne   r10, #DIR_UP
ELSE_UPD_1:
    and     r2, r0, #KEY_DOWN
    cmp     r2, #KEY_DOWN
    bne     ELSE_UPD_2
    cmpeq   r9, #DIR_UP
    movne   r10, #DIR_DOWN
ELSE_UPD_2:    
    and     r2, r0, #KEY_RIGHT
    cmp     r2, #KEY_RIGHT
    bne     ELSE_UPD_3
    cmpeq   r9, #DIR_LEFT
    movne   r10, #DIR_RIGHT
ELSE_UPD_3:    
    and     r2, r0, #KEY_LEFT
    cmp     r2, #KEY_LEFT
    bne     ELSE_UPD_4
    cmpeq   r9, #DIR_RIGHT
    movne   r10, #DIR_LEFT
ELSE_UPD_4:
// END CHECK INPUT
    
    add     r12, r12, #1
    cmp     r12, #MAX_COUNT
    blo     GAME_LOOP
    eor      r12, r12, r12
// END update
move: 
    // erase last tile
    mov     r5, #SNAKE_HEAD
    add     r5, r5, r11, lsl #2
    ldrh    r0, [r5, #(-2)]
    ldrh    r1, [r5, #(-4)]
    eor     r2, r2, r2
    bl      drawTile
    
    // move tiles
    mov     r0, r11
LS_MOVE1:
    ldr     r1, [r5, #(-4)]
    str     r1, [r5]
    sub     r5, r5, #4
    subs    r0, r0, #1
    bne     LS_MOVE1
LE_MOVE1:

    mov     r9, r10
    mov     r1, #SNAKE_HEAD
    
    cmp     r9, #DIR_UP
    bne     ELSE_MOVE1
    ldrh    r0, [r1]
    sub     r0, r0, #1
    strh    r0, [r1]
ELSE_MOVE1:
    cmp     r9, #DIR_DOWN
    bne     ELSE_MOVE2
    ldrh    r0, [r1]
    add     r0, r0, #1
    strh    r0, [r1]
ELSE_MOVE2:
    cmp     r9, #DIR_RIGHT
    bne     ELSE_MOVE3
    ldrh    r0, [r1, #2]
    add     r0, r0, #1
    strh    r0, [r1, #2]
ELSE_MOVE3:
    cmp     r9, #DIR_LEFT
    bne     ELSE_MOVE4
    ldrh    r0, [r1, #2]
    sub     r0, r0, #1
    strh    r0, [r1, #2]
ELSE_MOVE4:

    // draw new tile
    ldr     r0, [r1]
    mov     r1, r0, lsl #16
    lsr     r1, r1, #16
    lsr     r0, r0, #16
    mov     r2, #0xef00
    add     r2, r2, #0xff
    bl      drawSmallTile

    b       GAME_LOOP
// END move
end:
    b       end
    