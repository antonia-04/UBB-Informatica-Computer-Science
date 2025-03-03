#include "IteratorMD.h"
#include "MD.h"

using namespace std;

IteratorMD::IteratorMD(const MD& _md): md(_md) {
	/* de adaugat */
}

TElem IteratorMD::element() const{
	/* de adaugat */
	return pair <TCheie, TValoare>  (-1, -1);
}

bool IteratorMD::valid() const {
	/* de adaugat */
	return false;
}

void IteratorMD::urmator() {
	/* de adaugat */
}

void IteratorMD::prim() {
	/* de adaugat */
}

