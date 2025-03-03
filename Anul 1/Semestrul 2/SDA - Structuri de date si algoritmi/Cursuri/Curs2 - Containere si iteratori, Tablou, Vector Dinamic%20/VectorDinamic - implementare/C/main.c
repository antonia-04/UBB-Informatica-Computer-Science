#include "VectorDinamic.h"#include <stdio.h>#include <malloc.h>
VectorDinamic* creare() {
	//se aloca spatiu de memorare pentru vector	VectorDinamic* v = creeaza(2);	adaugaSfarsit(v, 1);	adaugaSfarsit(v, 2);	adaugaSfarsit(v, 3);	adaugaSfarsit(v, 4);	return v;
}

//tiparire folosind iteratorulvoid tiparire(VectorDinamic* v) {
	Iterator *i = iteratorV(v);	prim(i);	while (valid(i)) {		printf("%d ", elementI(i));		urmator(i);	}
	printf("\n");	distrugeI(i);
}
//tiparire iterand pe pozitiivoid tiparire2(VectorDinamic* v) {	printf("\n");	int i = 0;	for (i = 1; i <= dim(v); i++) {		printf("%d ", element(v, i));	}	printf("\n");}

int main(void) {	VectorDinamic *v = creare();	tiparire(v);	tiparire2(v);	distruge(v);	return 0;}
