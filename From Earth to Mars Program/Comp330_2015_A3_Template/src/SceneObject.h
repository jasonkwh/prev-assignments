/*
 * Basic SceneObject.h
 *
 * This is the scene object superclass, providing
 * the basics that you need to display objects on screen.
 *
 * by Matt Cabanag
 */

#include "Shapes.h"
#include "UtilityStructs.h"
#include <iostream>
#include <GL/glut.h>
#include <vector>//This is essentially a C++ ArrayList. It isn't a Vector in
				//a strictly mathematical sense, but can be used as one.
				//In our case, we're using it as an ArrayList.
using namespace std;


#ifndef SCENEOBJECT_H_
#define SCENEOBJECT_H_

class SceneObject
{
	public:
		//default constructor
		SceneObject();

		SceneObject(Vector3 pos, Vector3 speed, Vector3 scale,
				Vector3 ypr, Vector3 yprSpeed, Vector3 rgb);

		//the function to update the object's attributes.
		virtual void Update();

		//display the damn thing
		virtual void Display();

		//display stuff to console
		virtual void DisplayToConsole();

		virtual void AddChild(SceneObject*);
		virtual void RemoveChild();

		vector <SceneObject*> storeChild;
		Vector3 position;
		Vector3 offset;
		Vector3 speed;
		Vector3 scale;
		Vector3 rpy;//yaw pitch and roll
		Vector3 rpySpeed;//yaw pitch roll speed
		Colour4 colour;//red green blue.
		float pitch;
		float objPitch;
		float yaw;
		float objYaw;
		float radius;
		float oX;
		float oY;
		float oZ;
		float rotation;
		bool lighting;
		bool displayActive;
		bool active;
		int textureID;

	protected:

		//TODO: This code can handle one child. How do you handle multiple children?
		SceneObject * child;
		virtual void DrawModel();
		virtual void DrawChildren();
		virtual void UpdateChildren();

};


#endif /* SCENEOBJECT_H_ */
