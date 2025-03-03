#pragma once
#include <vector>
#include <utility>

using namespace std;

typedef int TElem;
typedef int TPrioritate;

typedef std::pair<TElem, TPrioritate> Element;

typedef bool (*Relatie)(TPrioritate p1, TPrioritate p2);

class CP {
private:
	/* aici reprezentarea */
public:
	//constructorul implicit
	CP(Relatie r);

	//adauga un element in CP
	void adauga(TElem e, TPrioritate p);

	//acceseaza elementul cel mai prioritar in raport cu relatia de ordine
	//arunca exceptie daca CP e vida
	Element element()  const;

	//sterge elementul cel mai prioritar si il returneaza
	//arunca exceptie daca CP e vida
	Element sterge();

	//verifica daca CP e vida;
	bool vida() const;

	// destructorul cozii
	~CP();

};
