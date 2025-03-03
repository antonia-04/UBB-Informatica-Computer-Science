from repository.RepoInchirieri import RepoInchirieri
from domeniu.Inchirieri import Inchiriere
class ServiceInchirieri:
    def __init__(self, repo):
        self.__repo = repo

    def add_inchiriere_s(self, cod, id):
        """
        Se adauga o inchiriere
        :param id: id client
        :param cod: id carte
        """
        inch = Inchiriere(cod, id)
        self.__repo.add_inchiriere(inch)

    def remove_inchiriere_s(self, cod, id):
        inch = Inchiriere(cod, id)
        self.__repo.delete_inchiriere(inch)

    def lista_inchirieri_carti_s(self):
        """
        Obtine din repo lista de id uri
        :return: list
        """
        return self.__repo.create_nr_inch_carti()

    def lista_inchirieri_clienti_s(self):
        return self.__repo.create_nr_inch_client()
