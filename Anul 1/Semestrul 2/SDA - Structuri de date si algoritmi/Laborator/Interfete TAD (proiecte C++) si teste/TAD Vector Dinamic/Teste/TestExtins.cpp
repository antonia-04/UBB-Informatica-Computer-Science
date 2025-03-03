#include <assert.h>
#include "VectorDinamic.h"
#include "TestExtins.h"
#include "IteratorVectorDinamic.h"
#include <iostream>
#include <exception>

using namespace std;


void testCreeaza() {
	VectorDinamic v(10);
	assert(v.dim() == 0);
	IteratorVectorDinamic iv = v.iterator(); //iterator pe vectorul vid ar trebui sa fie invalid din start
	assert(iv.valid() == false);
}

void testAdauga() {
	VectorDinamic v(5); //adaugam elementele [0, 4]
	for (int i = 0; i < 5; i++) {
		v.adaugaSfarsit(i);
	}
    	//adaugam la sfarsit 5,6,7
    	v.adauga(v.dim(),5);
    	v.adauga(v.dim(),6);
    	v.adauga(v.dim(),7);
	assert(v.dim() == 8);
	//vectorul este 0,1,2,3,4,5,6,7
	v.adauga(0,10);
	v.adauga(1,11);
	v.adauga(2,12);
	v.modifica(v.dim()-1,9);
	//vectorul este 10,11,12,0,1,2,3,4,5,6,9
	assert(v.dim() == 11);
	int vals[]={10,11,12,0,1,2,3,4,5,6,9};
	//test iterator
	IteratorVectorDinamic iv = v.iterator();
	iv.prim();
	int k = 0;
	while(iv.valid()){
        TElem e = iv.element();
        assert(e == vals[k]);
        k++;
        iv.urmator();
	}
	//test parcurgere
	for(int i = 0; i < v.dim(); i++){
        TElem e = v.element(i);
        assert(e == vals[i]);
	}
}

void testSterge() {
	VectorDinamic v(20);
	for (int i = -100; i < 100; i = i + 2) { //adaugam elemente din 2 in 2 (numere pare)
		v.adaugaSfarsit(i);
	}
	assert(v.dim() == 100);
	int val = 98;
	for (int i = 0; i < 100; i++) { //stergem elementele
			assert(v.sterge(v.dim()-1) == val);
            val -= 2;
    	}
	assert(v.dim() == 0);
	for (int i = -100; i <= 100; i = i + 2) { //adaugam elemente din 2 in 2
		v.adaugaSfarsit(i);
	}
	//stergem elementul de la final
	assert(v.sterge(v.dim() - 1) == 100);
    	assert(v.dim() == 100);
	//stergem toate elementele
	val = -100;
	for (int i = 0; i < 100; i++){
       		assert(v.sterge(0) == val);
       		val += 2;
    	}
    	//vectorul e vid
	assert(v.dim() == 0);
   	 for (int i = -100; i <= 100; i++) { //adaugam elemente de la -100 la 100
		v.adaugaSfarsit(i);
	}
	//stergem valorile pare
	int i=0;
	while(i < v.dim()){
        	TElem e = v.element(i);
        	if (e % 2 ==0) //e par, sterg
            		e = v.sterge(i);
        	else
           		i++;
	}
	//raman cele 100 elemente impare din intervalul [-100,100]
	//test iterator
	IteratorVectorDinamic iv = v.iterator();
	iv.prim();
	val = -99;
	while(iv.valid()){
        	TElem e = iv.element();
        	assert(e == val);
        	val += 2;
        	iv.urmator();
	}
	//test parcurgere
	val = -99;
	for(int i = 0; i < v.dim(); i++){
        	TElem e = v.element(i);
        	assert(e == val);
        	val += 2;
	}
 }


void testIterator() { // test iterator
	VectorDinamic v(10);
	for (int i = 0; i < 9; i = i + 2) { //adaugam elemente din 2 in 2 (numere pare)
		v.adaugaSfarsit(i);
	}
	IteratorVectorDinamic iv = v.iterator();
	assert(iv.valid() == true);
    	iv.prim();
	int k = 0;
	while(iv.valid()){
        	TElem e1 = iv.element();
        	TElem e2 = v.element(k);
        	assert(e1 == e2);
        	iv.urmator();
       		k++;
	}
}

void testQuantity() {//scopul e sa adaugam multe date
	VectorDinamic v(100);
	for (int i = 0; i < 200000 ; i++)
			v.adaugaSfarsit(i);
	assert(v.dim() == 200000);
	IteratorVectorDinamic iv = v.iterator();
	assert(iv.valid() == true);
	for (int i = 0; i < v.dim(); i++) {
		iv.urmator();
	}
	iv.prim();
	int i=0;
	while (iv.valid()) { //testam elementele returnate de iterator
		TElem e = iv.element();
		assert(e == i);
		i++;
		iv.urmator();
	}
	assert(iv.valid() == false);
	//stergem toate elementele, incepand de la final
	for (int i = v.dim()-1; i >= 0; i--) {
			assert(v.sterge(v.dim()-1)==i);
	}
	assert(v.dim() == 0);
}

void testExceptii() {
	VectorDinamic v(10);
	try {
		v.element(0);
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
    	try {
		TElem e = v.sterge(1);
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
    	try {
		v.modifica(0,1);
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
	try {
		assert(v.dim()==0);
	}
	catch (exception&) {
		assert(false); //nu ar trebui sa arunce exceptie
	}
}



void testAllExtins() {
	testCreeaza();
	testAdauga();
	testSterge();
	testIterator();
	testQuantity();
	testExceptii();
}
