#include "Colectie.h"
#include "IteratorColectie.h"
#include <exception>
#include <iostream>

using namespace std;

//functia care da hashCode-ul unui element
//Complexitate O(1)
int hashCode(TElem e) {
	return abs(e);
}
//Complexitate O(1) - constanta
Nod::Nod(Pereche p, PNod urm) {
	this->p = p;
	this->urm = urm;
}
//Complexitate O(1) - constanta
int Colectie::d(TElem e) const {
	return hashCode(e) % m;
}

//Complexitate: BEST=WORST=OVERALL O(m) - m dimensiunea tabelei
Colectie::Colectie() {
	/* de adaugat */
	m = MAX; //initializam m cu o valoare predefinita
	//daca va fi cazul, se poate redimensiona tabela si sa se redisperseze elementele
	//se initializeaza listele inlantuite ca fiind vide
	for (int i = 0; i < m; i++)
		l[i] = nullptr;
}
/*Complexitate: 
	BEST=O(1) - daca elementul exista deja in lista, se gaseste imediat si se incrementeaza frecventa 
	WORST=O(n) - daca elementul nu exista in lista si trebuie adaugat la final (se parcurge toata lista)
	OVERALL=O(n) - trebuie sa parcurgem lista pentru a adauga elementul
* 
*/
void Colectie::adauga(TElem elem) {
	int poz = d(elem);
	PNod p = l[poz];
	while (p != nullptr) {
		if (p->p.e == elem) {
			p->p.frecventa++; // incrementăm frecvența dacă elementul există deja
			return;
		}
		p = p->urm;
	}
	// dacă elementul nu există, îl adăugăm la începutul listei
	l[poz] = new Nod({ elem, 1 }, l[poz]);
}

/*Complexitate: 
	BEST=O(1) - daca elementul exista deja in lista, se gaseste imediat si se decrementeaza frecventa 
	WORST=O(n) - daca elementul nu exista in lista si trebuie adaugat la final (se parcurge toata lista)
	OVERALL=O(n) - trebuie sa parcurgem lista pentru a sterge elementul*/
bool Colectie::sterge(TElem elem) {
	int poz = d(elem); // calculăm poziția elementului in funcție de hash
	PNod p = l[poz];
	PNod prev = nullptr;
	while (p != nullptr) {
		if (p->p.e == elem) {
			p->p.frecventa--; // decrementăm frecvența elementului
			if (p->p.frecventa == 0) { // dacă frecvența a ajuns la 0, eliminăm perechea
				if (prev == nullptr) {
					l[poz] = p->urm;
				}
				else {
					prev->urm = p->urm;
				}
				delete p;
			}
			return true;
		}
		prev = p;
		p = p->urm;
	}
	return false; 
}
/*Complexitate: 
	BEST=O(1) - daca elementul exista deja in lista, se gaseste imediat si se returneaza true 
	WORST=O(n) - daca elementul nu exista in lista sau e la finalul listei
	OVERALL=O(n) - trebuie sa parcurgem lista pentru a gasi elementul*/
bool Colectie::cauta(TElem elem) const {
	int poz = d(elem); // calculăm poziția elementului in funcție de hash
	PNod p = l[poz]; // parcurgem lista corespunzătoare poziției elementului
	while (p != nullptr) {
		if (p->p.e == elem) {
			return true; 
		}
		p = p->urm;
	}
	return false; 
}
/*Complexitate:
* BEST=O(1) - daca elementul exista deja in lista, se gaseste imediat si se returneaza frecventa
* WORST=O(n) - daca elementul nu exista in lista sau e la finalul listei
* OVERALL=O(n) - trebuie sa parcurgem lista pentru a gasi elementul*/
int Colectie::nrAparitii(TElem elem) const {
	int poz = d(elem);
	PNod p = l[poz];
	while (p != nullptr) {
		if (p->p.e == elem) {
			return p->p.frecventa; // returnăm frecvența elementului pt ca e egala cu nr de apariții
		}
		p = p->urm;
	}
	return 0;
}
/*Complexitate:
* BEST=O(1) - daca toate listele sunt vide
* WORST=O(m*n) - fiecare lista contine un numar de elemente n si avem m liste
* OVERALL=O(m*n) - trebuie sa parcurgem fiecare lista pentru a calcula numarul total de elemente din colectie
*/
int Colectie::dim() const {
	int count = 0;
	for (int i = 0; i < m; i++) {
		PNod p = l[i];
		while (p != nullptr) {
			count += p->p.frecventa; // adăugăm frecvența elementului la total
			p = p->urm;
		}
	}
	return count;
}
/*Complexitate:
* Best= O(m*n)
  WORST=O(m*n) - fiecare lista contine un numar de elemente n si avem m liste
  OVERALL=O(m*n) - trebuie sa parcurgem fiecare lista pentru a calcula valoarea maxima din colectie
*/
int Colectie::valoareMaxima() const {
	TElem max = -1;
	if (vida()) {
		return NULL_TELEM;
	}
	for (int i = 0; i < m; i++) {
		PNod p = l[i];
		while (p != nullptr) {
			if (p->p.e > max) {
				max = p->p.e;
			}
			p = p->urm;
		}
	}
	return max;
}

/*Complexitate:
* BEST=O(1) - daca prima lista nu este vida
* WORST=O(m) - daca toate listele sunt vide
* OVERALL=O(m) - trebuie sa parcurgem fiecare lista pentru a verifica daca este vida
*/
bool Colectie::vida() const {
	/* de adaugat */
	for (int i = 0; i < m; i++) {
		if (l[i] != nullptr) {
			return false; // Lista i nu este vidă - best case
		}
	}
	return true;
}

//Complexitate: BEST=WORST=OVERALL O(1) - constanta
IteratorColectie Colectie::iterator() const {
	return  IteratorColectie(*this);
}

/* Complexitate:
	BEST=O(1) - dacă toate listele sunt goale
	WORST=O(m*n) - dacă fiecare listă conține n elemente
	OVERALL=O(m*n) - trebuie să parcurgem toate listele și toate elementele din fiecare listă
*/
Colectie::~Colectie() {
	/* de adaugat */
	for (int i = 0; i < m; i++) {
		PNod p = l[i];
		while (p != nullptr) {
			PNod temp = p;
			p = p->urm;
			delete temp; // eliberăm memoria pentru fiecare nod din lista i
		}
	}
}


