Load mem[30] into r0
Load mem[31] into r1

Zero out rX
Move r1 to rY
// p8
Bit XOR with rX:0 and rY:0
Bit XOR with rX:0 and rY:1
Bit XOR with rX:0 and rY:2

// p4
Bit XOR with rX:1 and rY:0
Bit XOR with rX:1 and rY:1
Bit XOR with rX:1 and rY:2

// p2
Bit XOR with rX:2 and rY:2
Bit XOR with rX:2 and rY:1

// p1
Bit XOR with rX:3 and rY:2
Bit XOR with rX:3 and rY:0

// p0
Bit XOR with rX:4 and rY:2
Bit XOR with rX:4 and rY:1
Bit XOR with rX:4 and rY:0

Move r0 to rY
// q8
Bit XOR with rX:0 and rY:7
Bit XOR with rX:0 and rY:6
Bit XOR with rX:0 and rY:5
Bit XOR with rX:0 and rY:4

// q4
Bit XOR with rX:1 and rY:7
Bit XOR with rX:1 and rY:3
Bit XOR with rX:1 and rY:2
Bit XOR with rX:1 and rY:1

// q2
Bit XOR with rX:2 and rY:6
Bit XOR with rX:2 and rY:5
Bit XOR with rX:2 and rY:3
Bit XOR with rX:2 and rY:2
Bit XOR with rX:2 and rY:0

// q1
Bit XOR with rX:3 and rY:6
Bit XOR with rX:3 and rY:4
Bit XOR with rX:3 and rY:3
Bit XOR with rX:3 and rY:1
Bit XOR with rX:3 and rY:0

// q0
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

Store r0 as mem[0]
Store r1 as mem[1]
