///Lab 6 - Problema 6 TAD Colectie reprezentare prin perechi de forma (element, frecventa),
//folosind o TD cu rezolvare coliziuni prin liste independente
#include <iostream>
#include "TestExtins.h"
#include "TestScurt.h"
#include <assert.h>
#include "Colectie.h"
using namespace std;

void testValoareMaxima() {
    Colectie c;
    assert(c.valoareMaxima() == NULL_TELEM); 

    c.adauga(5);
    c.adauga(10);
    c.adauga(15);
    assert(c.valoareMaxima() == 15); 

    c.adauga(20);
    assert(c.valoareMaxima() == 20); 

    c.sterge(20);
    assert(c.valoareMaxima() == 15); 
}


int main() {
    testValoareMaxima();
    cout<<"Teste pentru valoareMaxima trecute cu succes!\n";
	testAll();
	cout<<"Teste scurte trecute cu succes!\n";
	testAllExtins();
	cout << "End";
}
