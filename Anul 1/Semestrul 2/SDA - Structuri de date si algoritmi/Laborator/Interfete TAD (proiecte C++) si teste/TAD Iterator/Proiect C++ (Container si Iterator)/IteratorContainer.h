#pragma once
#include "Container.h"

class Container;

class IteratorContainer
{
	friend class Container;

private:
	//iteratorul memoreaza o referinta catre container
	const Container& con;
	//aici alte atribute specifice: curent, etc

	IteratorContainer(const Container& c);

public:
	TElem element() const;
	bool valid() const;
	void urmator();
	void prim();
};

