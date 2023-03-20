int main(int num) {
    char check = 208;
    char bits[32];

    check = check >> 3;
    int matchCount = 0;
    int byteCount = 0;
    int overlapMatchCount = 0;
    // loop 1
    for (int i = 0; i < 32; i++) {
        int found = 0;
        // loop 2
        for (int j = 0; j < 4; j++) {
            char c = bits[i] >> j;
            if (c == check) {
                matchCount++;
                overlapMatchCount++;
                found = 1;
            }
        }
        if (found) {
            byteCount++;
        }
        if (i < 31) {
            // loop 3
            for (int j = 1; j <= 4; j++) {
                char a = bits[i] << j;
                char b = bits[i+1] >> (8-j);
                char c = (a | b) & (char)31;
                if (c == check) {
                    overlapMatchCount++;
                }
            }
        }
    }
}

/*
    check - r0
    matchCount - rA
    byteCount - rB
    overlapMatchCount - rC
    i - r1
    bits[i] - r2
    bits[i+1] - r3
    found - r4
    j - r5
    r6, r7 unused
*/