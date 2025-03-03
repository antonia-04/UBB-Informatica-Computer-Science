#include "Iterator.h"
#include "DO.h"

using namespace std;

Iterator::Iterator(const DO& d) : dict(d) {
	/* de adaugat */
	index = 0;
}

void Iterator::prim() {
	/* de adaugat */
	index = 0;
}

void Iterator::urmator() {
	/* de adaugat */
	index = index + 1;

}

bool Iterator::valid() const {
	/* de adaugat */
	if (index < dict.dim())
		return true;
	return false;
}

TElem Iterator::element() const {
	/* de adaugat */
	if (!valid())
		return pair <TCheie, TValoare>(-1, -1);
	else return dict.elems[index];
}


