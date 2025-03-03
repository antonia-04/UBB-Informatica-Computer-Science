/*
 2. Fie un graf reprezentat sub o anumita forma (graful este citit dintr-un fisier).
 Sa se rezolve:
a. sa se determine nodurile izolate dintr-un graf.
b. sa se determine daca graful este regular.
c. pentru un graf reprezentat cu matricea de adiacenta sa se determine matricea distantelor.
d. pentru un graf reprezentat cu o matrice de adiacenta sa se determine daca este conex.
 */
#include <iostream>
#include <fstream>

using namespace std;
ofstream g("f.out");

/// Functia citeste din fisier nr de noduri & muchiile
/// \param a - matrice de adiacenta
/// \param n - numar de noduri din graf
void citire(int a[][50], int &n) {
    ifstream f("graph.txt");
    f >> n;

    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            a[i][j] = 0;

    int x, y;
    while (f >> x >> y) {
        a[x][y] = 1;
        a[y][x] = 1;
    }
    f.close();
}

int main() {
    int n, x, y;
    int a[50][50] = {0}, i, j, nr = 0, s = 0, ss = 0, p, nrbun = 0, m[50][50] = {0}, ok;
    const int INF = 1e9;
    citire(a, n);

    // contorizeaza numarul de muchii conectate cu primul nod
    for (j = 1; j <= n; j++) {
        if (a[1][j] == 1) {
            ss++;
        }
    }
    p = 1;
    // verificam daca toate nodurile au acelasi grad
    for (i = 1; i <= n; i++) {
        nr = 0;
        for (j = 1; j <= n; j++) {
            if (a[i][j] == 1) {
                nr = 1;
            }
            if (a[i][j] == 1) {
                s++;
            }
        }
        if (nr == 0) {
            nrbun++;
        }
        if (s != ss) {
            p = 0;
            ss = 0;
        }
        s = 0;
    }

    // matricea distantei
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            if (i == j) {
                m[i][j] = 0;
            } else if (a[i][j] == 1) {
                m[i][j] = 1;
            } else {
                m[i][j] = INF;
            }
        }
    }

    // Warshall algorithm
    for (int k = 1; k <= n; k++) {
        for (i = 1; i <= n; i++) {
            for (j = 1; j <= n; j++) {
                if (m[i][k] != INF && m[k][j] != INF) {
                    if (m[i][j] > m[i][k] + m[k][j]) {
                        m[i][j] = m[i][k] + m[k][j];
                    }
                }
            }
        }
    }

    // Graf conex
    ok = 1;
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            if (i != j) {
                if (m[i][j] == 0 || m[i][j] == INF) {
                    ok = 0;
                }
            }
        }
    }

    // Scriere in fisier
    g << nrbun << endl;
    if (p == 1) {
        g << "Graful este regular." << endl;
    } else {
        g << "Graful nu este regular." << endl;
    }
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            g << m[i][j] << " ";
        }
        g << endl;
    }
    if (ok == 1) {
        g << "Graful este conex.";
    } else {
        g << "Graful nu este conex.";
    }
    g.close();
    return 0;
}
