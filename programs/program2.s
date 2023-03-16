# TODO: Write loop structure for 15 messages
    li  30                          # Load immediate 32 into rM 
    mov r4, rM                      # 
    li  31                          # Load immediate 33 into rM
    mov r5, rM                      #
    li  30
    mov r6, rM
    nop                            # nop in order to match with Branch's power of 4
    nop
    nop
Loop:
    lb  r4                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r5                          # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]
    li  0                          # Load 0 into rM
    mov rY, rM                     # Clear out rY   
    
    # Calculating for q8, q4, q2, q1, q0

    # This will be accessing r0 because d11:5 is in r0

    # d11
    mov rX, r0                     # Moves mem[0] into rX
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY


    # d10
    mov rX, r0                     # Moves mem[0] into rX
    lsl rX, 1
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY


    # d9
    mov rX, r0                     # Moves mem[0] into rX                               
    lsl rX, 2                      # Keep only d9 from rX
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY
    

    # d8
    mov rX, r0                     # Moves mem[1] into rX
    lsl rX, 3
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 3                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY
    
    
    # d7
    mov rX, r0                     # Moves mem[1] into rX
    lsl rX, 4
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    
    # d6
    mov rX, r0                     # Moves mem[1] into rX
    lsl rX, 5
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY



    # d5
    mov rX, r0                     # Moves mem[1] into rX
    lsl rX, 6
    lsr rX, 7
    lsl rX, 4                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 3                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    
    

    # This will be accessing r1 because d4:1 is in r1
    
    # d1
    mov rX, r1                     # Moves mem[1] into rX                               
    lsl rX, 4                      # Keep only d1 from rX
    lsr rX, 7
    lsl rX, 2                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d2
    mov rX, r1                     # Moves mem[1] into rX
    lsl rX, 2
    lsr rX, 7
    lsl rX, 3                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d3
    mov rX, r1                     # Moves mem[1] into rX
    lsl rX, 1
    lsr rX, 7
    lsl rX, 3                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY 
    
    # d4
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 7
    lsl rX, 3                      # Places the wanted bit at bit 3 for p4  
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    
    # p8
    mov rX, rY                     # Moves current parity bits into rX
    lsr rX, 4                      # Gets rid of other parity bits for p8
    lsl rX, 7                      # Keep only p8 bit
    lsr rX, 7                      # Shifts for xor with p0
    xor rY                         # XOR rX and rY, put into rY

    # p4
    mov rX, rY                     # Moves current parity bits into rX
    lsr rX, 3                      # Gets rid of other parity bits for p4
    lsl rX, 7                      # Keep only p4 bit
    lsr rX, 7                      # Shifts for xor with p0
    xor rY                         # XOR rX and rY, put into rY

    # p2
    mov rX, rY                     # Moves current parity bits into rX
    lsr rX, 2                      # Gets rid of other parity bits for p2
    lsl rX, 7                      # Keep only p2 bit
    lsr rX, 7                      # Shifts for xor with p0
    xor rY                         # XOR rX and rY, put into rY

    # p1
    mov rX, rY                     # Moves current parity bits into rX
    lsr rX, 1                      # Gets rid of other parity bits for p1
    lsl rX, 7                      # Keep only p1 bit
    lsr rX, 7                      # Shifts for xor with p0
    xor rY                         # XOR rX and rY, put into rY


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # at this point all the parity bits are in rY
    # so now we move it to rA
    mov rA, rY
    # rA :0 0 0 p8 p4 p2 p1 p0

    # reload the mem[] values to extract the parity bits communicated
    mov r0, r4
    mov r1, r5
    lb  r0                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r1                          # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]
    li  0
    mov rY, rM


    # rY : 0 0 0 q8 q4 q2 q1 q0
    # q8
    mov rX, r0
    lsl rX, 7
    lsr rX, 3
    xor rY  # rY = rX ^ rY

    # q4
    mov rX, r1
    lsl rX, 3
    lsr rX, 7
    lsl rX, 3
    xor rY

    # q2
    mov rX, r1
    lsl rX, 5
    lsr rX, 7
    lsl rX, 2
    xor rY

    # q1 and q0
    mov rX, r1
    lsl rX, 6
    lsr rX, 6
    xor rY

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # at this point rA has p[] and rY has q[]
    mov rB, rY
    mov rX, rA
    xor rY

    # now rY has s[] which is the result of p[] ^ q[] 
    mov rC, rY

 
    # rC = 0 0 0 s8 s4 s2 s1 s0

    # making output first before checking what is wrong:
Forming_Output:
    li 0
    mov rY, rM
    mov rX, r0
    lsr rX, 3
    xor rX
    lsr rX, 2
    lsl rX, 1
    xor rX
    mov rA, rX
    mov rX, r1
    lsr rX, 1
    xor rX
    mov rY, rA
    lsl rY, 4
    lsr rY, 4
    lsl rX, 4
    xor rY
    # rA contains the correct d1 ~ d8
    mov rA, rY
    li 0
    mov rY, rM
    mov rX, r1
    lsr rX, 5
    xor rY
    # rB contains the right d11 ~ d9
    mov rB, rY


    # we check if s[] == 0 because if it is theres no error that we can report and we move to the Done branch
    mov rX, rC
    li 0
    mov rY, rM
    sbfeq
    b $Done

    # now we check if s0 is zero or not, because if it is, then we are dealing with two bit error
    # and can proceed to the same Done branch
    mov rX, rC
    li 0
    mov rY, rM
    lsl rX, 7
    lsr rX, 7
    sbfeq
    b $Done_2_Error

    # since there is an error and s0 is also not 0, we can assume there is a 1 bit error
    # so we check s1~8 to find which bit to fix
    mov rX, rC
    lsr rX, 1

    # bad parity bit p1 check since 1 == 0001
    li 1
    mov rY, rM
    sbfeq
    b $Done_1_Error

    # bad parity bit p2 check since 2 == 0010
    li 2
    mov rY, rM
    sbfeq
    b $Done_1_Error

    # bad parity bit p4 check since 4 == 0100
    li 4
    mov rY, rM
    sbfeq
    b $Done_1_Error

    # bad parity bit p8 check since 8 == 1000
    li 8
    mov rY, rM
    sbfeq
    b $Done_1_Error  
    
# - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# at this point we have s[] in rC, rA and rB have the output mem[0] and mem[1] with (maybe) the correct D1~11 respectively

Data_Error:
    
    # now we check for subsequent error to flip, flip that bit and return
    mov rX, rC
    lsr rX, 1
    li 3
    mov rY, rM
    sbfeq 
    b $Position_3_D1
    li 5
    mov rY, rM
    sbfeq
    b $Position_5_D2
    li 6
    mov rY, rM
    sbfeq
    b $Position_6_D3
    li 7
    mov rY, rM
    sbfeq
    b $Position_7_D4
    li 9
    mov rY, rM
    sbfeq
    b $Position_9_D5
    li 10
    mov rY, rM
    sbfeq
    b $Position_10_D6
    li 11
    mov rY, rM
    sbfeq
    b $Position_11_D7
    li 12
    mov rY, rM
    sbfeq
    b $Position_12_D8
    li 13
    mov rY, rM
    sbfeq
    b $Position_13_D9
    li 14
    mov rY, rM
    sbfeq
    b $Position_14_D10
    li 15
    mov rY, rM
    sbfeq 
    b $Position_15_D11

# rA
Position_3_D1:
    mov rX, rA
    not rX
    lsl rX, 7
    lsr rX, 7
    mov rY, rA
    lsr rY, 1
    lsl rY, 1
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_5_D2:
    mov rX, rA
    not rX
    lsl rX, 6
    lsr rX, 7
    lsl rX, 1
    mov rY, rA
    lsr rY, 2
    lsl rY, 2
    xor rY
    mov rX, rA
    lsl rX, 7
    lsr rX, 7
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_6_D3:
    mov rX, rA
    not rX
    lsl rX, 5
    lsr rX, 7
    lsl rX, 2
    mov rY, rA
    lsr rY, 3
    lsl rY, 3
    xor rY
    mov rX, rA
    lsl rX, 6
    lsr rX, 6
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_7_D4:
    mov rX, rA
    not rX
    lsl rX, 4
    lsr rX, 7
    lsl rX, 3
    mov rY, rA
    lsr rY, 4
    lsl rY, 4
    xor rY
    mov rX, rA
    lsl rX, 5
    lsr rX, 5
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_9_D5:
    mov rX, rA
    not rX
    lsl rX, 3
    lsr rX, 7
    lsl rX, 4
    mov rY, rA
    lsr rY, 5
    lsl rY, 5
    xor rY
    mov rX, rA
    lsl rX, 4
    lsr rX, 4
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_10_D6:
    mov rX, rA
    not rX
    lsl rX, 2
    lsr rX, 7
    lsl rX, 5
    mov rY, rA
    lsr rY, 6
    lsl rY, 6
    xor rY
    mov rX, rA
    lsl rX, 3
    lsr rX, 3
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error
Position_11_D7:
    mov rX, rA
    not rX
    lsl rX, 1
    lsr rX, 7
    lsl rX, 6
    mov rY, rA
    lsr rY, 7
    lsl rY, 7
    xor rY
    mov rX, rA
    lsl rX, 2
    lsr rX, 2
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error

Position_12_D8:
    mov rX, rA
    not rX
    lsr rX, 7
    lsl rX, 7
    mov rY, rA
    lsr rY, 4
    lsr rY, 4
    xor rY
    mov rX, rA
    lsl rX, 1
    lsr rX, 1
    xor rY
    mov rA, rY
    sbfjp
    b $Done_1_Error

# rB
Position_13_D9:
    mov rX, rB
    not rX
    lsl rX, 7
    lsr rX, 7
    mov rY, rB
    lsr rY, 1
    lsl rY, 1
    xor rY
    mov rB, rY
    sbfjp
    b $Done_1_Error
Position_14_D10:
    mov rX, rB
    not rX
    lsl rX, 6
    lsr rX, 7
    lsl rX, 1
    mov rY, rB
    lsr rY, 2
    lsl rY, 2
    xor rY
    mov rX, rB
    lsl rX, 7
    lsr rX, 7
    xor rY
    mov rB, rY
    sbfjp
    b $Done_1_Error
Position_15_D11:
    mov rX, rB
    not rX
    lsl rX, 5
    lsr rX, 7
    lsl rX, 2
    mov rY, rB
    lsr rY, 3
    lsl rY, 3
    xor rY
    mov rX, rB
    lsl rX, 6
    lsr rX, 6
    xor rY
    mov rB, rY
    sbfjp
    b $Done_1_Error
    
Done_1_Error:
    li 1
    mov rY, rM                  # loading 1 and moving to the left by 6 in order to get 64
    lsl rY, 6
    mov rX, rB
    xor rX
    mov rB, rX
    sbfjp
    b $Done

Done_2_Error:
    li 1
    mov rY, rM
    lsl rY, 7                   # loading 1 and moving to the left by 7 in order to get 128
    mov rX, rB
    xor rX
    mov rB, rX

Done:
    # Store output into mem[30:59]
    mov rX, r6
    mov rY, r4
    sub rX
    mov r2, rX
    mov rX, r6
    mov rY, r5
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