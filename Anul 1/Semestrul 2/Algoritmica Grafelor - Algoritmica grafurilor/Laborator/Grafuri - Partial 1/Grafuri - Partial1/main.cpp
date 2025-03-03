/*Ești însărcinat să creezi un program pentru a ajuta la optimizarea rutelor pentru un serviciu de livrare a coletelor. 
Compania operează într-o regiune cu diferite orașe.
Programul tău trebuie să găsească cea mai scurtă rută de la un oraș de plecare desemnat către toate celelalte orașe, luând în considerare distanțele variabile dintre ele.
În plus, ar putea exista probleme pe unele drumuri, reprezentând întârzieri potențiale sau obstacole.

Fișierul de intrare conține informații despre orașe și drumurile care le leagă. Fiecare linie reprezintă o șosea și constă din trei valori: orașul de plecare, orașul destinație și distanta dintre orase
*/
/*
* Se cauta cel mai scurt drum de la un nod sursa la un nod destinatie CU MINUS = BELLMAN-FORD 
*/

#include <iostream>
#include <fstream>

#define INFINITY 99999
int n; ///nr de noduri
int v; ///nr de arce
int n_sursa; ///nod sursa
int n_destinatie; ///nod destinatie

int d[10000];

using namespace std;
ifstream in("graf.txt");
ofstream out("out.txt");
struct {
    int x, y, c; // varf sursa, varf destinatie si costul arcului
} muchie[150001];

void initializare(int s, int t) {
    for (int i = 0; i < n; i++)
        d[i] = INFINITY;

    d[s] = 0;
    d[t] = INFINITY; // setam distanta nodului destinatie la INFINITY
}

void relax(int u, int v, int c) {
    if (d[v] > d[u] + c)
        d[v] = d[u] + c;
}

bool Bellman_Ford(int s, int t) {
    /// 1 = initializare
    initializare(s, t);
    for (int i = 0; i < n; i++) {
        for (int j = 1; j <= v; j++) {
            relax(muchie[j].x, muchie[j].y, muchie[j].c);
        }
    }
    for (int j = 1; j <= v; j++) {
        if (d[muchie[j].y] > d[muchie[j].x] + muchie[j].c)
            return false;
    }
    if (d[t] == INFINITY) // nu exista drum de la sursa la destinatie
        return false;
    else
        return true;
}

int main() {

    in >> n >> v; // fisier: nr de noduri, nr de muchii

    for (int i = 1; i <= v; i++) {
        in >> muchie[i].x >> muchie[i].y >> muchie[i].c;
    }
    cout<<"Introduceti nodul sursa: "; 
    cin>> n_sursa;
    cout<<"Introduceti nodul destinatie: ";
    cin >> n_destinatie;
    if (n_destinatie == n_sursa)
    {
		cout<<"Sunteti in orasul respectiv!";
		return 0;
	}
    if (!Bellman_Ford(n_sursa, n_destinatie))
        out << "Nu exista drum de la " << n_sursa << " la " << n_destinatie<<"! Ciclu infinit sau nu exista!";
    else
        out << "Exista o ruta! Costul drumului minim de la " << n_sursa << " la " << n_destinatie << " este: " << d[n_destinatie];
    in.close();
    out.close();
    return 0;
}