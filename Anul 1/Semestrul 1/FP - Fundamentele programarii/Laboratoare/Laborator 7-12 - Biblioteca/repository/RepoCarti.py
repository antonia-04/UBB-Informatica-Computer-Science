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
        for element in self.__carti.values():
            if element.getCod() == cod:
                element.setTitlu(carte.getTitlu())
                element.setAutor(carte.getAutor())
                element.setDescriere(carte.getDescriere())


    def find(self, cod):
        """
        Gaseste cartea cu codul dat
        :param cod: string
        :return: carte cu codul respectiv sau None daca nu exista
        """
        if not cod in self.__carti:
            return None
        return self.__carti[cod]

class CartiFileRepo(RepositoryCarti):
    def __init__(self, filename):
        """
            Constructorul clasei
            :param filename: numele fisierului
        """
        RepositoryCarti.__init__(self)
        self.__filename = filename
        self.__load_from_file()

    def __load_from_file(self):
        """
        Pune in repo-ul din memorie cartile din fisier
        """
        with open(self.__filename,"r") as f:
            lines = f.readlines()
        for line in lines:
            line = line.strip().split(";")
            if line[0] == "\n":
                    break
            carte_noua = Carte(int(line[0]), line[1], line[2], line[3])
            RepositoryCarti.store(self, carte_noua)

    def __save_to_file(self):
        """
        Salveaza in fisier date din in memory
        """
        with open(self.__filename,"w") as f:
            carti = RepositoryCarti.getALLcarti(self)
            for carte in carti:
                str_carte = str(carte.getCod())+";"+str(carte.getTitlu())+";"+str(carte.getAutor())+";"+str(carte.getDescriere())+"\n"
                f.write(str_carte)

    def store(self, carte):
        """
        Store carti
        carte is a Carte
        raise RepositoryException if we have a book with the same cod
        :param carte:
        :return:
        """
        RepositoryCarti.store(self, carte)
        # Verifică dacă cartea există deja
        existing = self.find(carte.getCod())
        if existing:
            raise DuplicatedCodException()
        self.__save_to_file()  # Salvează în fișier după modificare

    # def size(self):
    #     """
    #     :return: number of carti in repository
    #     """
    #     return RepositoryCarti.size(self)

    def remove(self, cod):
        """
        remove a carte from repository
        cod - string, cod ul cartii care trebuie sa fie sters
        return carte
        :param cod:
        :return:
        """
        carte = RepositoryCarti.remove(self, cod)
        self.__save_to_file()
        return carte


    def removeALL(self):
        """
        Sterge toate cartile din repository
        """
        RepositoryCarti.removeALL(self)
        self.__save_to_file()


    def update(self, cod, carte):
        """
          Update carte in the repository
          cod - string, the cod of the student to be updated
          carte - Carte, the updated carte
          raise ValueError if there is no student with the given id
        """
        RepositoryCarti.update(self, cod, carte)
        self.__save_to_file()

    # def find(self, cod):
    #     """
    #     Gaseste cartea cu codul dat
    #     :param cod: string
    #     :return: carte cu codul respectiv sau None daca nu exista
    #     """
    #     RepositoryCarti.find(self, cod)



#Teste

def test_repo_carti():
    repo_carti = RepositoryCarti()

    # Test store and size
    carte = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    repo_carti.store(carte)
    assert repo_carti.size() == 1

    # Test store duplicate
    carte2 = Carte(13, "Oameni", "James Bartlett", "tech")
    repo_carti.store(carte2)
    assert repo_carti.size() == 2

    # Test store duplicate exception
    carte1 = Carte(12, "Oameni VS Tehnologie", "James Bartlett", "tech")
    try:
        repo_carti.store(carte1)
        assert False
    except DuplicatedCodException:
        pass

    # Test get all carti
    all_carti = repo_carti.getALLcarti()
    assert len(all_carti) == 2

    # Test remove
    removed = repo_carti.remove(12)
    assert removed == carte
    assert repo_carti.size() == 1

    # Test update
    updated = Carte(13, "New Title", "New Author", "New Description")
    repo_carti.update(13, updated)
    found = repo_carti.find(13)
    assert found == updated

    # Test remove all
    repo_carti.removeALL()
    assert repo_carti.size() == 0


# Rulează testele
test_repo_carti()