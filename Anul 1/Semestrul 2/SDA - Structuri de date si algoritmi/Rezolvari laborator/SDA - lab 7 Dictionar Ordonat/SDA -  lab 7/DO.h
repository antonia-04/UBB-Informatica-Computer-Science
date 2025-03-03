#pragma once

typedef int TCheie;
typedef int TValoare;

#define NULL_TVALOARE -1

#include <utility>
typedef std::pair<TCheie, TValoare> TElem;

class Iterator;

typedef bool(*Relatie)(TCheie, TCheie);

class DO {
    friend class Iterator;
private:
    /* Reprezentarea internă a nodului arborelui */
    struct Node {
        TElem e; // Elementul nodului (perechea cheie-valoare)
        Node* left; // Pointer către copilul stâng
        Node* right; // Pointer către copilul drept

        Node(TElem e, Node* left = nullptr, Node* right = nullptr) : e{ e }, left{ left }, right{ right } {};
    };

    Relatie r; // Relația de ordine între chei
    Node* root; // Rădăcina arborelui
    int size; // Numărul actual de elemente din dicționar

    // Metode recursive pentru adăugare, căutare și ștergere
    Node* adauga_rec(Node* p, TCheie c, TValoare& v, bool& replaced);
    TValoare cauta_rec(Node* p, TCheie c) const;
    Node* sterge_rec(Node* p, TCheie c, TValoare& v, bool& deleted);
    Node* min(Node* p); // Returnează nodul cu cheia minimă din subarborele cu rădăcina în p


    // Eliberează memoria alocată pentru un subarbore
    void distruge(Node* p);

public:
    // Constructorul implicit al dicționarului
    DO(Relatie r);

    // Adaugă o pereche (cheie, valoare) în dicționar
    TValoare adauga(TCheie c, TValoare v);

    // Caută o cheie și returnează valoarea asociată
    TValoare cauta(TCheie c) const;

    // Șterge o cheie și returnează valoarea asociată
    TValoare sterge(TCheie c);

    int diferentaValoareMaxMin() const;

    // Returnează numărul de perechi (cheie, valoare) din dicționar
    int dim() const;

    // Verifică dacă dicționarul este vid
    bool vid() const;

    // Returnează un iterator pe dicționar
    Iterator iterator() const;

    // Destructorul dicționarului
    ~DO();
};
