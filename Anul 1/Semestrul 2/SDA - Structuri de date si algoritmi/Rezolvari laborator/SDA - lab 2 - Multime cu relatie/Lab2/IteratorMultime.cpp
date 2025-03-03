#include "IteratorMultime.h"
#include "Multime.h"


IteratorMultime::IteratorMultime(const Multime& m) : mult(m) {
	/* de adaugat */
	current = m.head;

	first = m.head;
}

TElem IteratorMultime::element() const {
	/* de adaugat */
	return current->info;
}

bool IteratorMultime::valid() const {
	/* de adaugat */
	if (current == nullptr)
		return false;
	return true;
}

void IteratorMultime::urmator() {
	current = current->next;
	/* de adaugat */
}

void IteratorMultime::prim() {
	/* de adaugat */
	current = first;
}

