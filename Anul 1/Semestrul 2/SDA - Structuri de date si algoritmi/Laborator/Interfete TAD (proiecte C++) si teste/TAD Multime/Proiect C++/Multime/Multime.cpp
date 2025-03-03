#include "Multime.h"
#include "IteratorMultime.h"

#include <iostream>

Multime::Multime() {
	/* de adaugat */
}


bool Multime::adauga(TElem elem) {
	/* de adaugat */
	return false;
}


bool Multime::sterge(TElem elem) {
	/* de adaugat */
	return false;
}


bool Multime::cauta(TElem elem) const {
	/* de adaugat */
	return false;
}


int Multime::dim() const {
	/* de adaugat */
	return 0;
}

bool Multime::vida() const {
	/* de adaugat */
	return true;
}


Multime::~Multime() {
	/* de adaugat */
}



IteratorMultime Multime::iterator() const {
	return IteratorMultime(*this);
}

