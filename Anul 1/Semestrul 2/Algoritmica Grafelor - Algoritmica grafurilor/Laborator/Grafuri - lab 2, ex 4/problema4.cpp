#include <vector>
#include <iostream>
#include <fstream>
#include <queue>
using namespace std;
/*4. Pentru un graf dat să se afișeze pe ecran vârfurile descoperite de algoritmul BFS și distanța față de vârful sursă (arborele descoperit).*/

ifstream f4("bfs.txt"); 

vector<int> v4[105]; // Vector de vectori pentru a reprezenta grafurile
queue<pair<int, int>> q4; // Coada de perechi (nod, distanță)
int n4, viz[105]; // Numărul de noduri și un vector pentru a ține evidența nodurilor vizitate


void bfs(int nod)
{
    q4.push({ nod, 1 }); // Adaugă nodul sursă în coadă cu distanța 1
    viz[nod] = 1; // Marchează nodul ca fiind vizitat
    while (!q4.empty())
    {
        int crt = q4.front().first; // Nodul curent din fața cozii
        int poz = q4.front().second; // Distanța până la nodul curent
        cout << crt << " " << poz << '\n'; 
        viz[crt] = 1; 
        for (int i = 0; i < v4[crt].size(); i++)
        {
            if (viz[v4[crt][i]] == 0) 
            {
                viz[v4[crt][i]] = 1; 
                q4.push({ v4[crt][i], poz + 1 }); 
            }
        }
        q4.pop(); // Scoate nodul curent din coadă
    }
}


void solve4()
{
    int x, y, s; 
    f4 >> n4; 
    while (f4 >> x >> y) 
    {
        v4[x].push_back(y); 
    }
    cout << "Nodul sursa: ";
    cin >> s; 
    bfs(s); 
}

int main() {
    solve4();
    return 0;
}
