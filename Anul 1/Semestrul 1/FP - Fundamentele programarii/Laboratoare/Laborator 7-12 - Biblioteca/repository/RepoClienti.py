#CRUD - Create Read Update Delete
from domeniu.entitati import Client

class RepositoryExceptionC(Exception):
    def __init__(self, msg):
        self.__msg = msg

    def getMsg(self):
        return self.__msg

    def __str__(self):
        return self.__msg

class DuplicatedIDException(RepositoryExceptionC):
    def __init__(self):
        RepositoryExceptionC.__init__(self, "Duplicated ID")

class RepositoryClienti:
    def __init__(self):
        """
        Initializam dictionarul ca fiind vid
        """
        self.__clienti = {}

    def store(self, client):
        """
        Store a client
        :param client: Client
        raise DuplicatedIDException for duplicated id
        """
        if client.getID() in self.__clienti:
            raise DuplicatedIDException
        self.__clienti[client.getID()] = client

    def size(self):
        """
        :return: the number of clienti in the repository
        """
        return len(self.__clienti)

    def remove(self, id):
        """
        remove a client from the repository
        :param id: string, id ul clientului care va fi eliminat
        :return: client-ul cu id ul respectiv
        raise ValueError if there is no client with that id
        """
        if not id in self.__clienti:
            raise ValueError("Nu exista un client cu id-ul acesta! ")

        client = self.__clienti[id]
        del self.__clienti[id]
        return client

    def removeALL(self):
        """
        Remove all the clients from the repository
        """
        self.__clienti = {}

    def getALL(self):
        """
        Retrive all the students
        :return: a list with clients
        """
        return list(self.__clienti.values())

    def update(self, id, client):
        """
        Update the client in the repository
        :param id: string, the id for the client to be updated
        :param client: Client, the updated client
        :return:
        """
        for element in self.__clienti.values():
            if element.getID() == id:
                element.setNume(client.getNume())
                element.setCNP(client.getCNP())

    def find(self, id):
        """
        Find the client for a given id
        :param id: string
        :return: client with given id or None if there is no client with the given id
        """
        if not id in self.__clienti:
            return None
        return self.__clienti[id]


class ClientiFileRepo(RepositoryClienti):

    def __init__(self, filename):
        RepositoryClienti.__init__(self)
        self.__filename = filename
        self.__load_from_file()

    def __load_from_file(self):
        with open(self.__filename, "r") as f:
            lines = f.readlines()

        for line in lines:
            line = line.strip().split(";")
            if line == "\n":
                break
            client_nou = Client(int(line[0]), line[1], line[2])
            RepositoryClienti.store(self, client_nou)

    def __save_to_file(self):
        """
        Salveaza in fisier date din in memory
        """
        with open(self.__filename,"w") as f:
            clienti = RepositoryClienti.getALL(self)
            for client in clienti:
                str_client = str(client.getID())+";"+str(client.getNume())+";"+str(client.getCNP())+"\n"
                f.write(str_client)

    def store(self, client):
        RepositoryClienti.store(self, client)
        self.__save_to_file()

    def remove(self, id):
        client = RepositoryClienti.remove(self, id)
        self.__save_to_file()
        return client

    def update(self, id, client):
        RepositoryClienti.update(self, id, client)
        self.__save_to_file()





#TESTE

def testRepoClienti():
    repo = RepositoryClienti()

    # Test store
    client1 = Client(1, "John", "1234567890123")
    repo.store(client1)
    assert repo.size() == 1

    # Test store duplicate
    client2 = Client(1, "Jane", "1234567890123")
    try:
        repo.store(client2)
        assert False
    except DuplicatedIDException as ex:
        pass
    assert repo.size() == 1

    # Test remove
    repo.remove(1)
    assert repo.size() == 0

    # Test update
    client3 = Client(2, "Alice", "9876543210987")
    repo.store(client3)
    repo.update(2, client3)
    updated = repo.find(2)
    assert updated == client3

    # Test remove all
    client4 = Client(3, "Bob", "5678901234567")
    repo.store(client4)
    assert repo.size() == 2
    repo.removeALL()
    assert repo.size() == 0


testRepoClienti()