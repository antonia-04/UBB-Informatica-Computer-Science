#include <assert.h>
#include "AB.h"
#include "TestExtins.h"
#include "IteratorAB.h"
#include <iostream>
#include <string>
#include <exception>

using namespace std;

AB creeazaArbore() {
    //arborele este
    //       1
    //      / \
    //     2   3
    //    /     \
    //   4       5
    //    \     /
    //     6   7
    //    /   / \
    //   8   9   10
    //    \      /
    //    11    12

    AB a11(11), a12(12), a10(10), a8(8), a9(9);
    a8.adaugaSubDr(a11);
    a10.adaugaSubSt(a12);
    AB a, a6(a8,6,a), a7(a9,7,a10), a4(a,4,a6),a5(a7,5,a),a2(a4,2,a),a3(a,3,a5),ab(a2,1,a3);
    return ab;
}

void testExceptii() {
	AB ab;
	try {
		ab.element();
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
    try {
		ab.stang();
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
    try {
		ab.drept();
	}
	catch (exception&) {
		assert(true); //ar trebui sa arunce exceptie
	}
	try {
		ab.vid();
		assert(true);
	}
	catch (exception&) {
		assert(false); //nu ar trebui sa arunce exceptie
	}
}

void testIterator(IteratorAB* iab, int i){
	int pre[]={1,2,4,6,8,11,3,5,7,9,10,12};
	int post[]={11,8,6,4,2,9,12,10,7,5,3,1};
	int in[]={4,8,11,6,2,1,3,9,7,12,10,5};
	int latime[]={1,2,3,4,5,6,7,8,9,10,11,12};
    iab->prim();
    int k=0;
    while (iab->valid()) {
        TElem e = iab->element();
		if (i==0)
			assert(e==pre[k]);
        else
            if (i==1)
                assert(e==post[k]);
            else
                if (i==2)
                    assert(e==in[k]);
                else
                    assert(e==latime[k]);
        k++;
        iab->urmator();
    }
}

AB creeazaArbore1() {
   // arborele este
   //              1
   //             /
   //            2
   //           /
   //          3
   //         /
   //        4
   //       /
   //      5
   //     /
   //    6
   //   /
   //  7
   // /
   //8

    AB a8(8), a, a7(a8,7,a), a6(a7,6,a), a5(a6,5,a), a4(a5,4,a), a3(a4,3,a), a2(a3,2,a), ab(a2,1,a);
    return ab;
}

AB creeazaArbore2() {
   // arborele este
   // 1
   //  \
   //   2
   //    \
   //     3
   //      \
   //       4
   //        \
   //         5
   //          \
   //           6
   //            \
   //             7
   //              \
   //               8

    AB a8(8), a, a7(a,7,a8), a6(a,6,a7), a5(a,5,a6), a4(a,4,a5), a3(a,3,a4), a2(a,2,a3), ab(a,1,a2);
    return ab;
}


void testIterator(IteratorAB* iab, int pre[], int post[], int in[], int latime[], int i){
       	iab->prim();
       	int k=0;
       	while (iab->valid()) {
        	TElem e = iab->element();
            if (i==0)
                assert(e==pre[k]);
            else
                if (i==1)
                    assert(e==post[k]);
                else
                    if (i==2)
                        assert(e==in[k]);
                    else
                        assert(e==latime[k]);
            k++;
           	iab->urmator();
        }
}

void test1_Extra() {
	string ordine[]={"preordine","postordine","inordine","latime"};
	AB ab;
   	 //test arbore vid
	for(int i=0;i<4;i++){
       	IteratorAB* iab = ab.iterator(ordine[i]);
		assert(iab->valid()==false);
    }
}


void test2_Extra() {
	string ordine[]={"preordine","postordine","inordine","latime"};
	int pre[]={1,2,3,4,5,6,7,8};
	int post[]={8,7,6,5,4,3,2,1};
	int in[]={8,7,6,5,4,3,2,1};
	int latime[]={1,2,3,4,5,6,7,8};
	AB ab=creeazaArbore1();
	for(int i=0;i<4;i++){
       	IteratorAB* iab = ab.iterator(ordine[i]);
		testIterator(iab, pre, post, in, latime, i);
    }
}

void test3_Extra() {
	string ordine[]={"preordine","postordine","inordine","latime"};
	int pre[]={1,2,3,4,5,6,7,8};
	int post[]={8,7,6,5,4,3,2,1};
	int in[]={1,2,3,4,5,6,7,8};
	int latime[]={1,2,3,4,5,6,7,8};
	AB ab=creeazaArbore2();
	for(int i=0;i<4;i++){
        IteratorAB* iab = ab.iterator(ordine[i]);
		testIterator(iab, pre, post, in, latime, i);
    }
}


void testAllExtins() {
	string ordine[]={"preordine","postordine","inordine","latime"};
	AB ab=creeazaArbore();
	for(int i=0;i<4;i++){
       	IteratorAB* iab = ab.iterator(ordine[i]);
		testIterator(iab, i);
	test1_Extra();
	test2_Extra();
	test3_Extra();
	testExceptii();
    }
}



