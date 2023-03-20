li      20
mov     rA, rM

li      0

Loop1:
mov     r0, rM
sb      r0

li      1
mov     rX, r0
mov     rY, rM
add     rZ

mov     rM, rZ

mov     rX, rZ
mov     rY, rA
sbflt
b       $Loop1

done