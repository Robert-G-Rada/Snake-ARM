    .align 2
    .global main
main:
    ldr     r13, .STACK_START
    b       start
.STACK_START:
    .word   0x0203FFF0
end:
    b       end
    
#include "util.h"
#include "game.s"
#include "draw.s"
