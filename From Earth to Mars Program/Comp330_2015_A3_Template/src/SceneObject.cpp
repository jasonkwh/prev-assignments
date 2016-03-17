/*
 * BasicSceneObject.cpp
 *
 * This is the scene object superclass, providing
 * the basics that you need to display objects on screen.
 *
 * by Matt Cabanag
 *
 */

#include "SceneObject.h"
#include <iostream>
#include <math.h>

SceneObject::SceneObject()
{
	active = true;
	displayActive = true;
	lighting = true;
	child = NULL;

	position = Vector3();
	offset = Vector3();
	speed = Vector3();
	scale = Vector3(1,1,1);
	rpy = Vector3();//yaw pitch and roll
	rpySpeed = Vector3();//yaw pitch roll speed
	pitch = 0;
	yaw = 0;
	objPitch = 0;
	objYaw = 0;
	radius = 0;
	oX = 0;
	oY = 0;
	oZ = 0;
	rotation = 0;

	colour.r = 1;
	colour.g = 1;
	colour.b = 1;
	colour.a = 1;

	textureID = -1;//this means it doesn't have a texture ID.
}

//Updating the logic in the scene object is simply
//adding its delta values to its current values.
//That is, add the speed vector to its position and
//add its roll/pitch/yaw speed values to its current
//yaw/pitch/roll.
void SceneObject::Update()
{
	//fomulas for calculating the planets moving
	pitch = objPitch * M_PI/180;
	yaw = objYaw * M_PI/180;
	oY = (0*cos(pitch))+(radius*-sin(pitch));
	oZ = (0*sin(pitch))+(radius*-cos(pitch));
	oX = (0*cos(yaw))+(oZ*sin(yaw));
	oZ = (0*-sin(yaw))+(oZ*cos(yaw));
	objYaw += rotation;
	if(radius > 0) {
		position = Vector3(oX, oY, oZ);
	}
	//position += speed;
	rpy += rpySpeed;
	//revo += revoSpeed;

	//  cout<<position.x<<","<<position.y<<","<<position.z<<","<<endl;

	UpdateChildren();
}

void SceneObject::DisplayToConsole()
{
	cout<<rpy.x<<","<<rpy.y<<","<<rpy.z<<","<<endl;
}

void SceneObject::Display()
{
	//deal with the lighting
	if(!lighting)
	{	glColor3f(colour.r,colour.g,colour.b);
	}
	else
	{	GLfloat col[4] = { colour.r,colour.g,colour.b, colour.a};
		GLfloat specular[4] = { 1, 1, 1, 1};
		GLfloat shininess = 50;

		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, col);
		glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, specular );
		glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, shininess);
	}

	//deal with the texturing
	if(textureID >= 0)
	{
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D,textureID);
	}
	else
	{
		glDisable(GL_TEXTURE_2D);
	}

	glPushMatrix();
		glTranslatef(position.x ,position.y ,position.z );
		glPushMatrix();
			glRotatef(rpy.z,0,1,0);//yaw
			glRotatef(rpy.y,0,0,1);//pitch
			glRotatef(rpy.x,1,0,0);//roll
			glScalef(scale.x,scale.y,scale.z);
			DrawModel();
		glPopMatrix();
		glScalef(scale.x,scale.y,scale.z);

		DrawChildren();
	glPopMatrix();

}

void SceneObject::DrawModel()
{
	glutSolidCube(3);
	glutSolidSphere(2,20,20);
	//DrawChildren();
}

//TODO: This code can handle one child. How do you handle multiple children?
void SceneObject::DrawChildren()
{
	//but  display your children.
	if(storeChild.size()>0)
	{
		for(unsigned int i = 0; i < storeChild.size(); i++)
		{
			glTranslatef(storeChild[i] -> offset.x,storeChild[i] -> offset.y,storeChild[i] -> offset.z);
			glPushMatrix();
				storeChild[i] -> Display();
			glPopMatrix();
		}
	}
}

//TODO: This code can handle one child. How do you handle multiple children?
void SceneObject::UpdateChildren()
{
	if(storeChild.size()>0) {
		for(unsigned int i = 0; i < storeChild.size(); i++)
		{
			storeChild[i] -> Update();
		}
	}
}

void SceneObject::AddChild(SceneObject* newChild)
{
	//push new child into the vector
	storeChild.push_back(newChild);
}

void SceneObject::RemoveChild() {
	//remove the vector storing object at position 0
	storeChild.erase(storeChild.begin()+0);
}




