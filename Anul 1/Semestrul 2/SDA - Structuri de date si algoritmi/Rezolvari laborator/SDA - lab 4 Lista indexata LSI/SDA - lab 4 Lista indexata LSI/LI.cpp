#include <exception>
#include <iostream>
#include "LI.h"
#include "IteratorLI.h"

using std::exception;

//Complexitate:
//best case: 0(1) cand inceput e primul element
//worst case: 0(n) cand pozitiile sunt spre sfarsitul listei
void LI::stergeIntre(int inceput, int sfarsit)
{
	if (inceput <= 0 || inceput > size || sfarsit <= 0 || sfarsit > size || sfarsit < inceput)
		throw exception("Pozitiiile sunt invalide!");
	else
		if (inceput == prim)
		{
			urm[prim] = urm[sfarsit];
			size = size - sfarsit;
		}
		else
		{
			int pre = -1, aux = prim;
			while (aux != -1 && aux != inceput)
			{
				pre = aux;
				aux = urm[aux];
			}
			if (aux != -1)
			{
				urm[pre] = urm[sfarsit];
			}
			size = size - (sfarsit - inceput + 1);
			urm[inceput] = primLiber;
			primLiber = inceput;
		}
}

//Complexitate: 0(n)
void LI::resize()
{
	cp = cp * 2;
	TElem* new_vector = new TElem[cp];
	int* new_urm = new int[cp];
	for (int i = 1; i < size + 1; i++)
	{
		new_vector[i] = vector[i];
		new_urm[i] = urm[i];
	}
	for (int i = size + 1; i < cp; i++)
		new_urm[i] = i + 1;
	new_urm[cp - 1] = -1;

	vector = new_vector;
	urm = new_urm;
	primLiber = size + 1;
}

//Complexitate: 0(cp)
//creaza o LDI de lungime cp
LI::LI() {
	//lista e vida
	cp = 10;
	vector = new TElem[cp];
	urm = new int[cp];
	prim = -1;
	size = 0;

	//se initializeaza lista spatiului liber - toate pozitiile din vectori sunt marcate ca fiind libere
	for (int i = 1; i < cp; i++)
		urm[i] = i + 1;
	urm[cp] = -1;

	//referinta spre prima pozitie e libera din lista
	primLiber = 1;
}

//Complexitate: 0(1)
int LI::aloca()
{
	//se trece pozitia i in lista spatiului liber
	int i = primLiber;
	primLiber = urm[primLiber];
	return i;
}

//Complexitate: 0(1)
void LI::dealoca(int i)
{
	//se trece pozitia in lista spatiului liber
	urm[i] = primLiber;
	primLiber = i;
}

//Complexitate: 0(1)
int LI::creeazaNod(TElem e)
{
	if (primLiber == -1)
		resize();
	int i = aloca();
	vector[i] = e;
	urm[i] = 0;
	return i;
}

//Complexitate: 0(1)
int LI::dim() const {
	return size;
}

//Complexitate: 0(1)
bool LI::vida() const {
	return size == 0 && prim == -1;
}

//Complexitate: 0()
TElem LI::element(int i) const {
	if (i <= 0 || i > size)
		throw exception("Pozitie invalida");
	else
	{
		int q = prim;
		while (q != -1)
		{
			if (q == i)
				return vector[q];
			q = urm[q];
		}
	}
}

TElem LI::modifica(int i, TElem e) {
	int q = prim;
	while (q != -1)
	{
		if (q == i)
		{
			int aux = vector[q];
			vector[q] = e;
			return aux;
		}
		q = urm[q];
	}
	throw std::exception("Pozitie invalida");
}

//Complexitate: 0(n)
void LI::adaugaSfarsit(TElem e) {
	if (primLiber == -1)
		resize();

	vector[primLiber] = e;
	int aux = primLiber;
	primLiber = urm[primLiber];
	urm[aux] = -1;

	if (prim == -1)
		prim = aux;
	else
	{
		int q = prim;
		while (urm[q] != -1)
			q = urm[q];
		urm[q] = aux;
	}
	size++;
}

//	Complexitate: 0(n)
void LI::adauga(int i, TElem e) {
	if (i <= 0)
		throw std::exception("Pozitie invalida");
	if (primLiber == -1)
		resize();
	if (i == prim)
	{
		int poz = primLiber;
		vector[poz] = e;
		primLiber = urm[primLiber];
		urm[poz] = prim;
		prim = poz;
		size++;
	}
	else
	{
		int aux = urm[prim];
		int pre = prim;
		while (aux != -1 && urm[pre] != i)
		{
			pre = aux;
			aux = urm[aux];
		}
		if (aux != -1)
		{
			int nou = primLiber;
			primLiber = urm[primLiber];

			vector[nou] = vector[aux];
			vector[aux] = e;
			vector[nou] = urm[aux];

			size++;
		}
		else
			throw std::exception("Pozitie invalida");
	}
}

//Complexitate: 0(n)
TElem LI::sterge(int i) {
	if (i <= 0)
		throw std::exception("Pozitie invalida");
	TElem aux;
	int curent = prim, pre = -1;
	while (curent != -1 && curent != i)
	{
		pre = curent;
		curent = urm[curent];
	}
	if (curent != -1)
	{
		if (curent == prim)
		{
			aux = vector[prim];
			prim = urm[prim];
			size--;
		}
		else
		{
			aux = vector[curent];
			urm[pre] = urm[curent];
			size--;
		}
		urm[curent] = primLiber;
		primLiber = curent;
	}
	else
		throw std::exception("Elementul nu exista!");
	return aux;
}

//Complexitate: 0(n)
int LI::cauta(TElem e) const {
	int q = prim;
	while (q != -1)
	{
		if (vector[q] == e)
			return q;
		q = urm[q];
	}
	return -1;
}

IteratorLI LI::iterator() const {
	return  IteratorLI(*this);
}

/*
LI::~LI() {
	delete[] vector;
	delete[] urm;
	delete[] prec;
}*/
