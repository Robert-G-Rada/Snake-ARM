FUNC_START:
    // turn on video mode 3 and BG2
    mov     r0, #0x400
    add     r0, r0, #3
    mov     r1, #REG_DISPCNT
    strh    r0, [r1]
    
    mov     r11, #4             // load snake_size
    mov     r10, #DIR_RIGHT     // load new_direction
    mov     r9, #DIR_RIGHT      // load direction
    
    // load snake tile positions
    // r0 = loop counter
    eor     r0, r0, r0
    mov     r1, #SNAKE_HEAD
    mov     r2, #((WINDOW_WIDTH / 2 + 1) << 16)
    mov     r3, #(WINDOW_HEIGHT / 2 + 1)
    
LS_START1:
    orr     r4, r2, r3
    str     r4, [r1], #4
    // TO DO: DRAW SNAKE TILE
    
    add     r0, r0, #1
    cmp     r0, r11
    beq     LE_START1
    
    mov     r4, #0x10000
    add     r2, r2, r4
    b       LS_START1
    
 LE_START1:
    b       FUNC_END
    