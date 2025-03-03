#include <iostream>
#include <fstream>
#include <queue>
#include <algorithm>
using namespace std;
ifstream fin("prim.txt");

typedef pair<int, int> pereche;
typedef pair<int, pereche> muchie;

void citire(vector<vector<muchie>>& listaAdiac) {
	if (!fin.is_open())
		return;
	listaAdiac.clear();
	int n,m;
	fin>>n>>m;
	for (int i=0;i<n;i++)
		listaAdiac.push_back(vector<muchie>());
	for (int i=0;i<m;i++) {
		int x,y,w;
		fin>>x>>y>>w;
		listaAdiac[x].push_back(muchie(w,pereche(x, y)));
		listaAdiac[y].push_back(muchie(w,pereche(y, x)));
	}
}

void prim(const vector<vector<muchie>>& listaAdiac, vector<muchie>& arborePartialCostMinim) {
	arborePartialCostMinim.clear();
	priority_queue < muchie, vector<muchie>, greater<muchie>> q;
	vector<bool> viz;
	for (int i=0;i<listaAdiac.size();i++)
		viz.push_back(false);
	viz[0]=true;
	for (const auto& i : listaAdiac[0])   //merg prin vecinii lui 0 si pun in coada muchiile
		q.push(i);
	for (int i=0;i<listaAdiac.size()-1;i++) {      // n-1 ori (arbore)
		muchie best;
		do{
			best=q.top();
			q.pop();
		} while (viz[best.second.second] == true);    //scot pana nodul nu mai e vizitat
		int x=best.second.first;
		int y=best.second.second;
		viz[y]=true;
		arborePartialCostMinim.push_back(best);
		for (const auto& j : listaAdiac[y]) {     //parcurg muchiile
			if (viz[j.second.second]==false)       //daca ajung la un nod nou adaug in coada de prioritati
				q.push(j);
		}
	}
}

void afisare(const vector<muchie>& arborePartialCostMinim) {
	int sum=0;
	for (const auto& i : arborePartialCostMinim)
		sum+=i.first;
	cout<<sum<<'\n';
	cout<<arborePartialCostMinim.size()<<'\n';
	for (const auto& i : arborePartialCostMinim)
		cout<<i.second.first<<' '<<i.second.second<<'\n';
}

int main(int argc, char* argv[]) {
	vector<vector<muchie>>lista;
	vector<muchie>arborePartialCostMinim;
	citire(lista);
	prim(lista, arborePartialCostMinim);
	afisare(arborePartialCostMinim);
	fin.close();
	return 0;
}
