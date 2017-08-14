    .align 4
    .global main
main:
    ldr     r13, .STACK_START
    eor     r12, r12, r12
    b       start
.STACK_START:
    .word   0x0203FFF0
    
#include "util.h"
#include "game.s"
#include "draw.s"
