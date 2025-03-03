/*2. Sa se determine închiderea transitivă a unui graf orientat.
 * (Închiderea tranzitivă poate fi reprezentată ca matricea care descrie,
 * pentru fiecare vârf în parte, care sunt vârfurile accesibile din acest vârf.
 * Matricea inchiderii tranzitive arată unde se poate ajunge din fiecare vârf.)
 * ex. figura inchidere_tranzitiva.png -
 * pentru graful de sus se construieste matricea de jos care arata inchiderea tranzitiva.
 */
#include <fstream>
using namespace std;

ifstream fin("graf.in");
ofstream fout("matrice.out");

const int NMAX = 105;


int main() {
    int mat[NMAX][NMAX];
    int n, m;
    fin >> n >> m;
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= n; j++) {
            mat[i][j] = 0;
        }
        mat[i][i] = 1;     ///1 pe diagonala principala
    }
    for(int i = 0; i <= m; i++){
        int x, y;
        fin >> x >> y;
        mat[x][y] = 1;
    }
    // Algoritmului Warshall pt matricea distantelor
    for(int k = 1; k <= n; k++) {
        for(int i = 1; i <= n; i++) {
            for(int j = 1; j <= n; j++) {
                mat[i][j] = mat[i][j]||(mat[i][k] && mat[k][j]); ///daca exista drum de la i la j
                                                                  /// SAU de la i la k si de la k la j
            }
        }
    }

    // Matricea închiderii tranzitive în fișierul de ieșire
    fout << "Matricea inchiderii tranzitive este: \n";
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= n; j++) {
            fout << mat[i][j] << ' ';
        }
        fout << '\n';
    }
    return 0;
}