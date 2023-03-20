# TODO: Write loop structure for 15 messages
    li  0                          # Load immediate 0 into rM
    mov r4, rM                     # 
    li  1                          # Load immediate 1 into rM
    mov r5, rM                     
    li  30
    mov r6, rM
Loop:
    # load message
    lb  r4                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r5                         # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]

    # reformat data bits
    # lower byte:
    mov rX, r0                      # load in lower bytes
    li  1                           # load 0001
    mov rY, rM
    and rX                          # extract d1
    lsl rW, 3                       # shift to correct position

    mov rX, r0                      # reload in lower bytes
    li  14                          # load 1110
    mov rY, rM
    and rX                          # extract d4, d3, d2
    lsl rX, 4                       # shift to correct position

    mov rY, rW                      # load d1
    or  rZ                          # gives us (d4)(d3)(d2)0(d1)000

    mov rA, rZ                      # save lower output byte to rA

    # higher byte:
    mov rX, r1                      # load in higher byte
    lsl rZ, 5                       # shift to correct position, gives us (d11)(d10)(d9)00000

    li  0xf                         # load in 1111
    mov rX, rM
    lsl rY, 4                       # immediate is now 11110000

    mov rX, r0                      # load in lower byte
    and  rX                         # extract d8, d7, d6, d5

    lsr rX, 3                       # shift to correct position, gives us 000(d8)(d7)(d6)(d5)0
    mov rY, rZ                      # load in d11, d10, d9
    or  rZ                          # gives us (d11)(d10)(d9)(d8)(d7)(d6)(d5)0

    mov rB, rZ                      # save higher byte in rB

    # Calculating for p8, p4, p2, p1, p0
    
    # p8
    mov rX, rB                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)0
    xrb rY                          # p8 = xor of the upper byte
    or  rZ
    mov rB, rZ                      # rB = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)

    # p4
    li  0b1111
    mov rX, rM
    lsl rY, 4                       # rY = 0b11110000
    
    mov rX, rB                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)(d10)(d9)(d8)0000
    xrb rW                          # xor byte rX into rW

    mov rX, rA                      # rX = (d4)(d3)(d2)0(d1)000
    and rX                          # rX = (d4)(d3)(d2)00000
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get p4
    lsl rY, 4                       # move p4 to the correct position

    mov rX, rA                      # rX = (d4)(d3)(d2)0(d1)000
    or  rZ
    mov rA, rZ                      # rA = (d4)(d3)(d2)(p4)(d1)000

    # p2
    li  0b1100
    mov rX, rM
    lsl rX, 4                       # rX = 0b11000000
    mov rY, rM
    or  rY                          # rY = 0b11001100

    mov rX, rB                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)(d10)00(d7)(d6)00
    xrb rW                          # xor byte rX into rW

    mov rX, rA                      # rX = (d4)(d3)(d2)0(d1)000
    and rX                          # rX = (d4)(d3)00(d1)000
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get p2
    lsl rY, 2                       # move p2 to the correct position

    mov rX, rA                      # rX = (d4)(d3)(d2)(p4)(d1)000
    or  rZ
    mov rA, rZ                      # rA = (d4)(d3)(d2)(p4)(d1)(p2)00

    # p1
    li  0b1010
    mov rX, rM
    lsl rX, 4                       # rX = 0b10100000
    mov rY, rM
    or  rY                          # rY = 0b10101010

    mov rX, rB                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)0(d9)0(d7)0(d5)0
    xrb rW                          # xor byte rX into rW

    mov rX, rA                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)00
    and rX                          # rX = (d4)0(d2)0(d1)000
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get p1
    lsl rY, 1                       # move p1 to the correct position

    mov rX, rA                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)00
    or  rZ
    mov rA, rZ                      # rA = (d4)(d3)(d2)(p4)(d1)(p2)(p1)0

    # p0
    mov rX, rB                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    xrb rW                          # xor byte rX into rW

    mov rX, rA                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)0
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rY                          # xor the results of both bytes to get p0

    mov rX, rA                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)0
    or  rZ
    mov rA, rZ                      # rA = (d4)(d3)(d2)(p4)(d1)(p2)(p1)(p0)

    # Store output into mem[30:59]
    mov rX, r4                      # get input address for lower byte
    mov rY, r6
    add rZ                          # get input address + 30 = output address
    mov r2, rZ                      # r2 = output address

    mov rX, r5                      # get input address for higher byte
    add rZ                          # get input address + 30 = output address
    mov r3, rZ                      # r3 = output address

    mov rM, rA                     # Put rA into rM
    sb r2                          # Store rM, mem[30] (lower byte)

    mov rM, rB                     # Put rB into rM
    sb r3                          # Store rM, mem[31] (higher byte)
    
Iterate:
    li  2
    mov rY, rM          # 2
    mov rX, r4          # 0
    add rZ              # rX + rY
    mov r4, rZ          
    mov rX, r5
    add rZ              # rX + rY after rX incremented
    mov r5, rZ
    mov rX, r4
    li  30
    mov rY, rM
    sbflt               # rX < rY then branch
    b $Loop

    done