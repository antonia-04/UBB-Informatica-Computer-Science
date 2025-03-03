#include "IteratorColectie.h"
#include "Colectie.h"


IteratorColectie::IteratorColectie(const Colectie& c) : col(c) {
	curent = 0;
}

TElem IteratorColectie::element() const {
	return col.e[curent];
}

bool IteratorColectie::valid() const {
	if (curent < col.dim())
		return true;
	return false;
}

void IteratorColectie::urmator() {
	curent++;
}

void IteratorColectie::prim() {
	curent = 0;
}
