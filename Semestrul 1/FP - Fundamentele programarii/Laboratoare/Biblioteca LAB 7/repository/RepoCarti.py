#CRUD - Create Read Update Delete
from domeniu.entitati import Carte

class RepositoryException(Exception):
    """
    Base class for the exceptions in the repository
    """
    def __init__(self, msg):
        self.__msg = msg

    def getMsg(self):
        return self.__msg

    def __str__(self):
        return self.__msg

class DuplicatedCodException(RepositoryException):
    def __init__(self):
        RepositoryException.__init__(self, 'Codul cartii apare de doua ori')

class RepositoryCarti:
    """
    Manage the store/retrival of carti
    """
    def __init__(self):
        self.__carti = {}

    def store(self, carte):
        """
        Store carti
        carte is a Carte
        raise RepositoryException if we have a book with the same cod
        :param carte:
        :return:
        """
        if carte.getCod() in self.__carti:
            raise DuplicatedCodException()

        self.__carti[carte.getCod()] = carte #in dictionar la key codul cartii se pune cartea

    def size(self):
        """
        :return: number of carti in repository
        """
        return len(self.__carti)

    def remove(self, cod):
        """
        remove a carte from repository
        cod - string, cod ul cartii care trebuie sa fie sters
        return carte
        :param cod:
        :return:
        """
        if not cod in self.__carti:
            raise ValueError("Nu exista o carte cu acest cod")
        carte = self.__carti[cod]
        del self.__carti[cod]
        return carte

    def removeALL(self):
        """
        Sterge toate cartile din repository
        """
        self.__carti = {}

    def getALLcarti(self):
        """
        Colecteaza toate cartile
        return: a list with all carti
        """

        return list(self.__carti.values())

    def update(self, cod, carte):
        """
          Update carte in the repository
          cod - string, the cod of the student to be updated
          carte - Carte, the updated carte
          raise ValueError if there is no student with the given id
        """
        #remove the old carte (this will raise exception if there is no carte)
        self.remove(cod)
        #store the student
        self.store(carte)

    def find(self, cod):
        """
        Gaseste cartea cu codul dat
        :param cod: string
        :return: carte cu codul respectiv sau None daca nu exista
        """
        if not cod in self.__carti:
            return None
        return self.__carti[cod]

#Teste

def testRepoCarti():
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett")
    repo = RepositoryCarti()

    # Test store
    assert repo.size() == 0
    repo.store(carte)
    assert repo.size() == 1

    # Test store duplicate
    carte2 = Carte(13, "Oameni", "James Bartlett")
    repo.store(carte2)
    assert repo.size() == 2

    # Test store duplicate exception
    carte1 = Carte(12, "Oameni VS Tehnologie", "James Bartlett")
    try:
        repo.store(carte1)
        assert False
    except RepositoryException:
        pass

    # Test get all carti
    allC = repo.getALLcarti()
    assert len(allC) == 2

    # Test remove
    removed = repo.remove(12)
    assert removed == carte

    # Test update
    updated = Carte(13, "New Title", "New Author")
    repo.update(13, updated)
    found = repo.find(13)
    assert found == updated

    # Test remove all
    repo.removeALL()
    assert repo.size() == 0


testRepoCarti()
