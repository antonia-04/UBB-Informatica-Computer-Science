#include "VectorDinamic.h"#include <malloc.h>
VectorDinamic* creeaza(int cp) {	VectorDinamic* v = (VectorDinamic*) malloc(sizeof(VectorDinamic));	//seteaza capacitatea	v->cp = cp;
	//aloca spatiu pentru vector	v->e = (TElem *) malloc(cp * sizeof(TElem));
	//seteaza numarul de elemente	v->n = 0;
	return v;}

void distruge(VectorDinamic* v) {	//elibereaza spatiul de memorare pentru vector	free(v->e);	free(v);}

void redim(VectorDinamic* v) {	//realocam un spatiu de capacitate dubla	TElem* eNou = (TElem*) malloc(2 * v->cp * sizeof(TElem));
	//copiem vechile valori in noua zona	int i;
	for (i = 0; i < v->n; i++)		eNou[i] = v->e[i];
	//dublam capacitatea	v->cp = 2 * v->cp;
	//eliberam vechea zona	free(v->e);
	//vectorul indica spre noua zona	v->e = eNou;}

int dim(VectorDinamic* v) {	return v->n;}

TElem element(VectorDinamic* v, int i) {	return v->e[i - 1];}

void adaugaSfarsit(VectorDinamic* v, TElem e) {	//daca s-a atins capacitatea maxima, redimensionam	if (v->n == v->cp)		redim(v);
	v->e[(v->n)++] = e;}
Iterator* iteratorV(VectorDinamic* v) {	//returneza iteratorul pe vector	return creeazaIterator(v);}
Iterator* creeazaIterator(VectorDinamic* v) {	//aloca spatiu de memorare pentru iterator	Iterator* i = (Iterator*) malloc(sizeof(Iterator));	//setam componentele iteratorului	i->v = v;	i->curent = 0;
	//varianta 2	//i->curent=v->e; //- pointer spre primul element din vector	return i;}
void prim(Iterator* i) {	//setam iteratorul pe prima pozitie in vector	i->curent = 0;
	//varianta 2	//i->curent=i->v->e; //- pointer spre primul element din vector}
int valid(Iterator* i) {	int n = dim(i->v);	//verificam daca iteratorul indica spre o pozitie in vector	return i->curent < n;	//varianta 2	// return (i->curent)-(i->v->e)<n;
}
TElem elementI(Iterator* i) {	//elementul curent din vector	return i->v->e[i->curent];
	//varianta 2	// return *(i->curent);}
void urmator(Iterator* i) {	//la fel si pentru varianta 2	i->curent++;}
void distrugeI(Iterator* i) {	free(i);}
