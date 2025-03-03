#include <iostream>
#include <fstream>

#define INFINITY 9999
int n; ///nr de varfuri
int v; ///nr de arce
int n_sursa; ///nod sursa
int n_destinatie; ///nod destinatie

int d[10000];

struct bellman {
    int x, y, c; // varf sursa, varf destinatie si costul arcului
} muchie[150001];

void initializare(int s, int t) {
    for (int i = 0; i < n; i++)
        d[i] = INFINITY;

    d[s] = 0;
    d[t] = INFINITY; // setăm distanța nodului destinație la INFINITY
}

void relax(int u, int v, int c) {
    if (d[v] > d[u] + c)
        d[v] = d[u] + c;
}

bool Bellman_Ford(int s, int t) {
    initializare(s, t);
    for (int i = 0; i < n; i++) {
        for (int j = 1; j <= v; j++) {
            relax(muchie[j].x, muchie[j].y, muchie[j].c);
        }
    }

    if (d[t] == INFINITY) // dacă distanța nodului destinație rămâne INFINITY, nu există drum de la sursă la destinație
        return false;
    else
        return true;
}

int main() {

    std::ifstream in("p1_in.txt");
    std::ofstream out("p1_out.txt");

    in >> n >> v >> n_sursa >> n_destinatie; // citim și nodul destinație

    for (int i = 1; i <= v; i++) {
        in >> muchie[i].x >> muchie[i].y >> muchie[i].c;
    }

    if (!Bellman_Ford(n_sursa, n_destinatie))
        out << "Nu exista drum de la " << n_sursa << " la " << n_destinatie;
    else
        out << "Costul minim de la " << n_sursa << " la " << n_destinatie << " este: " << d[n_destinatie];
    in.close();
    out.close();
    return 0;
}
//
// Created by Antonia on 11.04.2024.
//
