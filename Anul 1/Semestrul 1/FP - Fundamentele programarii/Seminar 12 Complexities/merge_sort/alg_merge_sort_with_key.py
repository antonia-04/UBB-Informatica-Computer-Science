from entities import Product


def merge(arr1, arr2, key):
    result = []

    i = 0
    j = 0

    while i < len(arr1) and j < len(arr2):
        if key(arr1[i]) < key(arr2[j]):
            result.append(arr1[i])
            i += 1
        else:
            result.append(arr2[j])
            j += 1

    result.extend(arr1[i:])
    result.extend(arr2[j:])

    return result


def merge_sort_with_key(my_list, key=lambda x: x):
    list_length = len(my_list)

    if list_length <= 1:
        return my_list

    middle = list_length // 2

    left = my_list[:middle]
    right = my_list[middle:]

    sorted_left = merge_sort_with_key(left, key)
    sorted_right = merge_sort_with_key(right, key)

    return merge(sorted_left, sorted_right, key)


def test_merge_sort_with_key():
    p1 = Product('SWEETS029', 'ciocolata Milka', 7.23)
    p2 = Product('SWEETS437', 'ferrero Rocher', 13.98)
    p3 = Product('SWEETS430', 'turta dulce', 3.88)
    p4 = Product('FRUITS274', 'portocale', 5.99)
    p5 = Product('FRUITS98', 'mandarine', 6.23)
    p6 = Product('FRUITS97', 'mandarine', 3.23)

    products = [p1, p2, p3, p4, p5]
    sorted_products = merge_sort_with_key(products, lambda x: x.getName())

    assert (sorted_products[0] == p1)
    assert (sorted_products[1] == p2)
    assert (sorted_products[2] == p5)
    assert (sorted_products[3] == p4)
    assert (sorted_products[4] == p3)

    sorted_products = merge_sort_with_key(products, lambda x: x.getPrice())

    assert (sorted_products[0] == p3)
    assert (sorted_products[1] == p4)
    assert (sorted_products[2] == p5)
    assert (sorted_products[3] == p1)
    assert (sorted_products[4] == p2)

    products = [p1, p2, p3, p4, p5, p6]
    sorted_products = merge_sort_with_key(products, lambda x: (x.getName(), x.getPrice()))
    assert (sorted_products[0] == p1)
    assert (sorted_products[1] == p2)
    assert (sorted_products[2] == p6)
    assert (sorted_products[3] == p5)
    assert (sorted_products[4] == p4)
    assert (sorted_products[5] == p3)


test_merge_sort_with_key()
