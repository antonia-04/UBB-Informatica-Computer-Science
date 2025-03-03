#include <assert.h>
#include "Colectie.h"
#include "TestExtins.h"
#include "IteratorColectie.h"
#include <iostream>
#include <vector>
#include <exception>

using namespace std;


void testCreeaza() {
	Colectie c;
	assert(c.dim() == 0);
	assert(c.vida() == true);
	for (int i = -5; i < 5; i++) { //cautam in colectia vida
		assert(c.cauta(i) == false);
	}
	for (int i = -10; i < 10; i++) { //stergem din colectia vida
		assert(c.sterge(i) == false);
	}
	for (int i = -10; i < 10; i++) { //numaram aparitii in colectia vida
		assert(c.nrAparitii(i) == 0);
	}

	IteratorColectie ic = c.iterator(); //iterator pe colectia vida ar trebui sa fie invalid din start
	assert(ic.valid() == false);
}

void testAdauga() {
	Colectie c; //adaugam elemente [0, 10)
	for (int i = 0; i < 10; i++) {
		c.adauga(i);
	}
	assert(c.vida() == false);
	assert(c.dim() == 10); 
	for (int i = -10; i < 20; i++) { //mai adaugam elemente [-10, 20), acum anumite elemente [0, 10) sunt de 2 ori
		c.adauga(i);
	}
	assert(c.vida() == false);
	assert(c.dim() == 40);
	for (int i = -100; i < 100; i++) { //mai adaugam elemente [-100, 100), acum anumite elemente [0, 10) sunt de 3 ori, altele [-10, 0), si [10, 20) sunt de 2 ori
		c.adauga(i);		
	}
	assert(c.vida() == false);
	assert(c.dim() == 240);
	for (int i = -200; i < 200; i++) { //numaram de cate ori apar anumite elemente (inclusiv elemente inexistente)
		int count = c.nrAparitii(i);
		if (i < -100) {
			assert(count == 0);
			assert(c.cauta(i) == false);
		}
		else if (i < -10) {
			assert(count == 1);
			assert(c.cauta(i) == true);
		}
		else if (i < 0) {
			assert(count == 2);
			assert(c.cauta(i) == true);
		}
		else if (i < 10) {
			assert(count == 3);
			assert(c.cauta(i) == true);
		}
		else if (i < 20) {
			assert(count == 2);
			assert(c.cauta(i) == true);
		}
		else if (i < 100) {
			assert(count == 1);
			assert(c.cauta(i) == true);
		}
		else {
			assert(count == 0);
			assert(c.cauta(i) == false);
		}
	}
	for (int i = 10000; i > -10000; i--) { //adaugam mult, si acum prima data adaugam valori mari, dupa aceea mici
		c.adauga(i);
	}
	assert(c.dim()==20240);
}

void testSterge() {
	Colectie c;
	for (int i = -100; i < 100; i++) { //stergem din colectie vida
		assert(c.sterge(i) == false);
	}
	assert(c.dim() == 0);
	for (int i = -100; i < 100; i = i + 2) { //adaugam elemente din 2 in 2 (numere pare)
		c.adauga(i);
	}
	for (int i = -100; i < 100; i++) { //stergem tot (inclusiv elemente inexistente)
	
		if (i % 2 == 0) {
			assert(c.sterge(i) == true);
		}
		else {
			assert(c.sterge(i) == false);
		}
	}
	assert(c.dim() == 0);
	for (int i = -100; i <= 100; i = i + 2) { //adaugam elemente din 2 in 2
		c.adauga(i);
	}
	for (int i = 100; i > -100; i--) { //stergem descrescator (in ordine inversa fata de ordinea adaugarii)
		if (i % 2 == 0) {
			assert(c.sterge(i) == true);
		}
		else {
			assert(c.sterge(i) == false);
		}
	}
	
	assert(c.dim() == 1);
	c.sterge(-100); 
	for (int i = -100; i < 100; i++) { //adaugam de 5 ori pe fiecare element
		c.adauga(i);
		c.adauga(i);
		c.adauga(i);
		c.adauga(i);
		c.adauga(i);
	}
	assert(c.dim() == 1000);
	for (int i = -100; i < 100; i++) {
		assert(c.nrAparitii(i) == 5);
	}
	for (int i = -100; i < 100; i++) { //stergem o aparitie de la fiecare
		assert(c.sterge(i) == true);
	}
	assert(c.dim() == 800);
	for (int i = -100; i < 100; i++) { 
		assert(c.nrAparitii(i) == 4);
	}
	for (int i = -200; i < 200; i++) { //stergem 5 aparitii de la elemente inexistente si existente (dar si acolo exista doar 4 aparitii)
		if (i < -100 || i >= 100) {
			assert(c.sterge(i) == false);
			assert(c.sterge(i) == false);
			assert(c.sterge(i) == false);
			assert(c.sterge(i) == false);
			assert(c.sterge(i) == false);
		}
		else {
			assert(c.sterge(i) == true);
			assert(c.sterge(i) == true);
			assert(c.sterge(i) == true);
			assert(c.sterge(i) == true);
			assert(c.sterge(i) == false);
		}
	}	
	assert(c.dim() == 0);
	for (int i = -1000; i < 1000; i++) {
		assert(c.nrAparitii(i) == 0);
	}
	int min = -200;
	int max = 200;
	while (min < max) { //adaugam elemente, pe 0 de 2 ori
		c.adauga(min);
		c.adauga(max);
		min++;
		max--;
	}
	c.adauga(0);
	c.adauga(0);
	assert(c.dim() == 402);
	for (int i = -30; i < 30; i++) { //stergem o parte dintre elemente
		
		assert(c.cauta(i) == true);
		assert(c.sterge(i) == true);
		if (i != 0) {
			assert(c.cauta(i) == false);
		}
		else {
			assert(c.cauta(i) == true);
		}
	}
	assert(c.dim() == 342);

 }


void testIterator() { // nu stim reprezentarea Colectiei, putem testa doar anumite lucruri generale, nu stim in ce ordine vor fi afisate elementele.
	Colectie c;
	IteratorColectie ic = c.iterator(); //iterator pe colectie vida
	assert(ic.valid() == false);

	for (int i = 0; i < 100; i++) {  //adaug 100 de elemente, fiecare e valoarea 33
		c.adauga(33);
	}
	IteratorColectie ic2 = c.iterator(); //daca iterez doar 33 poate sa-mi dea iteratorul
	assert(ic2.valid() == true);
	for (int i = 0; i < 100; i++) {
		TElem elem = ic2.element();
		assert(elem == 33);
		ic2.urmator();
	}
	assert(ic2.valid() == false);
	ic2.prim(); //resetam pe primul elemente
	assert(ic2.valid() == true);
	for (int i = 0; i < 100; i++) {
		TElem elem = ic2.element();
		TElem elem2 = ic2.element();
		assert(elem == 33);
		assert(elem2 == 33);
		ic2.urmator();
	}
	assert(ic2.valid() == false);

	Colectie c2;
	for (int i = -100; i < 100; i++) { //adaug 200 de elemente, fiecare de 3 ori
		c2.adauga(i);
		c2.adauga(i);
		c2.adauga(i);
	}
	IteratorColectie ic3 = c2.iterator();
	assert(ic3.valid() == true); //nu avem garantia ca elementele afisate vor fi egale, (adica ca vom avea acelasi element de 3 ori consecutiv), testam doar ca sunt 600 de elemente
	for (int i = 0; i < 600; i++) {
		TElem e1 = ic3.element();
		ic3.urmator();
	}
	assert(ic3.valid() == false);
	ic3.prim();
	assert(ic3.valid() == true);
	Colectie c3;
	for (int i = 0; i < 200; i= i + 4) { //adaugam doar multipli de 4
		c3.adauga(i);
	}
	IteratorColectie ic4 = c3.iterator();
	assert(ic4.valid() == true);
	int count = 0;
	while (ic4.valid()) { //fiecare element e multiplu de 4 si sunt in total 50 de elemente
		TElem e = ic4.element();
		assert(e % 4 == 0);
		ic4.urmator();
		count++;
	}
	assert(count == 50);
	Colectie c4; // adaugam niste elemente in colectie
	for (int i = 0; i < 100; i++) {
		c4.adauga(i);
		c4.adauga(i * (-2));
		c4.adauga(i * 2);
		c4.adauga(i / 2);
		c4.adauga(i / (-2));
	}
	//iteram peste colectie si adaugam elementele intr-un vector
	vector<TElem> elemente;
	IteratorColectie ic5 = c4.iterator();
	while (ic5.valid()) {
		TElem e = ic5.element();
		elemente.push_back(e);
		ic5.urmator();
	}
	
	assert(elemente.size() == c4.dim());
	for (unsigned int i = 0; i < elemente.size(); i++) { //scoatem pe rand elemente din vectorul dat de iterator, verificam sa fie in colectie si le stergem si din vector si din c4. Incepem stergerea cu ultimul
		TElem lastElem = elemente.at(elemente.size() - i  - 1);		
		assert(c4.cauta(lastElem) == true);
		c4.sterge(lastElem);		
	}

	Colectie c5; // adaugam niste elemente in colectie
	for (int i = 0; i < 100; i++) {
		c5.adauga(i);
		c5.adauga(i * (-2));
		c5.adauga(i * 2);
		c5.adauga(i / 2);
		c5.adauga(i / (-2));
	}
	//iteram peste colectie si adaugam elementele intr-un vector
	vector<TElem> elemente2;
	IteratorColectie ic6 = c5.iterator();
	while (ic6.valid()) {
		TElem e = ic6.element();
		elemente2.push_back(e);
		ic6.urmator();
	}

	assert(elemente2.size() == c5.dim());
	for (unsigned int i = 0; i < elemente2.size(); i++) { //scoatem pe rand elemente din vectorul dat de iterator, verificam sa fie in colectie si le stergem si din vector si din c4. Incepem stergerea cu primul
		TElem firstElem = elemente2.at(i);
		assert(c5.cauta(firstElem) == true);
		c5.sterge(firstElem);
	}
}

void testQuantity() {//scopul e sa adaugam multe date 
	Colectie c;
	for (int i = 10; i >= 1; i--) {	
		for (int j = -30000; j < 30000; j = j + i) {
			c.adauga(j);
		}
	}
	assert(c.dim() == 175739);
	assert(c.nrAparitii(-30000) == 10);
	IteratorColectie ic = c.iterator();
	assert(ic.valid() == true);
	for (int i = 0; i < c.dim(); i++) {
		ic.urmator();
	}
	ic.prim();
	while (ic.valid()) { //fiecare element returnat de iterator trebuie sa fie in colectie si nrAparitii trebuie sa fie mai mare ca 0
		TElem e = ic.element();
		assert(c.cauta(e) == true);
		assert(c.nrAparitii(e) > 0);
		ic.urmator();
	}
	assert(ic.valid() == false);
	for (int i = 0; i < 10; i++) { //stergem multe elemente existente si inexistente
		for (int j = 40000; j >= -40000; j--) {
			c.sterge(j);
		}
	}
	assert(c.dim() == 0);
}


void testAllExtins() {
	testCreeaza();
	testAdauga();
	testSterge();
	testIterator();
	testQuantity();
}