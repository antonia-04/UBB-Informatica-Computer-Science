#include <iostream>
#include <fstream>

using namespace std;
ifstream f("eulerian.txt");
int n,m,p=0,k,x,y,A[100][100],L[100];


void Euler(int k)
{
    for(int i=0 ; i<n ; i++)
        if(A[k][i] == 1)  //det nodurile adiacente cu k
        {
            A[k][i]=A[i][k]=0;  //eliminam muchia [k,i]
            Euler(i);
        }
    L[p]=k;  //punem nodul k in lista
    p++;
}

int main()
{
    f>>n>>m;
    while(f>>x>>y) {
        A[x][y]=A[y][x]=1;
    }
    Euler(0);

    for(int i=0; i<p-1; i++)
    {
        cout<<L[i]<<' ';
    }
    return 0;
}
