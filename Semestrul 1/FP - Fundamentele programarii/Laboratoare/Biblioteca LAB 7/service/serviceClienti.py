from domeniu.entitati import Client
from domeniu.Validare import ValidatorClient, ValidatorClientException
from repository.RepoClienti import RepositoryClienti

class ServiceClienti:
    def __init__(self, val, repo):
        """
        Initializeaza service
        :param repo: obiect de tip repo care ne ajuta sa destionam multimea de carti si clienti
        :type repo: InMemoryRepository
        :param val: validator pentru clienti
        :type val: ShowValidator
        """
        self.__repoClienti = repo
        self.__validatorClienti = val

    def create(self, id, nume): #def create(self, id, nume, cnp):
        """
        Adauga clienti
        :param id: id-ul clientului
        :type id: int
        :param nume: numele clientului
        :type nume: str
        :param cnp: cnp-ul clientului
        :type cnp: int
        :return: ValueError daca clientii au date invalide
        """
        clienti = Client(id, nume)
        #clienti = Client(id, nume, cnp)

        self.__validatorClienti.validate_client(clienti)
        self.__repoClienti.store(clienti)
        return clienti

    def getNrClienti(self):
        return self.__repoClienti.size()

    def remove(self, id):
        return self.__repoClienti.remove(id)

    def search(self, criteriu):
        all = self.__repoClienti.getALL()
        if criteriu == "":
            return all

        rez = []
        for client in all:
            if criteriu in client.getNume():
                rez.append(client)

        return rez

    def update(self, id, nume): #def update(self, id, nume, cnp):
        newClient = Client(id, nume)
        #newClient = Client(id, nume, cnp)

        self.__validatorClienti.validate_client(newClient)

        oldClient = self.__repoClienti.find(id)

        self.__repoClienti.update(id, newClient)

    def getALLClienti(self):
        return self.__repoClienti.getALL()

#TESTE

def testCreateClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    client = srv.create(1, "John Doe")
    assert client.getID() == 1
    assert client.getNume() == "John Doe"
    #assert client.getCNP() == "1234567890123"
    allClients = srv.getALLClienti()
    assert len(allClients) == 1
    assert allClients[0] == client

def testRemoveClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.create(1, "John Doe")
    assert srv.getNrClienti() == 1
    srv.remove(1)
    assert srv.getNrClienti() == 0

def testSearchClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.create(1, "John Doe")
    srv.create(2, "Jane Doe")
    foundClients = srv.search("John")
    assert len(foundClients) == 1
    assert foundClients[0].getNume() == "John Doe"

def testUpdateClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.create(1, "John Doe")
    srv.update(1, "Jane Doe")
    updatedClient = srv.getALLClienti()[0]
    assert updatedClient.getNume() == "Jane Doe"
    #assert updatedClient.getCNP() == "1234567890456"


testCreateClient()
testRemoveClient()
testSearchClient()
testUpdateClient()
