#include "Container.h"
#include "IteratorContainer.h"
#include <iostream>

// aici implementarea operatiilor din Container.h


Container::Container() {
	// TBA 
}

IteratorContainer Container::iterator() const {
	return IteratorContainer(*this);
}


Container::~Container() {
	// TBA
}


// restul operatiilor