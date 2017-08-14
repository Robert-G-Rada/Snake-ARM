drawSmallTile:
    // INPUT: r0, r1, r2 (x, y, color)
    // OUTPUT: NULL
    // CHANGES: r0-r5
    
    stmfd   r13!, {lr}
    bl      getTilePos
    
    orr     r5, r2, r2, lsl #16 // r5 = value of 2 pixels
    add     r0, r0, #480
    eor     r1, r1, r1      // r1 = loop counter
    
LS_drawSmallTile1:
    mov     r3, r0          // r3 = cursor
    lsl     r2, r2, #16
    str     r2, [r3]
    lsr     r2, r2, #16
    
    eor     r4, r4, r4      // r4 = loop 2 counter
LS_drawSmallTile2:
    add     r3, r3, #4
    str     r5, [r3]
    add     r4, r4, #1
    cmp     r4, #(TILE_SIZE / 2 - 2)
    bne     LS_drawSmallTile2
LE_drawSmallTile2:
    add     r3, r3, #4
    str     r2, [r3]
    add     r0, r0, #480
    
    add     r1, r1, #1
    cmp     r1, #(TILE_SIZE - 2)
    bne     LS_drawSmallTile1
LE_drawSmallTile1:
    
    ldmfd   r13!, {lr}
    bx      lr
// END drawSmallTile
    
getTilePos:
    // INPUT: r0, r1, 
    // OUTPUT: r0
    // CHANGES: r1, r3
    // returns WINDOW_POS + x * TILE_SIZE * 2 + y * TILE_SIZE * SCREEN_WIDTH * 2
    
    sub     r0, r0, #1
    sub     r1, r1, #1
    ldr     r3, .START_POS
    
    rsb     r1, r1, r1, lsl #4  
    lsl     r0, r0, #4          
    add     r0, r0, r1, lsl #8  // x * 16 + y * 256 * 15
    add     r0, r0, r3          // + WINDOW_POS
    bx      lr
    
.START_POS:
    .word   WINDOW_POS
// END getTilePos
    
drawTile:
    // INPUT: r0, r1, r2 (x, y, color)
    // OUTPUT: NULL
    // CHANGES: r0-r4
    
    stmfd   r13!, {lr}
    bl      getTilePos
    
    orr     r2, r2, r2, lsl #16 // r2 = value of 2 pixels
    eor     r1, r1, r1      // r1 = loop counter
    
LS_drawTile1:
    mov     r3, r0          // r3 = cursor
    eor     r4, r4, r4      // r4 = loop 2 counter
LS_drawTile2:
    str     r2, [r3], #4
    //add     r3, r3, #4
    add     r4, r4, #1
    cmp     r4, #(TILE_SIZE / 2)
    bne     LS_drawTile2
LE_drawTile2:
    add     r3, r3, #4
    add     r0, r0, #480
    
    add     r1, r1, #1
    cmp     r1, #(TILE_SIZE)
    bne     LS_drawTile1
LE_drawTile1:
    
    ldmfd   r13!, {lr}
    bx      lr
// END drawTile

drawBorder:
    stmfd   r13!, {lr}
    
    eor     r5, r5, r5      // r5 = loop counter
LS_drawBorder1:
    mov     r0, r5
    mov     r1, #0
    mov     r2, #31
    bl      drawTile
    
    mov     r0, r5
    mov     r1, #(WINDOW_HEIGHT + 1)
    mov     r2, #31
    bl      drawTile
LE_drawBorder1:
    add     r5, r5, #1
    cmp     r5, #(WINDOW_WIDTH + 1)
    bls     LS_drawBorder1
    
    eor     r5, r5, r5      // r5 = loop counter
LS_drawBorder2:
    mov     r0, #0
    mov     r1, r5
    mov     r2, #31
    bl      drawTile
    
    mov     r1, r5
    mov     r0, #(WINDOW_WIDTH + 1)
    mov     r2, #31
    bl      drawTile
LE_drawBorder2:
    add     r5, r5, #1
    cmp     r5, #(WINDOW_HEIGHT + 1)
    bls     LS_drawBorder2
    
    ldmfd   r13!, {lr}
    bx lr
// END drawBorder