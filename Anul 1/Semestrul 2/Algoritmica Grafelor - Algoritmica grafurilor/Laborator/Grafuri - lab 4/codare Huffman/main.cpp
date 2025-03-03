// L4p3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <fstream>
#include <map>
#include <queue>
using namespace std;
struct Nod
{
	Nod* st, * dr, * tata;
	int aparitii = 0;
	char val;
	Nod(Nod* st, Nod* dr, Nod* tata, int aparitii, char val = 0)
	{
		this->st = st;
		this->dr = dr;
		this->tata = tata;
		this->aparitii = aparitii;
		this->val = val;
	}
};

Nod* CreazaArbore(vector<pair<char, int>> aparitii, map<char, Nod*>& result)
{
	struct cmp
	{
		bool operator()(Nod* b, Nod* a)
		{
			return a->aparitii < b->aparitii ||
				(a->aparitii == b->aparitii && a->val < b->val);
		}
	};
	priority_queue<Nod*, vector<Nod*>, cmp> q;
	for (auto x : aparitii)
	{
		Nod* nod = new Nod(nullptr, nullptr, nullptr, x.second, x.first);
		q.push(nod);
		result[x.first] = nod;
	}

	while (q.size() > 1)
	{
		Nod* x = q.top();
		q.pop();
		Nod* y = q.top();
		q.pop();
		Nod* z = new Nod(x, y, nullptr, x->aparitii + y->aparitii);
		x->tata = y->tata = z;
		q.push(z);
	}

	return q.top();
}

void Show(Nod* p)
{
	if (p->tata != nullptr)
	{
		Show(p->tata);
		if (p->tata->st == p)
			cout << 0;
		else
			cout << 1;
	}
}
void Distruge(Nod* head)
{
	if (head)
	{
		Distruge(head->st);
		Distruge(head->dr);
		delete head;
	}
}
int main()
{
	string s;
	ifstream f("date.txt");
	f >> s;

	int aparitii[256]{};
	for (char c : s)
		aparitii[c]++;

	vector<pair<char, int>>v;
	for (int i = 0;i < 256;i++)
		if (aparitii[i] > 0)
			v.push_back({ i,aparitii[i] });

	map<char, Nod*> result;
	Nod* arb = CreazaArbore(v, result);

	cout << result.size() << '\n';
	for (auto x : result)
		cout << x.first << ' ' << x.second->aparitii << '\n';
	cout << '\n';

	for (char c : s)
		Show(result[c]);
	Distruge(arb);
	return 0;
}
