import cmath


def init_numbers():

    return [create_complex_number(1, 3), create_complex_number(2, 2), create_complex_number(3, 1), create_complex_number(-1, 3),
            create_complex_number(-1, -3), create_complex_number(1, 7), create_complex_number(4, 5), create_complex_number(6, 8),
            create_complex_number(8, 6), create_complex_number(-6, 8)]


# def init_numbers():
#     return {"real": 1,
#             "imag": 3}

# ---list---
def create_complex_number(real_part, imag_part):
    return [real_part, imag_part]


def get_real(number):
    return number[0]


def get_imag(number):
    return number[1]


def set_real(number, value):
    number = (value, number[1])


def set_imag(number, value):
    number = (number[0], value)


#---dictionary---
# def create_complex_number(real_part, imag_part):
#     return {"real": real_part, "imag": imag_part}
#
# def get_real(number):
#     return number["real"]
#
# def get_imag(number):
#     return number["imag"]
#
# def set_real(number, value):
#     number["real"] = value
#
# def set_imag(number, value):
#     number["imag"] = value

def to_string(number):
    if int(get_imag(number)) == 0:
        return "z = " + str(get_real(number))
    elif int(get_real(number)) == 0:
        return "z = " + str(get_imag(number)) + "i"
    elif int(get_imag(number)) < 0:
        return "z = " + str(get_real(number)) + " " + str(get_imag(number)) + "i"
    else:
        return "z = " + str(get_real(number)) + " + " + str(get_imag(number)) + "i"


def read_complex_number():
    real_part = int(input("Enter the real part of a complex number: "))
    imag_part = int(input("Enter the imaginary part of a complex number: "))
    complex_number = create_complex_number(real_part, imag_part)
    return complex_number


def add_complex_number(list_of_complex_numbers):
    complex_number = read_complex_number()
    list_of_complex_numbers.append(complex_number)
    print("Number added successfully!")
    return list_of_complex_numbers


# def add_complex_number(list_of_complex_numbers):
#     complex_number = read_complex_number()
#     list_of_complex_numbers.update({"real": get_real(complex_number)})
#     list_of_complex_numbers.update({"imag": get_imag(complex_number)})
#     print("Number added successfully!")
#     return list_of_complex_numbers


def display_complex_numbers(list_of_complex_numbers):
    for i in range(0, len(list_of_complex_numbers)):
        print(to_string(list_of_complex_numbers[i]))
    #print(list_of_complex_numbers)


# def display_complex_numbers(list_of_complex_numbers):
#     list_of_complex_numbers = init_numbers().items()
#     print(list_of_complex_numbers)

def calculate_modulus(complex_number):
    modulus = cmath.sqrt(complex_number[0]*complex_number[0] + complex_number[1]*complex_number[1])
    #modulus = cmath.sqrt(complex_number["real"]*complex_number["real"] + complex_number["imag"]*complex_number["imag"])
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
    print("Maximum length: ", max_length)
    start = i-max_length
    for index in range(start, i):
        print(to_string(list_of_complex_numbers[index]))
    #print(list_of_complex_numbers[i-max_length:i])


def maximum(a, b):
    if a > b:
        return a
    else: return b


def longest_alternating_subsequence(list_of_complex_numbers):
    length = len(list_of_complex_numbers)
    list_real_parts = []
    result_list = []
    for i in range(0, length):
        real_part = get_real(list_of_complex_numbers[i])
        list_real_parts.append(real_part)
    #print(list_real_parts)
    length_real = len(list_real_parts)
    result_list.append(list_real_parts[0])
    inc = 1
    dec = 1
    ok = False
    for i in range(1, length_real):
        if list_real_parts[i] > list_real_parts[i-1] and ok is False:
            inc = dec + 1
            # if result_list > list_real_parts[i-1]:
            result_list.append(list_real_parts[i])
            ok = True
        else:
            if list_real_parts[i] < list_real_parts[i-1] and ok is True:
                result_list.append(list_real_parts[i])
                dec = inc + 1
                ok = False
    max_length = maximum(inc, dec)
    print("Maximum length: ", max_length)
    print(result_list)


def print_menu():
    print("1. Add a complex number to the list.")
    print("2. Display complex numbers.")
    print("3. Length and elements of a longest subarray of numbers having the same modulus.")
    print("4. The length and elements of a longest alternating subsequence, when considering each number's real part.")
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
            longest_sequence_same_modulus(list_of_complex_numbers)
        elif option == '4':
            longest_alternating_subsequence(list_of_complex_numbers)
        elif option == '0':
            return
        else:
            print("Option does not exist!")


start()
