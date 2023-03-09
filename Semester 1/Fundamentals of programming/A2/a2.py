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

def is_sorted_in_reverse(list):
    list_length = len(list)
    for index in range(0, list_length-1):
        if list[index] < list[index+1]:
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
    #return (list)

def permutation_sort(list):
    while is_sorted(list) == False:

        shuffle(list)
    return list

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

def comb_sort(list):
    list_length = len(list)
    gap = list_length
    swapped = True
    while gap != 1 or swapped == 1:
        gap = get_next_gap(gap)
        swapped = False
        index = 0
        steps = 0
        while index < list_length-gap:
            if list[index] > list[index + gap]:
                list[index], list[index + gap] = list[index + gap], list[index]
                swapped = True
            steps = steps + 1
            index = index + 1
    return list

def generate_list_for_best_case(length):
    list = generate_list(length)
    list.sort()
    return list

def generate_list_for_average_case(length):
    list = generate_list(length)
    if is_sorted(list) is True:
        shuffle(list)
    elif is_sorted_in_reverse(list) is True:
        shuffle(list)
    return list

def generate_list_for_worst_case(length):
    list = generate_list(length)
    list.sort()
    result = []
    for item in list:
        result = [item] + result
    return result

def build_result_table_best_case():
    #perm O(n)
    #comb O(nlogn)
    table = Texttable()
    table.add_row(['Best Case', '', ''])
    table.add_row(['Length', 'Permutation Sort', 'Comb Sort'])
    for length in [100, 200, 400, 800, 1600]:
        array = generate_list_for_best_case(length)

        start_permutation = timeit.default_timer()
        permutation_sort(array)
        end_permutation = timeit.default_timer()
        start_comb = timeit.default_timer()
        comb_sort(array)
        end_comb = timeit.default_timer()

        table.add_row([length, end_permutation - start_permutation, end_comb-start_comb])

    return table

def build_result_table_average_case():
    table = Texttable()
    table.add_row(['Average Case', '', ''])
    table.add_row(['Length', 'Permutation Sort', 'Comb Sort'])
    for length in [3, 4, 6, 8, 11]:
        array = generate_list_for_average_case(length)
        start_permutation = timeit.default_timer()
        permutation_sort(array)
        end_permutation = timeit.default_timer()

        start_comb = timeit.default_timer()
        comb_sort(array)
        end_comb = timeit.default_timer()
        table.add_row([length, end_permutation - start_permutation, end_comb - start_comb])
    return table


def build_result_table_worst_case():
    #perm O(inf)
    #comb O(n^2)
    table = Texttable()
    table.add_row(['Worst Case', '', ''])
    table.add_row(['Length', 'Permutation Sort', 'Comb Sort'])
    for length in [3, 4, 6, 8, 10]:
        array = generate_list_for_worst_case(length)
        start_permutation = timeit.default_timer()
        permutation_sort(array)
        end_permutation = timeit.default_timer()

        start_comb = timeit.default_timer()
        comb_sort(array)
        end_comb = timeit.default_timer()
        table.add_row([length, end_permutation - start_permutation, end_comb - start_comb])
    return table

def print_menu():
    print("1. Generate a list of n random natural numbers.")
    print("2. Sort the list using Permutation Sort.")
    print("3. Sort the list using Comb Sort.")
    print("4. Best Case.")
    print("5. Average Case.")
    print("6. Worst Case.")
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
            print(build_result_table_best_case().draw())
        elif option == '5':
            print(build_result_table_average_case().draw())
        elif option == '6':
            print(build_result_table_worst_case().draw())
        elif option == '0':
            return
        else:
            print("Option does not exist!")

start()
