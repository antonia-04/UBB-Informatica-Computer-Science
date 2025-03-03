#include "Multime.h"
#include "IteratorMultime.h"
#include <iostream>

using namespace std;

//o posibila relatie
bool rel(TElem e1, TElem e2) {
	if (e1 <= e2) {
		return true;
	}
	else {
		return false;
	}
}

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

IteratorMultime Multime::iterator() const {
	return IteratorMultime(*this);
}


Multime::~Multime() {
	/* de adaugat */
}






