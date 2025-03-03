#include "Iterator.h"
#include "LO.h"

#include <iostream>
using namespace std;

#include <exception>

LO::LO(Relatie r) {
	/* de adaugat */
}

// returnare dimensiune
int LO::dim() const {
	/* de adaugat */
	return 0;
}

// verifica daca LO e vida
bool LO::vida() const {
	/* de adaugat */
	return true;
}

// returnare element
//arunca exceptie daca i nu e valid
TElement LO::element(int i) const{
	/* de adaugat */
	return -1;
}

// sterge element de pe o pozitie i si returneaza elementul sters
//arunca exceptie daca i nu e valid
TElement LO::sterge(int i) {
	/* de adaugat */
	return -1;
}

// cauta element si returneaza prima pozitie pe care apare (sau -1)
int LO::cauta(TElement e) const {
	/* de adaugat */
	return -1;
}

// adaugare element in LO
void LO::adauga(TElement e) {
	/* de adaugat */
}

// returnare iterator
Iterator LO::iterator(){
	return Iterator(*this);
}


//destructor
LO::~LO() {
	/* de adaugat */
}
