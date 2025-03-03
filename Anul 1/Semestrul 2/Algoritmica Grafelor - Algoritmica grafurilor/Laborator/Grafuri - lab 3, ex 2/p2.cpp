#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
using namespace std;
const int oo = 1<<30;
ifstream in("in.txt");
ofstream out("out.txt");

int v, e;
vector < pair<int, int> > vect[1005];
vector <int> vh;
vector < vector<int>> vd;

void citeste() {

    in >> v >> e;
    for (int i = 0; i < e; i++) {
        int x, y, w;
        in >> x >> y >> w;
        vect[x].push_back(make_pair(y, w));
    }
}

bool Bellman_Ford(vector < pair<int, int >> g[], int n, int s, vector<int>& d) {
    for (int i = 0; i < n; i++)
        d.push_back(oo);
    d[s] = 0;
    for (int i = 0; i <= n - 1; i++) {
        // pentru fiecare muchie incerc sa o relaxez
        for (int i = 0; i < n;  i++) {
            for (pair<int, int>& p : g[i]) {
                if (d[p.first] > d[i] + p.second) {
                    d[p.first] = d[i] + p.second;
                }
            }
        }
    }

    for (int i = 0; i < n; i++)
        for (pair<int, int>& p : g[i])
            if (d[p.first] > d[i] + p.second)
                return false; // este un ciclu negativ
    return true;

}
void Dijkstra(vector < pair<int, int >> g[], int v, int s, vector <int>& d) {

    vector <bool> InCoada;
    for (int i = 0; i < v; i++)
    {
        InCoada.push_back(false);
        d.push_back(oo);
    }

    auto comp = [d](int x, int y) {return d[x] < d[y]; };
    priority_queue< int, vector<int>, decltype(comp) > Q(comp);
    d[s] = 0;
    Q.push(s);
    InCoada[s] = true;

    while (!Q.empty())
    {
        int nodCurent = Q.top();
        Q.pop();

        InCoada[nodCurent] = false;
        for (size_t i = 0; i < g[nodCurent].size(); i++)
        {
            int Vecin = g[nodCurent][i].first;
            int Cost = g[nodCurent][i].second;
            if (d[nodCurent] + Cost < d[Vecin])
            {
                d[Vecin] = d[nodCurent] + Cost;
                if (InCoada[Vecin] == false)
                {
                    Q.push(Vecin);
                    InCoada[Vecin] = true;
                }
            }
        }
    }
}
bool Johnson(vector < pair<int, int> > g[], int v, vector < vector <int> > &d) {
    for (int i = 0; i < v; i++)
        g[v].push_back(make_pair(i, 0));//construiesc graful G' cu o muchie de la v la toate celelalte varfuri
    vector <int> dBF; //nod nou cu eticheta V
    if(Bellman_Ford(g, v+1, v, dBF) == false)
        return false;

    vector <int> h(v);
    for (int i = 0; i < v; i++)
        h[i] = dBF[i];

    for(int i = 0; i < v; i++)
        for(pair <int, int> &p : g[i])
            p.second = p.second+h[i]-h[p.first]; //
    for (int i = 0; i < v; i++)
        for (pair <int, int>&p: g[i])
            out << i << ' ' << p.first << ' ' << p.second << endl;

    vector <int> dDijkstra;
    for(int i = 0; i < v; i++) {
        dDijkstra.clear();
        Dijkstra(g, v, i, dDijkstra);
        for(int j = 0; j < d[i].size(); j++)
            d[i][j] = dDijkstra[j] - h[i] + h[j];
    }
    return true;
}

void rezolva() {
    for (int i = 0; i < v; i++) {
        vector <int> a;
        for (int j = 0; j < v; j++)
            a.push_back(oo);
        vd.push_back(a);
    }

    if (Johnson(vect, v, vd) == false) {
        out << -1;
        out.close();
    }

}

void afisare() {
    for (int i = 0; i < vd.size(); i++) {
        for (int j = 0; j < vd[i].size(); j++)
            if(abs(vd[i][j] - oo) <= 10000)
                out << "INF ";
            else
                out << vd[i][j] << ' ';
        out << endl;
    }
}

int main(){

    citeste();
    rezolva();
    afisare();

    out.close();
    in.close();
    return 0;
}