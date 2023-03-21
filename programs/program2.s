# TODO: Write loop structure for 15 messages
    li  30                          # Load immediate 32 into rM 
    mov r4, rM                      # 
    li  31                          # Load immediate 33 into rM
    mov r5, rM                      #
    li  30
    mov r6, rM

Loop:
    lb  r4                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r5                          # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]
    li  0                          # Load 0 into rM
    mov rY, rM                     # Clear out rY   
    
Calculate_S:
    # Calculating for s8, s4, s2, s1, s0
    # s8
    mov rX, r1                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    xrb rX                          # s8 = xor of the upper byte
    lsl rZ, 4
    mov rC, rZ                      # rC = 000(s8)0000

    # s4
    li  0b1111
    mov rX, rM
    lsl rY, 4                       # rY = 0b11110000
    
    mov rX, r1                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)(d10)(d9)(d8)0000
    xrb rW                          # xor byte rX into rW

    mov rX, r0                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)(p0)
    and rX                          # rX = (d4)(d3)(d2)(p4)0000
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get s4
    lsl rY, 3                       # move s4 to the correct position

    mov rX, rC                      # rX = 000(s8)0000
    or  rZ
    mov rC, rZ                      # rA = 000(s8)(s4)000

    # s2
    li  0b1100
    mov rX, rM
    lsl rX, 4                       # rX = 0b11000000
    mov rY, rM
    or  rY                          # rY = 0b11001100

    mov rX, r1                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)(d10)00(d7)(d6)00
    xrb rW                          # xor byte rX into rW

    mov rX, r0                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)(p0)
    and rX                          # rX = (d4)(d3)00(d1)(p2)00
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get s2
    lsl rY, 2                       # move s2 to the correct position

    mov rX, rC                      # rX = 000(s8)(s4)000
    or  rZ
    mov rC, rZ                      # rA = 000(s8)(s4)(s2)00

    # s1
    li  0b1010
    mov rX, rM
    lsl rX, 4                       # rX = 0b10100000
    mov rY, rM
    or  rY                          # rY = 0b10101010

    mov rX, r1                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    and rX                          # rX = (d11)0(d9)0(d7)0(d5)0
    xrb rW                          # xor byte rX into rW

    mov rX, r0                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)(p0)
    and rX                          # rX = (d4)0(d2)0(d1)0(p1)0
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rX                          # xor the results of both bytes to get s1
    lsl rY, 1                       # move s1 to the correct position

    mov rX, rC                      # rX = 000(s8)(s4)(s2)00
    or  rZ
    mov rC, rZ                      # rA = 000(s8)(s4)(s2)(s1)0

    # s0
    mov rX, r1                      # rX = (d11)(d10)(d9)(d8)(d7)(d6)(d5)(p8)
    xrb rW                          # xor byte rX into rW

    mov rX, r0                      # rX = (d4)(d3)(d2)(p4)(d1)(p2)(p1)(p0)
    xrb rX                          # xor byte rX back into rX

    mov rY, rW
    xor rY                          # xor the results of both bytes to get s0

    mov rX, rC                      # rX = 000(s8)(s4)(s2)(s1)0
    or  rZ
    mov rC, rZ                      # rA = 000(s8)(s4)(s2)(s1)(s0)

    # rC = 0 0 0 s8 s4 s2 s1 s0

    li  0
    mov rA, rM
    mov rB, rM

    # rA = 00000000
    # rB = 00000000

How_Many_Errors:
    # when s0 == 1, branch to handle the 1 bit error detection/correction
    # otherwise, if s8s4s2s1 == 0, there is no error
    # otherwise, there is a 2 bit error
    li  1
    mov rY, rM
    mov rX, rC
    and rX

    li  0
    mov rY, rM
    sbfne
    b   $One_Bit_Error

    mov rX, rC
    sbfne
    b   $Two_Bit_Error

    sbfjp
    b   $Form_Output

One_Bit_Error:

    # Add 1 bit error flag to output
    li  1
    mov rX, rM                  # loading 1 and moving to the left by 6 in order to get 64
    lsl rY, 6
    mov rX, rB
    or  rX
    mov rB, rX                  # rB = 01000000

    # Flip incorrect bit in the original bytes
    mov rX, rC
    lsr rX, 1                   # rX = 0000(s8)(s4)(s2)(s1)
    mov r7, rX                  # save rX to r7 for a check at the end of the correction

    mov rW, r0                  # default is to operate on the lower byte

    li  8
    mov rY, rM
    sbflt
    b   $Byte_Correction          # if s < 8, do byte correction

    mov rW, r1                  # otherwise, change to higher byte
    sub rX                      # subtract by 8 to get the new bit flip position
    
Byte_Correction:
    mov rY, rX                  # rY now has the shift factor
    li  1
    mov rX, rM
    lsl rY                      # shift a 1 bit to the bit flip position
    mov rX, rW                  # move the byte to correct into the computational register
    xor rZ                      # rZ is the corrected byte

    mov rX, r7
    li  8
    mov rY, rM
    sbflt
    b   $Correct_Lower          # if s < 8, the corrected byte is the lower byte

    mov r1, rZ                  # replace higher byte
    sbfjp
    b   $Form_Output

Correct_Lower:
    mov r0, rZ                  # replace lower byte

Form_Output:
    li  0b00001000
    mov rX, r0
    mov rY, rM
    and rX                      # rX = 0000(d1)000
    lsr rX, 3
    mov rY, rA                  
    or  rW                      # rW will store the lower byte being transformed; rW = 0000000(d1)

    li  0b00111000
    mov rX, rM
    lsl rY, 2                   # rY = immediate is now 0b11100000
    mov rX, r0                  
    and rX                      # rX = (d4)(d3)(d2)00000
    lsr rX, 4
    mov rY, rW
    or  rW                      # rW = 0000(d4)(d3)(d2)(d1)

    li  0b00011110
    mov rX, r1
    mov rY, rM
    and rX                      # rX = 000(d8)(d7)(d6)(d5)0
    lsl rX, 3
    mov rY, rW
    or  rW                      # rW = (d8)(d7)(d6)(d5)(d4)(d3)(d2)(d1)

    mov rA, rW                  # rA now has the correct lower byte format

    li  0b00111000
    mov rX, rM
    lsl rY, 2                   # rY = immediate is now 0b11100000
    mov rX, r1
    and rX                      # rX = (d11)(d10)(d9)00000
    lsr rX, 5
    mov rY, rB                  # rB is the higher byte with the correct error flags
    or  rZ                      # rZ = (f1)(f0)000(d11)(d10)(d9)
    
    mov rB, rZ                  # rB now has correct lower byte format

    sbfjp
    b   $Message_Done

Two_Bit_Error:
    li 1
    mov rX, rM
    lsl rY, 7                   # loading 1 and moving to the left by 7 in order to get 128
    mov rX, rB
    or  rX
    mov rB, rX

Message_Done:
    # Store output into mem[30:59]
    mov rY, r6
    mov rX, r4
    sub rX
    mov r2, rX
    mov rY, r6
    mov rX, r5
    sub rX
    mov r3, rX
    mov rM, rA                     # Put rY into rM
    sb r2                          # Store rM, mem[30]
    mov rM, rB                     # Put rY into rM
    sb r3                          # Store rM, mem[31]

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
    li  60
    mov rY, rM
    sbflt               # rX < rY then branch
    b $Loop

    done