# Solve the problem from the third set here  exercise 3
# 1,2,3,2,5,2,3,7,2,3,2,5,...
"""" We create a function which will search the n-th element; we take every number from 1, if it is a
compound number we count its prime divisors and we memorize them one by one, if the number of elements
counted by us is equal to n, we return the last element memorized
"""
""""
def checkPrime(n):
    for d in range(2, x // 2):
        if n % d == 0:
            return False
    return True
"""

def findNumber(n):
    x = 1
    y = 1
    p = 1
    while p < n:
        x = x + 1
        y = x
        p = p + 1
        d = 2
        ok = False
        while p <= n and d <= x // 2:
            if x % d == 0:
                p = p + 1
                y = d
                ok = True
            d = d + 1
        if ok == True:
            p = p - 1
    return (y)


def start():
    n = int(input("Give the number: "))
    print(findNumber(n))

start()

