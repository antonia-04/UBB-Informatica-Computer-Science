#pragma once;

typedef int TElem;

//alte definitii daca e cazul (relatie, elemente nule)

class IteratorContainer;

class Container {

	friend class IteratorContainer;

private:
	//aici reprezentarea containerului
public:
	//constructorul implicit
	Container();

	//aici operatiile specifice

	//returneaza un iterator pe container
	IteratorContainer iterator() const;

	// destructor
	~Container();

};

