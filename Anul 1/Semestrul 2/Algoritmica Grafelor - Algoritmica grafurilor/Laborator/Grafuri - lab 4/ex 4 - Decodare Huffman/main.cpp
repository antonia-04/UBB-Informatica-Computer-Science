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

Nod* CreazaArbore(vector<pair<char, int>> aparitii)
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
	for (auto& x : aparitii)
	{
		Nod* nod = new Nod(nullptr, nullptr, nullptr, x.second, x.first);
		q.push(nod);
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

void Show(char* p, Nod* head)
{
	Nod* cur = head;
	while (*p)
	{
		if (*p == '0')
			cur = cur->st;
		else
			cur = cur->dr;
		if (cur->st == nullptr && cur->dr == nullptr)
		{
			cout << cur->val;
			cur = head;
		}
		p++;
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
	vector<pair<char, int>> v;
	ifstream f("date.txt");
	int n;
	f >> n;
	for (int i = 1;i <= n;i++)
	{
		char c;
		int ap;
		f >> c >> ap;
		v.push_back({ c,ap });
	}
	char biti[50001];
	f >> biti;
	Nod* head = CreazaArbore(v);
	f.close();

	Show(biti, head);
	Distruge(head);
	return 0;
}
