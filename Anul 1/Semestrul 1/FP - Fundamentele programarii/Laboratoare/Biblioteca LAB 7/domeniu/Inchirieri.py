class ClientCarteInchiriere:
    def __init__(self, nume_client, nume_carte, inchiriere):
        self.__nume_client = nume_client
        self.__nume_carte = nume_carte
        self.__inchiriere = inchiriere

    def getNumeClient(self):
        return self.__nume_client

    def getNumeCarte(self):
        return self.__nume_carte

    def getInchiriere(self):
        return self.__inchiriere

    def get_DictRepresentation(self):
        """
        Reprezentarea sub forma unui dictionar a relatiei de inchiriere
        :return:
        """
        return {
            'nume_client': self.__nume_client,
            'nume_carte': self.__nume_carte,
            'inchirieri': self.__inchiriere
        }

    #print representation
    def __str__(self):
        return str({'nume_client': self.__nume_client, 'nume_carte': self.__nume_carte, 'inchiriere': self.__inchiriere})

#TESTE
def testClientCarteInchiriere():
    client_carte_inchiriere = ClientCarteInchiriere("Ion", "Oameni VS Tehnologie", 3)
    assert client_carte_inchiriere.getNumeClient() == "Ion"
    assert client_carte_inchiriere.getNumeCarte() == "Oameni VS Tehnologie"
    assert client_carte_inchiriere.getInchiriere() == 3

    expected_dict = {
        'nume_client': "Ion",
        'nume_carte': "Oameni VS Tehnologie",
        'inchirieri': 3
    }
    assert client_carte_inchiriere.get_DictRepresentation() == expected_dict

    expected_str = "{'nume_client': 'Ion', 'nume_carte': 'Oameni VS Tehnologie', 'inchiriere': 3}"
    assert str(client_carte_inchiriere) == expected_str


testClientCarteInchiriere()