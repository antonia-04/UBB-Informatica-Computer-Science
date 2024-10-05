class Carte:
    nr_carti = 0

    def __init__(self, cod, titlu, autor, descriere):
        self.__cod = int(cod)
        self.__titlu = titlu
        self.__autor = autor
        self.__descriere = descriere
        Carte.nr_carti += 1

    #Getters

    def getCod(self):
        return self.__cod

    def getTitlu(self):
        return self.__titlu

    def getDescriere(self):
        return self.__descriere

    def getAutor(self):
        return self.__autor

    #Setters

    def setCod(self, value):
        self.__cod = value

    def setTitlu(self, value):
        self.__titlu = value

    def setDescriere(self, value):
        self.__descriere = value

    def setAutor(self, value):
        self.__autor = value

    def __eq__(self, other):
        """
        Verifica egalitatea dintre cartea curenta si o alta carte (other)
        :param other:
        :return: True (cartile sunt egale, au aceeasi parametrii) else False
        """
        if self.__titlu == other.getTitlu() and self.__autor == other.getAutor():
            return True
        else:
            return False

    def __str__(self):
        """
        Provide a string representation for Carte
        :return: a string
        """
        return "Cod: " + str(self.__cod) + "| Titlu: " + str(self.__titlu) + "| Autor: " + str(self.__autor) + "| Descriere: " + str(self.__descriere)

    @staticmethod
    def getNumberofCartiObjects():
        return Carte.nr_carti

class Client:
    nr_clienti = 0

    def __init__(self, id, nume, cnp):
        """
        Creeaza un nou client cu paramentrii cod, nume si cnp
        :param cod: id
        :type cod: int
        :param nume: nume
        :type nume: str
        :param cnp: cnp
        :type cnp: str
        """
        self.__id = int(id)
        self.__nume = nume
        self.__cnp = cnp
        Client.nr_clienti +=1

    #Getters
    def getID(self):
        return int(self.__id)

    def getNume(self):
        return self.__nume

    def getCNP(self):
        return self.__cnp

    #Setters (value = noua valoare)

    def setID(self, value):
        self.__id = value

    def setNume(self, value):
        self.__nume = value

    def setCNP(self, value):
        self.__cnp = value

    def __eq__(self, other):
        """
        Verificam daca doi clienti sunt egali <=> id1 == id2
        :param other:
        :type other: Client
        :return: True daca sunt egali, False daca nu
        """
        if self.__id == other.getID():
            return True
        return False

    def __str__(self):
        return "Id: " + str(self.__id) + '| Numele: ' + str(self.__nume) + '| CNP:' + str(self.__cnp)

    @staticmethod
    def getNumberofClientiObjects():
        return Client.nr_clienti


class Biblioteca:

    def __init__(self, carte, client, inchirieri):
        self.__carte = carte
        self.__client = client
        self.__inchirieri = int(inchirieri)

    #Getters
    def getCarte(self):
        return self.__carte

    def getClient(self):
        return self.__client

    def getInchirieri(self):
        return self.__inchirieri

    def __str__(self):
        return "Carte: [" + str(self.__carte.getTitlu()) + ']; Client: ' + str(self.__client.getNume()) + '; Inchiriere:' + str(self.__inchirieri)


#TESTE
def testCreateCarte():
    """
    Testing the creation of a carte
    cod, titlu, autor, descriere
    """
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    assert carte.getCod() == 12
    assert carte.getTitlu() == "Oameni VS Tehnologie"
    assert carte.getAutor() == "James Bartlett"
    assert carte.getDescriere() == "tech"

def testCreateClient():
    """
    Testing the creation of a client
    id, nume, cnp
    """
    client = Client(1, "Ion", "1234567890123")
    assert client.getID() == 1
    assert client.getNume() == "Ion"
    assert client.getCNP() == "1234567890123"


def testCreateBiblioteca():
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    client = Client(1, "Ion", "1234567890123")
    inchiriere = 3

    biblioteca = Biblioteca(carte, client, inchiriere)

    assert biblioteca.getCarte() == carte
    assert biblioteca.getClient() == client
    assert biblioteca.getInchirieri() == inchiriere


def testEqualCarte():
    carte1 = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    carte2 = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    assert carte2 == carte1

def testEqualClient():
    client1 = Client(1, "Ion", "1234567890123")
    client2 = Client(1, "Ion", "1234567890123")
    assert client2 == client1


def testSetCarte():
    """
    Testing the setters for Carte class
    """
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    carte.setCod(15)
    carte.setTitlu("Nume nou")
    carte.setAutor("Autor nou")
    carte.setDescriere("Descriere noua")

    assert carte.getCod() == 15
    assert carte.getTitlu() == "Nume nou"
    assert carte.getAutor() == "Autor nou"
    assert carte.getDescriere() == "Descriere noua"


def testSetClient():
    """
    Testing the setters for Client class
    """
    client = Client(1, "Ion", "1234567890123")
    client.setID(2)
    client.setNume("Nume nou")
    client.setCNP("9876543210987")

    assert client.getID() == 2
    assert client.getNume() == "Nume nou"
    assert client.getCNP() == "9876543210987"


def testBibliotecaStr():
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    client = Client(1, "Ion", "1234567890123")
    inchiriere = 3

    biblioteca = Biblioteca(carte, client, inchiriere)
    assert str(biblioteca) == "Carte: [Oameni VS Tehnologie]; Client: Ion; Inchiriere:3"


testSetCarte()
testSetClient()
testBibliotecaStr()
testCreateCarte()
testEqualCarte()
testCreateClient()
testEqualClient()
testCreateBiblioteca()