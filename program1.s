# TODO: Write loop structure for 15 messages
    swt                            # Switch register sets
    li  0                          # Load immediate 0 into rM 
    mov r4, rM                     # 
    li  1                          # Load immediate 1 into rM
    mov r5, rM                     #
    nop                            # nop in order to match with Branch's power of 4
    nop
    nop
Loop:
    mov r0, r4
    mov r1, r5
    swt                            # Switch register sets
    lb  r0                         # Load mem[0] into rM
    mov r0, rM                     # ldb r0, mem[0]
    lb  r1                          # Load mem[1] into rM
    mov r1, rM                     # ldb r1, mem[1]
    li  0                          # Load 0 into rM
    mov rY, rM                     # Clear out rY   
    
    # Calculating for p8
    
    # d9
    mov rX, r0                     # Moves mem[0] into rX                               
    lsl rX, 7                      # Keep only d9 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 4 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 4 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 4 for p0
    xor rY                         # XOR rX and rY, put into rY
    
    // TO DO:
    # d10
    mov rX, r0                     # Moves mem[0] into rX
    lsr rX, 1                      # Shifts 1 to get rid of last bit          
    lsl rX, 7                      # Keep only d10 from rX
    lsr rX, 3                      # Places the wanted bit at bit 4 for p8
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 4 for p4
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 2                      # Places the wanted bit at bit 4 for p1
    xor rY                         # XOR rX and rY, put into rY
    lsr rX, 1                      # Places the wanted bit at bit 4 for p0
    xor rY                         # XOR rX and rY, put into rY
 
                                   # Bit XOR with rX:0 and rY:2

# p4
Bit XOR with rX:1 and rY:0
Bit XOR with rX:1 and rY:1
Bit XOR with rX:1 and rY:2

# p2
Bit XOR with rX:2 and rY:2
Bit XOR with rX:2 and rY:1

# p1
Bit XOR with rX:3 and rY:2
Bit XOR with rX:3 and rY:0

# p0
Bit XOR with rX:4 and rY:2
Bit XOR with rX:4 and rY:1
Bit XOR with rX:4 and rY:0

Move r0 to rY
# p8
Bit XOR with rX:0 and rY:7
Bit XOR with rX:0 and rY:6
Bit XOR with rX:0 and rY:5
Bit XOR with rX:0 and rY:4

# p4
Bit XOR with rX:1 and rY:7
Bit XOR with rX:1 and rY:3
Bit XOR with rX:1 and rY:2
Bit XOR with rX:1 and rY:1

# p2
Bit XOR with rX:2 and rY:6
Bit XOR with rX:2 and rY:5
Bit XOR with rX:2 and rY:3
Bit XOR with rX:2 and rY:2
Bit XOR with rX:2 and rY:0

# p1
Bit XOR with rX:3 and rY:6
Bit XOR with rX:3 and rY:4
Bit XOR with rX:3 and rY:3
Bit XOR with rX:3 and rY:1
Bit XOR with rX:3 and rY:0

# p0
Bit XOR with rX:4 and rY:7
Bit XOR with rX:4 and rY:6
Bit XOR with rX:4 and rY:5
Bit XOR with rX:4 and rY:4
Bit XOR with rX:4 and rY:3
Bit XOR with rX:4 and rY:2
Bit XOR with rX:4 and rY:1
Bit XOR with rX:4 and rY:0

Move rX to rY
Bit XOR with rX:4 and rY:4
Bit XOR with rX:4 and rY:3
Bit XOR with rX:4 and rY:2
Bit XOR with rX:4 and rY:1

Left shift rX by 3
Bitwise XOR between rX and r1

# Load 0 into register, then we can call load
# Do the same for 1

Store r0 as mem[30]
Store r1 as mem[31]

Iterate:
    swt                 # Switch register sets
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