#include "VectorDinamic.h"
#include "IteratorVectorDinamic.h"
#include <exception>

using namespace std;
void VectorDinamic::redim() {	/* de adaugat */
}
VectorDinamic::VectorDinamic(int cp) {	/* de adaugat */
}

VectorDinamic::~VectorDinamic() {	/* de adaugat */
}

int VectorDinamic::dim() const{	/* de adaugat */
	return 0;
}

TElem VectorDinamic::element(int i) const{	/* de adaugat */
	return -1;
}

void VectorDinamic::adaugaSfarsit(TElem e) {	/* de adaugat */
}

void VectorDinamic::adauga(int i, TElem e) {	/* de adaugat */
}

TElem VectorDinamic::modifica(int i, TElem e) {
	/* de adaugat */
	return -1;
}

TElem VectorDinamic::sterge(int i) {	/* de adaugat */
	return -1;
}
IteratorVectorDinamic VectorDinamic::iterator() {	return IteratorVectorDinamic(*this);
}

