#include "MD.h"
#include "IteratorMD.h"
#include <exception>
#include <iostream>

using namespace std;


MD::MD() {
	/* de adaugat */
}


void MD::adauga(TCheie c, TValoare v) {
	/* de adaugat */
}


bool MD::sterge(TCheie c, TValoare v) {
	/* de adaugat */
	return false;
}


vector<TValoare> MD::cauta(TCheie c) const {
	/* de adaugat */
	return vector<TValoare>();
}


int MD::dim() const {
	/* de adaugat */
	return 0;
}


bool MD::vid() const {
	/* de adaugat */
	return true;
}

IteratorMD MD::iterator() const {
	return IteratorMD(*this);
}


MD::~MD() {
	/* de adaugat */
}

