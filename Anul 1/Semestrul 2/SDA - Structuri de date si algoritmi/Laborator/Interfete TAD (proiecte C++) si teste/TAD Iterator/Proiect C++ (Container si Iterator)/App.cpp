#include <iostream>
#include "Container.h"
#include "IteratorContainer.h"

using namespace std;


int main() {


	Container c;
	// iterare
	IteratorContainer ic = c.iterator();
	while (ic.valid()) {
		TElem e = ic.element();
		// prelucrare element
		ic.urmator();
	}

	cout<<"End";


}
