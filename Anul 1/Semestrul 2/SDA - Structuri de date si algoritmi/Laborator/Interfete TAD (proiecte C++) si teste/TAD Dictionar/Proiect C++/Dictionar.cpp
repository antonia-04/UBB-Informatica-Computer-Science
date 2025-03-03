#include "Dictionar.h"
#include <iostream>
#include "IteratorDictionar.h"

Dictionar::Dictionar() {
	/* de adaugat */
}

Dictionar::~Dictionar() {
	/* de adaugat */
}

TValoare Dictionar::adauga(TCheie c, TValoare v){
	/* de adaugat */
	return NULL_TVALOARE;
}



//cauta o cheie si returneaza valoarea asociata (daca dictionarul contine cheia) sau null
TValoare Dictionar::cauta(TCheie c) const{
	/* de adaugat */
	return NULL_TVALOARE;
}


TValoare Dictionar::sterge(TCheie c){
	/* de adaugat */
	return NULL_TVALOARE;
}


int Dictionar::dim() const {
	/* de adaugat */
	return 0;
}

bool Dictionar::vid() const{
	/* de adaugat */
	return true;
}


IteratorDictionar Dictionar::iterator() const {
	return  IteratorDictionar(*this);
}


