//tip de data generic (pentru moment este intreg)typedef int TElem;
typedef struct {	//capacitate	int cp;	//dimensiune	int n;	//elemente	TElem* e;} VectorDinamic;

//iteratortypedef struct {
	//iteratorul contine pointer catre container	VectorDinamic* v;	//pozitia curenta in iterator	int curent;
	//varianta 2	//TElem *curent; //pointer spre un element
} Iterator;

//constructorVectorDinamic* creeaza(int cp);
//destructorvoid distruge(VectorDinamic* v);
//dimensiunea vectorului (numar de elemente)int dim(VectorDinamic* v);
//elementul al i-lea (1 <= i <= numar de elemente)TElem element(VectorDinamic* v, int);
//adaugare la sfarsitvoid adaugaSfarsit(VectorDinamic* v, TElem e);
//alte operatii specifice//...
//returneaza un iterator pe vectorIterator* iteratorV(VectorDinamic* v);
//operatii pe iterator
//constructorIterator* creeazaIterator(VectorDinamic* v);
void prim(Iterator* v);
void urmator(Iterator* i);
TElem elementI(Iterator* i);
int valid(Iterator* i);
void distrugeI(Iterator* i);