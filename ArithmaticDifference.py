def arithmaticDifference(n):
    max = 0
    min = 16
    for i in range(len(n)):
        for j in range(i+1, len(n)):
            setBits = n[i] + (~n[j] + 1)
            if setBits<0:
                setBits = -setBits
            if setBits>max:
                max = setBits
            elif setBits<min:
                min = setBits 
    return max, min

if __name__=='__main__':
    n = [0, -2, 4, -1]
    print(arithmaticDifference(n))