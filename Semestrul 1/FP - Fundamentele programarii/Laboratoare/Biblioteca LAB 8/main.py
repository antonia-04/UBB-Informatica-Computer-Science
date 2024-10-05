from domeniu.Validare import *
from repository.RepoCarti import *
from repository.RepoClienti import *
from repository.RepoInchirieri import *
from service.serviceInchirieri import *
from service.serviceCarti import *
from service.serviceClienti import *
from ui.consola import *
from genereaza.genereazaCarti import GenereazaCarti
from genereaza.genereazaClienti import GenereazaClienti

repo_Clienti = RepositoryClienti()
val_Clienti = ValidatorClient()
srv_Clienti = ServiceClienti(val_Clienti, repo_Clienti)

repo_Carti = RepositoryCarti()
val_Carti = ValidatorCarte()
srv_Carti = ServiceCarti(val_Carti, repo_Carti)

repo_Inchirieri = RepoInchirieri()
val_Inchirieri = ValidatorInchirieri()
srv_Inchirieri = ServiceInchirieri(repo_Inchirieri, val_Inchirieri, repo_Carti, val_Carti, repo_Clienti, val_Clienti)

g_Carti = GenereazaCarti(repo_Carti, val_Carti)
g_Clienti = GenereazaClienti(repo_Clienti, val_Clienti)
ui = Consola(srv_Inchirieri, srv_Carti, srv_Clienti, g_Carti, g_Clienti)

ui.show_ui()

