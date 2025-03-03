#include "Iterator.h"
#include "DO.h"
#include <exception>
using namespace std;
//Complexitate:BEST=WORST=OVERALL O(h)
Iterator::Iterator(const DO& dictionar) : dict{ dictionar } {
	prim();
}
//Complexitate:BEST=O(1) - cautare separata 
//  WORST=OVERALL O(h)
// Resetează poziția iteratorului la începutul containerului
void Iterator::prim() {
	while (!s.empty()) s.pop();
	curent = dict.root;
	while (curent != nullptr) {
		s.push(curent);
		curent = curent->left;
	}
	if (!s.empty()) {
		curent = s.top();
		s.pop();
	}
	else {
		curent = nullptr;
	}
}
//Complexitate:
// BEST=O(1) - cand nodul curent are copil drept
//  WORST= O(h) - cand nodul curent nu are copil drept, deci urcam in arbore
//  OVERALL=O(1) - in general o sa aiba 2 copii
// Mută iteratorul în container
void Iterator::urmator() {
	if (!valid()) throw exception();
	if (curent->right != nullptr) {
		curent = curent->right;
		while (curent != nullptr) {
			s.push(curent);
			curent = curent->left;
		}
	}
	if (!s.empty()) {
		curent = s.top();
		s.pop();
	}
	else {
		curent = nullptr;
	}
}
//Complexitate:O(1)
// Verifică dacă iteratorul e valid
bool Iterator::valid() const {
	return curent != nullptr;
}
//Complexitate:O(1)
// Returnează valoarea elementului din container referit de iterator
TElem Iterator::element() const {
	if (!valid()) throw exception();
	return curent->e;
}
