///Bellman-Ford - drum de cost minim
///Graf orientat ponderat
#include <iostream>
#include <fstream>

#define INFINITY 9999
int n; ///nr de varfuri
int v; ///nr de arce
int n_sursa; ///nod sursa

int d[10000];

struct bellman {
    int x, y, c; // varf sursa, varf destinatie si costul arcului
} muchie[150001];

void initializare(int s) {
    for (int i = 0; i < n; i++)
        d[i] = INFINITY;

    d[s] = 0;
}

void relax(int u, int v, int c) {
    if (d[v] > d[u] + c)
        d[v] = d[u] + c;
}

bool Bellman_Ford(int s) {
    initializare(s);
    for (int i = 0; i < n; i++) {
        for (int j = 1; j <= v; j++) {
            relax(muchie[j].x, muchie[j].y, muchie[j].c);
        }
    }

    for (int j = 1; j <= v; j++) {
        if (d[muchie[j].y] > d[muchie[j].x] + muchie[j].c)
            return false;
    }

    return true;
}

int main() {

    std::ifstream in("p1_in.txt");
    std::ofstream out("p1_out.txt");

    in >> n >> v >> n_sursa;

    for (int i = 1; i <= v; i++) {
        in >> muchie[i].x >> muchie[i].y >> muchie[i].c;
    }

    if (!Bellman_Ford(n_sursa))
       out << "ciclu negativ";
    else
        for (int i = 0; i < n; i++)
            if (d[i] == INFINITY)
                out << "INF ";
            else
                out << d[i] << ' ';
    in.close();
    out.close();
    return 0;
}
