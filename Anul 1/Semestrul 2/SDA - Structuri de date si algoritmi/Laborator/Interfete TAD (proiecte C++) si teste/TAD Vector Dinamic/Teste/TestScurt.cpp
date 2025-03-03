#include "TestScurt.h"
#include <assert.h>
#include "VectorDinamic.h"
#include "IteratorVectorDinamic.h"
#include <iostream>

using namespace std;

void testAll() { //apelam fiecare functie sa vedem daca exista
	VectorDinamic v(4);
	assert(v.dim() == 0); //adaug niste elemente
	v.adaugaSfarsit(5);
	v.adauga(1,1);
	v.adauga(0,10);
	v.adauga(1,7);
	v.adauga(1,1);
	v.adauga(1,11);
	v.adauga(1,-3);
	assert(v.dim() == 7);
	assert(v.sterge(1) == -3);
	assert(v.sterge(4) == 5);
	assert(v.dim() == 5);
	assert(v.modifica(0,7) == 10);
	assert(v.dim() == 5);
	IteratorVectorDinamic iv = v.iterator();
    	int vals[]={7,11,1,7,1};
	iv.prim();
	int k=0;
	while (iv.valid()) {
		TElem e = iv.element();
        assert(e==vals[k++]);
		iv.urmator();
	}
}
