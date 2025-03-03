/*
 1. Fie un fisier ce contine un graf neorientat reprezentat sub forma: prima linie contine numarul nodurilor
    iar urmatoarele randuri muchiile grafului. Sa se scrie un program in C/C++ care sa citeasca fisierul
    si sa reprezinte/stocheze un graf folosind matricea de adiacenta, lista de adiacenta si matricea de incidenta.
    Sa se converteasca un graf dintr-o forma de reprezentare in alta.
Fisier -> matrice de adiacenta -> lista adiacenta -> matrice de incidenta -> lista adiacenta -> matrice de adiacenta -> lista.
 */
#include <iostream>
#include <fstream>

using namespace std;

/// Functia citeste din fisier nr de noduri & muchiile
/// \param a - matrice de adiacenta
/// \param n - numar de noduri din graf
void citire(int a[][101], int &n) {
    ifstream f("graph.txt");
    f >> n;
    // zerorizarea matricei
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

/// Functia afiseaza matricea
/// \param a - matrice
/// \param n - nr linii
/// \param m - nr coloane
void afisare_matrice(int a[][101], int n, int m) {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++)
            cout << a[i][j] << " ";
        cout << endl;
    }
    cout << endl;
}
/// Functia creeaza lista de adiacenta a unui graf de la matricea de adiacenta
/// \param a - matricea de adiacenta
/// \param n - nr de varfuri
/// \param l - lista de adiacenta (fiecare linie e corespunzatoare unui varf)

void lista_adiacenta(int a[][101], int n, int l[][101]) {
    // zerorizare l[][]
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            l[i][j] = 0;

    for (int i = 1; i <= n; i++) {
        int k = 1;
        for (int j = 1; j <= n; j++)
            if (a[i][j] != 0) {
                l[i][k] = j;
                k++;
            }
    }
}

/// Afisare lista de adiacenta
/// \param l - lista de adiacenta, tablou bidimensional
/// \param n - numar de varfuri
void afisare_lista_adiacenta(int l[][101], int n) {
    for (int i = 1; i <= n; i++) {
        int j = 1, ok = 0;
        cout << "Varful " << i << " are vecinii:  ";
        while (l[i][j] != 0 && j <= n) {
            cout << l[i][j] << " ";
            j++;
            ok = 1;
        }
        if (ok == 0)
            cout << " -";
        cout << "\n";
    }
    cout << "\n";
}
/// Functia construiest
/// \param l - lista de adiacenta
/// \param n - nr de varfuri
/// \param m - matrice de incidenta
/// \param nr_muchii - cate muchii are graful dat

void matrice_incidenta(int l[][101], int n, int m[][101], int &nr_muchii) {
    // calculez numarul de muchii din graf
    // ma folosesc de vecinii din lista de adiacenta a caror numar reprezinta gradul fiecarui varf
    // hand-shaking theorem: suma grade = 2 * nrmuchii
    int suma_grade = 0;
    for (int i = 1; i <= n; i++) {
        int j = 1;
        while (l[i][j] != 0 && j <= n) {
            suma_grade++;
            j++;
        }
    }
    nr_muchii = suma_grade / 2;

    // zerorizare matrice incidenta
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= nr_muchii; j++)
            m[i][j] = 0;

    // matrice de incidenta
    // liniile = varfurile, coloanele = muchiile
    int coloana = 1;
    for (int i = 1; i <= n; i++) {
        int j = 1;
        while (l[i][j] != 0 && j <= n) {
            if (i < l[i][j]) {
                m[i][coloana] = 1;
                m[l[i][j]][coloana] = 1;
                coloana++;
            }
            j++;
        }
    }

}
/// Functia creeaza o lista de adiacenta, pornind de la matricea de incidenta
/// \param m - matricea de incidenta
/// \param vf - nr de vf
/// \param nr_muchii
/// \param l - lista de adiacenta, tablou bidimensional
void lista_adiacenta_din_matrice_incidenta(int m[][101], int vf, int nr_muchii, int l[][101]) {

    // zerorizare l[][]
    for (int i = 1; i <= vf; i++)
        for (int j = 1; j <= vf; j++)
            l[i][j] = 0;

    // parcurg matricea pe coloane
    for (int j = 1; j <= nr_muchii; j++) {
        int stg = -1, dr = -1;
        for (int i = 1; i <= vf; i++) {
            if (m[i][j] == 1) {
                if (stg == -1)
                    stg = i;
                else
                    dr = i;
            }
        }
        // am muchia (i,j)
        // caut locul unde sa inserez perechea
        int c;
        c = 1;
        while (l[stg][c] != 0)
            c++;
        l[stg][c] = dr;

        c = 1;
        while (l[dr][c] != 0)
            c++;
        l[dr][c] = stg;
    }
}
///Functia construieste matricea de adiacenta cu lista de adiacenta
/// \param l - lista de adiacenta
/// \param n - nr de noduri
/// \param a - matrice de adiacenta

void matrice_adiacenta_din_lista_adiacenta(int l[][101], int n, int a[][101]) {
    // zerorizare
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            a[i][j] = 0;

    for (int i = 1; i <= n; i++) {
        int j = 1;
        while (l[i][j] != 0 && j <= n) {
            a[i][l[i][j]] = 1;
            j++;
        }
    }
}

int main() {

    int a[101][101], n, l[101][101], m[101][101], nr_muchii;

    // Fisier -> matrice de adiacenta
    citire(a, n);
    cout << "Matricea de adiacenta este:\n";
    afisare_matrice(a, n, n);

    // matrice de adiacenta -> lista adiacenta
    lista_adiacenta(a, n, l);
    cout << "Lista de adiacenta:\n";
    afisare_lista_adiacenta(l, n);

    // lista adiacenta -> matrice de incidenta
    matrice_incidenta(l,n,m,nr_muchii);
    cout<<"Matricea de incidenta este:\n";
    afisare_matrice(m,n,nr_muchii);

    // matrice de incidenta -> lista adiacenta
    lista_adiacenta_din_matrice_incidenta(m,n,nr_muchii,l);
    cout<<"Lista de adiacenta:\n";
    afisare_lista_adiacenta(l,n);

    // lista adiacenta -> matrice de adiacenta
    matrice_adiacenta_din_lista_adiacenta(l,n,a);
    cout<<"Matricea de adiacenta este:\n";
    afisare_matrice(a,n,n);

    // matrice de adiacenta -> lista adiacenta
    lista_adiacenta(a, n, l);
    cout << "Lista de adiacenta:\n";
    afisare_lista_adiacenta(l, n);

    return 0;
}