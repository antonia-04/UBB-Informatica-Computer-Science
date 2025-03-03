#pragma once

class Iterator;

typedef int TElem;

//referire a clasei Nod

class Nod;

//se defineste tipul PNod ca fiind adresa unui Nod

typedef Nod *PNod;

class Nod {
	public:

	    friend class Lista;

        //constructor
		Nod(TElem e, PNod urm, PNod prec);
		TElem element();
		PNod urmator();
		PNod precedent();


	private:
		TElem e;
		//cele doua legaturi - lista  dublu inlantuita
		PNod urm, prec;

};

class Lista {
private:
	friend class Iterator;
	//prim/ultim referas primul/ultimul nod din LDI

    PNod prim, ultim;

public:

	// constructor
	Lista ();

	// prima pozitie din lista
	Iterator primPoz() const;

	// adaugare element la sfarsit
	void adaugaSfarsit(TElem e);

	//adaugare dupa pozitia poz - data de iterator
	//dupa adaugare poz este pozitionat pe elementul adaugat
	//arunca exceptie daca poz nu e valid
	void adaugaDupa(Iterator& poz, TElem e);

	//destructor
	~Lista();

	// alte operatii specifice: constructor de copiere

};
