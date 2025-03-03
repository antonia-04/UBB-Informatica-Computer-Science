"""13) Se dă o listă de numere întregi a1,...an.
Generaţi toate permutările listei pentru carenumerele au aspect de munte
(cresc până la un punct de unde descresc). Ex. 10, 16, 27, 18, 14, 7."""


lista = []


def dimensiune_lista(lista):
    return len(lista)

def print_sol(solutie):
    for i in range(len(solutie)):
        print(solutie[i], end= " ")


def consisent(v):
    # conditii sa fie inconsisenta: varful e pe prima sau ultima poz
    if len(v) == 1:
        return True
    #verificam daca exista duplicate
    if len(v) != len(set(v)):
        return False

    if lista[v[0]] > lista[v[1]]:
        return False

    ok = True
    i = 0
    # cautam primul varf sau daca sirul este crescator
    while ok and i < len(v) - 1:
        if lista[v[i]] >= lista[v[i + 1]]:
            ok = False
        else:
            i += 1
    # daca sirul este crescator si len permutare/sol candidat
    if ok == True and len(v) == len(lista):
        return False
    # in i ramane elementul gasit cu pozitia cea mai mare
    # daca gasim un varf mai mare atunci e invalid!
    while (i < len(v) - 1):
        if lista[v[i]] <= lista[v[i + 1]]:
            return False
        else:
            i += 1
    # altfel e valid si e o solutie candidat
    return True



def solutie(x):
    if len(x) == len(lista):
        return True

def solutieFound(x):
    t = []
    for i in range(len(lista)):
        t.append(lista[x[i]])
    print(t)


def BackTracking_Recursiv(x):
    x.append(0)
    for i in range(len(lista)):
        x[-1] = i
        if consisent(x) == True:
            if solutie(x) == True:
                solutieFound(x)
            BackTracking_Recursiv(x)
    x.pop()



def BackTracking_Iterativ(dim):
    x = [-1]  # candidate solution
    while len(x) > 0:
        choosed = False
        while not choosed and x[-1] < dim - 1:  # if we can increase the last component
            x[-1] = x[-1] + 1  # increase the last component
            choosed = consisent(x)
        if choosed:
            if solutie(x):
                solutieFound(x)
            x.append(-1)  # expand candidate solution
        else:
            x = x[:-1]  # go back one component


def citire():
    lista.clear()
    n=int(input("Dati numarul de numere din vector: "))
    for i in range(n):
        lista.append(int(input(f"Dati {i+1}-lea numar:")))
    return n

# *****************************

def main():
    while True:
        n = citire()
        print(f"Sirul introdus este {lista}")
        x = []
        op = int(input("Selectati optiunea: 1 - recursiv, 2 - iterativ"))
        if op == 1:
            BackTracking_Recursiv(x)
        else:
            BackTracking_Iterativ(n)


main()