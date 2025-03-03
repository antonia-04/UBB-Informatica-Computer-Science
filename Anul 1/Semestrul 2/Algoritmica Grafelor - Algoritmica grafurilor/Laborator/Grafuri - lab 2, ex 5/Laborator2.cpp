#include <iostream>
using namespace std;

/*5. Pentru un graf dat să se afișeze pe ecran vârfurile descoperite de apelul recursiv al procedurii DFS_VISIT(G, u) (apadurea descoperită de DFS).*/

void dfs(int varf, int n, int mat[101][101], int v[]) {
    cout << varf << " "; 
    v[varf] = 1; 

    for (int i = 1; i <= n; i++) {
        // Verifică dacă există o muchie de la nodul curent (varf) la nodul i și dacă nodul i nu a fost vizitat încă
        if (mat[varf][i] == 1 && v[i] == 0)
            dfs(i, n, mat, v); // Dacă condiția este îndeplinită, continuă parcurgerea recursivă din nodul i
    }
}

int main() {
    int n, m, mat[101][101] = { 0 }, x, y;

    cout << "Introduceti numarul de noduri:";
        cin >> n;
    cout<<"Introduceti numarul de muchii:";
    cin >> m;

    // Citirea muchiilor și construirea matricei de adiacență
    for (int i = 1; i <= m; i++) {
        cin >> x >> y;
        mat[x][y] = 1; // Există o muchie de la nodul x la nodul y
    }

    for (int i = 1; i <= n; i++) {
        int v[101] = { 0 }; // Vector pentru a marca nodurile vizitate în timpul parcurgerii DFS
        dfs(i, n, mat, v); // Parcurge graful începând cu nodul i
        cout << '\n'; 
    }

    return 0;
}
