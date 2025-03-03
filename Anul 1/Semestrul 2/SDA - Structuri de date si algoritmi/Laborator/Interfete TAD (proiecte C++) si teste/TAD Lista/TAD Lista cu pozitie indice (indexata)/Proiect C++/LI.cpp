#include <exception>
#include <iostream>
#include "LI.h"
#include "IteratorLI.h"

LI::LI() {
	/* de adaugat */
}

int LI::dim() const {
 	/* de adaugat */
	return 0;
}


bool LI::vida() const {
	/* de adaugat */
	return true;
}

TElem LI::element(int i) const {
	/* de adaugat */
	return -1;
}

TElem LI::modifica(int i, TElem e) {
	/* de adaugat */
	return -1;
}

void LI::adaugaSfarsit(TElem e) {
	/* de adaugat */
}

void LI::adauga(int i, TElem e) {
	/* de adaugat */
}

TElem LI::sterge(int i) {
	/* de adaugat */
	return -1;
}

int LI::cauta(TElem e) const{
	/* de adaugat */
	return -1;
}

IteratorLI LI::iterator() const {
	return  IteratorLI(*this);
}

LI::~LI() {
	/* de adaugat */
}
