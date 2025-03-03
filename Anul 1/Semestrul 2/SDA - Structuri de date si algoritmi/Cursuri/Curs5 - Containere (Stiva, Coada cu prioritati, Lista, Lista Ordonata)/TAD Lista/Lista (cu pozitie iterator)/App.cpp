#include <iostream>
#include "Lista.h"
#include "Iterator.h"

using namespace std;

//creare lista
void creareLista (Lista& l){
    l.adaugaSfarsit(1);
    //pentru a ilustra folosirea operatiei adaugaDupa
    Iterator i = l.primPoz();
    for(int e = 2;e <= 6; e++)
         l.adaugaDupa(i, e);
}

//tiparire folosind iteratorul
void tiparireLista(Lista& l){
	Iterator i = l.primPoz();
	cout<<endl<<"Lista este:";
	while (i.valid()) {
		TElem e = i.element();
		cout<<e<<" ";
		// prelucrare element
		i.urmator();
	}
 }

int main(){
    Lista l;
    creareLista(l);
    //ar trebui sa tipareasca 1 2 3 4 5 6
    tiparireLista(l);
    return 0;
}
