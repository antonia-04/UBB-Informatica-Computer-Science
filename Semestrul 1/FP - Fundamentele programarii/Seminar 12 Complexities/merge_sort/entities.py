class Product:
    def __init__(self, id, nume, pret):
        self.__id = id
        self.__name = nume
        self.__price = pret

    def getId(self):
        return self.__id

    def getName(self):
        return self.__name

    def getPrice(self):
        return self.__price

    def __eq__(self, other):
        if self.__id == other.__id:
            return True
        return False

    def __str__(self):
        return self.__name + ':' + str(self.__price)
