from domeniu.entitati import *

class ServiceInchirieri:

    def __init__(self, inch_repo, inch_val, carti_repo, carti_val, clienti_repo, clienti_val):
        self.__inch_repo = inch_repo
        self.__inch_val = inch_val
        self.__carti_repo = carti_repo
        self.__carti_val = carti_val
        self.__clienti_repo = clienti_repo
        self.__carti_val = carti_val

    def create_inchiriere(self, cod_carte, id_client, nr):
        carte = self.__carti_repo.find(cod_carte)
        client = self.__clienti_repo.find(id_client)

        if carte is None:
            raise ValueError('Cartea nu a fost gasita!')

        if client is None:
            raise ValueError("Clientul nu a fost gasit! ")

        biblioteca = Biblioteca(carte, client, nr)

        self.__inch_val.validate_inchirieri(biblioteca)
        self.__inch_repo.store_inchiriere(biblioteca)
        return biblioteca

    def getALLinchirieri(self):
        return self.__inch_repo.getALL()

    def get_top_inchirieri(self):
        pass


from domeniu.entitati import Biblioteca, Carte, Client
from repository.RepoInchirieri import RepoInchirieri
from repository.RepoCarti import RepositoryCarti
from repository.RepoClienti import RepositoryClienti
from domeniu.Validare import ValidatorInchirieri

def test_create_inchiriere():
    repo_inchirieri = RepoInchirieri()
    repo_carti = RepositoryCarti()
    repo_clienti = RepositoryClienti()
    validator_inchirieri = ValidatorInchirieri()
    service_inchirieri = ServiceInchirieri(
        repo_inchirieri, validator_inchirieri,
        repo_carti, None, repo_clienti, None
    )

    repo_carti.store(Carte(1, "Titlu1", "Autor1", "Descriere1"))
    repo_clienti.store(Client(1, "Nume1", "CNP1"))

    # Testăm crearea unei închirieri valide
    result = service_inchirieri.create_inchiriere(1, 1, 3)
    assert isinstance(result, Biblioteca)
    assert len(repo_inchirieri.getALL()) == 1


def test_getALLinchirieri():
    repo_inchirieri = RepoInchirieri()
    repo_carti = RepositoryCarti()
    repo_clienti = RepositoryClienti()
    validator_inchirieri = ValidatorInchirieri()
    service_inchirieri = ServiceInchirieri(
        repo_inchirieri, validator_inchirieri,
        repo_carti, None, repo_clienti, None
    )

    # Verificăm dacă lista de închirieri returnată este corectă
    result = service_inchirieri.getALLinchirieri()
    assert isinstance(result, list)
    assert len(result) == 0

test_create_inchiriere()
test_getALLinchirieri()
