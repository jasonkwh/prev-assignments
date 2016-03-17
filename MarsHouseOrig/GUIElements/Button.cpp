/*
 * Button2.cpp
 *
 *  Created on: 04/03/2010
 *      Author: Maximilian Wittmann
 */

#include "Button.h"

Button::Button(Point l, Point u, Icon * i)
{
	lower = l;
	upper = u;
	icon = i;
}
Button::~Button() {
	// TODO Auto-generated destructor stub
}

/* Render the Button's border and its icon*/
void Button::render()
{
	glColor3f(1.0,1.0,1.0);
	glRecti(lower.x, lower.y, upper.x, upper.y);
	glColor3f(0,0,0);

	glBegin(GL_LINE_LOOP);
	glVertex2i(lower.x, lower.y);
	glVertex2i(lower.x, upper.y);
	glVertex2i(upper.x, upper.y);
	glVertex2i(upper.x, lower.y);
	glEnd();

	icon->render();
}

/* Check whether a point lies inside the Button's rectangle.
 * Not implemented yet.
 */
bool Button::hit(Point p)
{
	return false;
}

/* Calculates and returns width */
int Button::getWidth()
{
	return upper.x - lower.x;
}

/* Calculates and returns height */
int Button::getHeight()
{
	return upper.y - lower.y;
}
