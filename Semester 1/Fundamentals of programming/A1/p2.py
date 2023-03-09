# exercise 10

def palindrome(number):
    pal = 0
    while number != 0:
        pal = pal * 10 + number % 10
        number = number // 10
    return pal

def start():
    number = int(input("Give the number: "))
    print(palindrome(number))

start()
