import copy


def multiplication(n):
    max = 0
    min = 16
    result = []
    for i in range(len(n)):
        for j in range(i+1, len(n)):
            setBits = 0
            multiplicant1 = copy.deepcopy(n[i])
            multiplicant2 = copy.deepcopy(n[j])
            while(multiplicant2>0):
                if multiplicant1 >= 0 and multiplicant2 >= 0:
                    if multiplicant2 & 1 == 1:
                        setBits+=multiplicant1
                    multiplicant1 <<= 1
                    multiplicant2 >>= 1
            result.append(setBits)
    return result

if __name__=='__main__':
    n = [1, 5, 1, 2, 3]
    print(multiplication(n))