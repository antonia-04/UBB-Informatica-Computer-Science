#pragma once
#include "Lista.h"

class Lista;

class Iterator{
	friend class Lista;
private:
	const Lista& lista;
	PNod curent;

	Iterator(const Lista& l);
public:
	void prim();
	void urmator();
	bool valid() const;
    TElem element() const;

};


