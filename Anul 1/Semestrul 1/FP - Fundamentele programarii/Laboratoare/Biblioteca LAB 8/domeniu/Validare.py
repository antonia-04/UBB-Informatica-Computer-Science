from domeniu.entitati import Client, Carte, Biblioteca

class ValidatorClientException(Exception):
    def __init__(self, errors):
        self.errors = errors
    def getErrors(self):
        return self.errors

class ValidatorClient:

    def validate_client(self, client):
        errors = []
        if client.getID() > 100:
            errors.append("ID-ul trebuie sa fie numar de 2 cifre! ")
        if len(client.getNume()) < 2:
            errors.append('Numele trebuie sa aiba mai mult de doua litere! ')
        if client.getCNP() == "":
            errors.append("CNP-ul trebuie sa fie de 13 cifre! ")

        if len(errors) > 0:
            raise ValidatorClientException(errors)

def testValidatorClient():
    val = ValidatorClient()

    client = Client(123, "", "")
    try:
        val.validate_client(client)
        assert False
    except ValidatorClientException as ex:
        assert len(ex.getErrors()) == 3

testValidatorClient()

class ValidatorCarteException(Exception):
    def __init__(self, errors):
        self.errors = errors
    def getErrors(self):
        return self.errors


class ValidatorCarte:

    def validate_carte(self, carte):
        errors = []
        if carte.getCod() < 0:
            errors.append("Codul nu este valid! ")
        if carte.getTitlu() == "":
            errors.append("Titlul este invalid! ")
        if carte.getDescriere() == "":
            errors.append("Trebuie sa existe o descriere! ")
        if carte.getAutor() =="":
            errors.append("Autorul nu a fost introdus! ")

        if len(errors) > 0:
            raise ValidatorCarteException(errors)

def testValidatorCarte():
    val = ValidatorCarte()

    carte = Carte(12, "", "", '')
    try:
        val.validate_carte(carte)
        assert False
    except ValidatorCarteException as ex:
        assert len(ex.getErrors()) == 3

testValidatorCarte()

class ValidatorInchirieriException(Exception):
    def __init__(self, errors):
        self.errors = errors

    def getErrors(self):
        return self.errors


class ValidatorInchirieri:

    def validate_inchirieri(self, inchirieri):
        errors = []
        if int(inchirieri.getInchirieri()) < 0 or int(inchirieri.getInchirieri()) > 100:
            errors.append('O carte poate fi inchiriata intre 1 si 100 de ori')
        if len(errors) > 0:
            raise ValidatorInchirieriException(errors)

def testValidatorInchirieri():
    validator = ValidatorInchirieri()

    inchirieri_valid = Biblioteca('John', 'Titlu Carte', 50)
    try:
        validator.validate_inchirieri(inchirieri_valid)
    except ValidatorInchirieriException:
        assert False

    inchirieri_invalid = Biblioteca('Jane ', 'Titlu Carte', 150)
    try:
        validator.validate_inchirieri(inchirieri_invalid)
        assert False
    except ValidatorInchirieriException as ex:
        assert len(ex.getErrors()) == 1

testValidatorInchirieri()
