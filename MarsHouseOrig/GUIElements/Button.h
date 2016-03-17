/*
 * Button.h
 *
 *  Created on: 04/03/2010
 *      Author: Maximilian Wittmann
 */

#ifndef Button_H_
#define Button_H_

#include "../SharedElements/Point.h"
#include "Icon.h"

#include <ctype.h>
#include <GL/glut.h>
#include <iostream>

class Button {
private:
	Point lower, upper;
	Icon * icon;

public:
	Button(Point l, Point u, Icon * i);

	virtual ~Button();

	/* Render the button's border and its icon*/
	void render();

	/* Check whether a point lies inside the button's rectangle.
	 * Not implemented yet.
	 */
	bool hit(Point p);

	/* Calculates and returns width */
	int getWidth();

	/* Calculates and returns height */
	int getHeight();
};

#endif /* Button_H_ */
