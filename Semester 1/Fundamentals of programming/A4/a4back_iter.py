def subsets(array):
    for i in range(0, len(array)):
        result = []
        result.append(array[i])
        print(result)
        for j in range(i + 1, len(array)):
            if array[j] > array[i]:
                result.append(array[j])
                print(result)
                nr = 1
                for k in range(j+1, len(array)):
                    if array[k] > array[j]:
                        result.append(array[k])
                        print(result)
                        nr = nr + 1
                while nr != 0:
                    result.pop()
                    nr = nr -1


lst = []
n = int(input("Enter number of elements : "))
for i in range(0, n):
    elem = int(input())
    lst.append(elem)

subsets(lst)



# def print_menu():
#     print("1.Determine all strictly increasing subsequences of sequence a - iterative")
#     print("2.Determine all strictly increasing subsequences of sequence a - recursive")
#     print("3.Maximize the value of the expression A[m] - A[n] + A[p] - A[q] - naive")
#     print("4.Maximize the value of the expression A[m] - A[n] + A[p] - A[q] - dynamic programming")
#     print("0. Exit")

# def start():
#     while True:
#         print_menu()
#         option = input("User option: ")
#         if option == '1':
#             array = int(input("Enter a list of numbers: "))
#             subsets(array)
#         else:
#             return
#
# start()


