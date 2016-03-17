/*
 * DiagramObject.h
 *
 *  Created on: 04/03/2010
 *      Author: Maximilian Wittmann
 */

#ifndef ASSIGNMENT1SKELETON_DIAGRAMELEMENTS_DIAGRAMOBJECT_H_
#define ASSIGNMENT1SKELETON_DIAGRAMELEMENTS_DIAGRAMOBJECT_H_

#include <iostream>
#include <fstream>
#include <sstream>
#include <GL/glut.h>
#include "../SharedElements/Point.h"
#include <vector>

using namespace std;

/*
 * class DiagramObject
 *
 * The class which handles storage of data and rendering (drawing)
 * of objects in your world.
 *
 */
class DiagramObject {
public:
	DiagramObject();
	virtual ~DiagramObject();

	DiagramObject(string _name, Point _lower, Point _upper);

	/*(Re)sets the element's position*/
	void setPosition(Point _lower, Point _upper);

	/*(Re)sets the element's name*/
	void setName(string n);

    void setObject(bool sleep, bool show, bool tab, bool toilet, bool low, bool high, bool win);

	/*Render (draw) the element*/
	void render();

    void getPoint(vector<string> saveName, vector<Point> saveVect1, vector<Point> saveVect2);

	void save(ofstream &outf);

	void load(ifstream &inf, string object);

	/* Did we hit element?
	 * Currently unimplemented */
	bool hit(Point p);

	/*Get name*/
	string getName();

	/*Calculate and return width*/
	int getWidth();

	/*Calculate and return height*/
	int getHeight();

	private:
		Point lower, upper;
		string name;
};

#endif /* ASSIGNMENT1SKELETON_DIAGRAMELEMENTS_DIAGRAMOBJECT_H_ */
