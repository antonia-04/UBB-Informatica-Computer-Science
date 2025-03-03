#include<iostream>
#include<limits.h>
#include<fstream>
using namespace std;

ifstream fin("graf.in");

// Variabile globale
int graf[20][20]={0},radacini[20],distanta[20],maxim=INT_MIN;

// Funcție pentru găsirea nodului cu cea mai mică distanță nevizitată
int distante_minime(int distanta[], bool vizitat[])
{
    // Initializare variabile locale
    int minim=INT_MAX,ind;

    // Parcurgere pentru găsirea nodului cu cea mai mică distanță
    for(int i=0;i<=maxim;i++)
    {
        if(vizitat[i]==false && distanta[i]<=minim)
        {
            minim=distanta[i];
            ind=i;
        }
    }
    return ind;
}

// Funcție pentru aplicarea algoritmului Dijkstra
void dijkstra(int radacina)
{
    int i;
    bool vizitat[maxim+2];

    // Inițializare distanțe și vector de vizitare
    for(int k = 0; k<=maxim; k++)
    {
        distanta[k] = INT_MAX;
        vizitat[k] = false;
        radacini[k]=-2;
    }

    // Actualizare distanță pentru nodul de început
    distanta[radacina] = 0;
    radacini[radacina] = -1;

    // Aplicare algoritm Dijkstra
    for(i = 0; i<=maxim; i++)
    {
        int m=distante_minime(distanta,vizitat);
        vizitat[m]=true;

        // Actualizare distanțe și noduri anterioare
        for(int k = 0; k<=maxim; k++)
            if(!vizitat[k] && graf[m][k] && distanta[m]!=INT_MAX && distanta[m]+graf[m][k]<distanta[k])
            {
                distanta[k]=distanta[m]+graf[m][k];
                radacini[k]=m;
            }
    }

}

int main()
{
    // Variabile pentru citirea datelor din fișier
    int nod_inceput,sfarsit;
    fin>>nod_inceput>>sfarsit;

    int muchii,i,j,k,cost;

    // Citirea grafului din fișier
    fin>>muchii;
    for(k=1;k<=muchii;k++){
        fin>>i>>j>>cost;
        graf[i][j]=cost;
        if(i>maxim) maxim=i;
        if(j>maxim) maxim=j;
    }

    // Aplicare algoritmului Dijkstra
    dijkstra(nod_inceput);

    // Afișare rezultat
    if(distanta[sfarsit] == INT_MAX)
        cout<<"Nu exista un drum intre aceste atractii."<<endl;
    else
    {
        cout<<sfarsit<<" ";
        while(radacini[sfarsit] != -1)
        {
            sfarsit = radacini[sfarsit];
            cout<<sfarsit<< " ";
        }
    }
    return 0;
}
