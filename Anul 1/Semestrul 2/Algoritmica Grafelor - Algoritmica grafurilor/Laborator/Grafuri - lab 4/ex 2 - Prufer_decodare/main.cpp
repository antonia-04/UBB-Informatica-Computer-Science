#include <iostream>
#include <fstream>

using namespace std;
ifstream f("2.txt");
int t[100], k[100], frecv[100];

int minim(int k[], int n)
{
    for(int i=0; i<n; i++)
        frecv[i]=0;
    for(int i=0; i<n; i++)
        frecv[k[i]]++;
    for(int i=0; i<n; i++)
        if(frecv[i]==0)
            return i;

}

void decodarePrufer(int k[], int t[], int& n)
{
    for(int i=0; i<n; i++)
    {
        int x=k[0]; //x primul elem din secventa
        int y=minim(k, n); //y cel mai mic nr care nu e in secv
        t[y]=x;  //x parintele lui y
        for(int i=0; i<n; i++)
            k[i]=k[i+1];  //sterg x din k
        k[n-1]=y;  //adaug pe y in coada
    }

}
int main()
{
   int n,x;
   f>>n;
   for(int i=0; i<n; i++)
   {
       f>>x;
       k[i]=x;  //initializare secventa
       t[i]=-1;  //initializare tati
   }

   decodarePrufer(k, t, n);
   cout<<n+1<<"\n";
   for(int i=0; i<=n; i++)
        cout<<t[i]<<" ";


    return 0;
}
