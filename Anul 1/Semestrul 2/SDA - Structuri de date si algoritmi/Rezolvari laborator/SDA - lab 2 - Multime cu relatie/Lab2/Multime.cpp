#include "Multime.h"
#include "IteratorMultime.h"
#include <iostream>

using namespace std;

//o posibila relatie
bool rel(TElem e1, TElem e2) {
	if (e1 <= e2) {
		return true;
	}
	else {
		return false;
	}
}

Multime::Multime() {
	size = 0;
	head = nullptr;
	tail = nullptr;
	/* de adaugat */
}


bool Multime::adauga(TElem elem) {

	if (head == nullptr)
	{
		Node<TElem>*p = new Node<TElem>;
		p->info = elem;
		p->next = nullptr;
		p->prev = nullptr;
		head = p;
		tail = p;
		size++;
		return true;
	}
	else {
		Node <TElem>* p = head;
		Node<TElem>* current = head;



		while (current != nullptr && rel(current->info, elem) ) {
			if (current->info == elem)
				return false;
			current = current->next;
		}
		Node<TElem>* node_add = new Node<TElem>;
		node_add->info = elem;
		if (current != nullptr)
		{
			if (current->prev == nullptr)
			{
				node_add->prev = nullptr;
				node_add->next = current;
				current->prev = node_add;
				head = node_add;
			}
			else
			{
				node_add->prev = current->prev;
				node_add->next = current;
				current->prev->next = node_add;
				current->prev = node_add;
			}
		}
		else
		{
			node_add->next = nullptr;
			node_add->prev = tail;
			tail->next = node_add;
			tail = node_add;
		}


		size++;
		return true;
	}
}


bool Multime::sterge(TElem elem) {
	/* de adaugat */

	if (head != nullptr && elem < head->info)
		return false;

	if(tail != nullptr && elem > tail->info)
		return false;

	Node<TElem>* P = head;

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

void Multime::afis()const {
	Node<TElem>* p = new Node<TElem>;
	p = head;

	while (p != nullptr)
	{
		cout << p->info << ' ';
		p = p->next;
	}
	cout << '\n';
}


bool Multime::cauta(TElem elem) const {
	Node<TElem>* P = head;

	while (P != nullptr)
	{
		if (P->info == elem)
			return true;
		P = P->next;
	}


	/* de adaugat */
	return false;
}


int Multime::dim() const {
	/* de adaugat */
	return size;
}



bool Multime::vida() const {
	if(size == 0)
		return true;
	return false;
}

IteratorMultime Multime::iterator() const {
	return IteratorMultime(*this);
}


Multime::~Multime() {
	/* de adaugat */
}






