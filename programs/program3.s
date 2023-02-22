main:
        # Load addresses and special values

        # Load byte with 5-bit bitstring to match
        li      32              
        mov     r4, rM          # loads 32 into r4
        lb      r4              # loads mem[32] into rM
        mov     rX, rM          # moves mem[32] to rX
        lsr     rX, 3           # rX = rX >> 3
        mov     r0, rX          # move bitstring to r0

        # Load zeroes into counter registers
        li      0
        mov     rA, rM
        mov     rB, rM
        mov     rC, rM

L1_setup:
        # Load loop 1 index into r1
        li      0
        mov     r1, rM          # loads 0 into r1

L1_conditional:
        mov     rY, r1
        li      31
        mov     rX, rM
        sbflt                   # check if r1 > 31, yes then end loop 1
        b       $L1_end

L1_content:
        # (r4 will represent number of matches found in the byte)
        li      0
        mov     r4, rM          # load 0 into r4
        # load mem[r1] into r2
        lb      r1
        mov     r2, rM

L2_setup:
        # load loop 2 index into r5
        li      3
        mov     r5, rM          # load 3 into r5 (the shift factor for every loop)

L2_conditional:
        mov     rY, r5
        li      0
        mov     rX, rM
        sbfle                   # check if 0 <= r5, yes then end loop 2
        b       $L2_end

L2_content:
        # right shift current byte by shift factor
        mov     rX, 
        mov     rY, r5
        lsr     rX

        # when there is no match, branch to L2_next
        mov     rY, r0
        sbfne
        b       $L2_next

        # increment within-byte match found counter r4
        mov     rX, r4
        li      1
        mov     rY, rM
        add     rZ
        mov     r4, rZ

L2_next:
        # decrement loop 2 index (shift factor)
        mov     rX, r5
        li      1
        mov     rY, rM
        sub     rZ
        mov     r5, rZ

        sbfjp
        b       $L2_conditional

L2_end:
        # check if r4 > 0, if yes then increment matched-byte counter
        li      0
        mov     rY, rM
        mov     rX, r4
        sbfle
        b       $not_last_byte_check
        
        # increment matched-byte counter by 1
        mov     rX, rB
        li      1
        mov     rY, rM
        add     rZ
        mov     rB, rZ

        # increment match counter and match overlap counter by within-byte match found counter
        mov     rY, r4
        mov     rX, rA
        add     rZ
        mov     rA, rZ

        mov     rX, rC
        add     rZ
        mov     rC, rZ

not_last_byte_check:
        # check if the byte index is not the last;
        # otherwise, go to the next iteration of loop 1
        mov     rY, r7
        li      31
        mov     rX, rM
        sbfle
        b       $L1_next
        
L3_setup:
        # load loop 3 index into r5
        li      1
        mov     r5, rM

        # load mem[r1+1] into rC
        mov     rX, r1
        li      1
        mov     rY, rM
        add     rZ
        mov     r6, rZ          # r6 = r1 + 1
        lb      r6
        mov     r3, rM          # load mem[r1+1] into r3

L3_conditional:
        li      4
        mov     rX, rM
        mov     rY, r5
        sbflt
        b       $L3_end         # if r5 > 4, end loop 3

L3_content:
        # rW = bits[i] << r5;
        mov     rY, r5
        mov     rX, r2
        lsl     rW

        # rY = 8 - r5
        li      8
        mov     rX, rM
        mov     rY, r5
        sub     rY

        # rY = bits[i+1] >> (8 - r5)
        mov     rX, r3
        lsr     rY

        # rX = rW | rY
        mov     rX, rW
        or      rX

        # rX = rX & 0b00011111
        li      0x1f
        mov     rY, rM
        and     rX

        # when there is no match, branch to L3_next
        mov     rY, r0
        sbfne
        b       $L3_next

        # increment overlap match counter rC
        mov     rX, rC
        li      1
        mov     rY, rM
        add     rZ
        mov     rC, rZ

L3_next:
        li      1
        mov     rY, rM
        mov     rX, r5
        add     rZ
        mov     r5, rZ

        sbfjp
        b       $L3_conditional

L1_next:
        # increment r1
        mov     rX, r1
        li      1
        mov     rY, rM
        add     rX
        mov     r1, rX

        sbfjp
        b       $L1_conditional

L1_end:
        # Load address immediates and store the counters
        li      33              
        mov     r6, rM          # loads 33 into r6
        mov     rM, rA
        sb      r6              # store rA into mem[33]

        li      34
        mov     r6, rM          # loads 34 into r6
        mov     rM, rB
        sb      r6              # store rB into mem[34]

        li      35
        mov     r6, rM          # loads 35 into r6
        mov     rM, rC
        sb      r6              # store rC into mem[35]

        done
