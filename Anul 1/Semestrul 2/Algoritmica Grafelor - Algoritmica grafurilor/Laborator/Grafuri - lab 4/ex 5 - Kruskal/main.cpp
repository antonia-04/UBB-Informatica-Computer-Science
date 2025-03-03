#include <iostream>
#include<fstream>
#include<algorithm>
using namespace std;

ifstream fin("in.txt");
//ofstream fout("out.txt");

const int dim = 1e6;

struct Nod
{
    int x, y, w;
}u[dim], sol[dim];

int p[dim], t[dim];

bool cmp(Nod x, Nod y)
{
    return (x.w < y.w);
}

int root(int x)
{
    while (x != t[x])
        x = t[x];
    return x;
}

void uneste(int x, int y)
{
    if (p[x] < p[y])
        t[x] = y;

    if (p[x] > p[y])
        t[y] = x;

    if (p[x] == p[y])
    {
        t[y] = x;
        p[x]++;
    }
}

int main()
{
    int n, m;
    fin >> n >> m;

    for (int i = 1; i <= m; i++)
    {
        fin >> u[i].x >> u[i].y >> u[i].w;
        t[i] = i;
    }

    sort(u + 1, u + m + 1, cmp);//sortez crescator muchiile graficului dupa pondere

    int i = 1;
    int k = 0;
    int ct = 0;

    while (k < n - 1)
    {
        int rx = root(u[i].x);
        int ry = root(u[i].y);

        if (rx != ry) {
            k++;
            ct += u[i].w;//calculez ponderea arborelui
            sol[k] = u[i];
            uneste(rx, ry);
        }
        i++;
    }

    cout << ct << "\n" << k << "\n";

    for (int i = 1; i <= k; i++)
        cout << sol[i].x << " " << sol[i].y << "\n";
}
