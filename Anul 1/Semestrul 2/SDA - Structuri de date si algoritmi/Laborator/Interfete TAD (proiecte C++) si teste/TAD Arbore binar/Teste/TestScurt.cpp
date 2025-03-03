#include "TestScurt.h"
#include <assert.h>
#include <string.h>
#include <iostream>
#include "AB.h"
#include "IteratorAB.h"

void tiparesteABPreordine(AB ab) {
   if (!ab.vid()){
    cout<<ab.element()<<" ";
    tiparesteABPreordine(ab.stang());
    tiparesteABPreordine(ab.drept());
   }
}


void testAll() { //apelam fiecare functie sa vedem daca exista
    string ordine[]={"preordine","postordine","inordine","latime"};
	AB ab;
	assert(ab.vid() == true);
	//adaug niste elemente
    //arborele este
    //       4
    //        \
    //         3
    //        / \
    //       1   2
	AB a1(1),a2(2),a3(3);
    a3.adaugaSubSt(a1);
    a3.adaugaSubDr(a2);
    AB a4(ab,4,a3);
	assert(a4.element() == 4);
    assert(a4.stang().vid()==true);
    assert(!(a4.drept().vid())==true);
    assert(a4.drept().element()==3);
    assert(a4.drept().stang().element()==1);
    assert(a4.drept().drept().element()==2);
    for(int i=0;i<4;i++){
             IteratorAB* iab = a4.iterator(ordine[i]);
            iab->prim();
            while (iab->valid()) {
                TElem e = iab->element();
                iab->urmator();
            }
     }
}
