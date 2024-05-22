# let n be an array of length 64 with 8-bit elements
# do multiply in an order of b2*a2, b2*a1, b1*a2, b1*a1
# a1 is multiplier
def doublePrecisionMult(array):
    for pairOffset in range(16): # 16 pairs of multiplicant and multipliers
        signExtend_subtract = 0b00
        a1 = array[pairOffset + 0]
        a2 = array[pairOffset + 1]
        b1 = array[pairOffset + 2]
        b2 = array[pairOffset + 3]
        
        f1,f2 = multiply(b2,a2,signExtend_subtract)
        signExtend_subtract += 1
        g1,g2 = multiply(b2,a1, signExtend_subtract)
        signExtend_subtract += 1
        h1,h2 = multiply(b1, a2, signExtend_subtract)
        signExtend_subtract += 1
        i1,i2 = multiply(b1, a1, signExtend_subtract)
        array[64 + pairOffset + 3] = f2
        array[64 + pairOffset + 2] = f1 + g2 + h2
        array[64 + pairOffset + 1] = h1 + g1 + i2 + overflow
        array[64 + pairOffset + 0] = i1 + Overflow
        

def multiply(multiplicant, multiplier, signExtend_subtract):
    accumulator = 0
    for i in range(8): # repeat 8 times
        if (multiplier[0] == 1):
            if(signExtend_subtract & 0b01): #if subtract bit is on
                accumulator -= multiplicant
            else:
                accumulator += multiplicant
        multiplier >> 1
        multiplier[7] = multiplicant[0]
        multiplicant >> 1
        if(signExtend_subtract & 0b10): #if signExtend bit is on
            multiplicant[7] = 1
    return multiplicant, multiplier

if __name__=='__main__':
    n = [1, 5, 1, 2, 3]
    print(doublePrecisionMult(n))