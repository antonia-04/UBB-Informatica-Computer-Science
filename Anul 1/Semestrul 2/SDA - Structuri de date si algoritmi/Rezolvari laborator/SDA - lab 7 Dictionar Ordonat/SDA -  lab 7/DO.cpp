#include "Iterator.h"
#include "DO.h"
#include <iostream>
#include <exception>
using namespace std;

// h este inaltimea arborelui

/* Complexitate:O(1) 
*/
// Constructor: inițializează dicționarul cu o relație
DO::DO(Relatie r) : r{ r }, root{ nullptr }, size{ 0 } {}

/* Complexitate:
BEST=O(1) - daca cheia se adauga in radacina arborelui
WORST=O(h) - daca cheia se afla in frunza sau nu este prezenta (h este inaltimea arborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/

// Creează un nou nod în arbore și returnează pointerul acestuia
DO::Node* DO::adauga_rec(Node* p, TCheie c, TValoare& v, bool& replaced) {
    //dacă nodul este null, creează un nod nou cu cheia și valoarea date
    if (p == nullptr) {
        return new Node({ c, v });
    }
    //daca cheia este deja in arbore, actualizeaza valoarea
   if (c == p->e.first) {
       swap(v, p->e.second);
        replaced = true;
    }
    else 
    //în funcție de relația de ordine, adaugă nodul în subarborele stâng sau drept
    if (r(c, p->e.first)) {
        p->left = adauga_rec(p->left, c, v, replaced); 
    }
    else {
        p->right = adauga_rec(p->right, c, v, replaced);
    }
    return p;
}
/* Complexitate:
BEST=O(1) - daca cheia se adauga in radacina arborelui
WORST=O(h) - daca cheia se afla in frunza sau nu este prezenta (h este inaltimea arborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/

// Adaugă o pereche (cheie, valoare) în dicționar
TValoare DO::adauga(TCheie c, TValoare v) {
    TValoare oldVal = v; //valoarea veche este egala cu valoarea noua
    bool replaced = false; //cheia nu a fost inlocuita
    root = adauga_rec(root, c, oldVal, replaced); //adauga nodul in arbore
    if (replaced) //daca cheia a fost inlocuita, returneaza valoarea veche
        return oldVal; 
    //daca e valoare noua
    size += 1; //altfel, creste dimensiunea arborelui
    return NULL_TVALOARE; //daca cheia nu a fost inlocuita, returneaza NULL_TVALOARE
}
/* Complexitate:
BEST=O(1) - daca cheia se afla in radacina arborelui - am cautare separata
WORST=O(h) - daca cheia se afla in frunza sau nu este prezenta (h este inaltimea arborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/
// Funcție recursivă pentru căutarea unei chei în arbore
TValoare DO::cauta_rec(Node* p, TCheie c) const {
    //daca nodul este null, cheia nu exista in arbore, returneaza NULL_TVALOARE
    if (p == nullptr)
        return NULL_TVALOARE;
    // dacă cheia nodului curent este egală cu cheia căutată, returnează valoarea asociată
    if (p->e.first == c)
        return p->e.second;
    //în funcție de relația de ordine, caută în subarborele stâng sau drept
    if (r(c, p->e.first))
        return cauta_rec(p->left, c);
    return cauta_rec(p->right, c);
}
/* Complexitate: - IDENTICE CAUTARII RECURSIVE
*/
// Caută o cheie în dicționar și returnează valoarea asociată
TValoare DO::cauta(TCheie c) const {
    return cauta_rec(root, c);
}
/* Complexitate:
BEST=O(1) - daca nodul are un copil stang direct
WORST=O(h) - daca nodul are copii stangi pana la cel mai adanc nivel (h este inaltimea subarborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/
// Returnează nodul cu cheia minimă din subarborele cu rădăcina în p
DO::Node* DO::min(Node* p) {
    Node* current = p;
    while (current && current->left != nullptr)
        current = current->left;
    return current;
}
/* Complexitate:
BEST=O(1) - daca cheia se afla in radacina arborelui - am cautare separata
WORST=O(h) - daca cheia se afla in frunza sau nu este prezenta (h este inaltimea arborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/
// Funcție recursivă pentru ștergerea unei chei din arbore
DO::Node* DO::sterge_rec(Node* p, TCheie c, TValoare& v, bool& deleted) {
    // Dacă nodul este null, cheia nu există în arbore, deci returnează null
    if (p == nullptr)
        return p;
    // În funcție de relația de ordine, caută în subarborele stâng sau drept
    if (r(c, p->e.first) && c != p->e.first) {
        p->left = sterge_rec(p->left, c, v, deleted);
        return p;
    }
    if (!r(c, p->e.first)) {
        p->right = sterge_rec(p->right, c, v, deleted);
        return p;
    }
    // Dacă nodul curent are ambii copii, înlocuiește cheia și valoarea acestuia cu cheia și valoarea minimă din subarborele drept
    if (p->left != nullptr && p->right != nullptr) {
        Node* minRight = min(p->right); // Găsește nodul cu cheia minimă în subarborele drept
        p->e = minRight->e; // Înlocuiește cheia și valoarea nodului curent cu cheia și valoarea minimă
        TValoare oldVal = p->e.second; // Stochează valoarea veche
        p->right = sterge_rec(p->right, p->e.first, v, deleted); // Șterge nodul cu cheia minimă din subarborele drept
        v = oldVal; // Actualizează valoarea veche
        deleted = true; // Setează indicatorul de ștergere la true
        return p; // Returnează nodul curent
    }
    // Dacă nodul curent are cel mult un copil, înlocuiește cu copilul său
    else {
        Node* repl = p->left ? p->left : p->right; // Dacă nodul curent are un copil stâng, înlocuiește-l cu copilul stâng, altfel cu copilul drept
        v = p->e.second; // Actualizează valoarea veche
        deleted = true; // Setează indicatorul de ștergere la true
        delete p; // Eliberează memoria alocată pentru nodul curent
        return repl; // Returnează nodul înlocuitor
    }
}

/*COMPLEXITATE:
* WORST=Theta(h) - daca arborele are n noduri
* OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/

int DO::diferentaValoareMaxMin() const {
    if (root == nullptr)
        throw std::exception("DICTIONARUL E GOL!!");

    Node* current = root; //pointer către nodul curent - initializat cu radacina
    
    // Parcurge arborele de la rădăcină la nodul cel mai din stânga (nodul cu valoarea minimă)
    //Într-un arbore binar de căutare, nodul cu valoarea minimă este nodul cel mai din stânga
    while (current->left != nullptr)
        current = current->left;

    int min = current->e.second;

    // Parcurge arborele de la rădăcină la nodul cel mai din dreapta (nodul cu valoarea maximă)
    //Într-un arbore binar de căutare, nodul cu valoarea maximă este nodul cel mai din dreapta
    current = root;
    while (current->right != nullptr)
        current = current->right;
    int max = current->e.second;

    // Returnează diferența dintre valoarea maximă și valoarea minimă
    return max - min;
}




/* Complexitate:
BEST=O(1) - daca cheia se afla in radacina arborelui
WORST=O(h) - daca cheia se afla in frunza sau nu este prezenta (h este inaltimea arborelui)
OVERALL=O(h) - deoarece trebuie sa parcurga de la radacina la frunza in cel mai rau caz
*/
// Șterge o cheie din dicționar și returnează valoarea asociată
TValoare DO::sterge(TCheie c) {
    bool deleted = false;
    TValoare oldVal;
    root = sterge_rec(root, c, oldVal, deleted);
    if (!deleted)
        return NULL_TVALOARE;
    size -= 1;
    return oldVal;
}
/// Complexitate:O(1)
// Returnează numărul de perechi (cheie, valoare) din dicționar
int DO::dim() const {
    return size;
}
/* Complexitate:O(1)
*/
// Verifică dacă dicționarul este vid
bool DO::vid() const {
    return root == nullptr;
}
/* Complexitate:
BEST=O(1) - daca arborele este gol
WORST=O(n) - daca arborele are n noduri
OVERALL=O(n) - deoarece trebuie sa viziteze fiecare nod pentru a-l sterge
*/

// Eliberează memoria alocată pentru un subarbore
void DO::distruge(Node* p) {
    if (p != nullptr) {
        distruge(p->left);
        distruge(p->right);
        delete p;
    }
}

//θ(1)
Iterator DO::iterator() const {
    return  Iterator(*this);
}
/* Complexitate:
BEST=O(1) - daca arborele este gol
WORST=O(n) - daca arborele are n noduri
OVERALL=O(n) - deoarece trebuie sa viziteze fiecare nod pentru a-l sterge
*/

// Destructorul dicționarului
DO::~DO() {
    distruge(root);
}
