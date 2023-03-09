import random
import timeit

from texttable import Texttable

def generate_list(n):
    random_list = []
    for index in range(0, n):
        number = random.randint(0, 100)
        random_list.append(number)
    return random_list

def is_sorted(list):
    list_length = len(list)
    for index in range(0, list_length-1):
        if list[index] > list[index+1]:
            return False
    return True

def shuffle(list):
    list_length = len(list)
    for index in range(0, list_length):
        random_number = random.randint(0, list_length-1)
        list[index], list[random_number] = list[random_number], list[index]

def permutation_sort_with_step(list, step):
    while is_sorted(list) == False:
        index = 0
        while index != step:
            shuffle(list)
            index = index + 1
        print(list)

def get_next_gap(gap):
    gap = (gap * 10) // 13
    if gap < 1:
        return 1
    return gap

def comb_sort_with_step(list, step):
    list_length = len(list)
    gap = list_length
    swapped = True
    while gap != 1 or swapped == 1:
        gap = get_next_gap(gap)
        swapped = False
        index = 0
        steps = 0
        while index < list_length-gap and steps != step:
            #steps = 0
            #while steps != step:
            if list[index] > list[index + gap]:
                list[index], list[index + gap] = list[index + gap], list[index]
                swapped = True
            steps = steps + 1
            index = index + 1
        print(list)

def build_result_table():
    table = Texttable()
    table.add_row(['Term', 'Best Case', 'Average Case', 'Worst Case'])
    for term in [10, 20, 40, 80, 160]:
        start = timeit.default_timer()
        list = generate_list(term)
        row = permutation_sort_with_step(list, 2)
        end = timeit.default_timer()
        table.add_row([term, end - start])
    return table

def print_menu():
    print("1. Generate a list of n random natural numbers.")
    print("2. Sort the list using Permutation Sort.")
    print("3. Sort the list using Comb Sort.")
    print("4. Time complexity for permutation sort.")
    print("0. Exit")

def start():


    while True:
        print_menu()
        option = input("User option: ")
        if option == '1':
            n = int(input("Enter a number: "))
            list_of_numbers1 = generate_list(n)
            print(list_of_numbers1)
        elif option == '2':
            step = int(input("Enter step: "))
            permutation_sort_with_step(list_of_numbers1, step)
        elif option == '3':
            step = int(input("Enter step: "))
            comb_sort_with_step(list_of_numbers1, step)
        elif option == '4':
            print(build_result_table().draw())
        elif option == '0':
            return
        else:
            print("Option does not exist!")

start()
