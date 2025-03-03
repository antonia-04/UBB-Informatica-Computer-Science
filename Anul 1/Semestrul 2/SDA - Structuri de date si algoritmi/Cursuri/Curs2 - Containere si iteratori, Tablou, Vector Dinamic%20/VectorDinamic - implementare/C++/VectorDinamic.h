//tip de data generic (pentru moment este intreg)typedef int TElem;
class Iterator;class VectorDinamic {private:	//capacitate	int cp;	//dimensiune	int n;	//elemente	TElem *e;	//pentru redimensionare	void redim();
public:	//pentru ca Iteratorul sa poata accesa reprezentarea vectorului	friend class Iterator;	//constructor	VectorDinamic(int);	//destructor	~VectorDinamic();
	//dimensiunea vectorului (numar de elemente)	int dim() const;
	//elementul al i-lea (1 <= i <= numar de elemente)	TElem element(int) const;
	//adaugare la sfarsit	void adaugaSfarsit(TElem);
	//returneaza un iterator pe vector	Iterator iterator();
	//alte operatii specifice
	//constructor copiere, operator atribuire...
};
class Iterator {
private:
	//iteratorul contine o referinta catre container	const VectorDinamic& v;	//pozitia curenta in iterator	int curent;
	//varianta 2	//TElem *curent; //pointer spre un element din vector
public:
	//constructor	Iterator(const VectorDinamic&);
	//operatii pe iterator	void prim();
	void urmator();
	TElem element() const;
	bool valid() const;
};

