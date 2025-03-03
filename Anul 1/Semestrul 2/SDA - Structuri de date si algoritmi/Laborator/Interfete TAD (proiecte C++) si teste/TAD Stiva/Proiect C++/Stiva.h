#pragma once

using namespace std;

typedef int TElem;

class Stiva
{
	private:
		/* aici reprezentarea */

	public:
		Stiva();

		//adauga un element in stiva
		void adauga(TElem e);

		//acceseaza elementul cel mai devreme introdus in stiva
		//arunca exceptie daca coada e vida
		TElem element() const;

		//sterge elementul cel mai recent introdus in stivasi returneaza elementul sters (principiul LIFO)
		//arunca exceptie daca stiva e vida
		TElem sterge();

		//verifica daca stiva e vida;
		bool vida() const;
		
		// destructorul stivei
		~Stiva();
};
