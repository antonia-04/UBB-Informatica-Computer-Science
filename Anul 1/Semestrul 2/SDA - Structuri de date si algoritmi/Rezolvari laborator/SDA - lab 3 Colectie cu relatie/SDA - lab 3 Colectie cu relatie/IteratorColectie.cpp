#include "IteratorColectie.h"
#include "Colectie.h"


IteratorColectie::IteratorColectie(const Colectie& c) : col(c) {
	/* adaugat */
	current = c.head;
	first = c.head;
}

TElem IteratorColectie::element() const {
	/* adaugat */
	return current->info;
}

bool IteratorColectie::valid() const {
	/* adaugat */
	if (current == nullptr)
		return false;
	return true;
}

void IteratorColectie::urmator() {
	/* adaugat */
	current = current->next;
}

void IteratorColectie::prim() {
	/* adaugat */
	current = first;
}
