#pragma once
//tip de data generic (pentru moment este intreg)
typedef int TElem;
class IteratorVectorDinamic;

class VectorDinamic {
private:	/* aici e reprezentarea */
	// redimensionare
	void redim();

public:		// constructor
		//arunca exceptie in cazul in care capacitate e <=0
		VectorDinamic (int capacitate);

		// returnare dimensiune
		int dim() const;

		// returnare element
		//arunca exceptie daca i nu e valid
		//indicii ii consideram de la 0
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

		// returnare iterator
		IteratorVectorDinamic iterator();

		//destructor
		~VectorDinamic();
};



