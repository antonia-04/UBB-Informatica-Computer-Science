
#include "CP.h"
#include <exception>
#include <stdio.h>

using namespace std;


CP::CP(Relatie r) {
	/* de adaugat */
}


void CP::adauga(TElem e, TPrioritate p) {
	/* de adaugat */
}

//arunca exceptie daca coada e vida
Element CP::element() const {
	/* de adaugat */
	return pair <TElem, TPrioritate>  (-1, -1);       // copy constructor
;
}

Element CP::sterge() {
	/* de adaugat */
	return pair <TElem, TPrioritate>  (-1, -1);
}

bool CP::vida() const {
	/* de adaugat */
	return true;
}


CP::~CP() {
	/* de adaugat */
};

