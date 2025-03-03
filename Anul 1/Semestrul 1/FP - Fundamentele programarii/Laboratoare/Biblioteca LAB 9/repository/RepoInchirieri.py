#CRUD - Create Read Update Delete
from domeniu.entitati import Carte, Client
from domeniu.Validare import ValidatorCarte, ValidatorClient
from repository.RepoClienti import RepositoryClienti
from repository.RepoCarti import RepositoryCarti

class RepoInchirieri:
    def __init__(self):
        """
        Initializam clasa in care vom adauga
        """
        self.__inchirieri = []

    def add_inchiriere(self, id, cod):
        """
        Functia adauga la lista de inchirieri
        id = id client
        cod = cod carte
        """
        self.__inchirieri.append((id, cod))

    def delete_inchiriere(self, id, cod):
        """
        Functia sterge o inchiriere
        :param id: id client
        :param cod: cod carte
        :raises: ValueError daca filmul nu este gasit
        """
        ok = True
        for i in range(len(self.__inchirieri)):
            if self.__inchirieri[i][0] == id and self.__inchirieri[i][1] == cod:
                self.__inchirieri.pop(i)
                ok = False
                break
        if ok == True:
            raise ValueError("Inchirierea nu a fost gasita! ")

    def getList(self):
        """
        Aceasta functie obtine lista cu numarul cartilor inchiriate de fiecare client
        :return:
        """
        freq = [0] * 100
        for id, cod in self.__inchirieri:
            freq[id] += 1
        return freq

    def getAllforMax(self):
        """
        obtine lista de carti si cati clienti le au inchiriat
        :return:
        """
        freq = [0] * 100
        maxx = 0
        codmax = 0
        for id, cod in self.__inchirieri:
            freq[codmax] += 1
            if freq[codmax] > maxx:
                maxx = freq[cod]
                codmax = cod

        lista = []

        for id, cod in self.__inchirieri:
            if cod == codmax:
                lista.append(id)
        return lista

    def get_all_id(self, id_cautat):
        """
        Functia cauta toate cartile inchiriate de un client
        :param id: id-ul clientului cautat
        """
        books = []
        for id, cod in self.__inchirieri:
            if id==id_cautat:
                books.append(cod)
        return books

    def get_all_cod(self, cod_cautat):
        """
        Functia cauta totii clientii care au inchiriat o carte
        :param cod: codul cartii cautate
        """
        clienti = []
        for id, cod in self.__inchirieri:
            if cod == cod_cautat:
                clienti.append(id)
        return clienti

    def getALL(self):
        return self.__inchirieri



#TESTE

def test_add_rent():
    repo_carti = RepositoryCarti()
    repo_client = RepositoryClienti()
    repo_rent= RepoInchirieri()
    customer = Client(1,"Antonia Moga","502021314002")
    carte = Carte(1,"Poveste","Mihai","wow")

    repo_client.store(customer)
    repo_carti.store(carte)

    repo_rent.add_inchiriere(1,1)

    assert repo_rent.getALL() == [(1,1)]

test_add_rent()

def test_delete_rent():
    repo_carti = RepositoryCarti()
    repo_client = RepositoryClienti()
    repo_rent= RepoInchirieri()
    customer = Client(1,"Antonia Moga","502021314002")
    carte = Carte(1,"Poveste","Mihai","wow")

    repo_client.store(customer)
    repo_carti.store(carte)

    repo_rent.add_inchiriere(1,1)

    assert repo_rent.getALL()==[(1,1)]

    repo_rent.delete_inchiriere(1,1)

    assert repo_rent.getALL()==[]


def test_get_list():
    repo_rent= RepoInchirieri()
    repo_rent.add_inchiriere(1,2)
    repo_rent.add_inchiriere(1,3)
    repo_rent.add_inchiriere(2,4)
    repo_rent.add_inchiriere(5,3)

    lst = repo_rent.getList()

    assert lst == [0,2,1,0,0,1]+[0]*94

def test_get_all_id():
    repo_rent= RepoInchirieri()
    repo_rent.add_inchiriere(1,1)
    repo_rent.add_inchiriere(1,2)
    assert repo_rent.get_all_id(1) == [1,2]

def test_last():
    repo_rent= RepoInchirieri()
    repo_rent.add_inchiriere(1,2)
    repo_rent.add_inchiriere(1,3)
    repo_rent.add_inchiriere(2,4)
    repo_rent.add_inchiriere(5,3)

    lst = repo_rent.getAllforMax()

    assert lst == [1,5]



test_add_rent()
test_delete_rent()
test_get_list()
test_last()
test_get_all_id()

