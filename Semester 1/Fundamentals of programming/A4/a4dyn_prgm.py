
def maximum(a, b):
    if a > b:
        return a
    else:
        return b


def find_max_value(array, length):
    result = []
    if length < 4:
        print("The array should have at lest 4 elements")
        return minim

    table1, table2 = [minim] * (length + 1), [minim] * length
    table3, table4 = [minim] * (length - 1), [minim] * (length - 2)

    # table1[] stores the maximum value of array[m]
    for i in range(length - 1, -1, -1):
        table1[i] = maximum(table1[i + 1], array[i])
    result.append(table1[i])
    # result[0] = table1[i]
    # print(result[0])

    # table2[] stores the maximum value of array[m] - array[n]
    for i in range(length - 2, -1, -1):
        table2[i] = maximum(table2[i + 1], table1[i + 1] - array[i])
    result.append(table2[i])
    # result[1] = table2[i] - result[0]
    # print(result[1])

    # table3[] stores the maximum value of array[m] - array[n] + array[p]
    for i in range(length - 3, -1, -1):
        table3[i] = maximum(table3[i + 1], table2[i + 1] + array[i])
    result.append(table3[i])

    # table4[] stores the maximum value of array[m] - array[n] + array[p] - array[q]
    for i in range(length - 4, -1, -1):
        table4[i] = maximum(table4[i + 1], table3[i + 1] - array[i])
    result.append(table4[i])
    #print(result)
    array_res = []
    for j in range(0, len(result)):
        array_res[0] = result[0]
        array_res[1] = result[0] - result[1]
    return table4[0]

array = []
x = int(input("Enter a number: "))
array.append(x)
while x != 0:
    x = int(input("Enter a number: "))
    array.append(x)
# array = [30, 5, 15, 18, 30, 40]
length = len(array)
minim = -100000000
print(find_max_value(array, length))
