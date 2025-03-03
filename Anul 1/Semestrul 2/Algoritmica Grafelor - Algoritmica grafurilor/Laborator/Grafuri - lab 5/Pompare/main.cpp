#include <iostream>
#include <fstream>
#include <algorithm>

using namespace std;

ifstream f("pompareT.txt");

const int INF = 10000000;

void Pompare(int** C, int** F, int* e, int u, int v)
{
    int minim = min(e[u], C[u][v] - F[u][v]);
    F[u][v] += minim;
    F[v][u] -= minim;
    e[u] -= minim;
    e[v] += minim;
}

void Inaltare(int V, int** C, int** F, int* h, int u)
{
    int h_min = INF;
    for (int v = 0; v < V; v++)
        if (C[u][v] - F[u][v] > 0)
        {
            h_min = min(h_min, h[v]);
            h[u] = h_min + 1;
        }
}

void Descarcare(int V, int** C, int** F, int* e, int* h, int* viz, int u)
{
    while (e[u] > 0)
        if (viz[u] < V)
        {
            int v = viz[u];
            if ((C[u][v] - F[u][v] > 0) && (h[u] > h[v]))
                Pompare(C, F, e, u, v);
            else
                viz[u]++;
        }
        else
        {
            Inaltare(V, C, F, h, u);
            viz[u] = 0;
        }
}


int Pompare_topologica(int V, int** C, int** F, int sursa, int destinatie)
{
    int* e = new int[V];
    int* h = new int[V];
    int* viz = new int[V];
    int* L = new int[V - 2];
    for (int i = 0; i < V; i++)
        e[i] = 0;
    for (int i = 0; i < V; i++)
        h[i] = 0;
    for (int i = 0; i < V; i++)
        viz[i] = 0;
    int len = 0;
    for (int i = 0; i < V; i++)
        if ((i != sursa) && (i != destinatie))
        {
            L[len] = i;
            len++;
        }

    h[sursa] = V;
    e[sursa] = INF;
    for (int i = 0; i < V; i++)
        Pompare(C, F, e, sursa, i);

    int k = 0;
    while (k < V - 2)
    {
        int u = L[k];
        int H = h[u];
        Descarcare(V, C, F, e, h, viz, u);
        if (h[u] > H)
        {
            int aux = L[k];
            for (int i = k; i > 0; i--)
                L[i] = L[i - 1];
            L[0] = aux;
            k = 0;
        }
        else
            k++;
    }

    int flux_maxim = 0;
    for (int i = 0; i < V; i++)
        flux_maxim += F[sursa][i];

    delete[] L;
    delete[] viz;
    delete[] h;
    delete[] e;

    return flux_maxim;
}

int main()
{
    int V, E, u, v, c;
    f >> V >> E;

    int** C = new int*[V];
    for (int i = 0; i < V; i++)
        C[i] = new int[V];

    int** F = new int*[V];
    for (int i = 0; i < V; i++)
        F[i] = new int[V];

    for (int i = 0; i < V; i++)
    {
        for (int j = 0; j < V; j++)
        {
            C[i][j] = 0;
            F[i][j] = 0;
        }
    }

    for (int i = 0; i < E; i++)
    {
        f >> u >> v >> c;
        C[u][v] = c;
    }

    int sursa = 7, destinatie = 0;
    cout << "Fluxul maxim: " << Pompare_topologica(V, C, F, sursa, destinatie) << '\n';

    for (int i = 0; i < V; i++)
        delete[] C[i];
    delete[] C;

    for (int i = 0; i < V; i++)
        delete[] F[i];
    delete[] F;
    return 0;
}
