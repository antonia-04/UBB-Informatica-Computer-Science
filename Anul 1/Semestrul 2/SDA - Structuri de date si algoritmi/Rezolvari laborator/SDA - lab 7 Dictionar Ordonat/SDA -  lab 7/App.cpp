//8. TAD Dictionar Ordonar - reprezentare sub forma unui ABC reprezentat inlantuit cu alocare dinamica
#include <iostream>
#include "TestScurt.h"
#include "TestExtins.h"
#include "DO.h"
#include <assert.h>

bool relatieTEST(TCheie cheie1, TCheie cheie2) {
    if (cheie1 <= cheie2) {
        return true;
    }
    else {
        return false;
    }
}

void testDiferentaValoareMaxMin() {

    DO dict(relatieTEST);

    dict.adauga(1, 10);
    dict.adauga(2, 20);
    dict.adauga(3, 30);

    assert(dict.diferentaValoareMaxMin() == 20);

    dict.adauga(4, 40);

    assert(dict.diferentaValoareMaxMin() == 30);

    dict.adauga(0, 5);

    assert(dict.diferentaValoareMaxMin() == 35);

}

int main() {
    testDiferentaValoareMaxMin();
    std::cout<<"Teste diferenta cu succes!"<<std::endl;
    testAll();
    testAllExtins();
    std::cout << "Finished Tests!" << std::endl;
}
