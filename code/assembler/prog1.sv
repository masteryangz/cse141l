111111r7 //mem[64] = 64
110000r7 //r0 = 64
110001r7 //r1 = 64
111010r7 //max(mem[64]) = 0
0010001 //r0 = 32
0010001 //r0 = 16
010111r6 //r7 = 65
111000r7 //min(mem[65]) = 16
010111r6 //r7 = 66
111010r7 //mem[66] = 0
010111r6 //r7 = 67
111001r7 //mem[67] = 64
010111r6 //r7 = 68
010111r6 //r7 = 69
111101r7 //mem[69] = -1
010111r6 //r7 = 70
111110r7 //mem[70] = 1
110111r7 //r7 = 64
110000r7 //r0 = 0
110001r7 //r1 = 0
110011r7 //r3 = 0
010011r2 //load r3 with r2(i)
100011r5 //r3 = ~r2
010011r6 //r3 = -r2
010111r5 //r7 = len(n)-1
010111r5 //r7 = len(n)-2
010011r7 //r3 = len(n)-2-i
010111r6 //r7 = len(n)-1
010111r6 //r7 = len(n)
1010116 //for i in range(len(n)-1)
010111r6 //r7 = len(n)+1
010111r6 //r7 = len(n)+2
110011r7 //r3 = 0
010011r6 //r3 = 1
010011r6 //r3 = 2
010011r2 //r3(j) = r2(i)+2
110100r7 //r4 = 0
010100r3 //load r4 with r3(j)
100100r5 //r4 = ~r3
010100r6 //r4 = -r3
010111r5 //r7 = len(n)+1
010111r5 //r7 = len(n)
010111r5 //r7 = len(n)-1
010100r7 //r4 = len(n)-1-j
010111r6 //r7 = len(n)
1011004 //for j in range(i+1, len(n))
110100r2 //load mem[i] into r4
110000r3 //load mem[j] into r0
100100r0 //x(r4) = n[i]^n[j]
1011002 //while x>0
010111r6 //r7 = len(n)+1
010111r6 //r7 = len(n)+2
010111r6 //r7 = len(n)+3
010111r6 //r7 = len(n)+4
111100r7 //store x into mem[68]
110000r7 //load x into r0
010001r0 //setBits(r1) = r1+r0
0011001 //arithmetic right shift x by 1
010111r5 //r7 = 67
110000r7 //r0 = 64
010111r5 //r7 = len(n)+2
010111r5 //r7 = len(n)+1
010111r5 //r7 = len(n)
010000r0 //r0 = 10000000
100000r5 //r0 = 011111111
1011013 //jump back to while loop
010011r6 //j+=1
010011r6 //j+=1
1011015 //jump back to j for loop
010010r6 //i+=1
010010r6 //i+=1
1011017 //jump back to i for loop
