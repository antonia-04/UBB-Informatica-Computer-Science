#include "VectorDinamic.h"#include <iostream>
using namespace std;void creare(VectorDinamic& v) {	v.adaugaSfarsit(1);	v.adaugaSfarsit(2);	v.adaugaSfarsit(3);	v.adaugaSfarsit(4);}
//tiparire folosind iteratorulvoid tiparire1(VectorDinamic& v) {
	Iterator i = v.iterator();	i.prim();	while (i.valid()) {		cout << i.element() << ' ';		i.urmator();	}
}
//tiparire iterand pe pozitiivoid tiparire2(const VectorDinamic& v) {
	cout << endl;	for (int i = 1; i <= v.dim(); i++)		cout << v.element(i) << ' ';
}
int main(void) {	VectorDinamic v(2);	creare(v);	tiparire1(v);	tiparire2(v);	return 0;
}
