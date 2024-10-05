#DTO din lista in aceasta entitate

class Inchiriere:
    def __init__(self, id, cod):
        self.__id = id
        self.__cod = cod

    def getIDClient(self):
        return self.__id

    def getCodCarte(self):
        return self.__cod

    def setID(self, value):
        self.__id = value

    def setCod(self, value):
        self.__cod = value

    def __str__(self):
        return "ID Client: " + str(self.__id) + "Cod Carte: " + str(self.__cod)
