# MERGE SORT

"""
MergeSort(arr[], l,  r)
If len(l)>1
     1. Find the middle point to divide the array into two halves:
     2. Call mergeSort for first half:
     3. Call mergeSort for second half:
     4. Merge the two halves sorted in step 2 and 3:
"""

"""
def merge(arr1, arr2):
    result = []

    i = 0
    j = 0

    while i < len(arr1) and j < len(arr2):
        if arr1[i] < arr2[j]:
            result.append(arr1[i])
            i += 1
        else:
            result.append(arr2[j])
            j += 1

    result.extend(arr1[i:])
    result.extend(arr2[j:])

    return result


def merge_sort(my_list):
    list_length = len(my_list)

    if list_length <= 1:
        return my_list

    middle = list_length // 2

    left = my_list[:middle]
    right = my_list[middle:]

    sorted_left = merge_sort(left)
    sorted_right = merge_sort(right)

    return merge(sorted_left, sorted_right)



def test_merge_sort():
    a3 = [1]
    sorted_list = merge_sort(a3)
    assert (sorted_list == [1])

    a2 = [1, 4, 5, 3, 2]
    result2 = merge_sort(a2)
    assert (result2 == [1, 2, 3, 4, 5])

    assert (merge_sort([]) == [])

    a4 = [1, 1, 1, 1]
    assert (merge_sort(a4) == [1, 1, 1, 1])

    a1 = [1, 4, 3, 2, 5, 1, 5, 33, 2, 11]
    assert (merge_sort(a1) == [1, 1, 2, 2, 3, 4, 5, 5, 11, 33])
"""

def f(n):
    if n<0:
        raise ValueError()
    l = [x for x in range(n-1, -1, -1)]
    for i in range(n-1):
        l[i+1] = l[i+1] + l[i]
    return l[-1]

def test_f():
    assert f(3) == 3
    assert f(5) == 9
    try:
        f(-1)
        assert False
    except ValueError:
        assert True

    try:
        f(0)
        assert False
    except ValueError:
        assert True


test_f()
