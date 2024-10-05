# Complexitate timp
import time
"""
O(n) -> limita superioara
Theta(n) -> limita superioara + limita inferioara
Omega(n) -> limita inferioara
"""

#T(n) = 10*n -> Theta(n)

def f_1(n: int):
    count = 0
    for i in range(10): #0..9
        for j in range(n): #0..n-1
            count = count + 1


#Best case (BC): elementul de pe pozitia 0 este divizibil cu 5
#               se executa 1 pas -> Theta(1)
#Worst case (WC): cand nu exista element divizibil cu 5 in lista
#               se parcurge toata lista -> T(n) = n -> Theta(n)
#Average case (AC): Theta(n)

#Overall complexity: O(n)

def f_1_1(lst: list):
    poz = 0
    n = len(lst)
    while poz < n and lst[poz] % 5 != 0:
        poz += 1
    return poz < n


#T(n) = 10*n -> Theta(n), O(n)
def f_2(n: int):
    count = 0

    for i in range(n, n + 10): #n, n+1,..., n+9
        for j in range(n): #0..n-1
            count += 1


#Theta(n^2)
def f_3(n: int):
    count = 0

    for i in range(1, n):
        for j in range(i, n):
            count += 1

#Theta(n^2)
def f_10(n: int):
    for i in range(n):
        for j in range(n, i, -1):
            print("Hello World")


#Theta(n^2)
def f_4(n: int):
    count = 0

    for i in range(n):
        for j in range(2 * i + 1):
            count += 1


#Theta(n^4)
def f_5(n: int):
    count = 0

    for i in range(n ** 2):
        for j in range(i):
            count += 1


#Theta(nlogn)
def f_6(n: int):
    for i in range(n): #0..n-1
        t = 1
        while t < n: #log2n
            print("Hello World")
            t *= 2

#Theta(n+m)
def f_7(n, m: int):
    for i in range(0, n):
        print("Hello World")
    for j in range(0, m):
        print("Hello World")


#T(n) = 2n -> Theta(n)
def f_8(n, m: int):
    for i in range(0, n):
        print("Hello World")
    for j in range(0, n):
        print("Hello World")

#T(n) = 2n^2 -> Theta(n^2)
def f_9(n: int):
    for i in range(n):
        for j in range(n):
            print("Hello World")
        for k in range(n):
            print("Hello World")

#T(n) = n^2 * logn
def f_11(n: int):
    s = 0
    for i in range(1, n ** 2):
        j = i
        while j != 0:
            s = s + j - 10 * j // 10
            j //= 10
    return s



"""
Recursive functions
"""


def recursive_f_1(n: int):
    if n <= 0:
        return 1
    else:
        return 1 + recursive_f_1(n - 1)


def recursive_f_2(n: int):
    if n <= 1:
        return 1
    else:
        return 1 + recursive_f_2(n - 5)


def recursive_f_3(n: int):
    if n <= 0:
        return 1
    else:
        return 1 + recursive_f_3(n // 2)


def recursive_f_4(n, m, o):
    if n <= 0:
        print('m =', m, "n =", n, "o =", o)
    else:
        recursive_f_4(n - 1, m + 1, o)
        recursive_f_4(n - 1, m, o + 1)


def recursive_f_5(n: int):
    print(n)
    for i in range(n):
        print("Hello world!")
    if n < 1:
        return 1
    else:
        return 1 + recursive_f_5(n - 1)

def recursive_f_6(n, i: int):
    if n > 1:
        i *= 2
        m = n // 2
        recursive_f_6(m, i - 2)
        recursive_f_6(m, i - 1)
        recursive_f_6(m, i + 2)
        recursive_f_6(m, i + 1)
    else:
        print(i)

"""
Analyze the time and space complexity 
"""

def f_12(data: list):
    data_sum = 0
    for el in data:
        j = len(data)
        while j > 1:
            data_sum += el * j
            j = j // 3
    return data_sum


def f_13(data: list):
    if len(data) == 0:
        return 0
    if len(data) == 1:
        return data[0]
    m = len(data) // 2
    return f_13(data[:m]) + f_13(data[m:])


data = list(range(10))
print(data)
print('Original list id:',id(data))
slice = data[:5]
print('Slice up to 5:', slice)
print('Slice id:',id(slice))
slice.append(99)
print('Slice after adding 99:', slice)
print('Data after adding 99 to slice:', data)


data = list(range(1000))
print('Original list id:', id(data))
slice_left = data[:500]
print('Slice data[:5] id:', id(slice_left))
slice_right = data[500:]
print('Slice data[5:] id:', id(slice_right))
print('Original list id after slicing:', id(data))


# def check_execution_time(n: int):
#     print("n=" + str(n))
#     print('O(n):')
#     start_time = time.time()
#     f_1(n)
#     end_time = time.time()
#     print("--- %s seconds ---" % (round(end_time - start_time, 3)))
#
#     print('O(n^2)')
#     start_time = time.time()
#     f_3(n)
#     end_time = time.time()
#     print("--- %s seconds ---" % (round(end_time - start_time, 3)))
#
#     print('O(n^4)')
#     if n>500:
#         print("n^4 means", n**4,'elements')
#         print("Won't compute time. Because it will take a lot. ")
#     else:
#         start_time = time.time()
#         f_5(n)
#         end_time = time.time()
#         print("--- %s seconds ---" % (round(end_time - start_time, 3)))
#     print("========" * 10)
#
#
#
# check_execution_time(10)
# check_execution_time(100)
# check_execution_time(300)
# check_execution_time(500)
# check_execution_time(1000)
# check_execution_time(10000)
# check_execution_time(100000)
