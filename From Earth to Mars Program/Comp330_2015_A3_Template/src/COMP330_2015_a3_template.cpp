/*
COMP330 - 2015

Assignment 3 Template.

Matt Cabanag
Tim Lambert
Scott McCallum
Nathan Tarr
+ others...

Note from Scott M: Matt deserves most of the credit for putting together this code template.
It is provided to you so you can "hit the ground running".
It is not meant to restrict your efforts in any way - that is, you can feel free to modify
anything you wish, or even start completely from scratch.
*/

#include <iostream>
#include <stdlib.h>
#include <string>
#include <stdio.h>
#include <fstream>
#include <time.h>
#include <math.h>
#include <vector>
#include <GL/glut.h>
#include <GL/glu.h>
#include "Soil.h"
#include "UtilityStructs.h"
#include "Shapes.h"
#include "SceneObject.h"
#include "QuadCube.h"
#include "QuadSphere.h"


using namespace std;

#define X_RES 1024
#define Y_RES 768
#define MVP_X_RES 1024
#define MVP_Y_RES 600

//scene hierarchy root used for drawing
vector <SceneObject*> SceneRoot;

//intermediate scene data
vector <RawSceneData> MyRawData;

//variables for spaceship moving and mars arrivals
float angleMars;
float angleEarth;
bool flyKey = false;
bool fly = false;
float zB;
bool shipFly = false;

//movement speed variable for general use.
GLfloat moveSpeed = 0.25;

//variables for the main camera's location
GLfloat mainCamX = 15;
GLfloat mainCamY = 7;
GLfloat mainCamZ = 35;

//coordinates for what the camera is looking at
GLfloat mainCamLookX = 0;
GLfloat mainCamLookY = 0;
GLfloat mainCamLookZ = 0;

//variables for the main camera's "up" vector
GLfloat mainCamUpX = 0;
GLfloat mainCamUpY = 1.0;
GLfloat mainCamUpZ = 0;

//Backup GLfloat for changing different views
bool checkTopdown = false;
GLfloat mainCamXBUP;
GLfloat mainCamYBUP;
GLfloat mainCamZBUP;
GLfloat mainCamLookXBUP;
GLfloat mainCamLookYBUP;
GLfloat mainCamLookZBUP;
GLfloat mainCamUpXBUP;
GLfloat mainCamUpYBUP;
GLfloat mainCamUpZBUP;

//variables for the spaceship and light source
QuadCube* mySpaceShip = new QuadCube;
QuadSphere* mySpaceShip2 = new QuadSphere;
QuadSphere* mySpaceShip3 = new QuadSphere;

//Planets
QuadSphere * earth = new QuadSphere;
QuadSphere * mars = new QuadSphere;

Vector3 lightPos;
Vector3 lightDir;

Colour4 lightAmbient;
Colour4 lightDiffuse;
Colour4 lightSpecular;

//variables for follow view
double showx = 0;
double showz = 0;
double showEyex = 0;
double showEyez = 0;
double showEyeMx = 0;
double showEyeMz = 0;
double showMx = 0;
double showMz = 0;
float x; //variable to calculate spaceship position x
float z; //variable to calculate spaceship position z
float anglenew;

//variables for texturing;
#define MAX_NO_TEXTURES 1
GLuint texture[MAX_NO_TEXTURES];

//Taken from Tim Lambert's "textures" example project, 2013.
int loadGLTexture(const char *fileName)                                    // Load Bitmaps And Convert To Textures
{
	string name = "textures/";
	name += fileName;
	/* load an image file from texture directory as a new OpenGL texture */
	texture[0] = SOIL_load_OGL_texture
			(
					name.c_str(),
					SOIL_LOAD_AUTO,
					SOIL_CREATE_NEW_ID,
					SOIL_FLAG_INVERT_Y
			);

	if(texture[0] == 0) {
		std::cerr << fileName << " : " << SOIL_last_result();
		return false;
	}

	// Typical Texture Generation Using Data From The Bitmap
	glBindTexture(GL_TEXTURE_2D, texture[0]);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT);
	return true;// Return Success
}

// Axes drawing function
// credit: Scott McCallum 2012.
// modified by Matt Cabanag 2014
void axes(void)
{

	glDisable(GL_LIGHTING);
	glDisable(GL_LIGHT0);
	//glBegin(GL_LINES);
	//	  glVertex3f(0.0, 0.0, 0.0);
	//	  glVertex3f(50.0, 0.0, 0.0); /* draw x-axis */
	//	  glVertex3f(0.0, 0.0, 0.0);
	//	  glVertex3f(0.0, 50.0, 0.0); /* draw y-axis */
	//	  glVertex3f(0.0, 0.0, 0.0);
	//	  glVertex3f(0.0, 0.0, 50.0); /* draw z-axis */
	//glEnd();

	//Draw Earth orbit
	int n = 5000;
	glBegin(GL_LINES);
	for(int i=0; i<n; ++i) {
		glVertex3f(17 * cos(2 * M_PI * i / n),0,
				17 * sin(2 * M_PI * i / n));
	}
	glEnd();

	//Draw Mars orbit
	glBegin(GL_LINES);
	for(int i=0; i<n; ++i) {
		glVertex3f(26 * cos(2 * M_PI * i / n),0,
				26 * sin(2 * M_PI * i / n));
	}
	glEnd();
}


//sets up the main view
void setupMainView()
{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(90, (float)MVP_X_RES/(float)MVP_Y_RES, 0.1, 200);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(mainCamX, mainCamY, mainCamZ,
			  mainCamLookX, mainCamLookY, mainCamLookZ,
			  mainCamUpX, mainCamUpY, mainCamUpZ);

	//setup the depth buffer
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glEnable( GL_DEPTH_TEST );

	//have a light source at the origin!
	float lp [] = {0.0,1,0.0, 0.0};
	glLightfv(GL_LIGHT0, GL_POSITION, lp);

	glEnable(GL_LIGHTING);// Enable lighting calculations
	glEnable(GL_LIGHT0);// Turn on light #0.
}

//sets up the top down view
void setupTopDownView()
{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	//TODO: use the correct aspect ratio for this viewport.
	gluPerspective(90, (float)MVP_X_RES/(float)MVP_Y_RES, 0.1, 200);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0, 35, 0,
			  0, 0, 0,
			  0, 0, 1);

	//if spaceship is not moving yet
	if(fly==false) {
		//calculate spaceship position x and z for the following cameras
		float twoPI =  M_PI*2;
		x = -cos(anglenew*twoPI) * 4;
		z =	sin (anglenew*twoPI) * 4;
		mySpaceShip->position =Vector3 (x ,0, z);
		//mySpaceShip2->position =Vector3(x,0,z);
		anglenew += 0.005;
	}

	//if spaceship moves
	if(fly==true) {
		if(zB <= 9) {
			mySpaceShip->position = Vector3(0+1,0,0+zB); //spaceship moving
			zB += 0.2; //spaceship moving by increasing 0.2 of the position z
		}
		//cout<<zB<<endl;
		if (zB>7) {
			//zB = z;
			if(shipFly == false) {
				earth -> RemoveChild(); //leave earth
				//mySpaceShip -> position = Vector3(x,0,zB);
				mySpaceShip -> position =  Vector3(1,7,-8); //in mars orbit
				mars -> AddChild(mySpaceShip); //join mars
				shipFly = true;
			}
			fly = false;

		}
		//fly = false;
	}

	//setup the depth buffer
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glEnable( GL_DEPTH_TEST );

	//have a light source at the origin!
	float lp [] = {0.0,1,0.0, 0.0};
	glLightfv(GL_LIGHT0, GL_POSITION, lp);

	glEnable(GL_LIGHTING);// Enable lighting calculations
	glEnable(GL_LIGHT0);// Turn on light #0.
}

//sets up the spaceship follow view
void setupFrontView()
{
	showx = earth -> position.x;
	showz = earth -> position.z;
	showEyex = earth -> position.x + (mySpaceShip -> position.x);
	showEyez = earth -> position.z + (mySpaceShip -> position.z);
	showEyeMx = mars -> position.x + (mySpaceShip -> position.x);
	showEyeMz = mars -> position.z + (mySpaceShip -> position.z);

	showMx = mars -> position.x;
	showMz = mars -> position.z;


	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	//TODO: use the correct aspect ratio for this viewport.
	gluPerspective(15, (float)MVP_X_RES/(float)MVP_Y_RES, 0.1, 200);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	//if the spaceship in earth orbit
	if(shipFly == false) {
		gluLookAt(showx, 5, showz,
				  showEyex, 4, showEyez,
				  0, 1, 0);
	}

	//if the spaceship in mars orbit
	else if(shipFly == true) {
		gluLookAt(showMx, 5, showMz,
				  showEyeMx, 4, showEyeMz,
				  0, 1, 0);
	}

	//setup the depth buffer
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glEnable( GL_DEPTH_TEST );

	//have a light source at the origin!
	float lp [] = {0.0,1,0.0, 0.0};
	glLightfv(GL_LIGHT0, GL_POSITION, lp);

	glEnable(GL_LIGHTING);// Enable lighting calculations
	glEnable(GL_LIGHT0);// Turn on light #0.
}

void setupSideView()
{
	showx = earth -> position.x;
	showz = earth -> position.z;
	showEyex = earth -> position.x + (mySpaceShip -> position.x);
	showEyez = earth -> position.z + (mySpaceShip -> position.z);
	showEyeMx = mars -> position.x + (mySpaceShip -> position.x);
	showEyeMz = mars -> position.z + (mySpaceShip -> position.z);

	showMx = mars -> position.x;
	showMz = mars -> position.z;


	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	//TODO: use the correct aspect ratio for this viewport.
	gluPerspective(15, (float)MVP_X_RES/(float)MVP_Y_RES, 0.1, 200);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	//if the spaceship in earth orbit
	if(shipFly == false) {
		gluLookAt(x, 15, z,
				  showEyex, 2, showEyez,
				  0, 1, 0); //x and z is the position of spaceship
	}
	else if(shipFly == true) {
		gluLookAt(showMx, 15, showMz,
				  showEyeMx, 2, showEyeMz,
				  0, 1, 0);
	}

	//setup the depth buffer
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glEnable( GL_DEPTH_TEST );

	//have a light source at the origin!
	float lp [] = {0.0,1,0.0, 0.0};
	glLightfv(GL_LIGHT0, GL_POSITION, lp);

	glEnable(GL_LIGHTING);// Enable lighting calculations
	glEnable(GL_LIGHT0);// Turn on light #0.
}

//THE SCENE DRAWER!
void drawScene()
{

	for(unsigned int i = 0; i < SceneRoot.size(); i++)
	{
		SceneRoot.at(i) -> Display();
	}

}

void checkAngle() {
	//for calculating the gap between the earth and the mars
	float aE = (360 * 1.0) / 475;
	float aM = (360 * 0.4) / 575;
	if (angleEarth < 360) {
		angleEarth+=aE;
	}
	else if (angleEarth >= 360) {
		angleEarth = 0;
	}
	if (angleMars < 360) {
		angleMars+=aM;
	}
	else if (angleMars >= 360) {
		angleMars = 0;
	}
	float absAngle = abs(angleMars - angleEarth);

	//when the absolute value of the gap angle is less than 6
	if(absAngle < 6) {
		if(flyKey==true) {
			fly = true;
		}
	}
}

//THE ANIMATOR!!
//called by the glut idle function.
void animateScene()
{
	for(unsigned int i = 0; i < SceneRoot.size(); i++)
	{
		SceneRoot.at(i) -> Update();
	}

	checkAngle();
}

void animateSceneTimer(int milis)
{
	animateScene();
	glutTimerFunc(milis, animateSceneTimer, milis);
}

//the actual display callback function
void display(void)
{	//clear the screen!
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

	//first update the "logical model"; animate the world in other words
	//animateScene();

	//draw the main viewport
	setupMainView();
	glViewport(0, Y_RES-MVP_Y_RES, MVP_X_RES, MVP_Y_RES);
	//draw the axis:
	glColor3f(1,1,1);
	axes();
	drawScene();

	//draw the top down viewport
	setupTopDownView();
	glViewport(-100, 0, X_RES/2, Y_RES-MVP_Y_RES);
	drawScene();

	//draw the spaceship side viewport
	setupSideView();
	glViewport(300, 0, X_RES/2, Y_RES-MVP_Y_RES);
	drawScene();

	//draw the spaceship front viewport
	setupFrontView();
	glViewport(700, 0, X_RES/2, Y_RES-MVP_Y_RES);
	drawScene();

	//draw the axis:
	glColor3f(1,1,1);
	axes();

	//OpenGL house cleaning
	glFlush();//put everything on the pipeline
	glutPostRedisplay();//post the ready scenes.
	glutSwapBuffers();//swap the buffers

}

//keyboard handler
void keyboard( unsigned char key, int x, int y )
{
	switch ( key )
	{	//move the view around with WASD
		case 'w':
		{
			mainCamZ -= moveSpeed;
		}break;

		case 's':
		{
			mainCamZ += moveSpeed;
		}break;

		case 'a':
		{
			mainCamX -= moveSpeed;
		}break;

		case 'd':
		{
			mainCamX += moveSpeed;
		}break;

		case 'c':
		{
			mainCamY -= moveSpeed;
		}break;

		case 'e':
		{
			mainCamY += moveSpeed;
		}break;

		//reset everything!
		case 'r':
		{
			mainCamX = 5;
			mainCamY = 5;
			mainCamZ = 10;
		}break;

		case '.':
		{
			lightPos.y += moveSpeed;
		}break;

		case ',':
		{
			lightPos.y -= moveSpeed;
		}break;

		case 'f':
		{
			flyKey = true;
		}break;

		case 'z':
		{
			//change the main viewport to topdown viewport
			if(checkTopdown==false) {
				mainCamXBUP = mainCamX;
				mainCamYBUP = mainCamY;
				mainCamZBUP = mainCamZ;
				mainCamLookXBUP = mainCamLookX;
				mainCamLookYBUP = mainCamLookY;
				mainCamLookZBUP = mainCamLookZ;
				mainCamUpXBUP = mainCamUpX;
				mainCamUpYBUP = mainCamUpY;
				mainCamUpZBUP = mainCamUpZ;
				mainCamX = 0;
				mainCamY = 35;
				mainCamZ = 0;
				mainCamLookX = 0;
				mainCamLookY = 0;
				mainCamLookZ = 0;
				mainCamUpX = 0;
				mainCamUpY = 0;
				mainCamUpZ = 1;
				checkTopdown = true;
			}
		}break;

		case 'x':
		{
			//change the topdown viewport back to the main viewport
			if(checkTopdown==true) {
				mainCamX = mainCamXBUP;
				mainCamY = mainCamYBUP;
				mainCamZ = mainCamZBUP;
				mainCamLookX = mainCamLookXBUP;
				mainCamLookY = mainCamLookYBUP;
				mainCamLookZ = mainCamLookZBUP;
				mainCamUpX = mainCamUpXBUP;
				mainCamUpY = mainCamUpYBUP;
				mainCamUpZ = mainCamUpZBUP;
				checkTopdown = false;
			}
		}break;

		//this is the escape key
		case 27:
		{	exit(1);
		}break;
	}

	mySpaceShip -> position = lightPos;

	display();
}


void SpecialInput(int key, int x, int y)
{
	switch(key)
	{
		case GLUT_KEY_UP:
		{
			lightPos.z -= moveSpeed;
		}break;

		case GLUT_KEY_DOWN:
		{
			lightPos.z += moveSpeed;
		}break;

		case GLUT_KEY_LEFT:
		{
			lightPos.x -= moveSpeed;
		}break;

		case GLUT_KEY_RIGHT:
		{
			lightPos.x += moveSpeed;
		}break;

		case GLUT_KEY_F1:
		{

		}break;
	}

	mySpaceShip -> position = lightPos;

	display();
}

void LoadDefaultScene()
{
	//if these are the first textures loaded into the program
	loadGLTexture("sun_surface.jpg");//textureID 1
	loadGLTexture("Earth.jpg");//textureID 2
	loadGLTexture("brownleather.jpg");//textureID 3


	//Sun
	QuadSphere * sun = new QuadSphere;
	sun = (new QuadSphere);
	sun -> colour = Colour4(1,1,1,1);
	sun -> textureID = 1;
	sun-> rpySpeed = Vector3(0,0,0.15f);

	//Earth
	earth -> colour = Colour4(1,1,1,1);
	earth -> position = Vector3(0,0,17);
	//notice having to flip the sphere sideways to
	earth -> rpy = Vector3(-90,0,0);
	earth -> rpySpeed = Vector3(0,0,4);
	earth -> textureID = 2;
	earth -> radius = earth -> position.z;
	earth -> rotation = 0.75;

	//Mars
	mars -> colour = Colour4(1,1,1,1);
	mars -> position = Vector3(0,0,26);
	//notice having to flip the sphere sideways to
	mars -> rpy = Vector3(-90,0,0);
	mars -> rpySpeed = Vector3(0,0,2);
	mars -> textureID = 3;
	mars -> radius = mars -> position.z;
	mars -> rotation = 0.25;
	mars -> scale = Vector3(0.8,0.8,0.8);
	//add the earth to the sun.
	//sun -> AddChild(earth);

	//TODO: How will you handle Mars or any additional moons?

	//Add planets into the SceneRoot vector
	SceneRoot.push_back(sun);
	SceneRoot.push_back(earth);
	SceneRoot.push_back(mars);


	//Your Spaceship.
	//the Spaceship design = mySpaceShip + mySpaceShip2 + mySpaceShip3
	mySpaceShip -> colour = Colour4(1,1,0,1);
	mySpaceShip -> scale = Vector3(0.3,0.3,0.3);
	mySpaceShip -> position =  Vector3(3,3,0);
	mySpaceShip -> rpySpeed = Vector3(0,0,3.6);
	mySpaceShip2 -> colour = Colour4(1,1,0,1);
	mySpaceShip2 -> scale = Vector3(0.25,0.25,0.25);
	mySpaceShip2 -> position =  Vector3(1,0,0);
	mySpaceShip3 -> colour = Colour4(1,1,0,1);
	mySpaceShip3 -> scale = Vector3(0.25,0.25,0.25);
	mySpaceShip3 -> position =  Vector3(-1,0,0);
	earth -> AddChild(mySpaceShip); //into the earth orbit
	mySpaceShip -> AddChild(mySpaceShip2); //joint the original cube
	mySpaceShip -> AddChild(mySpaceShip3); //joint the original cube


	//SceneRoot.push_back(mySpaceShip);
}

int main(int argc, char** argv)
{

	glutInit(&argc, argv);


	glEnable(GL_NORMALIZE);
	glClearColor(1.0, 1.0, 1.0, 0.0);
	//setup double buffering
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);

	//set up the window
	glutInitWindowSize(X_RES, Y_RES);
	glutInitWindowPosition(0, 0);
	glutCreateWindow ("Voyage to Mars");

	//assign the callback functions
	glutDisplayFunc(display);
	glutSpecialFunc(SpecialInput);
	glutKeyboardFunc(keyboard);


	LoadDefaultScene();//load the scene
	animateSceneTimer(20);//set the animation timer

	//GOOOOWWW!!
	glutMainLoop();
	return 0;
}
