/*
 * Icon.h
 *
 *  Created on: 20/02/2009
 *      Author: damxam
 *
 *	The icon class creates an icon. The drawing code goes into
 *  the render function. In this case, a rectangle is drawn.
 *
 */

#ifndef SQUARE_ICON_H_
#define SQUARE_ICON_H_ 1

#include <ctype.h>
#include <GL/glut.h>
#include "Icon.h"

class SquareIcon : public Icon
{
public:
	SquareIcon(int _xl, int _yl, int _xh, int _yh);

	/* Render (draw) this icon, a square in this case*/
	void render();

private:
	int xl,yl,xh,yh;
};

#endif /* ICON_H_ */
