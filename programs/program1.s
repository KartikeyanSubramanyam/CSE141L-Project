# TODO: Write loop structure for 15 messages
    li  0                          # Load immediate 0 into rM 
    mov r4, rM                     # 
    li  1                          # Load immediate 1 into rM
    mov r5, rM                     
Loop:
    mov r0, r4
    mov r1, r5
    lb  r0                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r1                          # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]
    li  0                          # Load 0 into rM
    mov rY, rM                     # Clear out rY   
    
    # Calculating for p8, p4, p2, p1, p0
    
    # d9
    mov rX, r0                     # Moves mem[0] into rX                               
    lsl rX, 7                      # Keep only d9 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY
    
    # d10
    mov rX, r0                     # Moves mem[0] into rX
    lsr rX, 1                      # Shifts 1 to get rid of last bit          
    lsl rX, 7                      # Keep only d10 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY
    
    # d11
    mov rX, r0                     # Moves mem[0] into rX
    lsr rX, 2                      # Shifts 2 to get rid of last 2 bits          
    lsl rX, 7                      # Keep only d11 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d1
    mov rX, r1                     # Moves mem[1] into rX                               
    lsl rX, 7                      # Keep only d1 from rX
    lsr rX, 5                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d2
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 1                      # Shifts 1 to get rid of last bit                               
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 4                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d3
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 2                      # Shifts 2 to get rid of last 2 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 4                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY 
    
    # d4
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 3                      # Shifts 3 to get rid of last 3 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 4                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d5
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 4                      # Shifts 4 to get rid of last 4 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 3                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d6
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 5                      # Shifts 5 to get rid of last 5 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d7
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 6                      # Shifts 6 to get rid of last 6 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 2 for p2
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 1 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 0 for p0
    xor rY                         # XOR rX and rY, put into rY

    # d8
    mov rX, r1                     # Moves mem[1] into rX
    lsr rX, 7                      # Shifts 7 to get rid of last 7 bits                              
    lsl rX, 7                      # Keep only d2 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 3 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 3                      # Places the wanted bit at bit 0 for p0
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

    # Store output into mem[30:59]
    mov rM, rY                     # Put rY into rM
    sb r2                          # Store rM, mem[30]
    mov rM, rY                     # Put rY into rM
    sb r3                          # Store rM, mem[31]

    # TODO will have to fix addressing for storing to make it relative to input memory address
    
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