#include <assert.h>
#include "CP.h"
#include "TestExtins.h"
#include <vector>
#include <exception>

using namespace std;

bool rel2(TPrioritate p1, TPrioritate p2) {
	if (p1 <= p2) {
		return true;
	}
	else {
		return false;
	}
}


void testCreeaza() {
	CP c(rel2);
	assert(c.vida() == true);
	try {
		c.element(); //daca e vida ar trebui sa arunce exceptie
		assert(false); //daca nu a aruncat exceptie, vrem sa avem un assert care da fail
	}
	catch (exception&) {
		assert(true);
	}
	try {
		c.sterge(); //daca e vida ar trebui sa arunce exceptie
		assert(false); //daca nu a aruncat exceptie, vrem sa avem un assert care da fail
	}
	catch (exception&) {
		assert(true);
	}
}

void testAdauga() {
	CP c(rel2);
	for (int i = 0; i < 10; i++) {
		c.adauga(i, i);
	}
	assert(c.vida() == false);
	for (int i = -10; i < 20; i++) {
		c.adauga(i, i);
	}
	assert(c.vida() == false);
	for (int i = -100; i < 100; i++) {
		c.adauga(i, i);
	}
	assert(c.vida() == false);

	for (int i = -1000; i <= 1000; i++) {
		c.adauga(i, i);
	}
	assert(c.vida() == false);
	assert(c.element().second != 1000);
	assert(c.element().second == -1000);

	assert(c.sterge().second == -1000);
	assert(c.element().second == -999);
}

void testSterge() {
	CP c(rel2);
	for (int i = 0; i < 10; i++) {
		c.adauga(i, i);
	}
	assert(c.element().second == 0);
	assert(c.vida() == false);
	for (int i = -10; i < 20; i++) {
		c.adauga(i, i);
	}
	assert(c.element().second == -10);
	for (int i = 100; i > 50; i--) {
		c.adauga(i, i);
	}
	assert(c.element().second == -10);

	//le gasim in ordinea prioritatii
	for (int i = -10; i < 0; i++) {
		assert(c.sterge().second == i);
	}
	for (int i = 0; i < 10; i++) {
		assert(c.sterge().second == i);
		assert(c.sterge().second == i);
	}
	for (int i = 10; i < 20; i++) {
		assert(c.sterge().second == i);
	}
	for (int i = 51; i <= 100; i++) {
		assert(c.sterge().second == i);
	}

	
	assert(c.vida() == true);
}

void testQuantity() {//scopul e sa adaugam multe date 
	CP c(rel2);
	for (int i = 1; i <= 10; i++) {
		for (int j = 300; j >= -300; j --) {
			c.adauga(j, j);
		}
	}

	for (int i = -300; i <= 300; i++) {
		for (int j = 1; j <= 10; j++) {
			assert(c.sterge().second == i);
		}
	}
}

void testAllExtins() {
	testCreeaza();
	testAdauga();
	testSterge();
	testQuantity();
}