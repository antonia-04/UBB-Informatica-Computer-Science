#include <iostream>

#include "TestExtins.h"
#include "Colectie.h"
#include "TestScurt.h"

using namespace std;


int main() {
	///TAD Colectie cu relatie cu elemente de tip comparabil, LDI
	testFiltreaza();
	cout<<"Testele de filtrare trecute cu succes! \n";
	testAll();
	cout << "Testele scurte trecute cu succes! \n";
	testAllExtins();
	cout<< "Testele extinse trecute cu succes!\n";
}