#include <iostream>
#include <fstream>
#include <cstring>
#include <map>
#include <string>
#include <climits>
#include <queue>

using namespace std;

map<char, int> frecv; // map pentru frecventele caracterelor

// structura pentru nodurile arborelui Huffman
struct varf {
    varf* stang = nullptr; //pointeri la copii
    varf* drept = nullptr;
    int fr = 0; //frecventa caracterului
    char caracter = NULL; //caracterul
};
/// comparam dupa frecventa si caracter pentru a pastra ordinea corecta in arbore
class Compare {
public:
    bool operator()(varf* a, varf* b) {
        if (a->fr > b->fr)
            return true;
        else if (a->fr == b->fr && a->caracter > b->caracter)
            return true;
        else
            return false;
    }
};

map<char, string> m; // map pentru codurile Huffman
// parcurgere in adancime pentru a genera codurile Huffman
void dfs(varf* vf, string cod) {
    if (vf->caracter != NULL)
        m[vf->caracter] = cod; // adaugam codul Huffman pentru caracter daca e frunza
    else {
        dfs(vf->stang, cod + '0'); // adaugam 0 pentru stanga
        dfs(vf->drept, cod + '1'); // adaugam 1 pentru dreapta
    }
}
// coada cu prioritate pentru a pastra ordinea corecta in arbore
priority_queue<varf*, vector<varf*>, Compare> q;

varf* codare_huffman() {
    while (q.size() != 1) {
        auto z = new varf;
        auto x = q.top(); // nodul cu cea mai mica frecventa
        q.pop();
        auto y = q.top(); // nodul cu a doua cea mai mica frecventa
        q.pop();
        z->stang = x; // nodul z va avea ca fii nodurile x si y
        z->drept = y; // nodul z va avea ca fii nodurile x si y
        z->fr = x->fr + y->fr; // frecventa nodului z va fi suma frecventelor nodurilor x si y
        z->caracter = NULL; // nodul z nu va avea caracter
        q.push(z); // adaugam nodul z in coada cu prioritate
    }
    return q.top(); // returnam radacina arborelui Huffman
}

string codificare(const string& text) {
    string rez;
    for (auto c : text) {
        rez += m[c]; // adaugam codul Huffman pentru fiecare caracter
    }
    return rez;
}

string decodificare(varf* vf, const string& codificat) {
    string rez;
    auto nod = vf;
    for (auto c : codificat) {
        if (c == '0')
            nod = nod->stang; // mergem in stanga daca avem 0
        else
            nod = nod->drept; // mergem in dreapta daca avem 1
        if (nod->caracter != NULL) { // daca am ajuns la un caracter
            rez += nod->caracter;   // adaugam caracterul la rezultat
            nod = vf; // reporneste de la radacina pentru urmatorul caracter
        }
    }
    return rez;
}

int main() {

    string text;
    ifstream fin("date.txt");
    fin >> text;
    
    // calcul. frecventelor
    for (char c : text)
        frecv[c]++;

    // crearea nodurilor pentru fiecare caracter si inserarea lor in coada cu prioritate
    for (auto elem : frecv) {
        auto vf = new varf;
        vf->fr = elem.second;
        vf->caracter = elem.first;
        q.push(vf);
    }
    if (q.size() == 0) {
        return 1;
    }

    // Construirea arborelui Huffman
    varf* root = codare_huffman();

    // Generarea codurilor Huffman
    dfs(root, "");

    // Codificarea textului
    string codificat = codificare(text);
    cout << "Text codificat: " << codificat << endl;

    // Decodificarea textului
    string decodificat = decodificare(root, codificat);
    cout << "Text decodificat: " << decodificat << endl;

    return 0;
}
