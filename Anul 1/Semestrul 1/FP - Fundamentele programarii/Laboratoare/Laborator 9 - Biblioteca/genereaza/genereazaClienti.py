from domeniu.entitati import Client
from domeniu.Validare import ValidatorClient
from repository.RepoClienti import RepositoryClienti
import random

class GenereazaClienti:

    def __init__(self, repo2, val2):
        """
        Genereaza automat clienti
        :param repo2: obiecte de tip repo care ne ajuta sa gestionam multimea de clienti
        :type repo2: InMemoryRepository
        :param val2: validator pentru verificarea cartilor
        :type val2: ShowValidator
        """
        self.__repo2 = repo2
        self.__validatorClient = val2

    def generate_random_string(self, lungime):
        sir = ''
        caractere_valide = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

        for i in range(lungime):
            caracter_aleatoriu = random.choice(caractere_valide)
            sir += caracter_aleatoriu
        return sir

    def generate_random_cnp(self, lungime):
        sir = ''
        caractere_valide = '0123456789'

        for i in range(lungime):
            caracter_aleatoriu = random.choice(caractere_valide)
            sir += caracter_aleatoriu
        return sir

    def generate(self, x):
        for i in range(x):
            id = random.randint(1, 99)
            l_nume = random.randint(3, 30)

            nume = self.generate_random_string(l_nume)
            cnp = self.generate_random_cnp(13)

            client = Client(id, nume, cnp)
            try:
                self.__validatorClient.validate_client(client)
            except ValueError as ve:
                raise ve
            try:
                self.__repo2.store(client)
            except ValueError as ve:
                raise ve




class TestGenereazaClienti:
    def test_generate(self):
        repo = RepositoryClienti()
        validator = ValidatorClient()
        genereaza_clienti = GenereazaClienti(repo, validator)

        genereaza_clienti.generate(5)

        assert len(repo.getALL()) != 0

#TestGenereazaClienti().test_generate()
