#include "Colectie.h"
#include "IteratorColectie.h"
#include <iostream>
#include <assert.h>

using namespace std;
//Complexitate Theta(1)
bool rel(TElem e1, TElem e2) {
	/* de adaugat */
	return e1 <= e2;
}
bool cond(TElem e) {
	return e % 2 == 0;
}
Colectie::Colectie() {
	/* de adaugat */
	head = nullptr;
	tail = nullptr;
	size = 0;
}
//Complexitate Best: Theta(1), Worst: Theta(n), Overall: O(n)
void Colectie::adauga(TElem elem) {
	Node<TElem>* node_add = new Node<TElem>;
	node_add->info = elem;
	node_add->next = nullptr;

	if (head == nullptr) {
		node_add->prev = nullptr;
		head = node_add;
		tail = node_add;
	}
	else {
		Node<TElem>* current = head;
		Node<TElem>* prev = nullptr;
		// parcurgem lista pana la locul potrivit pentru inserare
		// operatie O(n) in worst case ca trebuie sa parcurgem toata lista
		while (current != nullptr && rel(current->info, elem)) {
			prev = current;
			current = current->next;
		}
		//inseram elementul in lista O(1)
		node_add->prev = prev;
		node_add->next = current;

		if (prev != nullptr) {
			prev->next = node_add;
		}
		else {
			head = node_add;
		}

		if (current != nullptr) {
			current->prev = node_add;
		}
		else {
			tail = node_add;
		}
	}
	size++;
}

//Complexitate Best: Theta(1), Worst: Theta(n), Overall: O(n)

bool Colectie::sterge(TElem elem) {
	/* adaugat */
	//O(1) daca elementul este in capul listei sau in capatul listei va fi false deci Theta(1)
	if (head != nullptr && elem < head->info)
		return false;

	if (tail != nullptr && elem > tail->info)
		return false;

	Node<TElem>* P = head;
	//O(n) in worst case ca trebuie sa parcurgem toata lista
	while (P != nullptr)
	{
		if (P->info == elem)
		{
			if (P->prev != nullptr)
			{
				if (P->next != nullptr)
				{
					P->prev->next = P->next;
					P->next->prev = P->prev;
					delete[] P;
					size--;
				}
				else
				{
					P->prev->next = nullptr;
					tail = P->prev;
					delete[] P;
					size--;
				}
			}
			else
			{
				if (P->next != nullptr)
				{
					head = P->next;
					P->next->prev = nullptr;
					delete[] P;
					size--;
				}
				else
				{
					head = nullptr;
					tail = nullptr;
					size--;
					delete[] P;
				}
			}
			return true;
		}
		P = P->next;

	}
	return false;
}

//Complexitate Best: Theta(1), Worst: Theta(n), Overall: O(n)
bool Colectie::cauta(TElem elem) const {
	/* de adaugat */
	Node<TElem>* P = head;
	//O(n) in worst case ca trebuie sa parcurgem toata lista
	while (P != nullptr)
	{
		if (P->info == elem)
			return true;
		P = P->next;
	}
}

//Complexitate Best: Theta(1), Worst: Theta(n), Overall: O(n)
int Colectie::nrAparitii(TElem elem) const {
	/* de adaugat */
	//Best case O(1) daca elementul este in capul listei 
	Node<TElem>* P = head;
	int count = 0;
	while (P != nullptr)
	{
		if (P->info == elem)
			count++;
		P = P->next;
	}
	return count;
	//return 0;
}


//Complexitate: Theta(1)
int Colectie::dim() const {
	/* de adaugat */
	return size;
	//return 0;
}

//Complexitate: Theta(1)
bool Colectie::vida() const {
	/* de adaugat */
	if (size == 0)
		return true;
	return false;
}


IteratorColectie Colectie::iterator() const {
	return  IteratorColectie(*this);
}

//Complexitate Best: Theta(1), Worst: Theta(n), Overall: O(n)
Colectie::~Colectie() {
	/* adaugat */
	Node<TElem>* P = head;
	while (P != nullptr)
	{
		Node<TElem>* temp = P;
		P = P->next;
		delete[] temp;
	}
	head = nullptr;
	tail = nullptr;
	size = 0;
}
//pastreaza in colectie numai acele elemente care respecta conditia data
//conditia este o functie care primeste un element si returneaza true sau false
//Complexitate Best: Theta(n) -  head = nullptr deci lista goala, Worst: Theta(n^2), Overall: O(n^2)
void Colectie::filtreaza(Conditie cond) {
	Node<TElem>* P = head;
	//O(n) in worst case ca trebuie sa parcurgem toata lista
	while (P != nullptr)
	{
		Node<TElem>* nextNode = P->next; 
		if (cond(P->info) == false)
		{
			sterge(P->info);//O(n)
		}
		P = nextNode; 
	}
}


void testFiltreaza() {
	Colectie c;
	c.adauga(5);
	c.adauga(6);
	c.adauga(0);
	c.adauga(5);
	c.adauga(10);
	c.adauga(12);
	c.filtreaza(cond);
	assert(c.dim() == 4);
	assert(c.nrAparitii(5) == 0);
	assert(c.nrAparitii(6) == 1);
	assert(c.nrAparitii(0) == 1);
	assert(c.nrAparitii(10) == 1);
}