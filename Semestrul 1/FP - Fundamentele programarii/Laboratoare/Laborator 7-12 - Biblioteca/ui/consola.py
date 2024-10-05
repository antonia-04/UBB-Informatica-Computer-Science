from domeniu.entitati import Carte
import random
from repository.RepoCarti import RepositoryException
from repository.RepoClienti import RepositoryExceptionC
from domeniu.Validare import ValidatorClientException, ValidatorCarteException
from repository.RepoClienti import RepositoryClienti
from genereaza.genereazaCarti import GenereazaCarti
from ui.sortati import quick_sort, gnome_sort


def cmp_nume(elem):
    """
    Functie de comparare cand aceasta se face dupa nume
    :param elem:
    :return: primul elem, aferent numelui
    """
    return elem[0]


def cmp_carti(elem):
    """
    Functie de comparare cand aceasta se face dupa nr de carti
    :param elem:
    :return:
    """
    return elem[1]

class Consola:
    def __init__(self, srv_Inchirieri, srv_Carti, srv_Clienti, GenereazaCarti, GenreazaClienti):
        self.__srv_Inch = srv_Inchirieri
        self.__srv_Carti = srv_Carti
        self.__srv_Clienti = srv_Clienti
        self.__srv_GenereazaCarti = GenereazaCarti
        self.__srv_GenereazaClienti = GenreazaClienti

    def print_all_carti(self):
        """
        Afișează toate cărțile din lista de cărți
        """
        lista_carti = self.__srv_Carti.getALLcarti()
        if len(lista_carti) == 0:
            print("Nu există cărți în listă!")
        else:
            for carte in lista_carti:
                print(f"Cod: {carte.getCod()} Titlu: {carte.getTitlu()} Autor: {carte.getAutor()} Descriere: {carte.getDescriere()}")

    def print_all_clienti(self):
        """
        Afișează toți clienții din lista de clienți
        """
        lista_clienti = self.__srv_Clienti.getALLClienti()
        if len(lista_clienti) == 0:
            print("Nu există clienți în listă!")
        else:
            for client in lista_clienti:
                print(f"ID: {client.getID()} Nume: {client.getNume()} CNP: {client.getCNP()}")

    def print_search_results(self, search_list):
        if len(search_list) == 0:
            print("Nu s-au găsit rezultate.")
        else:
            print("Rezultatele căutării sunt:")
            for item in search_list:
                print(item)

    #ADD
    def __add_carti(self):
        """
        Adauga o carte cu datele citite de la tastatura
        """
        try:
            cod = int(input("Codul cartii: "))
        except ValueError:
            print("Codul cartii trebuie sa fie un numar de 2 cifre")
            return
        titlu = input('Titlul cartii: ')
        autor = input("Autorul: ")
        descriere = input("Descrierea cartii: ")

        try:
            added_carte = self.__srv_Carti.create(cod, titlu, autor, descriere)
            print('Cartea ' + added_carte.getTitlu() + " a fost adaugata cu succes!")
            #verifica aici
        except RepositoryException:
            print("Cod duplicat! ")
        except ValidatorCarteException as ex:
            print(str(ex))

    def __add_clienti(self):
        try:
            id = int(input("Id-ul clientului (de la 1 la 99): "))
        except ValueError:
            print("Id-ul trebuie sa fie un numar!")
            return
        nume = input("Nume:")
        cnp = input("CNP:")

        try:
            added_client = self.__srv_Clienti.createC(id, nume, cnp)
            print('Clientul ' + added_client.getNume() +' a fost adaugat cu succes! ')
        except ValidatorClientException as ve:
            print(str(ve))
        except RepositoryExceptionC:
            print("Duplicated ID!")

    def __add_inchirieri(self):
       try:
            id_client = int(input('ID client: '))
            self.__srv_Clienti.search_by_id(id_client)
            print("Bine ai venit!")
            print("Acestea sunt cartile disponibile: ")
            for elem in self.__srv_Carti.getALLcarti():
                print(elem)

            cod_carte = int(input("Introduceti codul cartii: "))
            self.__srv_Carti.search_by_cod(cod_carte)
            self.__srv_Inch.add_inchiriere_s(id_client, cod_carte)

            print("Cartea a fost inchiriata cu succes! ")
       except ValueError as ve:
           print(ve)

    #UPDATE
    def __update_carti(self):
        # cod, titlu, autor, descriere
        try:
            cod = int(input("Codul cartii:"))
        except ValueError:
            print('Id-ul cartii trebuie sa fie un numar!')
            return
        titlu = input("Titlul cartii:")
        autor = input("Autorul:")
        descriere = input("Descrierea cartii:")

        try:
            self.__srv_Carti.update(cod, titlu, autor, descriere)
            print("Cartea a fost modificata cu succes!")
        except ValueError as ve:
            print(ve)
    def __update_clienti(self):
        try:
            id = int(input("Id-ul clientului: "))
        except ValueError:
            print('Id-ul clientului trebuie sa fie un numar')
            return
        nume = input("Nume: ")
        try:
            cnp = int(input("CNP: "))
        except ValueError:
            print("CNP-ul clientului trebuie sa fie un numar! ")

        try:
            self.__srv_Clienti.update(id, nume, cnp)
            print("Clientul a fost modificat cu succes!")
        except ValueError as ve:
            print(str(ve))

    #DELETE
    def __delete_carti(self):
        try:
            cod = int(input("Codul cartii: "))
        except ValueError:
            print("Codul cartii trebuie sa fie un numar!")
            return

        try:
            delete_carte = self.__srv_Carti.remove(cod)
            print('Cartea ' + str(delete_carte.getTitlu()) + " a fost stearsa cu succes!")
        except ValueError as ve:
            print(str(ve))

    def __delete_clienti(self):
        try:
            id = int(input("Id-ul clientului: "))
        except ValueError:
            print('Id-ul clientului trebuie sa fie un numar')
            return

        try:
            delete_clienti = self.__srv_Clienti.remove(id)
            print('Clientul ' + str(delete_clienti.getID()) + ' a fost sters cu succes')
        except ValueError as ve:
            print(str(ve))

    #SEARCH
    def __search_carti(self):
        """
        cauta cartile cu un cuvant cheie in Titlu citit de la tastatura
        """
        cheie = input("Cuvantul din titlu cautat: ")
        search_list = self.__srv_Carti.search(cheie)
        return search_list

    def __search_clienti(self):
        """
        cauta clientii cu un anumit nume
        """
        cheie = input("Cuvantul din nume cautat: ")
        search_list1 = self.__srv_Clienti.search(cheie)
        return search_list1

    #RAPOARTE

    def __report_top_carti(self):
        client_books = []

        # Parcurge lista clienților și a cărților închiriate pentru a contoriza numărul de închirieri pentru fiecare carte
        client_freq = self.__srv_Inch.lista_inchirieri_carti_s()
        for i in range(100):
            if client_freq[i] != 0:
                client_books.append([i, client_freq[i]])
        sorted_books = sorted(client_books,key=lambda x: x[1],reverse=True)
        if sorted_books:
            for elem in sorted_books:
                print("ID Carte: " + str(elem[0]) + ", inchiriata de : " + str(elem[1]) + " ori")
        else:
            print("Nu se pot genera rapoarte!")

    def __report_inch_clienti(self):
        #Clienți cu cărți închiriate ordonat dupa: nume, după numărul de cărți închiriate
        client_freq = self.__srv_Inch.lista_inchirieri_clienti_s()
        client_books = []

        for i in range(100):
            if client_freq[i] != 0:
                client_books.append([i, client_freq[i]])
        sorted_books = sorted(client_books, key=lambda x: (x[1], self.__srv_Clienti.search_id(x[0])),reverse=True)
        if sorted_books:
            for elem in sorted_books:
                print("ID Carte: " + str(elem[0])+ ", inchiriata de : " + str(elem[1]) + " ori")
        else:
            print("Nu se pot genera rapoarte!")

    def __report_carti_20(self):
        """
        Genereaza raportul clienti cu carti inchiriate, ordonat dupa nr de carti inchiriate descrescator, primii 20%
        """
        client_freq = self.__srv_Inch.lista_inchirieri_clienti_s()
        client_books = []

        def cmp_clienti(elem):
            # Sortați inițial după numărul de cărți închiriate (descrescător)
            # și apoi după nume (crescător)
            return (-elem[1], self.__srv_Clienti.get_nume_by_id(elem[0]))

        for i in range(100):
            if client_freq[i] != 0:
                client_books.append([i, client_freq[i]])

        quick_sort(client_books, 0, len(client_books) - 1, key=cmp_clienti,reverse=False)
        sorted_list = client_books

        if sorted_list:
            percentile = 0.8
            end_index = int(len(sorted_list) * (1 - percentile))
            for elem in sorted_list[end_index:]:
                print("Nume: " + self.__srv_Clienti.get_nume_by_id(elem[0]) + " carti inchiriate " + str(elem[1]))
        else:
            print("Nu se pot genera rapoarte!")

    #GENEREAZA

    def __generate_random_carti(self):
        try:
            x = int(input("Cate carti? "))
        except:
            raise ValueError("Trebuie sa fie un numar intre 1 si 20!")
        self.__srv_GenereazaCarti.generate(x)

    def __generate_random_clienti(self):
        try:
            x = int(input("Cati clienti? "))
        except:
            raise ValueError("Trebuie sa fie un numar intre 1 si 20!")
        self.__srv_GenereazaClienti.generate(x)

    def show_ui(self):

        print("Comenzi disponibile pentru clienti si carti:")
        print("genereaza")
        print("--------------------------------------------")
        print("rapoarte")
        print("adauga")
        print("modifica")
        print("sterge")
        print("cauta")
        print("afiseaza")
        print("exit")
        while True:
            print("Scrieti comanda dorita!")
            cmd = input(">>> ")
            cmd = cmd.lower().strip()

            if cmd == "genereaza":
                print("1. Carte, 2. Client")
                cm = input('Comanda de generare pentru: ')
                cm = cm.strip()
                if cm == "1":
                    self.__generate_random_carti()
                elif cm == "2":
                    self.__generate_random_clienti()
                else:
                    print("Comanda invalida!")

            if cmd == "adauga":
                print("1. Carte, 2. Client, 3. Inchiriere")
                cm = input('Comanda de adaugare pentru: ')
                cm = cm.strip()
                if cm == "1":
                    try:
                        self.__add_carti()
                    except Exception as ex:
                        print(ex)
                elif cm == "2":
                    try:
                        self.__add_clienti()
                    except Exception as ex:
                        print(ex)
                elif cm == "3":
                    try:
                        self.__add_inchirieri()
                    except Exception as ex:
                        print(ex)
                else:
                    print('Comanda invalida! Incearca din nou!')

            if cmd == "modifica":
                print('1. Carte, 2. Client')
                cm = input("Comanda de modificare pentru: ")
                cm = cm.strip()
                if cm == "1":
                    try:
                        self.__update_carti()
                    except Exception as ex:
                        print(ex)
                elif cm == "2":
                    self.__update_clienti()
                else:
                    print('Comanda invalida! Incearca din nou!')

            if cmd == "afiseaza":
                print('1. Carte, 2. Client')
                cm = input("Comanda de afisare pentru: ")
                cm = cm.strip()
                if cm == "2":
                    self.print_all_clienti()
                elif cm == "1":
                    self.print_all_carti()
                else:
                    print('Comanda invalida! Incearca din nou!')

            if cmd == "sterge":
                print('1. Carte, 2. Client')
                cm = input("Comanda de stergere pentru: ")
                cm = cm.strip()
                if cm == "1":
                    self.__delete_carti()
                elif cm == "2":
                    self.__delete_clienti()
                else:
                    print('Comanda invalida! Incearca din nou!')

            if cmd == "cauta":
                print('1. Carte in functie de titlu, 2. Client dupa nume')
                cm = input("Comanda de cautare pentru: ")
                cm = cm.strip()
                if cm == "1":
                    lista = self.__search_carti()
                    self.print_search_results(lista)
                elif cm == "2":
                    lista = self.__search_clienti()
                    self.print_search_results(lista)
                else:
                    print('Comanda invalida! Incearca din nou!')

            if cmd == "rapoarte":
                print("1. Cele mai inchiriate cărți")
                print("2. Clienți cu cărți închiriate ordonat dupa: nume, după numărul de cărți închiriate")
                print('3. Primi 20% dintre cei mai activi clienți (nume client si numărul de cărți închiriate)')
                cm = input("Comanda rapoarte: ")
                cm = cm.strip()
                if cm == "1":
                    self.__report_top_carti()
                elif cm == "2":
                    self.__report_inch_clienti()
                elif cm == "3":
                    self.__report_carti_20()
                else:
                    print("Comanda invalida! Incearca din nou!")

            if cmd == "exit":
                return 0