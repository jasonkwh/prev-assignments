/*
 * Icon.h
 *
 *  Created on: 20/02/2009
 *      Author: damxam
 *
 *  The Icon class is used as a base class for Icons. The button
 *  class accepts Icon objects, so using polymorphism different
 *  buttons can be created by passing different subclassed objects
 *  of inherited class icon.
 *
 *  All it inherits to its children is the render function, which
 *  is used to render (draw) child objects.
 */

#ifndef ASSIGNMENT1SKELETON_SHAREDELEMENTS_ICON_H_
#define ASSIGNMENT1SKELETON_SHAREDELEMENTS_ICON_H_

class Icon
{
public:
	virtual void render() = 0;
};

#endif /* ASSIGNMENT1SKELETON_SHAREDELEMENTS_ICON_H_ */
