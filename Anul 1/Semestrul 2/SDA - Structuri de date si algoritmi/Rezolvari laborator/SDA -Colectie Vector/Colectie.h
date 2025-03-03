//tip de data generic (pentru moment este intreg)
typedef int TElem;
class Iterator;
class Colectie {
private:	//capacitate	int cp;	//dimensiune	int n;	//elemente	TElem *e;
	//pentru redimensionare	void redim();
public:
	//pentru ca Iteratorul sa poata accesa reprezentarea vectorului	friend class Iterator;	//constructor	Colectie(int);	//destructor	~Colectie();
	//dimensiunea colectiei (numar de elemente)	int dim() const;
	//adaugare elmnt in colectie	void adauga(TElem);
	//returneaza un iterator pe colectie	Iterator iterator();
	//alte operatii specifice
	//constructor copiere, operator atribuire...

};

class Iterator {
private:
	//iteratorul contine o referinta catre container	const Colectie& c;
	//pozitia curenta in iterator	int curent;
	//varianta 2	//TElem *curent; //pointer spre un element din colectie
public:
	//constructor	Iterator(const Colectie&);
	//operatii pe iterator	void prim();
	void urmator();
	TElem element() const;
	bool valid() const;
};

