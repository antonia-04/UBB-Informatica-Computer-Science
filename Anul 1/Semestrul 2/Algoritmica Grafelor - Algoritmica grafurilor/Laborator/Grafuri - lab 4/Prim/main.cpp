#include <iostream>
#include <fstream>
using namespace std;

ifstream f("prim.txt");

int s,x,y,po,i,j,n,m,u,v,k,inf=10000,nod, d_m;
int p[101], Q[101], w[101][101], key[100];


bool este(int v, int d)
{
    for(int i=0; i<d; i++)
        if(Q[i]==v)
            return true;
    return false;


}
int extract_minim(int &d, int n, int &S, int& nr)
{
    d_m = inf;
    k=-1;
    m=n+1;
    for(i=0; i<d; i++)
    {
        nod=Q[i];
        if(key[nod] < d_m)
        {
        d_m = key[nod];
        m = nod;
        k=i;
        }
    }
    nr++;
    S=S+d_m;
    for(i=k; i<d-1; i++)
        Q[i]=Q[i+1];
    Q[d-1]=0;
    d--;
    return m;
}

int main()
{
    int nr=0;
    int S=0;
    f>>n>>m;
    while(f>>x>>y>>po)
        w[x][y]=w[y][x]=po;

    for(i=0; i<n; i++)
    {
        key[i]=inf;
        p[i]=0;

    }

    key[0]=0;

    for(i=0; i<n; i++)
    {
        Q[i]=i;
    }
    int d=n;

    while(d != 0)
    {
        u=extract_minim(d,n,S,nr);
        cout<<u<<" ";

        for(v=0; v<n; v++)
            if (w[u][v]!=0)
             {
               if(este(v,d) && w[u][v]<key[v])
                {
                    p[v]=u;
                    key[v]=w[u][v];

                }
            }
    }
    cout<<"\n"<<S<<"\n";
    cout<<nr-1;

}
