#include "Colectie.h"
#include "IteratorColectie.h"
#include <iostream>

using namespace std;

bool rel(TElem e1, TElem e2) {
	/* de adaugat */
	return false;
}

Colectie::Colectie() {
	/* de adaugat */
}

void Colectie::adauga(TElem e) {
	/* de adaugat */
}


bool Colectie::sterge(TElem e) {
	/* de adaugat */
	return false;
}


bool Colectie::cauta(TElem elem) const {
	/* de adaugat */
	return false;
}


int Colectie::nrAparitii(TElem elem) const {
	/* de adaugat */
	return 0;
}



int Colectie::dim() const {
	/* de adaugat */
	return 0;
}


bool Colectie::vida() const {
	/* de adaugat */
	return true;
}


IteratorColectie Colectie::iterator() const {
	return  IteratorColectie(*this);
}


Colectie::~Colectie() {
	/* de adaugat */
}
