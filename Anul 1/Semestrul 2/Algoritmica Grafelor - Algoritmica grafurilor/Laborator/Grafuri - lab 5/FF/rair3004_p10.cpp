#include <iostream>
#include <fstream>
#include <queue>
using namespace std;


bool BFS(int G[100][100], int V, int s, int d, int parinte[])
{
    bool* viz=new bool[V];
    for(int i=0; i<V; i++)
        viz[i]=false;

    queue<int> Q;
    Q.push(s);
    parinte[s]=-1;
    viz[s]=true;
    while(!Q.empty())
    {
        int u = Q.front();
        Q.pop();
        for(int v=0; v<V; v++)
        {
            if(viz[v]==false && G[u][v]!=0)
                {
                    Q.push(v);
                    parinte[v]= u;
                    viz[v]=true;
                }
        }
    }

    if(viz[d]==true)
    {
        delete[] viz;
        return true;
    }
    else
    {
        delete[] viz;
        return false;
    }
}


int Ford_Fulkerson(int G[100][100],int& V,int s, int d){
    int u, v;
    int rG[100][100];   // graf rezidual

    for(u=0; u<V; u++)
        for(v=0; v<V; v++)
            rG[u][v]= G[u][v];

    int* parinte=new int[V];
    int flux_maxim=0;
    while(BFS(rG, V, s, d, parinte))
    {
        cout<<"1 ";
        int flux_cale=INT_MAX;
        for(v=d; v!=s; v=parinte[v])
            {
                u = parinte[v];
                flux_cale = min(flux_cale, rG[u][v]);
            }

        for(v=d; v!=s; v=parinte[v])
            {
                u = parinte[v];
                rG[u][v]-= flux_cale;
                rG[v][u]+= flux_cale;
            }

        flux_maxim += flux_cale;
    }

    return flux_maxim;

}


int main(int argc, char* argv[])
{
    ifstream fin;
    ofstream fout;
    if(argc==3)
    {
        fin.open(argv[1]);
        fout.open(argv[2]);
    }
    else
    {
        fin.open("in.txt");
        fout.open("out.txt");
    }
    int V,E,c,x,y;
    int G[100][100];

    fin>>V>>E;
    for(int i=0; i<E; i++)
    {
        fin>>x>>y>>c;
        G[x][y]=c;
    }

    int fluxM=Ford_Fulkerson(G,V,0,5);
    fout<<fluxM;

    fin.close();
    fout.close();
    return 0;
}
