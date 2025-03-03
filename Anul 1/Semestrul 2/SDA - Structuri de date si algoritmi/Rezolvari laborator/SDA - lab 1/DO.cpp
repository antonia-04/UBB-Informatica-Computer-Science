#include "Iterator.h"
#include "DO.h"
#include <iostream>

#include <exception>

using namespace std;

DO::DO(Relatie r) {
    /* de adaugat */
    this->n = 0;
    this->cp = 2;
    this->r = r;
    elems = new TElem[cp];
    //facem o capacitate initiala de 2, apoi vom redimensiona
    //setam nr. de elems initial ca fiind 0
    //alocam spatiu pentru vectorul dinamic
}

//adauga o pereche (cheie, valoare) in dictionar
//daca exista deja cheia in dictionar, inlocuieste valoarea asociata cheii si returneaza vechea valoare
//daca nu exista cheia, adauga perechea si returneaza null
//Complexitate: Best=Theta(1), Worst=Average=Theta(n^2) ~ putea fi n, pot modifica, Overall= O(n^2)
TValoare DO::adauga(TCheie c, TValoare v) {
    /* de adaugat */
    //daca nu mai este spatiu disponibil, dublam capacitatea
    int i;
    if (n == cp) {
        TElem *elems_nou = new TElem[2 * cp];
        cp = 2 * cp;
        for (i = 0; i < n; i++) {
            elems_nou[i].first = this->elems[i].first;
            elems_nou[i].second = this->elems[i].second;
        }
        delete[] elems;
        elems = elems_nou;
    }
    //cautam sa nu existe deja cheia
    //nu pot folosi functia cauta, pt ca nu imi da pozitia
    for (i = 0; i < n; i++) {

        if (this->elems[i].first == c) {
            TValoare val_veche = this->elems[i].second;
            this->elems[i].second = v;
            return val_veche;
        }
    }

    //daca e tot ok punem pe pozitia buna perechea
    for (i = 0; i < n; i++) {

        if (r(c, this->elems[i].first) == true) {

            n = n + 1;
            for (int j = n - 1; j > i; j--) {
                this->elems[j].first = this->elems[j - 1].first;
                this->elems[j].second = this->elems[j - 1].second;
            }

            this->elems[i].first = c;
            this->elems[i].second = v;
            return NULL_TVALOARE;
        }
    }

    //pune pe ultima poz daca inca nu a dat return
    n = n + 1;
    this->elems[n - 1].first = c;
    this->elems[n - 1].second = v;
    return NULL_TVALOARE;
}

//cauta o cheie si returneaza valoarea asociata (daca dictionarul contine cheia) sau null
//Complexitate: Best=Theta(1), Worst=Average=Theta(n), Overall=O(n)
TValoare DO::cauta(TCheie c) const {
    /* de adaugat */
    int i;

    for (i = 0; i < n; i++) {
        if (this->elems[i].first == c)
            return this->elems[i].second;
    }
    return NULL_TVALOARE;
}

//sterge o cheie si returneaza valoarea asociata (daca exista) sau null
//Complexitate: Best=Theta(n), Worst=Average=Theta(n^2), Overall=O(n^2)
TValoare DO::sterge(TCheie c) {
    /* de adaugat */
    int i, j;
    for (i = 0; i < n; i++) {

        if (this->elems[i].first == c) {
            TValoare val = this->elems[i].second;
            for (j = i; j < n - 1; j++) {
                this->elems[j].first = this->elems[j + 1].first;
                this->elems[j].second = this->elems[j + 1].second;
            }
            n = n - 1;
            return val;
        }
    }
    return NULL_TVALOARE;
}

//returneaza numarul de perechi (cheie, valoare) din dictionar
//Complexitate: Theta(1)
int DO::dim() const {
    /* de adaugat */
    return n;
}

//verifica daca dictionarul e vid
//Complexitate: Theta(1)
bool DO::vid() const {
    /* de adaugat */
    if (n > 0)
        return false;
    else return true;
    //dimensiunea creste cand adaugam elemente
    //daca nu e 0, dictionarul nu e gol
}

Iterator DO::iterator() const {
    return Iterator(*this);
}

//Complexitate: Theta(1)
DO::~DO() {
    delete[] elems;
    //se elibereaza spatiul alocat pentru vectorul dinamic
}