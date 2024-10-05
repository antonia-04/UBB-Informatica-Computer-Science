from domeniu.entitati import Carte
from domeniu.Validare import ValidatorCarte
from repository.RepoCarti import RepositoryCarti

class ServiceCarti:
    def __init__(self, val, repo):
        self.__val = val
        self.__repo = repo

    def create(self, cod, titlu, autor, descriere):
        """
        Create, validate and store a carte
        :param cod:
        :param titlu:
        :param autor:
        :param descriere:
        :return:
        """
        #create Carte instance
        carte = Carte(cod, titlu, autor, descriere)
        try:
            self.__val.validate_carte(carte)
        except ValueError as ve:
            raise ve
        try:
            self.__repo.store(carte)
        except ValueError as ve:
            raise ve


        return carte

    def getNrCarti(self):
        """
        Return the number of carti
        :return: int
        """
        return self.__repo.size()

    def remove(self, cod):
        """
        Remove carte with the given cod
        :param cod: string
        :return:
        """
        return self.__repo.remove(cod)

    def search(self, criteriu):
        """
        Search a carte with the titlu containing criteriu
        :param criteriu: string
        :return: list of carti where the titlu is criteriu
        """
        all = self.__repo.getALLcarti()
        if criteriu == "":
            return all

        rez = []
        for carte in all:
            if criteriu in carte.getTitlu():
                rez.append(carte)

        return rez

    def update(self, cod, titlu, autor, descriere):
        """
        Update the carte with the given cod
        :param cod: string
        :param titlu: string
        :param autor: string
        :param descriere: string
        :return: the old carte
        raise ValueError if the carte is invalid, if there is no carte with the given cod
        """
        newCarte = Carte(cod, titlu, autor, descriere)

        #validate the new carte
        self.__val.validate_carte(newCarte)
        #get the old carte
        oldCarte = self.__repo.find(cod)
        #update the carte
        self.__repo.update(cod, newCarte)
        return oldCarte

    def getALLcarti(self):
        """
        Returneaza o lista cu toate cartile disponibile
        :return: lista de carti disponibile
        :rtype: list of objects de tip carte
        """
        return self.__repo.getALLcarti()


#TESTE

def testCreateCarte():
    repo = RepositoryCarti()
    val = ValidatorCarte()
    srv = ServiceCarti(val, repo)
    carte = srv.create(1, "Carte", "Autor", "descriere")
    assert carte.getCod() == 1
    assert carte.getTitlu() == "Carte"
    assert carte.getAutor() == "Autor"
    assert carte.getDescriere() == "descriere"
    allCarti = srv.getALLcarti()
    assert len(allCarti) == 1
    assert allCarti[0] == carte

def testRemoveCarte():
    repo = RepositoryCarti()
    val = ValidatorCarte()
    srv = ServiceCarti(val, repo)
    srv.create(1, "Carte1", "Autor1", "descriere1")
    srv.create(2, "Carte2", "Autor2", "descriere2")
    assert srv.getNrCarti() == 2
    srv.remove(1)
    assert srv.getNrCarti() == 1

def testSearchCarte():
    repo = RepositoryCarti()
    val = ValidatorCarte()
    srv = ServiceCarti(val, repo)
    srv.create(1, "Carte1", "Autor1", "descriere1")
    srv.create(2, "Carte2", "Autor2", "descriere2")
    foundCarti = srv.search("Carte")
    assert len(foundCarti) == 2

def testUpdateCarte():
    repo = RepositoryCarti()
    val = ValidatorCarte()
    srv = ServiceCarti(val, repo)
    srv.create(1, "Carte1", "Autor1", "descriere1")
    srv.update(1, "Carte11", "Autor11", "descriere11")
    updatedCarte = srv.getALLcarti()[0]
    assert updatedCarte.getTitlu() == "Carte11"
    assert updatedCarte.getAutor() == "Autor11"
    assert updatedCarte.getDescriere() == "descriere11"


testCreateCarte()
testRemoveCarte()
testSearchCarte()
testUpdateCarte()
