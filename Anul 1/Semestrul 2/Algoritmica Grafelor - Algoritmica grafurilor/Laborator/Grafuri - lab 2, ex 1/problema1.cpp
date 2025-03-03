#include <fstream>
#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>

/*1. Implementați algoritmul lui Moore pentru un graf orientat neponderat (algoritm bazat pe Breath-first search, vezi cursul 2). 
Datele sunt citete din fisierul graf.txt. Primul rând din graf.txt conține numărul vârfurilor, iar următoarele rânduri conțin muchiile grafului.
Programul trebuie să afiseze lanțul cel mai scurt dintr-un vârf (vârful sursa poate fi citit de la tastatura).*/

using namespace std;

ifstream f("graf.txt"); 

const int NMAX = 105; // Numarul maxim de noduri în graf
const int INF = 100000;
vector<vector<int>> G(NMAX); 

int n, m; 

struct solution { vector<int> V, P; }; // Structura pentru a reține vectorul de distanțe și vectorul de părinți

void read() {
    f >> n >> m; 
    while (m--) {
        int x, y;
        f >> x >> y; 
        G[x].push_back(y); // Adăugăm y în lista de adiacență a lui x
    }
}
/// <summary>
/// Moore's algorithm
auto bfs(int source) {
    vector<int> V(NMAX), P(NMAX);
    queue<int> q; // Coada pentru BFS

    q.push(source); // Adăugăm nodul sursă în coadă

    for (int i = 1; i <= n; ++i) {
        V[i] = INF; // Inițializăm distanțele cu infinit pentru toate nodurile
    }
    V[source] = 0; // Distanța de la sursă la sursă este 0

    while (!q.empty()) { 
        int val = q.front(); // Extragem nodul din fața cozii
        q.pop(); // Ștergem nodul extras din coadă
        for (auto x : G[val]) { // Pentru fiecare vecin al nodului extras
            if (V[x] == INF) { // Dacă vecinul nu a fost vizitat
                P[x] = val; // Setăm nodul val drept părinte pentru nodul x
                V[x] = V[val] + 1; // Actualizăm distanța până la nodul x
                q.push(x); // Adăugăm nodul x în coadă pentru a-l explora mai departe
            }
        }
    }

    return solution{ V, P }; // Returnăm vectorul de distanțe și vectorul de părinți
}

vector<int> road(vector<int> V, vector<int> P, int source) {
    int k = V[source]; // Lungimea drumului de la sursă la destinație
    vector<int> sol; // Vectorul în care vom reține drumul

    sol.push_back(source); // Adăugăm sursa la începutul drumului
    int x = source;
    while (k) {
        sol.push_back(P[x]); // Adăugăm părintele lui x în drum
        x = P[x]; // Ne deplasăm către părintele lui x
        k--;
    }

    reverse(sol.begin(), sol.end()); // Invertim vectorul pentru a obține drumul de la sursă la destinație

    return sol; // Returnăm drumul de la sursă la destinație
}

void solve() {
    int source, dest;

    read(); 

    cout << "Introduceti nodul sursa: ";
    cin >> source; 
    cout << "Introduceti nodul destinatie: ";
    cin >> dest; 

    solution Sol;

    Sol = bfs(source); // Aplicăm BFS pentru a găsi drumul cel mai scurt de la sursă la destinație

    vector<int> r;
    r = road(Sol.V, Sol.P, dest); // Construim drumul de la sursă la destinație

    cout << "\nLantul cel mai scurt este: \n";

    for (auto x : r) { // Afisăm drumul cel mai scurt
        cout << x << " ";
    }
}

int main(void) {
    solve(); 
}

