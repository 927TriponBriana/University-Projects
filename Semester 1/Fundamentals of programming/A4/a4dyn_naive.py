def get_max_value_of_expression(array):
    max_value = 0
    m = 0
    n = 0
    p = 0
    q = 0
    for i in range(len(array)-1, 0, -1):
        for j in range(i-1, 0, -1):
            for k in range(j-1, 0, -1):
                for z in range(k-1, 0, -1):
                    current_value = array[i]-array[j]+array[k]-array[z]
                    if current_value > max_value:
                        max_value = current_value
                        m = array[i]
                        n = array[j]
                        p = array[k]
                        q = array[z]
    print(m, '-', n, '+', p, '-', q)
    print(max_value)

lst = []
# n = int(input("Enter number of elements : "))
# for i in range(0, n):
#     elem = int(input())
#     lst.append(elem)
x = int(input("Enter a number: "))
lst.append(x)
while x != 0:
    x = int(input("Enter a number: "))
    lst.append(x)
get_max_value_of_expression(lst)
