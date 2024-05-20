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
            multiplicant2Copy = copy.deepcopy(n[j])
            while(multiplicant2Copy>0):
                
            result.append(setBits)
    return result

if __name__=='__main__':
    n = [1, 5, 1, 2, 3]
    print(multiplication(n))