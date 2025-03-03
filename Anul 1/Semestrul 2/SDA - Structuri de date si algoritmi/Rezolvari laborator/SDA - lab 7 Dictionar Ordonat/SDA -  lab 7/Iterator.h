#pragma once

#include "DO.h"
#include <stack>
using std::stack;

class Iterator {
	friend class DO;
private:
	Iterator(const DO& dictionar);

	const DO& dict;
	DO::Node* curent;
	stack<DO::Node*> s; //Stack pentru a retine nodurile parcurse	

public:
	void prim();
	void urmator();
	bool valid() const;
	TElem element() const;
};
