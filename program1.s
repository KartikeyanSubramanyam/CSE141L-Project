# TODO: Write loop structure for 15 messages

Loop:

# Load 0 into register, then we can call load
# Do the same for 1

ldb r0, mem[0]
ldb r1, mem[1]   

Zero out rX
Move r1 to rY
# p8
Bit XOR with rX:0 and rY:0
Bit XOR with rX:0 and rY:1
Bit XOR with rX:0 and rY:2

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
