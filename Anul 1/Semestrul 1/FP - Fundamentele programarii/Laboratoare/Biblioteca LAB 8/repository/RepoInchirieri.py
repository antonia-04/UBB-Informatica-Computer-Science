#CRUD - Create Read Update Delete
from domeniu.entitati import Biblioteca

class RepoInchirieri:
    def __init__(self):
        self.__inchirieri = []

    def find_inchiriere(self, rent):
        """
        Find inchiriere cautata (rent == o inchiriere)
        :param rent: Biblioteca
        :return: inchiriere, None if inchiriere not found
        """
        for inchirieri in self.__inchirieri:
            if rent == inchirieri:
                return inchirieri
        return None

    def store_inchiriere(self, rent):
        """
        Se cauta rent in lista de inchirieri
        :param rent: inchiriere tip Biblioteca
        lista de inchirieri se modifica prin adaugarea rent daca ea nu exista deja
        """
        inchiriere = self.find_inchiriere(rent)
        if inchiriere is not None:
            raise ValueError("Aceasta inchiriere exista deja, nu o putem stoca! ")

        self.__inchirieri.append(rent)

    def getALL(self):
        return self.__inchirieri

#TESTE

def testCreateInchiriere():
    repo = RepoInchirieri()

    # Test store_inchiriere
    biblioteca = Biblioteca("Titlu1", "Nume1", 3)
    repo.store_inchiriere(biblioteca)
    assert len(repo.getALL()) == 1

testCreateInchiriere()


def testFINDInchiriere():
    repo = RepoInchirieri()

    # Test find_inchiriere
    biblioteca = Biblioteca("Titlu1",  "Nume1", 3)
    repo.store_inchiriere(biblioteca)

    found = repo.find_inchiriere(biblioteca)
    assert found == biblioteca

testFINDInchiriere()





