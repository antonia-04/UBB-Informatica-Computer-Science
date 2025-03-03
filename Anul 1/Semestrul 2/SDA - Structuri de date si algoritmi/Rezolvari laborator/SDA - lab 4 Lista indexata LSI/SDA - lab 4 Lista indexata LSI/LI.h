#pragma once

typedef int TElem;
class IteratorLI;

class LI {
private:
	friend class IteratorLI;

	int cp;

	//vectorul de elemente de tip TElem
	TElem* vector;

	//vectorul pentru legaturile urmatoare, respectiv legaturile precedente
	int* urm;

	//referinta pentru primul element al listei, pentru ultimul element al listei, pentru primul element din spatiul liber si pentru lungimea listei
	int prim, primLiber, size;

	//functii pentru alocarea/dealocarea unui spatiu liber

	//se returneaza pozitia unui spatiu liber in lista
	int aloca();

	//dealoca spatiul indice i
	void dealoca(int i);

	//functie privata care creeaza un nod in lista inlantuita
	int creeazaNod(TElem e);

	//redimensionare
	void resize();
public:
	//elimina toate elementel intre doua pozitii date
	//arunca exceptie in cazul in care pozitia de inceput sau de sfarsit nu este valida
	void stergeIntre(int inceput, int sfarsit);

	// constructor implicit
	LI();

	// returnare dimensiune
	int dim() const;

	// verifica daca lista e vida
	bool vida() const;

	// returnare element
	//arunca exceptie daca i nu e valid
	TElem element(int i) const;

	// modifica element de pe pozitia i si returneaza vechea valoare
	//arunca exceptie daca i nu e valid
	TElem modifica(int i, TElem e);

	// adaugare element la sfarsit
	void adaugaSfarsit(TElem e);

	// adaugare element pe o pozitie i 
	//arunca exceptie daca i nu e valid
	void adauga(int i, TElem e);

	// sterge element de pe o pozitie i si returneaza elementul sters
	//arunca exceptie daca i nu e valid
	TElem sterge(int i);

	// cauta element si returneaza prima pozitie pe care apare (sau -1)
	int cauta(TElem e)  const;

	// returnare iterator
	IteratorLI iterator() const;

	//destructor
	//~LI();

};
