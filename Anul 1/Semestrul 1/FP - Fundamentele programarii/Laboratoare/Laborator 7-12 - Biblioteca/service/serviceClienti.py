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

    def createC(self, id, nume, cnp):
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
        clienti = Client(id, nume, str(cnp))
        try:
            self.__validatorClienti.validate_client(clienti)
        except ValueError as ve:
            raise ve
        try:
            self.__repoClienti.store(clienti)
        except ValueError as ve:
            raise ve
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

    def search_by_id(self, criteriu):
        """
        Search a client with the cod
        :param criteriu: string
        :return: list of client where id is id
        """
        all = self.__repoClienti.getALL()
        rez = []
        for client in all:
            if criteriu == client.getID():
                rez.append(client)
        return rez

    def search_id(self,id):
        """
        Verifica daca id-ul unui client este valid
        :param id: id-ul clientului
        :raises: ValueError daca clientul nu este gasit
        """
        self.__repoClienti.find(id)

    def update(self, id, nume, cnp):
        newClient = Client(id, nume, cnp)

        self.__validatorClienti.validate_client(newClient)

        oldClient = self.__repoClienti.find(id)

        self.__repoClienti.update(id, newClient)

    def getALLClienti(self):
        return self.__repoClienti.getALL()

    def get_nume_by_id(self, id):
        clienti = self.__repoClienti.getALL()
        for client in clienti:
            if client.getID() == id:
                return client.getNume()


#TESTE

def testCreateClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    client = srv.createC(1, "John Doe", "1234567890123")
    assert client.getID() == 1
    assert client.getNume() == "John Doe"
    assert client.getCNP() == "1234567890123"
    allClients = srv.getALLClienti()
    assert len(allClients) == 1
    assert allClients[0] == client

def testRemoveClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.createC(1, "John Doe", "1234567890123")
    assert srv.getNrClienti() == 1
    srv.remove(1)
    assert srv.getNrClienti() == 0

def testSearchClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.createC(1, "John Doe", "1234567890123")
    srv.createC(2, "Jane Doe", "1234567890456")
    foundClients = srv.search("John")
    assert len(foundClients) == 1
    assert foundClients[0].getNume() == "John Doe"

def testUpdateClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.createC(1, "John Doe", "1234567890123")
    srv.update(1, "Jane Doe", "1234567890456")
    updatedClient = srv.getALLClienti()[0]
    assert updatedClient.getNume() == "Jane Doe"
    assert updatedClient.getCNP() == "1234567890456"

def testSearchByIdClient():
    repo = RepositoryClienti()
    val = ValidatorClient()
    srv = ServiceClienti(val, repo)
    srv.createC(1, "John Doe", "1234567890123")
    srv.createC(2, "Jane Doe", "1234567890456")
    foundClients = srv.search_by_id(2)
    assert len(foundClients) == 1
    assert foundClients[0].getNume() == "Jane Doe"

testSearchByIdClient()
testCreateClient()
testRemoveClient()
testSearchClient()
testUpdateClient()
