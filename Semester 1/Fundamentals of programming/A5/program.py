import cmath


# Write the implementation for A5 in this file
#

# 
# Write below this comment 
# Functions to deal with complex numbers -- list representation
# -> There should be no print or input statements in this section 
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values

# def create_complex_number(real_part, imag_part):
#     return [real_part, imag_part]
#
#
# def get_real(number):
#     return number[0]
#
#
# def get_imag(number):
#     return number[1]
#
#
# def set_real(number, value):
#     number = (value, number[1])
#
#
# def set_imag(number, value):
#     number = (number[0], value)

#
# Write below this comment 
# Functions to deal with complex numbers -- dict representation
# -> There should be no print or input statements in this section 
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values

def create_complex_number(real_part, imag_part):
    return {"real": real_part, "imag": imag_part}


def get_real(number):
    return number["real"]


def get_imag(number):
    return number["imag"]


def set_real(number, value):
    number["real"] = value


def set_imag(number, value):
    number["imag"] = value


#
# Write below this comment 
# Functions that deal with subarray/subsequence properties
# -> There should be no print or input statements in this section 
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values
def init_numbers():
    return [create_complex_number(1, 3), create_complex_number(2, 2), create_complex_number(3, 1),
            create_complex_number(-1, 3),
            create_complex_number(-1, -3), create_complex_number(1, 7), create_complex_number(4, 5),
            create_complex_number(6, 8),
            create_complex_number(8, 6), create_complex_number(-6, 8)]


def to_string(number):
    if int(get_imag(number)) == 0:
        return "z = " + str(get_real(number))
    elif int(get_real(number)) == 0:
        return "z = " + str(get_imag(number)) + "i"
    elif int(get_imag(number)) < 0:
        return "z = " + str(get_real(number)) + " " + str(get_imag(number)) + "i"
    else:
        return "z = " + str(get_real(number)) + " + " + str(get_imag(number)) + "i"


def add_complex_number(list_of_complex_numbers):
    complex_number = read_complex_number()
    list_of_complex_numbers.append(complex_number)
    print("Number added successfully!")
    return list_of_complex_numbers


# def display_complex_numbers(list_of_complex_numbers):
#     for i in range(0, len(list_of_complex_numbers)):
#         print(to_string(list_of_complex_numbers[i]))
#     #print(list_of_complex_numbers)


def calculate_modulus(complex_number):
    # modulus = cmath.sqrt(complex_number[0]*complex_number[0] + complex_number[1]*complex_number[1])
    # modulus = cmath.sqrt(complex_number["real"]*complex_number["real"] + complex_number["imag"]*complex_number["imag"])
    modulus = cmath.sqrt(
        get_real(complex_number) * get_real(complex_number) + get_imag(complex_number) * get_imag(complex_number))
    return modulus


def longest_sequence_same_modulus(list_of_complex_numbers):
    length = len(list_of_complex_numbers)
    modulus = calculate_modulus(list_of_complex_numbers[0])
    i = 1
    current_length = 1
    max_length = 1
    for index in range(1, length):
        current_modulus = calculate_modulus(list_of_complex_numbers[index])
        if current_modulus == modulus:
            current_length += 1
        else:
            if current_length > max_length:
                max_length = current_length
                i = index
            current_length = 1
            modulus = current_modulus
    if current_length > max_length:
        max_length = current_length
        i = length
    # print(modulus)
    # print("Maximum length: ", max_length)
    start = i - max_length
    result_list = []
    for index in range(start, i):
        result_list.append(to_string(list_of_complex_numbers[index]))
        # print(to_string(list_of_complex_numbers[index]))
    return result_list
    # print(list_of_complex_numbers[i-max_length:i])


def maximum_length_modulus(list_of_complex_numbers):
    result_list = longest_sequence_same_modulus(list_of_complex_numbers)
    length = 0
    for i in range(0, len(result_list)):
        length += 1
    return length

#
# def longest_alternating_subsequence(list_of_complex_numbers):
#     length = len(list_of_complex_numbers)
#     list_real_parts = []
#     result_list = []
#     for i in range(0, length):
#         real_part = get_real(list_of_complex_numbers[i])
#         list_real_parts.append(real_part)
#     #print(list_real_parts)
#     length_real = len(list_real_parts)
#     result_list.append(list_real_parts[0])
#     #inc = 1
#     #dec = 1
#     ok = False
#     for i in range(1, length_real):
#         if list_real_parts[i] > list_real_parts[i-1] and ok is False:
#             #inc = dec + 1
#             result_list.append(list_real_parts[i])
#             ok = True
#         else:
#             if list_real_parts[i] < list_real_parts[i-1] and ok is True:
#                 result_list.append(list_real_parts[i])
#                 #dec = inc + 1
#                 ok = False
#     #max_length = maximum(inc, dec)
#     #print("Maximum length: ", max_length)
#     #print(result_list)
#     return result_list
#
#
# def maximum_length_alternating(list_of_complex_numbers):
#     result_list = longest_alternating_subsequence(list_of_complex_numbers)
#     length = 0
#     for i in range(0, len(result_list)):
#         length += 1
#     return length


def maximum(a, b):
    if a > b:
        return a
    else:
        return b


def longest_alternating_subsequence(list_of_complex_numbers):
    length = len(list_of_complex_numbers)
    list_real_parts = []
    for i in range(0, length):
        real_part = get_real(list_of_complex_numbers[i])
        list_real_parts.append(real_part)
    length_real = len(list_real_parts)
    las = [[0 for i in range(2)]
           for j in range(length_real)]
    for i in range(length_real):
        las[i][0], las[i][1] = 1, 1

    res = 1
    for i in range(1, length_real):
        for j in range(0, i):
            if list_real_parts[j] < list_real_parts[i] and las[i][0] < las[j][1] + 1:
                las[i][0] = las[j][1] + 1
            if list_real_parts[j] > list_real_parts[i] and las[i][1] < las[j][0] + 1:
                las[i][1] = las[j][0] + 1
        if res < maximum(las[i][0], las[i][1]):
            res = maximum(las[i][0], las[i][1])
    return res

# Write below this comment 
# UI section
# Write all functions that have input or print statements here
# Ideally, this section should not contain any calculations relevant to program functionalities


def read_complex_number():
    real_part = int(input("Enter the real part of a complex number: "))
    imag_part = int(input("Enter the imaginary part of a complex number: "))
    complex_number = create_complex_number(real_part, imag_part)
    return complex_number


def display_complex_numbers(list_of_complex_numbers):
    for i in range(0, len(list_of_complex_numbers)):
        print(to_string(list_of_complex_numbers[i]))
    # print(list_of_complex_numbers)


def print_menu():
    print("1. Add a complex number to the list.")
    print("2. Display complex numbers.")
    print("3. Length and elements of a longest subarray of numbers having the same modulus.")
    print("4. The length of a longest alternating subsequence, when considering each number's real part.")
    print("0. Exit.")


def start():
    list_of_complex_numbers = init_numbers()
    # list_of_complex_numbers = init_numbers()
    while True:
        print_menu()
        option = input("Enter option: ")
        if option == '1':
            add_complex_number(list_of_complex_numbers)
        elif option == '2':
            display_complex_numbers(list_of_complex_numbers)
        elif option == '3':
            print("Maximum length: ", maximum_length_modulus(list_of_complex_numbers))
            print(longest_sequence_same_modulus(list_of_complex_numbers))
        elif option == '4':
            #print("Maximum length: ", maximum_length_alternating(list_of_complex_numbers))
            print(longest_alternating_subsequence(list_of_complex_numbers))
        elif option == '0':
            return
        else:
            print("Option does not exist!")


start()
