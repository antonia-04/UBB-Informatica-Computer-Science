def quick_sort(arr, low, high, key=lambda x: x, cmp=lambda x, y: x > y, reverse=False):
    if low < high:
        pivot_index = partition(arr, key, low, high, cmp)
        quick_sort(arr, low, pivot_index - 1, key, cmp, reverse)
        quick_sort(arr, pivot_index + 1, high, key, cmp, reverse)

    if not reverse:
        arr.reverse()

def partition(arr, key, low, high, cmp):
    pivot = arr[high]
    i = low - 1

    for j in range(low, high):
        if cmp(key(arr[j]), key(pivot)):
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1


def gnome_sort(lista, key=lambda x: x, cmp=lambda x, y: x > y, reverse=False):
    index = 0
    lungime = len(lista)

    while index < lungime:
        if index == 0 or cmp(key(lista[index]), key(lista[index - 1])):
            index += 1
        else:
            lista[index], lista[index - 1] = lista[index - 1], lista[index]
            index -= 1

    if reverse:
        lista.reverse()



