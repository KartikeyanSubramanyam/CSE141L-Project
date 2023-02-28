# TODO: Write loop structure for 15 messages
    li  32                          # Load immediate 32 into rM 
    mov r4, rM                     # 
    li  33                          # Load immediate 33 into rM
    mov r5, rM                     #
    nop                            # nop in order to match with Branch's power of 4
    nop
    nop
Loop:
    mov r0, r4
    mov r1, r5
    lb  r0                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r1                          # Load mem[1] into rM
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

    # q1
    mov rX, r1
    lsl rX, 6
    lsr rX, 7
    lsl rX, 1
    xor rA

    # q0
    mov rX, r1
    lsl rX, 7
    lsr rX, 7
    xor rY

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # at this point rA has p[] and rY has q[]
    mov rB, rY
    mov rX, rA
    xor rY

    # now rY has s[] which is the result of p[] ^ q[] 
    mov rC, rY

    # ---- up until this should be correct 
    # rY = rC = 0 0 0 s8 s4 s2 s1 s0

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
    # so we check s1:8 to find which bit to fix
    mov rX, rC
    lsr rX, 1

    # bad parity bit p1 check since 1 == 0001
    li 1
    mov rY, rM
    sbfeq
    b $Parity_Error

    # bad parity bit p2 check since 2 == 0010
    li 2
    mov rY, rM
    sbfeq
    b $Parity_Error

    # bad parity bit p4 check since 4 == 0100
    li 4
    mov rY, rM
    sbfeq
    b $Parity_Error

    # bad parity bit p8 check since 8 == 1000
    li 8
    mov rY, rM
    sbfeq
    b $Parity_Error    
    
# - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# at this point we have s[] in rC, r0 and r1 have the input mem[0] and mem[1] respectively
# rA and rB can be freed

# bad parity check for p1
Data_Error:
    sbfjp
    b $Done_1_Error


Parity_Error:
    li 0
    mov rY, rM
    mov rX, r1
    lsr rX, 3
    xor rX
    lsr rX, 1
    xor rX
    mov rA, rX
    mov rX, r0
    lsr rX, 1
    xor rX
    mov rY, rA
    lsl rY, 4
    lsr rY, 4
    lsl rX, 4
    xor rY
    # rA contains the right 1 ~ 8
    mov rA, rY

    mov rY, rM
    mov rX, r0
    lsr rX, 5
    xor rY
    # rB contains the right 11 ~ 9
    mov rB, rY
    sbfjp
    b $Done_1_Error
    
Done_1_Error:
    li 64
    mov rY, rM
    mov rX, rB
    xor rX
    mov rB, rX
    sbfjp
    b $Done

Done_2_Error:
    li 128
    mov rB, rM
    li 0
    mov rA, 0

Done:
    # Store output into mem[30:59]
    mov rM, rB                     # Put rY into rM
    sb r2                          # Store rM, mem[30]
    mov rM, rA                     # Put rY into rM
    sb r2                          # Store rM, mem[31]
Iterate:
    li  2
    mov rY, rM          # 2
    mov rX, r4          # 0
    add rZ              # rX + rY
    mov r4, rZ          
    mov rX, r5
    add rZ              # rX + rY after rX incremented
    mov r5, rZ
    li  30
    mov rY, rM
    sbflt               # rX < rY then branch
    b $Loop

    done