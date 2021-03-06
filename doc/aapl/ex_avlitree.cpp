#include "avlitree.h"
#include <iostream>

struct CustomEl :
		public AvliTreeEl<CustomEl>,
		public CmpOrd<int>
{
	/* Needed for the insert(const &Key key) routine. */
	CustomEl(int key) : key(key), data(0) { }

	/* For our purposes. */
	CustomEl(int key, const char *data) : key(key), data(data) { }

	const int getKey() { return key; }
	int key;
	const char *data;
};

int main()
{
	AvliTree<CustomEl, int> tree;

	/* This will make a new element for us. */
	tree.insert( 1 );

	/* Here we make the element ourselves. */
	tree.insert( new CustomEl( 2, "CustomEl") );

	for ( CustomEl *el = tree.head; el != 0; el = el->next )
		std::cout << el->key << std::endl;

	tree.empty();
	return 0;
}
