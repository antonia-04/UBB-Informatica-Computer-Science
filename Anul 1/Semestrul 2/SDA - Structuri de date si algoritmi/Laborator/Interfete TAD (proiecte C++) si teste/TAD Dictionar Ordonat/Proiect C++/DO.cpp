#include "Iterator.h"
#include "DO.h"
#include <iostream>

#include <exception>
using namespace std;

DO::DO(Relatie r) {
	/* de adaugat */
}

//adauga o pereche (cheie, valoare) in dictionar
//daca exista deja cheia in dictionar, inlocuieste valoarea asociata cheii si returneaza vechea valoare
//daca nu exista cheia, adauga perechea si returneaza null
TValoare DO::adauga(TCheie c, TValoare v) {
	/* de adaugat */
	return NULL_TVALOARE;
}

//cauta o cheie si returneaza valoarea asociata (daca dictionarul contine cheia) sau null
TValoare DO::cauta(TCheie c) const {
	/* de adaugat */
	return NULL_TVALOARE;	
}

//sterge o cheie si returneaza valoarea asociata (daca exista) sau null
TValoare DO::sterge(TCheie c) {
	/* de adaugat */
	return NULL_TVALOARE;
}

//returneaza numarul de perechi (cheie, valoare) din dictionar
int DO::dim() const {
	/* de adaugat */
	return 0;
}

//verifica daca dictionarul e vid
bool DO::vid() const {
	/* de adaugat */
	return true;
}

Iterator DO::iterator() const {
	return  Iterator(*this);
}

DO::~DO() {
	/* de adaugat */
}
