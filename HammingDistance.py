def hammingDistance(n):
 
    #x = n1 ^ n2 
    #setBits = 0
 
    #while (x > 0) :
        #setBits += x & 1
        #x >>= 1
     
    #return setBits 
    max = 0
    min = 16
    for i in range(len(n)-1):
        for j in range(i+1, len(n)):
            x = n[i] ^ n[j] 
            setBits = 0
 
            while x > 0:
                setBits += x & 1
                x >>= 1
     
            if setBits>max:
                max = setBits
            elif setBits<min:
                min = setBits 
    return max, min
if __name__=='__main__':
    n = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    print(hammingDistance(n))
 