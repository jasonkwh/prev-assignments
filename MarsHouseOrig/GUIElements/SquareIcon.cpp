/*
 * SquareIcon.cpp
 *
 *  Created on: 20/02/2009
 *      Author: damxam
 *
 *	The icon class creates an icon. The drawing code goes into
 *  the render function. In this case, a rectangle is drawn.
 *
 */
#include "SquareIcon.h"

SquareIcon::SquareIcon(int _xl, int _yl, int _xh, int _yh)
{
	xl = _xl;
	yl = _yl;

	xh = _xh;
	yh = _yh;

}

/* Render (draw) this icon, a square in this case*/
void SquareIcon::render()
{
	glColor3f(1.0,1.0,0.3);
	glRecti(xl,yl,xh,yh);
	glColor3f(0,0,0);

	glBegin(GL_LINE_LOOP);
	glVertex2i(xl,yl);
	glVertex2i(xl,yh);
	glVertex2i(xh,yh);
	glVertex2i(xh,yl);
	glEnd();
}
