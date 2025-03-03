#include "TestExtins.h"
#include "Dictionar.h"
#include "IteratorDictionar.h"
#include <assert.h>
#include <iostream>

using namespace std;


void printD(Dictionar& d){
	TElem e;
	IteratorDictionar id = d.iterator();
	while (id.valid()){
		e = id.element();
		cout << " ( " << e.first << " , " << e.second << " ) ";
		id.urmator();
	}
	cout << std::endl;
	cout << std::endl;
}


void testCreeaza() {
	Dictionar d;
	assert(d.dim() == 0);
	assert(d.vid() == true);

	for (int i = -10; i < 10; i++) { //cautam in container vid
		assert(d.cauta(i) == NULL_TVALOARE);
	}
	for (int i = -10; i < 10; i++) { //stergem din container vid
		assert(d.sterge(i) == NULL_TVALOARE);
	}

	IteratorDictionar id = d.iterator(); //iterator pe multimea vida ar trebui sa fie invalid din start
	assert(id.valid() == false);
	//printD(d);
}


void testAdauga() {
	Dictionar d; //adaugam elemente [0, 10)
	for (int i = 0; i < 10; i++) {
		d.adauga(i,i);
	}
	//printD(d);
	assert(d.vid() == false);
	assert(d.dim() == 10);
	for (int i = -10; i < 20; i++) { //mai adaugam elemente [-10, 20)
		d.adauga(i,i);
	}
	//printD(d);
	assert(d.vid() == false);
	assert(d.dim() == 30);
	for (int i = -100; i < 100; i++) { //mai adaugam elemente [-100, 100)
		d.adauga(i,i);
	}
	//printD(d);
	assert(d.vid() == false);
	assert(d.dim() == 200);
	for (int i = -200; i < 200; i++) {
		if (i < -100) {
			assert(d.cauta(i) == NULL_TVALOARE	);
		}
		else if (i < 0) {
			assert(d.cauta(i) == i);
		}
		else if (i < 100) {
			assert(d.cauta(i) == i);
		}
		else {
			assert(d.cauta(i) == NULL_TVALOARE);
		}
	}
	for (int i = 10000; i > -10000; i--) { //adaugam mult, si acum prima data adaugam valori mari, dupa aceea mici
		d.adauga(i,i);
	}
	assert(d.dim()==20000);
}


void testSterge() {
	Dictionar d;

	for (int i = -100; i < 100; i++) { //stergem din containerul vid
		assert(d.sterge(i) == NULL_TVALOARE);
	}
	assert(d.dim() == 0);
	//printD(d);
	for (int i = -100; i < 100; i = i + 2) { //adaugam elemente din 2 in 2 (numere pare)
		d.adauga(i,i);
	}
	for (int i = -100; i < 100; i++) { //stergem tot (inclusiv elemente inexistente)
		if (i % 2 == 0) {
			assert(d.sterge(i) == i);
		}
		else {
			assert(d.sterge(i) == NULL_TVALOARE);
		}
	}
	assert(d.dim() == 0);
	//printD(d);

	for (int i = -100; i <= 100; i = i + 2) { //adaugam elemente din 2 in 2
		d.adauga(i,i);
	}
	//printD(d);
	for (int i = 100; i > -100; i--) { //stergem descrescator (in ordine inversa fata de ordinea adaugarii)
		if (i % 2 == 0) {
			assert(d.sterge(i) == i);
		}
		else {
			assert(d.sterge(i) == NULL_TVALOARE);
		}
	}

	assert(d.dim() == 1);
	//printD(d);

	d.sterge(-100);
	assert(d.dim() == 0);

	for (int i = -100; i < 100; i++) { //adaugam de 5 ori pe fiecare element
		d.adauga(i,0);
		d.adauga(i,1);
		d.adauga(i,2);
		d.adauga(i,3);
		d.adauga(i,4);
	}
	//printD(d);
	assert(d.dim() == 200);
	for (int i = -200; i < 200; i++) { //stergem elemente inexistente si existente
		if (i < -100 || i >= 100) {
			assert(d.sterge(i) == NULL_TVALOARE);
		}
		else {
			assert(d.sterge(i) == 4);
			assert(d.sterge(i) == NULL_TVALOARE);
		}
	}
	assert(d.dim() == 0);

 }



void testIterator() {
	Dictionar d;
	IteratorDictionar id = d.iterator(); //iterator pe container vid
	assert(id.valid() == false);

	for (int i = 0; i < 100; i++) {  //adaug de 100 de ori valoarea 33
		d.adauga(33,33);
	}
	IteratorDictionar id2 = d.iterator(); //daca iterez doar 33 poate sa-mi dea iteratorul
	assert(id2.valid() == true);
	TElem el = id2.element();
	assert(el.first == 33);
	id2.urmator();
	assert(id2.valid() == false);

	id2.prim(); //resetam pe primul elemente
	assert(id2.valid() == true);

	Dictionar d2;
	for (int i = -100; i < 100; i++) { //adaug 200 de elemente, fiecare de 3 ori
		d2.adauga(i,i);
		d2.adauga(i,i);
		d2.adauga(i,i);
	}
	IteratorDictionar id3 = d2.iterator();
	assert(id3.valid() == true);
	for (int i = 0; i < 200; i++) {
		id3.urmator();
	}
	assert(id3.valid() == false);
	id3.prim();
	assert(id3.valid() == true);

	Dictionar d3;
	for (int i = 0; i < 200; i= i + 4) { //adaugam doar multipli de 4
		d3.adauga(i,i);
	}

	IteratorDictionar id4 = d3.iterator();
	assert(id4.valid() == true);
	int count = 0;
	while (id4.valid()) { //fiecare element e multiplu de 4 si sunt in total 50 de elemente
		TElem e = id4.element();
		assert(e.first % 4 == 0);
		id4.urmator();
		count++;
	}
	assert(count == 50);

}



void testQuantity() {//scopul e sa adaugam multe date
	Dictionar d;

	for (int i = 10; i >= 1; i--) {
		for (int j = -30000; j < 30000; j = j + i) {
			d.adauga(j,j);
		}
	}
	assert(d.dim() == 60000);
	IteratorDictionar id = d.iterator();
	assert(id.valid() == true);
	for (int i = 0; i < d.dim(); i++) {
		id.urmator();
	}
	id.prim();
	while (id.valid()) { //fiecare element returnat de iterator trebuie sa fie in container
		TElem e = id.element();
		assert(d.cauta(e.first) == e.first);
		id.urmator();
	}
	assert(id.valid() == false);
	for (int i = 0; i < 10; i++) { //stergem multe elemente existente si inexistente
		for (int j = 40000; j >= -40000; j--) {
			d.sterge(j);
		}
	}
	assert(d.dim() == 0);
}



// nu stim reprezentarea, putem testa doar anumite lucruri generale, nu stim in ce ordine vor fi afisate elementele
void testAllExtins() {
	testCreeaza();
	testAdauga();
	testSterge();
	testIterator();
	testQuantity();
}
