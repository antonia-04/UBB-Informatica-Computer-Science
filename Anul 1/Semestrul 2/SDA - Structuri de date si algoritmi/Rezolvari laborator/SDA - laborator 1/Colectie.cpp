#include "Colectie.h"
#include "IteratorColectie.h"
#include <iostream>

using namespace std;

bool rel(TElem e1, TElem e2) {
    if (e1 <= e2)
        return true;
    return false;
}

void Colectie::redim() {
    TElem* elemnou = new int[2 * cp];
    for (int i = 0; i < n; i++)
        elemnou[i] = e[i];
    cp = 2 * cp;
    delete[] e;
    e = elemnou;
}

Colectie::Colectie() {
    this->cp = 5;
    e = new TElem[cp];
    this->n = 0;
}
void QuickSort(TElem v[], int st, int dr)
{
    /*
   * Complexitate timp:
   * caz favorabil = O(n logn);
   * caz mediu =  O(n logn);
   * caz defavorabil = θ(n^2);
   * caz general = O(n^2);
   */
    if (st < dr)
    {
        //pivotul este inițial v[st]
        int m = (st + dr) / 2;
        int aux = v[st];
        v[st] = v[m];
        v[m] = aux;
        int i = st, j = dr, d = 0;
        while (i < j)
        {
            if (rel(v[i], v[j]) == false)
            {
                aux = v[i];
                v[i] = v[j];
                v[j] = aux;
                d = 1 - d;
            }
            i += d;
            j -= 1 - d;
        }
        QuickSort(v, st, i - 1);
        QuickSort(v, i + 1, dr);
    }
}

void Colectie::adauga(TElem e) {
    /*
   * Complexitate timp:
   * caz favorabil = O(n logn);
   * caz mediu =  O(n logn);
   * caz defavorabil = θ(n^2);
   * caz general = O(n^2);
   */

   //daca s-a atins capacitatea maxima, redimensionam
    if (n == cp)
        redim();

    //adaugam la sfarsit
    this->e[n++] = e;
    QuickSort(this->e, 0, this->n - 1);
}




bool Colectie::sterge(TElem e) {
    int poz = -1;
    for (int i = 0; i < n; i++)
        if (this->e[i] == e)
            poz = i;
    if (poz != -1)
    {
        for (int i = poz; i < n - 1; i++)
            this->e[i] = this->e[i + 1];
        n--;
        return true;
    }
    return false;
}


bool Colectie::cauta(TElem elem) const {
    if (n == 0)
        return false;
    if (elem < e[0] || elem > e[n - 1])
        return false;
    int stanga = 0, dreapta = n;
    while (stanga <= dreapta)
    {
        int mij = (stanga + dreapta) / 2;
        if (e[mij] == elem)
            return true;
        if (elem < e[mij])
            dreapta = mij - 1;
        if (elem > e[mij])
            stanga = mij + 1;
    }
    return false; 
}


int Colectie::nrAparitii(TElem elem) const {
    int nrApar = 0;
    for (int i = 0; i < n; i++)
        if (e[i] == elem)
            nrApar++;
    return nrApar;
}



int Colectie::dim() const {
    return n;
}


bool Colectie::vida() const {
    if (n)
        return false;
    return true;
}


IteratorColectie Colectie::iterator() const {
    return  IteratorColectie(*this);
}


Colectie::~Colectie() {
    delete[] e;
}
