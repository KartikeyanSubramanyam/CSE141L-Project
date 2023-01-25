

# Load mem[32]
ldb rM, mem[32]
# Move rM to rX
mov rM, rX

# Loop

# Load mem[0]
ldb rM, mem[0]
# Move rM to rY
mov rM, rY
# XOR rX and rY -> rZ
xor
# 

r2 - 00000000

11101000 rX
01011101 rY



10110101 rZ
move rZ to r3
right shift rZ by 3 bits
00010110
is it not equal to 0 (is there a 1 in the bits)
branch to special code to increase the counter (add)

Load the next byte
Left shift rY by 1 bit: rY 10111010

Counter through bits increment to 1 : shifter
Loop this 1 time

rY: 11101000
Load mem[1] : 01011010
Right shift new copy of mem[1] by [shifter] bits : 00000010
Orr with rY : 11101010

Continue for 1 bits

Left shift new copy of mem[1] by 3 bits : 11010000
Right shift copy of mem[1] by 5 bits : 00000110
Orr with rY : 


a, b)

rX : 
rY :
r0 : counting number of occurrences of pattern in the bytes (no overlap)
r1 : counting number of bytes that have the pattern (no overlap)
r2 : to store 1 if byte has pattern, 0 otherwise
r3 : swap, move

c)

r0 : counting number of occurrences of pattern overall (overlap)
r1 : 
r2 : 
r3 : 

