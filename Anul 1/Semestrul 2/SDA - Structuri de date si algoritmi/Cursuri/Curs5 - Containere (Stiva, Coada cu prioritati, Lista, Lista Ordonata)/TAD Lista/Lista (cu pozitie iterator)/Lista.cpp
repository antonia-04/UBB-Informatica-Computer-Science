
#include <exception>

#include "Iterator.h"
#include "Lista.h"

#include <iostream>

using namespace std;

Nod::Nod(TElem e, PNod urm, PNod prec) {
	this->e = e;
	this->urm = urm;
	this->prec = prec;
}

TElem Nod::element() {
	return e;
}

PNod Nod::urmator() {
	return urm;
}

PNod Nod::precedent() {
	return prec;
}

Lista::Lista() {
	this->prim = nullptr;
	this->ultim = nullptr;
}

Iterator Lista::primPoz() const {
	Iterator it = Iterator(*this);
	it.curent = prim;
	return it;
}

void Lista::adaugaDupa(Iterator& poz, TElem e) {
    // itearatorul nu e valid
    if (!poz.valid()) {
        throw std::exception();
    } else {
        //nodul curent din iterator (e valid)
        PNod nodCurent = poz.curent;
        //se adauga un nou nod in lista, avand informatia utila e
        PNod nou = new Nod(e, nullptr, nullptr);
        //stam iteratorul pe noul adaugat
        poz.curent = nou;
        //daca se adauga dupa ultim
        if (nodCurent == ultim){
            ultim->urm = nou;
            nou->prec = ultim;
            ultim = nou;
        }
        else{//se adauga intre nodCurent si nodCurent -> urm
            nou->urm = nodCurent->urm;
            nodCurent->urm->prec = nou;
            nodCurent->urm = nou;
            nou->prec = nodCurent;
        }
    }
}

void Lista::adaugaSfarsit(TElem e) {
     //se adauga un nou nod in lista, avand informatia utila e
     PNod nou = new Nod(e, nullptr, nullptr);
     //daca lista e vida
     if (prim == nullptr){
        prim = nou;
        ultim = nou;
     }
     else{
        //se adaug dupa ultim
            ultim -> urm = nou;
            nou -> prec = ultim;
            ultim = nou;
     }
}

Lista::~Lista() {
    while (prim != nullptr){
        PNod p = prim;
        prim = prim->urm;
        delete p;
    }
}

