li      17
mov     rX, rM
lsl     rX, 1
li      0
mov     r0, rM
mov     rM, rX
sb      r0

li      2
mov     rY, rM
lsl     rX

li      1
mov     r0, rM
mov     rM, rX
sb      r0

lsr     rX, 3

li      2
mov     r0, rM
mov     rM, rX
sb      r0

done