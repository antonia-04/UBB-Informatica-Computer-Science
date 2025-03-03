#include <assert.h>
#include <exception>

#include "TestExtins.h"
#include "IteratorLP.h"
#include "Lista.h"

using namespace std;

void testAllExtins() {
    Lista lista = Lista(); // creem lista vida
    assert(lista.vida());
    IteratorLP it0 = lista.prim(); //creem un iterator pe lista vida
    assert(!it0.valid());
    try {
        it0.element();  // nu ar trebui sa fie posibil ca iteratorul sa returneze un element
        assert(false);
    } catch (exception&) {
        assert(true);
    }

    lista.adaugaSfarsit(1); // lista e [1]
    assert(lista.dim() == 1);
    IteratorLP it = lista.prim();
    assert(it.element() == 1);

    IteratorLP it2 = lista.prim(); //creem un al doilea iterator
    for (int i = 0; i < 100; i++){ //adaugam 100 de elemente
        lista.adaugaSfarsit(i);
        if (i<=50){ // al doilea iterator il setam sa arate pozitia unde valoarea va fi 50
            it2.urmator();
        }
        it.urmator();
        assert(it.element() == i); // primul iterator va arata ultima pozitie
    } // lista este acum [1,0,1,2,3,...,97,98,99] de lungime 101
    assert(it2.element() == 50);
    assert(lista.dim() == 101);
    assert(it.valid());
    it.urmator(); //primul iterator va deveni invalid
    assert(!it.valid());
    try {
        lista.element(it);
        assert(false);
    } catch (exception&) {
        assert(true);
    }


    IteratorLP it3 = lista.cauta(50); //creem un al treilea iterator care ar trebui sa arate pozitia unde valoarea e 50
    assert(it3.valid());    // Iteratori: it - arata o pozitie invalida, it2, it3 - arata catre pozitia cu valoarea 50
    assert(it3.element() == 50);
    TElem vechi = lista.modifica(it3, 51);
    assert(vechi == 50);
    assert(it3.element() == it2.element()); //ambii iteratori arata catre aceeasi pozitie in aceeasi lista, deci si elementul catre care arata it2 s-a schimbat
    IteratorLP it3_2 = lista.cauta(50); //cautam o valore care nu mai exista, ar trebui sa returneze un iterator invalid
    assert(!it3_2.valid());
    try {
        lista.adauga(it3_2, 0);
        assert(false);
    } catch (exception&) {
        assert(true);
    }
    IteratorLP it4 = lista.cauta(99); //Creem un nou iterator
    assert(it4.element() == 99);
    it4.urmator(); // invalidam iteratorul.
    assert(!it4.valid());
    try {
        it4.urmator();
        assert(false);
    } catch (exception&){
        assert(true);
    }
    IteratorLP it3_3 = lista.cauta(51);
    lista.adauga(it3_3, 150);
    assert(it3_3.element() == 150);

    IteratorLP it5 = lista.cauta(51);
    lista.modifica(it5, 50);
    assert(lista.element(it5) == 50);
    TElem vechi_2 = lista.sterge(it3_3); //stergem elementul de la it3_3
    assert(vechi_2 == 150);

    //verificam ca nu se poate modifica/sterge la o pozitie invalida
    try {
        lista.modifica(it, 0);
        assert(false);
    } catch (exception&) {
        assert(true);
    }
    try {
        lista.sterge(it);
        assert(false);
    } catch (exception&) {
        assert(true);
    }
}



    