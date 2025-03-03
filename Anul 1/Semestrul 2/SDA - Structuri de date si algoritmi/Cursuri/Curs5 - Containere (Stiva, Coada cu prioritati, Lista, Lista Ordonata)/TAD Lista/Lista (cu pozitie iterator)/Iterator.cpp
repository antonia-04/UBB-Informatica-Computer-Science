#include "Iterator.h"
#include "Lista.h"


Iterator::Iterator(const Lista& l): lista(l){
	this->curent = l.prim;
}

void Iterator::prim(){
	this->curent = lista.prim;
}

void Iterator::urmator(){
 	this->curent=this->curent->urmator();
}

bool Iterator::valid() const{
	return (curent != nullptr);
}

TElem Iterator::element() const{
	return curent->element();
}


