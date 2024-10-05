from repository.RepoInchirieri import RepoInchirieri

class ServiceInchirieri:
    def __init__(self, repo):
        self.__repo = repo

    def add_inchiriere_s(self, id, cod):
        """
        Se adauga o inchiriere
        :param id: id client
        :param cod: id film
        """
        self.__repo.add_inchiriere(id, cod)

    def remove_inchiriere_s(self, id, cod):
        self.__repo.delete_inchiriere(id, cod)

    def get_list_of_ids(self):
        """
        Obtine din repo lista de id uri
        :return: list
        """
        return self.__repo.getList()

    def get_list_with_id_m(self):
        """
        Obtine lista de carti si cati clienti le-au inchiriat
        :return: lista de carti
        """
        return self.__repo.getAllforMax()

    def get_all_for_id(self, id):
        """
        Functia identifica toate cartile inchiriate de un client
        :param id: id-ul clientului
        :return: lista de id-uri ale cartilor pe care clientul le are inchiriate
        """
        return self.__repo.get_all_id(id)

    def get_all_for_cod(self, cod):
        """
        Functia identifica toti clientii ce au inchiriat o carte
        :param cod: codul cartii
        :return: lista de codurile ale cartilor pe care clientul le are inchiriate
        """
        return self.__repo.get_all_cod(cod)