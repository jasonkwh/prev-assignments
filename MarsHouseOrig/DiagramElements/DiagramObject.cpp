/*
 * DiagramObject.cpp
 *
 *  Created on: 04/03/2010
 *      Author: Maximilian Wittmann
 */

#include "DiagramObject.h"
#include <math.h>
#include <vector>

//encounter to_string bug of MiniGW complier
template <typename T>
    std::string to_string(T value)
    {
      //create an output string stream
      std::ostringstream os ;

      //throw the value into the string stream
      os << value ;

      //convert the string stream into a string and return
      return os.str() ;
    }

bool sleep = false;
bool show = false;
bool tab = false;
bool toilet = false;
bool low = false;
bool high = false;
bool win = false;
vector<string> savName;
vector<Point> savVect1;
vector<Point> savVect2;
string cor;

DiagramObject::DiagramObject() {
	// TODO Auto-generated constructor stub

}

DiagramObject::~DiagramObject() {
	// TODO Auto-generated destructor stub
}


DiagramObject::DiagramObject(string _name, Point _lower, Point _upper)
{
	name = _name;
	lower = _lower;
	upper = _upper;
}
/*(Re)sets the element's position*/
void DiagramObject::setPosition(Point _lower, Point _upper)
{


	lower = _lower;
	upper = _upper;

}
/*(Re)sets the element's name*/
void DiagramObject::setName(string n)
{
    name = n;
}

/* Set the object type */
void DiagramObject::setObject(bool _sleep, bool _show, bool _tab, bool _toilet, bool _low, bool _high, bool _win) {
    sleep = _sleep;
    show = _show;
    tab = _tab;
    toilet = _toilet;
    low = _low;
    high = _high;
    win = _win;
}

/*Render (draw) the element*/
void DiagramObject::render()
{

	//Draw the element's background
	glColor3f(1.0,1.0,1.0);
	glBegin(GL_QUADS);
	glVertex2i(lower.x, lower.y);
	glVertex2i(lower.x, upper.y);
	glVertex2i(upper.x, upper.y);
	glVertex2i(upper.x, lower.y);
	glEnd();
	//Draw elements
    if(low == true) {
        glColor3f(1,0,0);
        glPushAttrib (GL_LINE_BIT);
        glLineWidth(10);
        glBegin(GL_LINE_LOOP);
        glVertex2i(lower.x, lower.y);
        glVertex2i(lower.x, upper.y);
        glVertex2i(upper.x, upper.y);
        glVertex2i(upper.x, lower.y);
        glEnd();
        glColor3f(0.0,0.0,0.0);
        glBegin(GL_QUADS);

        //4 if cases for different situations..
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            glVertex2i(upper.x+20, upper.y-5);
            glVertex2i(upper.x+55, upper.y-5);
            glVertex2i(upper.x+55, upper.y+5);
            glVertex2i(upper.x+20, upper.y+5);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            glVertex2i(upper.x+20, lower.y-5);
            glVertex2i(upper.x+55, lower.y-5);
            glVertex2i(upper.x+55, lower.y+5);
            glVertex2i(upper.x+20, lower.y+5);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            glVertex2i(lower.x+20, upper.y-5);
            glVertex2i(lower.x+55, upper.y-5);
            glVertex2i(lower.x+55, upper.y+5);
            glVertex2i(lower.x+20, upper.y+5);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            glVertex2i(lower.x+20, lower.y-5);
            glVertex2i(lower.x+55, lower.y-5);
            glVertex2i(lower.x+55, lower.y+5);
            glVertex2i(lower.x+20, lower.y+5);
        }

        glEnd();
        glPopAttrib();

        /* Low Grade size */
        glColor3f(0,0,0);
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            cor = "Lower Grade " + to_string(lower.x-upper.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(upper.x, upper.y-15);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            cor = "Lower Grade " + to_string(lower.x-upper.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(upper.x, lower.y-15);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            cor = "Lower Grade " + to_string(upper.x-lower.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(lower.x, upper.y-15);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            cor = "Lower Grade " + to_string(upper.x-lower.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(lower.x, lower.y-15);
        }
        for (unsigned int i = 0; i < cor.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, cor[i]);
        }
        low = false; //reset low grade
        cor = ""; // reset string
    }
    if(win == true) {
        glColor3f(0,0,1);
        glBegin(GL_QUADS);
        glVertex2i(upper.x-5, upper.y-30);
        glVertex2i(upper.x-5, upper.y-80);
        glVertex2i(upper.x+5, upper.y-80);
        glVertex2i(upper.x+5, upper.y-30);
        glEnd();
        win = false;
    }
    if ((sleep == true) || (show == true)) {
        glColor3f(0,0,0);
        glBegin(GL_LINE_LOOP);
        glVertex2i(lower.x, lower.y);
        glVertex2i(lower.x, upper.y);
        glVertex2i(upper.x, upper.y);
        glVertex2i(upper.x, lower.y);
        glEnd();
    }
    if(tab == true) {
        glColor3f(0.3f,0.35f,0.5f);
        glBegin(GL_QUADS);
        glVertex2i(lower.x, lower.y);
        glVertex2i(lower.x, upper.y);
        glVertex2i(upper.x, upper.y);
        glVertex2i(upper.x, lower.y);
        glEnd();

        /* Table size */
        glColor3f(0,0,0);
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            cor = "Table " + to_string(lower.x-upper.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(upper.x, upper.y-10);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            cor = "Table " + to_string(lower.x-upper.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(upper.x, lower.y-10);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            cor = "Table " + to_string(upper.x-lower.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(lower.x, upper.y-10);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            cor = "Table " + to_string(upper.x-lower.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(lower.x, lower.y-10);
        }
        for (unsigned int i = 0; i < cor.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, cor[i]);
        }
        tab = false; //reset table
        cor = ""; //reset string
    }
    if(sleep == true) {
        glBegin(GL_LINE_LOOP);

        //4 if cases for different situations..
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            glVertex2i(upper.x+5, upper.y+5);
            glVertex2i(lower.x-5, upper.y+5);
            glVertex2i(lower.x-5, upper.y+30);
            glVertex2i(upper.x+5, upper.y+30);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            glVertex2i(upper.x+5, upper.y-5);
            glVertex2i(lower.x-5, upper.y-5);
            glVertex2i(lower.x-5, upper.y-30);
            glVertex2i(upper.x+5, upper.y-30);
        }
        else if (upper.x > lower.x && (upper.y < lower.y)) {
            glVertex2i(upper.x-5, lower.y-5);
            glVertex2i(upper.x-5, upper.y+5);
            glVertex2i(upper.x-30, upper.y+5);
            glVertex2i(upper.x-30, lower.y-5);
        }
        else if (upper.x > lower.x && (upper.y > lower.y)) {
            glVertex2i(lower.x+5, lower.y+5);
            glVertex2i(lower.x+5, upper.y-5);
            glVertex2i(lower.x+30, upper.y-5);
            glVertex2i(lower.x+30, lower.y+5);
        }

        glEnd();

        /* Bed size */
        glColor3f(0,0,0);
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            cor = "Bed " + to_string(lower.x-upper.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(upper.x, upper.y-10);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            cor = "Bed " + to_string(lower.x-upper.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(upper.x, lower.y-10);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            cor = "Bed " + to_string(upper.x-lower.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(lower.x, upper.y-10);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            cor = "Bed " + to_string(upper.x-lower.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(lower.x, lower.y-10);
        }
        for (unsigned int i = 0; i < cor.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, cor[i]);
        }
        sleep = false; //reset bed
        cor = ""; //reset string
    }
    if(show == true) {
        glBegin(GL_LINES);
        glVertex2i(lower.x, lower.y);
        glVertex2i(upper.x, upper.y);
        glVertex2i(upper.x, lower.y);
        glVertex2i(lower.x, upper.y);
        glEnd();

        /* Shower size */
        glColor3f(0,0,0);
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            cor = "Shower " + to_string(lower.x-upper.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(upper.x, upper.y-10);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            cor = "Shower " + to_string(lower.x-upper.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(upper.x, lower.y-10);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            cor = "Shower " + to_string(upper.x-lower.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(lower.x, upper.y-10);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            cor = "Shower " + to_string(upper.x-lower.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(lower.x, lower.y-10);
        }
        for (unsigned int i = 0; i < cor.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, cor[i]);
        }
        show = false; //reset shower
        cor = ""; //reset string
    }
    if(toilet == true) {
        double radius;
        int sides = 20;  // The amount of segment to create the circle
        glColor3f(0,0,0);
        glBegin(GL_LINE_LOOP);
        glVertex2i(lower.x, lower.y);
        glVertex2i(lower.x, upper.y);
        glVertex2i(upper.x, upper.y);
        glVertex2i(upper.x, lower.y);
        glEnd();
        if(upper.x > lower.x) {
            if(upper.y > lower.y) {
                radius = (upper.y - lower.y) / 2; // The radius of the circle
            }
            else {
                radius = (lower.y - upper.y) / 2; // The radius of the circle
            }
        }
        else {
            radius = (lower.x - upper.x) / 2; // The radius of the circle
        }
        glBegin(GL_LINE_LOOP);
        for (int a = 0; a < 360; a += 360 / sides)
        {
            double heading = a * 3.1415926535897932384626433832795 / 180;
            //4 if cases for different situations..
            if((upper.x > lower.x) && (upper.y > lower.y)) {
                glVertex2d(lower.x+radius+(cos(heading) * radius), lower.y+radius+(sin(heading) * radius));
            }
            else if((upper.x > lower.x) && (upper.y < lower.y)) {
                glVertex2d(lower.x+radius+(cos(heading) * radius), lower.y-radius+(sin(heading) * radius));
            }
            else if((upper.x < lower.x) && (upper.y > lower.y)) {
                glVertex2d(upper.x+radius+(cos(heading) * radius), upper.y-radius+(sin(heading) * radius));
            }
            else if((upper.x < lower.x) && (upper.y < lower.y)) {
                glVertex2d(upper.x+radius+(cos(heading) * radius), upper.y+radius+(sin(heading) * radius));
            }
        }
        glEnd();

        /* Shower size */
        glColor3f(0,0,0);
        if((upper.x < lower.x) && (upper.y < lower.y)) {
            cor = "Toilet " + to_string(lower.x-upper.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(upper.x, upper.y-10);
        }
        else if((upper.x < lower.x) && (upper.y > lower.y)) {
            cor = "Toilet " + to_string(lower.x-upper.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(upper.x, lower.y-10);
        }
        else if((upper.x > lower.x) && (upper.y < lower.y)) {
            cor = "Toilet " + to_string(upper.x-lower.x) + "x" + to_string(lower.y-upper.y);
            glRasterPos2i(lower.x, upper.y-10);
        }
        else if((upper.x > lower.x) && (upper.y > lower.y)) {
            cor = "Toilet " + to_string(upper.x-lower.x) + "x" + to_string(upper.y-lower.y);
            glRasterPos2i(lower.x, lower.y-10);
        }
        for (unsigned int i = 0; i < cor.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, cor[i]);
        }
        toilet = false; //reset toilet object
        cor = ""; //reset string
    }
}
/* Save the element */
# if 1

void DiagramObject::getPoint(vector<string> _savName, vector<Point> _savVect1, vector<Point> _savVect2) {
    //reference vectors from main.cpp for saving
    savName = _savName;
    savVect1 = _savVect1;
    savVect2 = _savVect2;
}

void DiagramObject::save(ofstream &out)
{
	// The first line of saved data says what type of object it is so that it can be parsed correctly.
    if(out.is_open())
    {
        for(vector<string>::size_type i=0; i<savName.size();++i) {
            out << "NAME " << savName[i] << endl;
            out << "LOWER " << savVect1[i].x << " " << savVect1[i].y << endl;
            out << "UPPER " << savVect2[i].x << " " << savVect2[i].y << endl;
        }
        cout << "Data saved to text.dat" << endl;
    }
    else cout << "Unable to save file" << endl;
}
# endif

/* Did we hit element?
 * Currently unimplemented */
bool DiagramObject::hit(Point p)
{
	return false;
}
/*Get name*/
string DiagramObject::getName()
{
	return name;
}
/*Calculate and return width*/
int DiagramObject::getWidth()
{
	return upper.x - lower.x;
}
/*Calculate and return height*/
int DiagramObject::getHeight()
{
	return upper.y - lower.y;
}
