def subsetsUtil(A, subset, index, j):
    # if index == 0:
    #     subset.append(A[0])
    #     print(subset)
    for i in range(index, len(A)):
        if i == 0:
            subset.append(A[i])
            print(subset)
            subsetsUtil(A, subset, i + 1, j)
            subset.pop()
            if len(subset) == 1:
                j = 0
        elif A[i] > A[j]:
            subset.append(A[i])
            j = i
            print(subset)
            subsetsUtil(A, subset, i + 1, j)
            subset.pop()
            if len(subset) == 1:
                j = 0

        else:
            subsetsUtil(A, subset, i + 1, j)
    return


def subsets(A):
    subset = []
    j = 0
    index = 0
    subsetsUtil(A, subset, index, j)


array = [1, 6, 3, 4, 7]

subsets(array)
