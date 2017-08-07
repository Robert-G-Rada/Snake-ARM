start:
    // turn on video mode 3 and BG2
    // INPUT: NULL
    // OUTPUT: NULL
    // USED: r0-r3, r9-r11
    
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
    b       end
    