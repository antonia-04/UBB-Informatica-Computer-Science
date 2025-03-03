#include <exception>
#include <assert.h>
#include <algorithm>
#include <vector>
#include "Iterator.h"
#include "DO.h"
#include "TestExtins.h"
using namespace std;

bool cresc(TCheie c1, TCheie c2) {
	if (c1 <= c2) {
		return true;
	} else {
		return false;
	}
}

bool desc(TCheie c1, TCheie c2) {
	if (c1 >= c2) {
		return true;
	} else {
		return false;
	}
}

void testCreeaza() {
	DO d = DO(cresc);
	assert(d.dim() == 0);
	assert(d.vid());

	Iterator it = d.iterator();
	it.prim();
	assert(!it.valid());

	for (int i = 0; i < 10; i++) {
		assert(d.cauta(i) == NULL_TVALOARE);
	}

	for (int i = -10; i < 10; i++) {
		assert(d.sterge(i) == NULL_TVALOARE);
	}
}

void testCauta(Relatie r) {
	DO d = DO(r);
	int cMin = 0;
	int cMax = 10;
	try {
		for (int i = cMin; i <= cMax; i++) {
			d.adauga(i, i + 1);
		}
		assert(true);
	} catch (exception&) {
		assert(false);
	}
	int intervalDim = 10;
	for (int i = cMin; i <= cMax; i++) {
		assert(d.cauta(i) == i + 1);
	}
	for (int i = cMin - intervalDim; i < cMin; i++) {
		assert(d.cauta(i) == NULL_TVALOARE);
	}
	for (int i = cMax + 1; i < cMax + intervalDim; i++) {
		assert(d.cauta(i) == NULL_TVALOARE);
	}
}

void testCauta() {
	testCauta(cresc);
	testCauta(desc);
}

//genereaza un vector continand in ordine aleatoare valorile naturale din intervalul inchis [cMin, cMax]
vector<int> cheiInOrdineAleatoare(int cMin, int cMax) {
	vector<int> chei;
	for (int c = cMin; c <= cMax; c++) {
		chei.push_back(c);
	}
	int n = chei.size();
	for (int i = 0; i < n - 1; i++) {
		int j = i + rand() % (n - i);
		swap(chei[i], chei[j]);
	}
	return chei;
}

void populeazaDOVidIdentic(DO& doc, int cMin, int cMax) {
	vector<int> chei = cheiInOrdineAleatoare(cMin, cMax);
	int n = chei.size();
	for (int i = 0; i < n; i++) {
		assert(doc.adauga(chei[i], chei[i]) == NULL_TVALOARE);
	}
}

void rePopuleazaDOSh(DO& doc, int cMin, int cMax, int shift) {
	vector<int> chei = cheiInOrdineAleatoare(cMin, cMax);
	int n = chei.size();
	for (int i = 0; i < n; i++) {
		assert(doc.adauga(chei[i], chei[i] - shift) == chei[i]);
	}
}

void populeazaDOSh(DO& doc, int cMin, int cMax, int shift) {
	vector<int> chei = cheiInOrdineAleatoare(cMin, cMax);
	int n = chei.size();
	for (int i = 0; i < n; i++) {
		doc.adauga(chei[i], chei[i] - shift);
	}
}

void testAdaugaSiCauta(Relatie r) {
	DO d = DO(r);
	int cMin = 100;
	int cMax = 200;

	populeazaDOVidIdentic(d, cMin, cMax);
	for (int c = cMin; c <= cMax; c++) {
		assert(d.cauta(c) == c);
	}
	assert(d.dim() == (cMax - cMin + 1));

	rePopuleazaDOSh(d, cMin, cMax, 1);
	assert(d.dim() == (cMax - cMin + 1));

	populeazaDOSh(d, 2 * cMax, 3 * cMax, 2 * cMax - cMin);
	for (int c = 2 * cMax; c <= 3 * cMax; c++) {
		assert(d.cauta(c) == c - 2 * cMax + cMin);
	}
	assert(d.dim() == (cMax - cMin + 1) + (cMax + 1));

	Iterator it = d.iterator();
	it.prim();
	if (it.valid()) {
		TCheie cPrec = it.element().first;
		assert(d.cauta(cPrec) != NULL_TVALOARE);
		it.urmator();
		while (it.valid()) {
			TCheie c = it.element().first;
			assert(r(cPrec, c));
			assert(d.cauta(c) != NULL_TVALOARE);
			cPrec = c;
			it.urmator();
		}
	}

}

void testAdauga() {
	testAdaugaSiCauta(cresc);
	testAdaugaSiCauta(desc);
}

void testStergeCauta(Relatie r) {
	DO d = DO(r);
	int cMin = 10;
	int cMax = 20;
	populeazaDOVidIdentic(d, cMin, cMax);
	for (int c = cMax + 1; c <= 2 * cMax; c++) {
		assert(d.sterge(c) == NULL_TVALOARE);
	}
	int dim = cMax - cMin + 1;
	assert(d.dim() == dim);
	for (int c = cMin; c <= cMax; c++) {
		assert(d.sterge(c) == c);
		assert(d.cauta(c) == NULL_TVALOARE);

		Iterator it = d.iterator();
		it.prim();
		if (it.valid()) {
			TCheie cPrec = it.element().first;
			it.urmator();
			while (it.valid()) {
				TCheie c = it.element().first;
				assert(r(cPrec, c));
				cPrec = c;
				it.urmator();
			}
		}

		dim--;
		assert(d.dim() == dim);

	}

	for (int c = cMin; c <= cMax; c++) {
		assert(d.sterge(c) == NULL_TVALOARE);
	}
	assert(d.vid());
	assert(d.dim() == 0);

}

void testSterge() {
	testStergeCauta(cresc);
	testStergeCauta(desc);
}

void testIterator(Relatie r) {
	DO d = DO(r);
	Iterator it = d.iterator();
	assert(!it.valid());
	it.prim();
	assert(!it.valid());
	int cMin = 100;
	int cMax = 300;
	vector<int> chei = cheiInOrdineAleatoare(cMin, cMax);
	int n = chei.size();
	for (int i = 0; i < n; i++) {
		assert(d.adauga(chei[i], chei[n - i - 1]) == NULL_TVALOARE);
	}

	Iterator itD = d.iterator();
	assert(itD.valid());
	itD.prim();
	assert(itD.valid());

	TCheie cPrec = itD.element().first;
	for (int i=1; i<100; i++){
		assert(cPrec == itD.element().first);
	}
    itD.urmator();
	while (itD.valid()) {
		TCheie c = itD.element().first;
		assert(cMin <= c && c <= cMax);
		assert(d.cauta(c) != NULL_TVALOARE);
		assert(r(cPrec, c));
		cPrec = c;
		itD.urmator();
	}
}

void testCantitativ(){
	DO d = DO(cresc);
	int cMin = -3000;
	int cMax = 3000;
	vector<int> chei  = cheiInOrdineAleatoare(cMin, cMax);
    populeazaDOVidIdentic(d, cMin, cMax);
    for (int c = cMin; c <= cMax; c++){
      	assert(d.cauta(c) == c);
    }
    assert(d.dim() == cMax - cMin + 1);
    Iterator it  = d.iterator();
    assert(it.valid());
    it.prim();
    assert(it.valid());
    for (int i = 0; i < d.dim(); i++) {
    	it.urmator();
    }
    assert(!it.valid());
    it.prim();
    while (it.valid()){
    	TCheie c = it.element().first;
    	assert(d.cauta(c) == c);
        TValoare v  = it.element().second;
        assert(c == v);
        it.urmator();
    }
    assert(!it.valid());
    for (int c = cMin-100; c <= cMax+100; c++){
         d.sterge(c);
         assert(d.cauta(c) == NULL_TVALOARE);
    }
    assert(d.dim() == 0);
    assert(d.vid());
}

void testIterator() {
	testIterator(cresc);
	testIterator(desc);
}

void testAllExtins() {
	testCreeaza();
	testAdauga();
	testCauta();
	testSterge();
	testIterator();
	testCantitativ();
}
