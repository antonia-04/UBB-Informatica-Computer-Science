
#include <exception>

#include "IteratorLP.h"
#include "Lista.h"

#include <iostream>

Lista::Lista() {
	/* de adaugat */
}

int Lista::dim() const {
	/* de adaugat */
	return 0;
}


bool Lista::vida() const {
	/* de adaugat */
	return true;
}

IteratorLP Lista::prim() const {
	/* de adaugat */
    return IteratorLP(*this);
}

TElem Lista::element(IteratorLP poz) const {
	/* de adaugat */
	return -1;
}

TElem Lista::sterge(IteratorLP& poz) {
	/* de adaugat */
	return -1;
}

IteratorLP Lista::cauta(TElem e) const{
	/* de adaugat */
	return IteratorLP(*this);
}

TElem Lista::modifica(IteratorLP poz, TElem e) {
	/* de adaugat */
	return -1;
}

void Lista::adauga(IteratorLP& poz, TElem e) {
	/* de adaugat */
}

void Lista::adaugaInceput(TElem e) {
	/* de adaugat */
}

void Lista::adaugaSfarsit(TElem e) {
	/* de adaugat */
}

Lista::~Lista() {
	/* de adaugat */
}
