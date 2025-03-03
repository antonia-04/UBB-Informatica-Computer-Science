#include <iostream>
#include <fstream>

using namespace std;
ifstream f("1.txt");

int fii[100], t[100], k[100], nr=0;


void codarePrufer(int k[],int fii[],int t[],int n, int& nr)
{
    int copie=0;
    bool gasit =false;
    while(!gasit)//cat timp exista fii pentru orice nod
    {
        for(int i =0; i < n; i++){
            gasit =true;
            if(fii[i]==0)//daca nodul i este frunza, se alege cea mai mica frunza
            {
            gasit = false;
            copie = i;
            fii[i]--;//se elimina ca fiind nod frunza

            if(t[i] != -1)
                fii[t[i]]--;//se scade un fiu pt tata lui i
            k[nr++]= t[copie];// se salveaza parintele
            break;
            }
        }
    }
}

int main(){
    int n,x;
    f>>n;

    for (int i=0; i<n; i++)
        fii[i]=0;

    for(int i=0; i<n; i++)
    {
        f>>x;
        t[i]=x;
        if(t[i]!=-1)
            fii[t[i]]++;
    }

    codarePrufer(k, fii, t, n, nr);
    cout<<nr-1<<"\n";
    for(int i=0; i<nr-1; i++)
        cout<<k[i]<<" ";

    return 0;
}
