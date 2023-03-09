#exercise 1
def check_if_Prime(number):
    """
    the function checks if a number is prime or not
    """
    if number % 2 == 0 and number != 2:
        return False
    for index in range(2, number // 2):
        if number % index == 0:
            return False
    return True

def findNumber(number):
    """

    :param n: the number given for which we should be generated the first prime number larger
    :return: the first prime number larger than n
    """
    is_prime = False
    x = number + 1
    while is_prime == False:
        if check_if_Prime(x) == True:
            is_prime = True
        else:
            x = x + 1
    if is_prime == True:
        return x

def start():
    number = int(input("Give the number: "))
    print(findNumber(number))

start()