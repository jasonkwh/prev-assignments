/*
 * Point.h
 *
 *  Created on: 20/02/2009
 *      Author: damxam
 */

#ifndef ASSIGNMENT1SKELETON_SHAREDELEMENTS_POINT_H_
#define ASSIGNMENT1SKELETON_SHAREDELEMENTS_POINT_H_

/*
 * class Point
 *
 * A simple struct which stores data for a 2d point.
 * Retrieve x,y by direct access to struct members.
 */

struct Point
{
	int x,y;

	Point();

	Point(int _x, int _y);
};

#endif /* ASSIGNMENT1SKELETON_SHAREDELEMENTS_POINT_H_ */
