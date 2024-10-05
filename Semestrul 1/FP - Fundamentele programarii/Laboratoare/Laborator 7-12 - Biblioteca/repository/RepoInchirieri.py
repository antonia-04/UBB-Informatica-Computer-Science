#CRUD - Create Read Update Delete
from domeniu.entitati import Carte, Client
from domeniu.Inchirieri import Inchiriere
from domeniu.Validare import ValidatorCarte, ValidatorClient
from repository.RepoClienti import RepositoryClienti
from repository.RepoCarti import RepositoryCarti

class RepoInchirieri:
    def __init__(self):
        """
        Initializam clasa in care vom adauga
        """
        self.__inchirieri = []

    def add_inchiriere(self, inchiriere):
        """
        Functia adauga la lista de inchirieri
        """
        self.__inchirieri.append(inchiriere)

    def delete_inchiriere(self, inchiriere):
        """
        Functia sterge o inchirere
        inchiriere = inchirierea pe care o stergem
        element = inchirierea din lista
        """
        lista = []
        for element in self.__inchirieri:
            if element.getIDClient() != inchiriere.getIDClient() and element.getCodCarte() != inchiriere.getCodCarte():
                lista.append(element)

        self.__inchirieri = lista

    def getALL(self):
        return self.__inchirieri

    def create_nr_inch_carti(self):
        """
        Creeaza o lista cu frecventa inchirierilor unei carti
        :return: list
        """
        freq = [0] * 100
        for element in self.__inchirieri:
            cod = int(element.getCodCarte())
            freq[cod] = freq[cod] + 1

        return freq


    def create_nr_inch_client(self):
        """
        Creeaza o lista cu frecventa aparitiilor unui client
        :return: list
        """
        freq = [0] * 100
        for element in self.__inchirieri:
            id = int(element.getIDClient())
            freq[id] = freq[id] + 1

        return freq


class InchirieriFileRepo(RepoInchirieri):

    def __init__(self, filename):
        RepoInchirieri.__init__(self)
        self.__filename = filename
        self.__load_from_file()

    def __load_from_file(self):
        with open(self.__filename, "r") as f:
            lines = f.readlines()
        for line in lines:
            line = line.strip().split(",")
            if line == '\n':
                break
            inchiriere_noua = Inchiriere(line[0], line[1])
            InchirieriFileRepo.add_inchiriere(self, inchiriere_noua)

    """
    #Cerinta lab 10
    def __load_from_file(self):
        with open(self.__filename, "r") as f:
            for line in f:
                cod = line.strip()
                id = next(f).strip()
                inchiriere_noua = Inchiriere(cod, id)
                InchirieriFileRepo.add_inchiriere(self, inchiriere_noua)

    """

    def __save_to_file(self):
        with open(self.__filename, "w") as f:
            inchirieri = RepoInchirieri.getALL(self)
            for inch in inchirieri:
                strf = str(inch.getCodCarte()) + "," +  str(inch.getIDClient())+ "\n"
                f.write(strf)

    '''
    #cerinta lab 10
    def __save_to_file(self):
        with open(self.__filename, "w") as f:
            inchirieri = RepoInchirieri.getALL(self)
            for inch in inchirieri:
                strf = str(inch.getCodCarte()) + "\n" + str(inch.getIDClient()) + "\n"
                f.write(strf)

    '''

    def add_inchiriere(self, inchiriere):
        RepoInchirieri.add_inchiriere(self, inchiriere)
        self.__save_to_file()

    def delete_inchiriere(self, inchiriere):
        RepoInchirieri.delete_inchiriere(self, inchiriere)
        self.__save_to_file()




#TESTE

def testRepoInchirieri():
    repo_inchirieri = RepoInchirieri()

    # Test add_inchiriere
    inchiriere1 = Inchiriere(1, 101)
    repo_inchirieri.add_inchiriere(inchiriere1)
    assert len(repo_inchirieri.getALL()) == 1

    # Test delete_inchiriere
    inchiriere2 = Inchiriere(2, 102)
    repo_inchirieri.add_inchiriere(inchiriere2)
    repo_inchirieri.delete_inchiriere(inchiriere1)
    assert len(repo_inchirieri.getALL()) == 1


testRepoInchirieri()