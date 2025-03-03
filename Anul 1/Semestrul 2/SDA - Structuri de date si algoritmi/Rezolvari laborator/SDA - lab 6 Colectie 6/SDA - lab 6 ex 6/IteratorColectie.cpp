#include "IteratorColectie.h"
#include "Colectie.h"
#include <exception>
#include <iostream>

/* Complexitate:
	BEST=WORST=OVERALL=O(m) - m este numărul de liste în tabelă
*/
void IteratorColectie::deplasare() {
	//gaseste prima lista nevida incepand cu locatia poz din tabela
	while (poz < col.m && col.l[poz] == nullptr) 
		poz++;
	if (poz < col.m)
		curent = col.l[poz];
}
/* Complexitate:
	BEST=WORST=OVERALL=O(m) - m este numărul de liste în tabelă
*/
IteratorColectie::IteratorColectie(const Colectie& c) : col(c) {
	/* de adaugat */
	poz = 0;
	frecventa = 1;
	deplasare();
}
/* Complexitate:
	BEST=WORST=OVERALL=O(m) - m este numărul de liste în tabelă
*/

void IteratorColectie::prim() {
	/* de adaugat */
	//se determina prima lista nevida
	poz = 0;
	frecventa = 1;
	deplasare();
}

/* Complexitate:
	BEST=O(1) - dacă următorul element este în același nod sau în următorul nod din aceeași listă
	WORST=O(m) - dacă trebuie să parcurgem toate listele pentru a găsi următorul element
	OVERALL=O(m) - în medie, este posibil să fie nevoie să parcurgem o parte din listele din tabelă
*/
void IteratorColectie::urmator() {
	/* de adaugat */
	if (!valid()) {
		throw std::exception("Depasire!");
	}
	//se muta la urmatorul nod din lista curenta
	if (curent != nullptr) {
		if (frecventa < curent->p.frecventa) {
			frecventa++;
		}
		else {
			curent = curent->urm;
			frecventa = 1;
		}
	}
	//daca lista curenta este gata, se muta la urmatoarea lista nevida
	if (curent == nullptr) {
		poz++;
		deplasare();
	}
}

/* Complexitate:
	BEST=WORST=OVERALL=O(1) - doar verifică două condiții
*/
bool IteratorColectie::valid() const {
	/* de adaugat */
	return poz < col.m && (curent != nullptr);
}

/* Complexitate:
	BEST=WORST=OVERALL=O(1) - doar returnează elementul din nodul curent
	*/

TElem IteratorColectie::element() const {
	/* de adaugat */
	 return curent->p.e; 
}
