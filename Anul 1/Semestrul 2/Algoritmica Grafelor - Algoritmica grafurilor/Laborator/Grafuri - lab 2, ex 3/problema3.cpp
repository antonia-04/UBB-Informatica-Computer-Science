#include <iostream>
#include <fstream>
#include <cstring>

using namespace std;

ifstream f3("labirint_1.txt"); // Deschidem fișierul de intrare

int a[1005][1005]; // Declaram matricea labirintului
int n3, m, xs, ys, xf, yf; // Variabile pentru dimensiunile labirintului și pozițiile de start și final
char s[1005]; // Șirul pentru citirea unei linii din fișier

// Funcție pentru bordarea labirintului cu perete (-1)
void bordare()
{
    for (int i = 0; i <= n3 + 1; i++)
        a[i][0] = a[i][m + 1] = -1; // Bordăm coloanele laterale cu perete
    for (int i = 0; i <= m + 1; i++)
        a[0][i] = a[n3 + 1][i] = -1; // Bordăm rândurile superioară și inferioară cu perete
}

// Funcție pentru aplicarea algoritmului Lee pentru găsirea celui mai scurt drum
void lee(int x, int y)
{
    if (x == xf && y == yf)
    {
        return; // Dacă am ajuns la destinație, ne oprim
    }

    // Verificăm dacă putem merge în sus, jos, stânga sau dreapta și actualizăm distanța dacă este mai mică
    if (a[x + 1][y] == 0 || a[x][y] + 1 < a[x + 1][y])
    {
        a[x + 1][y] = a[x][y] + 1;
        lee(x + 1, y);
    }
    if (a[x - 1][y] == 0 || a[x][y] + 1 < a[x - 1][y])
    {
        a[x - 1][y] = a[x][y] + 1;
        lee(x - 1, y);
    }
    if (a[x][y + 1] == 0 || a[x][y] + 1 < a[x][y + 1])
    {
        a[x][y + 1] = a[x][y] + 1;
        lee(x, y + 1);
    }
    if (a[x][y - 1] == 0 || a[x][y] + 1 < a[x][y - 1])
    {
        a[x][y - 1] = a[x][y] + 1;
        lee(x, y - 1);
    }
}

// Funcție pentru rezolvarea labirintului
void solve3()
{
    // Citim labirintul linie cu linie din fișier
    while (f3.getline(s, 1005))
    {
        n3++; // Incrementăm numărul de rânduri citite
        m = strlen(s); // Actualizăm numărul de coloane pe baza lungimii șirului citit

        // Parcurgem caracterele din șir și construim matricea labirintului
        for (int i = 0; i < strlen(s); i++)
        {
            if (s[i] == '1')
                a[n3][i + 1] = -1; // Perete
            else if (s[i] == ' ')
                a[n3][i + 1] = 0; // Spațiu liber
            else if (s[i] == 'S')
            {
                a[n3][i + 1] = 1; // Poziția de start
                xs = n3; // Retinem coordonatele poziției de start
                ys = i + 1;
            }
            else
            {
                xf = n3; // Poziția finală
                yf = i + 1;
            }
        }
    }

    // Adăugăm bordura perimetrală cu perete
    bordare();

    // Aplicăm algoritmul Lee pentru a găsi cel mai scurt drum
    lee(xs, ys);

    // Afișăm lungimea celui mai scurt drum
    cout << "Drumul are lungime " << a[xf][yf] << '\n';

    int x, y;
    x = xf;
    y = yf;

    // Reconstruim drumul marcatând pozițiile pe care trecem cu -2 până ajungem la poziția de start
    while (x != xs || y != ys)
    {
        if (a[x - 1][y] + 1 == a[x][y])
        {
            a[x][y] = -2;
            x = x - 1;
        }
        else if (a[x + 1][y] + 1 == a[x][y])
        {
            a[x][y] = -2;
            x++;
        }
        else if (a[x][y - 1] + 1 == a[x][y])
        {
            a[x][y] = -2;
            y--;
        }
        else if (a[x][y + 1] + 1 == a[x][y])
        {
            a[x][y] = -2;
            y++;
        }
    }

    // Marchez poziția finală cu -3
    a[xf][yf] = -3;

    // Afișăm labirintul rezolvat
    for (int i = 1; i <= n3; i++)
    {
        for (int j = 1; j <= m; j++)
        {
            if (a[i][j] == -1)
                cout << '1'; // Perete
            else if (a[i][j] == 1)
                cout << 'S'; // Start
            else if (a[i][j] == -2)
                cout << 'D'; // Drum
            else if (a[i][j] == -3)
                cout << 'F'; // Final
            else
                cout << ' '; // Spațiu liber
        }
        cout << '\n';
    }
}

int main() {
    solve3(); // Rezolvăm labirintul
    return 0;
}


