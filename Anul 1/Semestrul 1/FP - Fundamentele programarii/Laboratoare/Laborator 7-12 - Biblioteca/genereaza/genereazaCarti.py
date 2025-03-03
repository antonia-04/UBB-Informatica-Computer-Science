from domeniu.entitati import Carte
from domeniu.Validare import ValidatorCarte
from repository.RepoCarti import RepositoryCarti
import random

class GenereazaCarti:

    def __init__(self, repo2, val2):
        """
        Genereaza automat carti
        :param repo2: obiecte de tip repo care ne ajuta sa gestionam multimea de carti
        :type repo2: InMemoryRepository
        :param val2: validator pentru verificarea cartilor
        :type val2: ShowValidator
        """
        self.__repo2 = repo2
        self.__validatorCarti = val2

    def generate_random_string(self, lungime):
        sir = ''
        caractere_valide = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

        for i in range(lungime):
            caracter_aleatoriu = random.choice(caractere_valide)
            sir += caracter_aleatoriu
        return sir

    def generate(self, x):
        for i in range(x):
            cod = random.randint(1, 99)
            l_titlu = random.randint(3, 30)
            l_autor = random.randint(3, 30)
            l_descriere = random.randint(3, 40)

            titlu = self.generate_random_string(l_titlu)
            autor = self.generate_random_string(l_autor)
            descriere = self.generate_random_string(l_descriere)

            carte = Carte(cod, titlu, autor, descriere)
            try:
                self.__validatorCarti.validate_carte(carte)
            except ValueError as ve:
                raise ve
            try:
                self.__repo2.store(carte)
            except ValueError as ve:
                raise ve




class TestGenereazaCarti:
    def test_generate(self):
        repo = RepositoryCarti()
        validator = ValidatorCarte()
        genereaza_carte = GenereazaCarti(repo, validator)

        genereaza_carte.generate(5)

        assert len(repo.getALLcarti()) != 0


#TestGenereazaCarti().test_generate()
