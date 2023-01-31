int main(int num) {
    char check = 208;
    char bits[32];

    check = check >> 3;
    int matchCount = 0;
    int byteCount = 0;
    int overlapMatchCount = 0;
    for (int i = 0; i < 32; i++) {
        int found = 0;
        for (int j = 3; j >= 0; j++) {
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