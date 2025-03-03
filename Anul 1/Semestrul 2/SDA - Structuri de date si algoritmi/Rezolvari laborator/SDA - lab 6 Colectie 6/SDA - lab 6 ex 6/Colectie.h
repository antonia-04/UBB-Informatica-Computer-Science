#pragma once

#define NULL_TELEM -1
#define MAX 10000 // numarul maxim de locatii din tabela
typedef int TElem;

class IteratorColectie;
//referire a clasei Nod
class Nod;
//se defineste tipul PNod ca fiind adresa unui Nod dintr-o lista inlantuita
typedef Nod* PNod;
struct Pereche {
	TElem e;
	int frecventa;
};

class Nod
{
private:
	Pereche p;
	PNod urm;
public:
	friend class Colectie;
	friend class IteratorColectie;
	//constructor
	Nod(Pereche p, PNod urm);
	//Pereche p care are element si frecventa
	//PNod urmator(); 


};


class Colectie
{
	friend class IteratorColectie;

private:
	/* aici e reprezentarea */
	// reprezentare folosind o TD - rezolvare coliziuni prin liste independente
	int m; // numarul de locatii din tabela de dispersie
	PNod l[MAX]; // listele independente - vector static

	int d(TElem e) const;
public:
	//constructorul implicit
	Colectie();

	//adauga un element in colectie
	void adauga(TElem e);

	//sterge o aparitie a unui element din colectie
	//returneaza adevarat daca s-a putut sterge
	bool sterge(TElem e);

	//verifica daca un element se afla in colectie
	bool cauta(TElem elem) const;

	//returneaza numar de aparitii ale unui element in colectie
	int nrAparitii(TElem elem) const;

	int valoareMaxima() const;


	//intoarce numarul de elemente din colectie;
	int dim() const;

	//verifica daca colectia e vida;
	bool vida() const;

	//returneaza un iterator pe colectie
	IteratorColectie iterator() const;

	// destructorul colectiei
	~Colectie();

};

