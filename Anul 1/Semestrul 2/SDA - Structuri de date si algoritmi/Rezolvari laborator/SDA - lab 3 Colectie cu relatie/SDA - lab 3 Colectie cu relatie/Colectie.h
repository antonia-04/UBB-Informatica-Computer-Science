#pragma once

typedef int TElem;

typedef bool(*Relatie)(TElem, TElem);
typedef bool(*Conditie)(TElem);
class IteratorColectie;


//in implementarea operatiilor se va folosi functia (relatia) rel (de ex, pentru <=)
// va fi declarata in .h si implementata in .cpp ca functie externa colectiei
bool rel(TElem, TElem);

class IteratorColectie;
template <class TElem>
struct Node {
	TElem info;
	Node<TElem>* next;
	Node<TElem>* prev;
};
class Colectie {

	friend class IteratorColectie;

private:
	/* aici e reprezentarea */
	Node<TElem>* head;
	Node<TElem>* tail;
	int size;

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


	//intoarce numarul de elemente din colectie;
	int dim() const;

	//verifica daca colectia e vida;
	bool vida() const;

	//returneaza un iterator pe colectie
	IteratorColectie iterator() const;

	// destructorul colectiei
	~Colectie();
	void filtreaza(Conditie cond);


};
void testFiltreaza();