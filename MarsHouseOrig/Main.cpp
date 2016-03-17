/*
 * Main.cpp
 *
 * The entry point for the Assignment 1 skeleton
 *
 * Created: 	Scott McCallum 11/3/06
 * Modified:	Maximilian Wittmann 28/02/09
 * Modified:    Len Hamey  06/03/2015
 * Modified:    Hanxiang Huang 07/04/2015
 *
 * You don't have to extend the provided class structure, but it's probably a good idea
 * to do object-oriented code.
 *
 * Good luck everyone!
 *
 */

#include <ctype.h>
#include <GL/glut.h>
#include <iostream>
#include "GUIElements/Button.h"
#include "GUIElements/SquareIcon.h"
#include "SharedElements/Point.h"
#include "DiagramElements/DiagramObject.h"
#include <vector>
#include <sstream>

/* Menu items */
#define SLEEPER 1
#define SHOWER 2
#define WINDOW 3
#define TABLE 4
#define WC 5
#define LOW 6
#define HIGH 7
#define EXIT 8
#define CONSOLE 9
#define SAVE 10
#define LOAD 11
#define NEW 12

using namespace std;

//menus
static int menu;
static int submenu1;
static int submenu2;

/* Application variables */
int application_width 	= 640;
int application_height 	= 480;

/* Global mouse variables */
int startx, starty, endx, endy;

/* Global vector for storing */
vector<Point> storeVect1;
vector<Point> storeVect2;
vector<string> storeStrVect;

/* Global vector for redrawing objects */
vector<Point> storeVectR1;
vector<Point> storeVectR2;
vector<string> storeStrVectR;

/* Estimate furnitures appear or not */
bool SLEEPER_switcher = false;
bool SHOWER_switcher = false;
bool TABLE_switcher = false;
bool WC_switcher = false;
bool LOW_switcher = false;
bool HIGH_switcher = false;
bool WIN_switcher = false;

/* Determine for storing in vector */
bool drawGrade = false;
bool saved = false;

/* Determine if inside the window */
bool insideWindow = true;
string outWindowWarning = "Design must within the canvas!";

/* Determine if inside the grade */
bool insideApartment = true;
string outApartWarning = "Objects inside the apartment is recommended.";

/* New design or not */
bool NEW_switcher = false;

/* Button for menu */
bool button_menu;

/* Display coordinates */
string a;
string b;
string displayCor;

/* Draw Application Borders */
Point windowLower = Point(int(application_width*0.01), int(application_height*0.01));
Point windowUpper = Point(int(application_width*0.85), int(application_height*0.955));

/* Objects */
Button * diagramObjectButton;
DiagramObject * object;

/* Object names */
string lowGradeName = "Low Grade";
string highGradeName = "High Grade";
string tableName = "Table";
string bedName = "Sleeper";
string winName = "Window";
string showerName = "Shower";
string toiletName = "Toilet";

/* Console */
string commands;
string confirm;
int obj_number;
bool console_help = false;
bool console_del = false;
bool console_test = false;

/* Convert string to int */
stringstream ss;

void init(void)
{
    // sets background colour and drawing colour
    glClearColor(0.75, 0.75,0.75,1.0);
    glColor3f(0.0, 0.0, 0.0);

    // sets up projection transformation
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0, 640.0, 0.0, 480.0);
}

void load()
{
    /* Wipe everything first */
    LOW_switcher = false;
    HIGH_switcher = false;
    drawGrade = false;
    saved = false;
    storeStrVect.clear();
    storeVect1.clear();
    storeVect2.clear();
    glClear(GL_COLOR_BUFFER_BIT);

    string line;
    string name;
    ifstream in("text.dat");
    while(getline (in, line)) {
        /* Disable the switchers */
        if(SLEEPER_switcher==true) {
            SLEEPER_switcher=false;
        }
        if(SHOWER_switcher==true) {
            SHOWER_switcher=false;
        }
        if(TABLE_switcher==true) {
            TABLE_switcher=false;
        }
        if(WC_switcher==true) {
            WC_switcher=false;
        }
        if(WIN_switcher==true) {
            WIN_switcher=false;
        }

        // Get the NAME line
        if (line.substr(0,5) != "NAME ") {
            cerr << "Expected NAME, got " << line << endl;
            exit(1);
        }

        // Get the LOWER line
        name = line.substr(5,string::npos);

        // Check switchers
        if(name==lowGradeName) {
            LOW_switcher = true;
            drawGrade = true;
        }
        if(name==highGradeName) {
            HIGH_switcher = true;
            drawGrade = true;
        }
        if(name==showerName)
            SHOWER_switcher = true;
        if(name==bedName)
            SLEEPER_switcher = true;
        if(name==tableName)
            TABLE_switcher = true;
        if(name==toiletName)
            WC_switcher = true;
        if(name==winName)
            WIN_switcher = true;

        storeStrVect.push_back(name);
        getline (in, line);
        if (line.substr(0,6) != "LOWER ") {
            cerr << "Expected LOWER, got " << line << endl;
            exit(1);
        }
        stringstream(line.substr(6,string::npos)) >> startx >> starty;
        storeVect1.push_back(Point(startx,starty));

        // Get the UPPER line
        name = line.substr(5,string::npos);
        getline (in, line);
        if (line.substr(0,6) != "UPPER ") {
            cerr << "Expected UPPER, got " << line << endl;
            exit(1);
        }
        stringstream(line.substr(6,string::npos)) >> endx >> endy;
        storeVect2.push_back(Point(endx,endy));
    }
    glutPostRedisplay();
}

void remove() {
    if(storeStrVect.size()>0) {
        //store objects info into the vector for redrawing
        storeStrVectR.push_back(storeStrVect[storeStrVect.size()-1]);
        storeVectR1.push_back(storeVect1[storeVect1.size()-1]);
        storeVectR2.push_back(storeVect2[storeVect2.size()-1]);

        //remove recent object
        storeStrVect.erase(storeStrVect.begin()+(storeStrVect.size()-1));
        storeVect1.erase(storeVect1.begin()+(storeVect1.size()-1));
        storeVect2.erase(storeVect2.begin()+(storeVect2.size()-1));

        //redisplay the screen
        glutPostRedisplay();
    }
    if(storeStrVect.size()==0) {
        /* Clear the screen */
        glClear(GL_COLOR_BUFFER_BIT);
        LOW_switcher = false;
        HIGH_switcher = false;
        drawGrade = false;
        saved = false;
    }
}

//remove temporary vectors which is for redrawing objects
void removeR() {
    if(storeStrVectR.size()>0) {
        storeStrVectR.erase(storeStrVectR.begin()+(storeStrVectR.size()-1));
        storeVectR1.erase(storeVectR1.begin()+(storeVectR1.size()-1));
        storeVectR2.erase(storeVectR2.begin()+(storeVectR2.size()-1));
    }
}

// the display callback function
void display(void)
{
    /*Clear the screen*/
    glClear(GL_COLOR_BUFFER_BIT);

    /* Objects */
    object = new DiagramObject("", Point(startx,starty), Point(endx,endy));

    //Gui Fill
    //glColor3f(0.9,0.9,0.9);
    glColor3f(1,1,1);
    glRecti(windowLower.x, windowLower.y, windowUpper.x-1, windowUpper.y-1);
    glColor3f(0,0,0);

    //GUI border
    glBegin(GL_LINE_LOOP);
    glVertex2i(windowLower.x, windowLower.y);
    glVertex2i(windowLower.x, windowUpper.y);
    glVertex2i(windowUpper.x, windowUpper.y);
    glVertex2i(windowUpper.x, windowLower.y);
    glEnd();

    /* Display items from the stored vector container */
    for(vector<string>::size_type i = 0; i<storeStrVect.size(); ++i) {
        if(storeStrVect[i]==lowGradeName) {
           object->setObject(false, false, false, false, true, false, false);
           object->setPosition(Point(storeVect1[i]), Point(storeVect2[i]));
        }
        if(storeStrVect[i]==winName) {
            object->setObject(false, false, false, false, false, false, true);
            object->setPosition(Point(storeVect1[i]), Point(storeVect2[i]));
        }
        if(storeStrVect[i]==tableName) {
            object->setObject(false, false, true, false, false, false, false);
            object->setPosition(Point(storeVect1[i]), Point(storeVect2[i]));
        }
        if(storeStrVect[i]==bedName) {
            object->setObject(true, false, false, false, false, false, false);
            object->setPosition(Point(storeVect2[i]), Point(storeVect1[i]));
        }
        if(storeStrVect[i]==showerName) {
            object->setObject(false, true, false, false, false, false, false);
            object->setPosition(Point(storeVect1[i]), Point(storeVect2[i]));
        }
        if(storeStrVect[i]==toiletName) {
            object->setObject(false, false, false, true, false, false, false);
            object->setPosition(Point(storeVect2[i]), Point(storeVect1[i]));
        }
        object->render();
    }

    //render the button
    diagramObjectButton->render();

    //Set the object style, and render the object
    if(LOW_switcher == true) {
        object->setObject(false, false, false, false, true, false, false);
        object->setPosition(Point(startx, starty), Point(endx, endy));
    }
    if(TABLE_switcher==true) {
        saved = false;
        object->setObject(false, false, true, false, false, false, false);
        object->setPosition(Point(startx, starty), Point(endx, endy));
    }
    if(SLEEPER_switcher==true) {
        saved = false;
        object->setObject(true, false, false, false, false, false, false);
        object->setPosition(Point(endx, endy), Point(startx, starty));
    }
    if(SHOWER_switcher==true) {
        saved = false;
        object->setObject(false, true, false, false, false, false, false);
        object->setPosition(Point(startx, starty), Point(endx, endy));
    }
    if(WC_switcher==true) {
        saved = false;
        object->setObject(false, false, false, true, false, false, false);
        object->setPosition(Point(startx, starty), Point(endx, endy));
    }
    if(insideWindow==true && insideApartment==true) {
        object->render();
        glutPostRedisplay();
    }

    /* Text Warnings */
    else if(insideWindow==false && button_menu==false) {
        glColor3f(1,0,0);
        glRasterPos2i((windowLower.x+3), windowLower.y+5);
        for (unsigned int i = 0; i < outWindowWarning.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, outWindowWarning[i]);
        }
    }
    if(insideApartment==false && button_menu==false) {
        glColor3f(1,0,0);
        glRasterPos2i((windowLower.x+3), windowLower.y+5);
        for (unsigned int i = 0; i < outApartWarning.length(); i++) {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, outApartWarning[i]);
        }
    }

    /* Clear, new design */
    if(NEW_switcher==true) {
        /* Wipe everything */
        LOW_switcher = false;
        HIGH_switcher = false;
        SLEEPER_switcher=false;
        SHOWER_switcher=false;
        TABLE_switcher=false;
        WC_switcher=false;
        WIN_switcher=false;
        drawGrade = false;
        saved = false;

        /* Wipe storing vectors */
        for(vector<string>::size_type i=0; i<storeStrVect.size(); i++) {
            remove();
        }

        /* Wipe redrawing vectors */
        for(vector<string>::size_type i=0; i<storeStrVectR.size(); i++) {
            removeR();
        }
    }

    /* Display mouse press coordinates */
    ss.str("");
    ss.clear();
    ss << startx;
    a = ss.str();
    ss.str("");
    ss.clear();
    ss << starty;
    b = ss.str();
    displayCor = "Mouse Coordinate: (" + a + "," + b + ")."; //Combined coordinates and string

    //Display Mouse Coordinates
    glColor3f(1,0,0);
    glRasterPos2i((windowLower.x+3), windowUpper.y-13);
    for (unsigned int i = 0; i < displayCor.length(); i++) {
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_10, displayCor[i]);
    }

    /* Console */
    //if user wanna get help
    if(console_help==true) {
        cout<<"del - delete specific object"<<endl;
        cout<<"test - test specfic things of the program"<<endl;
        cout<<"exit - save & exit the program"<<endl;
        console_help = false;
        cout<<"More commands?"<<endl;
        cin>>commands;

        //recall the console commands
        if(commands=="help") {
            console_help = true;
            glutPostRedisplay();
        }
        if(commands=="del") {
            console_del = true;
            glutPostRedisplay();
        }
        if(commands=="test") {
            console_test = true;
            glutPostRedisplay();
        }
        if(commands=="exit") {
            if(storeStrVect.size()>1) {
                ofstream out("text.dat");
                object->getPoint(storeStrVect, storeVect1, storeVect2);
                object->save(out);
            }
            exit(0);
        }
    }
    //if user wanna remove specific object
    if(console_del==true) {
        console_del = false;
        if(storeStrVect.size()==0) {
            cout<<"Your current design has no objects."<<endl;
            cout<<"More commands?"<<endl;
            cin>>commands;
        }
        else if (storeStrVect.size()==1) {
            cout<<"Your current design has only 1 object."<<endl;
            cout<<"Remove this object? (yes, no)"<<endl;
            cin>>commands;
            if(commands=="yes") {
                for(int i=0; i<(storeStrVect.size() && storeVect1.size() && storeVect2.size());i++) {
                    storeStrVect.erase(storeStrVect.begin()+i);
                    storeVect1.erase(storeVect1.begin()+i);
                    storeVect2.erase(storeVect2.begin()+i);
                }
                cout<<"Successfully remove this object!"<<endl;
                cout<<"More commands?"<<endl;
                cin>>commands;
            }
            if(commands=="no") {
                cout<<"More commands?"<<endl;
                cin>>commands;
            }
        }
        else if (storeStrVect.size()>1) {
        	ss.str("");
        	ss.clear();
        	ss << storeStrVect.size();
        	string vectSize = ss.str();
            cout<<"Your current design has " + vectSize + " objects."<<endl;
            cout<<"Objects list:"<<endl;
            for(int i=0; i<(storeStrVect.size());i++) {
            	ss.str("");
            	ss.clear();
            	ss << i;
            	string numi = ss.str();
                cout<<"[" + numi + "]. " + storeStrVect[i]<<endl;
            }
            cout<<"Which object do you want to remove? (enter the number)"<<endl;
            cin>>obj_number;
            cout<<"Remove this object? (yes, no)"<<endl;
            cin>>confirm;
            if(confirm=="yes") {
                if(obj_number==0) {
                    cout<<"ERROR: Basic design is required!"<<endl;
                }
                if(obj_number>0) {
                    storeStrVect.erase(storeStrVect.begin()+obj_number);
                    storeVect1.erase(storeVect1.begin()+obj_number);
                    storeVect2.erase(storeVect2.begin()+obj_number);
                    cout<<"Successfully remove this object!"<<endl;
                }
                cout<<"More commands?"<<endl;
                cin>>commands;
            }
            if(confirm=="no") {
                cout<<"More commands?"<<endl;
                cin>>commands;
            }
        }

        //recall the console commands
        if(commands=="help") {
            console_help = true;
            glutPostRedisplay();
        }
        if(commands=="del") {
            console_del = true;
            glutPostRedisplay();
        }
        if(commands=="test") {
            console_test = true;
            glutPostRedisplay();
        }
        if(commands=="exit") {
            if(storeStrVect.size()>1) {
                ofstream out("text.dat");
                object->getPoint(storeStrVect, storeVect1, storeVect2);
                object->save(out);
            }
            exit(0);
        }
    }
    //if the programmer wanna test the program
    if(console_test==true) {
        /* Testing the vector */
        cout<<("1. Test storeStrVect:")<<endl;
        for(int i=0; i<(storeStrVect.size());i++) {
        	ss.str("");
        	ss.clear();
        	ss << i;
        	string numi = ss.str();
            cout<<("[" + numi + "]. " + storeStrVect[i])<<endl;
        }
        if(storeStrVect.size()==0) {
            cout<<("storeStrVect has no objects.")<<endl;
        }

        cout<<("")<<endl;
        cout<<("2. Test storeVect1 & storeVect2:")<<endl;
        if(storeVect1.size() == storeVect2.size()) {
            for(int i=0; i<(storeVect1.size());i++) {
            	ss.str("");
            	ss.clear();
            	ss << i;
            	string numi = ss.str();
                cout<<("Drawing objects, store at " + numi)<<endl;
                cout<<("Name: " + storeStrVect[i])<<endl;
            	ss.str("");
            	ss.clear();
            	ss << storeVect1[i].x;
            	string vect1x = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVect1[i].y;
            	string vect1y = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVect2[i].x;
            	string vect2x = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVect2[i].y;
            	string vect2y = ss.str();
                cout<<("Stored X: " + vect1x + " and Stored Y: " + vect1y)<<endl;
                cout<<("Stored X: " + vect2x + " and Stored Y: " + vect2y)<<endl;
                cout<<("")<<endl;
            }
        }
        else {
        	ss.str("");
        	ss.clear();
        	ss << storeVect1.size();
        	string vect1size = ss.str();
        	ss.str("");
        	ss.clear();
        	ss << storeVect2.size();
        	string vect2size = ss.str();
            cout<<("The size of storeVect1 [" + vect1size + "] and storeVect2 [" + vect2size + "] does not match.")<<endl;
        }
        if(storeVect1.size()==0) {
            cout<<("storeVect1 has no objects.")<<endl;
        }
        if(storeVect2.size()==0) {
            cout<<("storeVect2 has no objects.")<<endl;
        }

        cout<<("3. Test storeStrVectR:")<<endl;
        for(int i=0; i<(storeStrVectR.size());i++) {
        	ss.str("");
        	ss.clear();
        	ss << i;
        	string numi = ss.str();
            cout<<("[" + numi + "]. " + storeStrVectR[i])<<endl;
        }
        if(storeStrVectR.size()==0) {
            cout<<("storeStrVectR has no objects.")<<endl;
        }

        cout<<("")<<endl;
        cout<<("4. Test storeVectR1 & storeVectR2:")<<endl;
        if(storeVectR1.size() == storeVectR2.size()) {
            for(int i=0; i<(storeVectR1.size());i++) {
            	ss.str("");
            	ss.clear();
            	ss << i;
            	string numi = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVectR1[i].x;
            	string vectR1x = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVectR1[i].y;
            	string vectR1y = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVectR2[i].x;
            	string vectR2x = ss.str();
            	ss.str("");
            	ss.clear();
            	ss << storeVectR2[i].y;
            	string vectR2y = ss.str();
                cout<<("Drawing objects, store at " + numi)<<endl;
                cout<<("Name: " + storeStrVectR[i])<<endl;
                cout<<("Stored X: " + vectR1x + " and Stored Y: " + vectR1y)<<endl;
                cout<<("Stored X: " + vectR2x + " and Stored Y: " + vectR2y)<<endl;
                cout<<("")<<endl;
            }
        }
        else {
        	ss.str("");
        	ss.clear();
        	ss << storeVectR1.size();
        	string vectR1size = ss.str();
        	ss.str("");
        	ss.clear();
        	ss << storeVectR2.size();
        	string vectR2size = ss.str();
            cout<<("The size of storeVectR1 [" + vectR1size + "] and storeVectR2 [" + vectR2size + "] does not match.")<<endl;
        }
        if(storeVectR1.size()==0) {
            cout<<("storeVectR1 has no objects.")<<endl;
        }
        if(storeVectR2.size()==0) {
            cout<<("storeVectR2 has no objects.")<<endl;
        }
        console_test = false;
        cout<<"More commands?"<<endl;
        cin>>commands;

        //recall the console commands
        if(commands=="help") {
            console_help = true;
            glutPostRedisplay();
        }
        if(commands=="del") {
            console_del = true;
            glutPostRedisplay();
        }
        if(commands=="test") {
            console_test = true;
            glutPostRedisplay();
        }
        if(commands=="exit") {
            if(storeStrVect.size()>1) {
                ofstream out("text.dat");
                object->getPoint(storeStrVect, storeVect1, storeVect2);
                object->save(out);
            }
            exit(0);
        }
    }

    //Flush out drawn elements and do double buffering
    glFlush();
    glutSwapBuffers();
}

void initClassDiagrams()
{
    // Set up data for drawing
    diagramObjectButton = new Button(Point(int(application_width*0.86), int(application_height*0.85)),
                                     Point(int(application_width*0.86+40), int(application_height*0.85+40)),
                                     new SquareIcon(int(application_width*0.86+10),int(application_height*0.85+10),int(application_width*0.86+30),int(application_height*0.85+30))
                                     );
}

/*
 * **********************************************************************
 * **********************************************************************
 * Handlers
 * **********************************************************************
 * **********************************************************************
 */

//Determine if within some area...
bool window(Point a, Point b, int mX, int mY) {
    bool insideWin = false;
    if(mX > a.x && mY > a.y && mX < b.x && mY < b.y) {
        insideWin = true;
    }
    return insideWin;
}

static void passiveMove (int x, int y)
{
    if(window(Point(int(application_width*0.86), int(application_height*0.85)), Point(int(application_width*0.86+40), int(application_height*0.85+40)), startx, starty) == true) {
    	button_menu = true;
    	//out<<button_menu<<endl;
    }
    else {
    	button_menu = false;
    }

    if(button_menu == true) {
    	//attach the menu to right button
    	glutAttachMenu(GLUT_RIGHT_BUTTON);
    	glutPostRedisplay();
    }
    else {
    	glutDetachMenu(GLUT_RIGHT_BUTTON);
    }
}

static void processMouseMotion(int x, int y)
{
    //Whenever the mouse moves, update the second point
    endx = x;
    endy = 480 - y;


    //Redisplay the changes
    glutPostRedisplay();
}

static void processMouse(int _button, int _state, int _x, int _y)
{
    if(_state==GLUT_DOWN) {
        //initialise the starting position when the mouse down
        startx = _x;
        starty = 480 - _y;
        endx = startx;
        endy = starty;
        //to determine the starting coordinate is within the canvas
        if(window(windowLower, windowUpper, startx, starty) == true) {
            insideWindow = true;
        }
        else {
        	insideWindow = false;
        }

        //to determine the starting coordinate is within the grade design
        if((storeStrVect.size()>0) && (insideWindow==true)) {
            if(window(storeVect1[0], storeVect2[0], startx, starty) == true) {
                insideApartment = true;
            }
            else {
                insideApartment = false;
            }
        }
    }
    if(_state==GLUT_UP) {
        //record the final mouse coordinates when the mouse up
        endx = _x;
        endy = 480 - _y;

        //to determine the ending coordinate is within the canvas
        if(window(windowLower, windowUpper, endx, endy) == true) {
            insideWindow = true;

            //double check for mouse dragging from bottom right position
            if(window(windowLower, windowUpper, startx, starty) == true) {
            	insideWindow = true;
            }
            else {
            	insideWindow = false;
          	}
        }
        else {
        	insideWindow = false;
        }

        //to determine the ending coordinate is within the grade design
        if((storeStrVect.size()>0) && (insideWindow==true)) {
            if(window(storeVect1[0], storeVect2[0], endx, endy) == true) {
                insideApartment = true;

                //double check for mouse dragging from bottom right position
                if(window(storeVect1[0], storeVect2[0], startx, starty) == true) {
                    insideApartment = true;
                }
                else {
                    insideApartment = false;
                }
            }
            else {
                insideApartment = false;
                cout<<insideApartment<<endl;
            }
        }

        /* Push object positions to vectors */

        //push grade design..
        if(((LOW_switcher == true) || (HIGH_switcher==true)) && (drawGrade == false) && (insideWindow == true)) {
        	storeVect1.push_back(Point(startx,starty));
        	storeVect2.push_back(Point(endx,endy));
            storeStrVect.push_back(lowGradeName);
            drawGrade = true;
        }

        //push objects...
        if(((drawGrade == true) && (saved == false)) && (insideWindow == true) && (insideApartment == true) && ((SHOWER_switcher == true) || (WC_switcher == true) || (TABLE_switcher == true) || (SLEEPER_switcher == true))) {
        	storeVect1.push_back(Point(startx,starty));
        	storeVect2.push_back(Point(endx,endy));
        	if(SHOWER_switcher == true)
        		storeStrVect.push_back(showerName); //store "Shower" into the vector
        	if(WC_switcher == true)
        		storeStrVect.push_back(toiletName); //store "Toilet" into the vector
        	if(TABLE_switcher == true)
        		storeStrVect.push_back(tableName); //store "Table" into the vector
        	if(SLEEPER_switcher == true)
        		storeStrVect.push_back(bedName); //store "Sleeper" into the vector
            saved = true;
        }
        if((insideWindow==false) && (storeStrVect.size()==0)) {
        	LOW_switcher = false;
        	drawGrade = false;
        }
        if(drawGrade == true) { //to fix the bug of checking objects inside the apartment
            int temp_a, temp_b, temp_c, temp_d;

            for(vector<string>::size_type i=0; i<storeStrVect.size(); ++i) {
                if((storeStrVect[i]==lowGradeName) || (storeStrVect[i]==toiletName)) {
                    temp_a = storeVect1[i].x;
                    temp_b = storeVect1[i].y;
                    temp_c = storeVect2[i].x;
                    temp_d = storeVect2[i].y;
                    if(storeVect2[i].x < storeVect1[i].x) {
                        if(storeVect1[i].y > storeVect2[i].y) {
                            storeVect1[i] = Point(temp_c,temp_d);
                            storeVect2[i] = Point(temp_a,temp_b);
                        }
                        else if(storeVect2[i].y > storeVect1[i].y) {
                            storeVect1[i] = Point(temp_c,temp_b);
                            storeVect2[i] = Point(temp_a,temp_d);
                        }
                    }
                    else if(storeVect1[i].x < storeVect2[i].x) {
                        if(storeVect1[i].y > storeVect2[i].y) {
                            storeVect1[i] = Point(temp_a,temp_d);
                            storeVect2[i] = Point(temp_c,temp_b);
                        }
                        else if(storeVect2[i].y > storeVect1[i].y) {
                            storeVect1[i] = Point(temp_a,temp_b);
                            storeVect2[i] = Point(temp_c,temp_d);
                        }
                    }
                }
            }
        }
    }
}

static void processNormalKeys(unsigned char key, int x, int y) {
    if (key == 's') {
        if(storeStrVect.size()>1) {
            ofstream out("text.dat");
            object->getPoint(storeStrVect, storeVect1, storeVect2);
            object->save(out);
        }
    }
    if (key == 'l') {
        load();
    }

    /* Press 'd' to delete recently added object */
    if (key == 'd') {
        remove();
    }

    /* Press 'r' to redraw recently deleted object */
    if (key == 'r') {
        if((storeStrVectR[storeStrVectR.size()-1]==lowGradeName) || (storeStrVectR[storeStrVectR.size()-1]==highGradeName)) {
            LOW_switcher = true;
            HIGH_switcher = true;
            drawGrade = true;
        }
        if(storeStrVectR.size()!=0) {
            storeStrVect.push_back(storeStrVectR[storeStrVectR.size()-1]);
            storeVect1.push_back(storeVectR1[storeVectR1.size()-1]);
            storeVect2.push_back(storeVectR2[storeVectR2.size()-1]);

            //remove recent redrawed object
            storeStrVectR.erase(storeStrVectR.begin()+(storeStrVectR.size()-1));
            storeVectR1.erase(storeVectR1.begin()+(storeVectR1.size()-1));
            storeVectR2.erase(storeVectR2.begin()+(storeVectR2.size()-1));
        }
    }
}

void processSpecialKeys(int key, int x, int y)
{

}

void processMenuEvents(int option) {
    //response to the menu entries

    /* Disable the switchers */
    if(SLEEPER_switcher==true) {
        SLEEPER_switcher=false;
    }
    if(SHOWER_switcher==true) {
        SHOWER_switcher=false;
    }
    if(TABLE_switcher==true) {
        TABLE_switcher=false;
    }
    if(WC_switcher==true) {
        WC_switcher=false;
    }
    if(WIN_switcher==true) {
        WIN_switcher=false;
    }
    if(NEW_switcher==true) {
        NEW_switcher=false;
    }

    /* Enable the switchers */
    switch(option) {
        case EXIT:
            exit(0);
            break;
        case SLEEPER:
            if((LOW_switcher == true) || (HIGH_switcher == true)) {
                SLEEPER_switcher = true;
            }
            glutPostRedisplay();
            break;
        case SHOWER:
            if((LOW_switcher == true) || (HIGH_switcher == true)) {
                SHOWER_switcher = true;
            }
            glutPostRedisplay();
            break;
        case WINDOW:
            if((LOW_switcher == true) || (HIGH_switcher == true)) {
                WIN_switcher = false;
                storeStrVect.push_back(winName); //store "Window" into the vector

                //use for loop to add coordinates
                for(vector<string>::size_type i=0; i<storeStrVect.size(); ++i) {
                    if(storeStrVect[i]==lowGradeName) {
                        storeVect1.push_back(Point(storeVect1[i].x,storeVect2[i].y));
                        storeVect2.push_back(Point(storeVect1[i].x,storeVect2[i].y));
                    }
                }
            }
            glutPostRedisplay();
            break;
        case TABLE:
            if((LOW_switcher == true) || (HIGH_switcher == true)) {
                TABLE_switcher = true;
            }
            glutPostRedisplay();
            break;
        case WC:
            if((LOW_switcher == true) || (HIGH_switcher == true)) {
                WC_switcher = true;
                cout<<"Notices: Toilet must attach to the wall."<<endl;
            }
            glutPostRedisplay();
            break;
        case LOW:
            LOW_switcher = true;
            break;
        /*case HIGH:
            HIGH_switcher = true;
            break;*/

        case NEW:
            NEW_switcher = true;
            break;

        case SAVE:
            if(storeStrVect.size()>1) {
                ofstream out("text.dat");
                object->getPoint(storeStrVect, storeVect1, storeVect2);
                object->save(out);
            }
            break;

        case LOAD:
            load();
            break;

        /* Console for for deleting specific objects */
        case CONSOLE:
            cout<<"Console opened. Notice: You must restart the program, and load your design to see the changes."<<endl;
            cout<<"Please type the commands in lower case (e.g., help):"<<endl;
            cin>>commands;
            if(commands=="help") {
                console_help = true;
                glutPostRedisplay();
            }
            if(commands=="del") {
                console_del = true;
                glutPostRedisplay();
            }
            if(commands=="test") {
                console_test = true;
                glutPostRedisplay();
            }
            if(commands=="exit") {
                if(storeStrVect.size()>1) {
                    ofstream out("text.dat");
                    object->getPoint(storeStrVect, storeVect1, storeVect2);
                    object->save(out);
                }
                exit(0);
            }
            break;
    }
}

void createGLUTMenu() {
    //add menu entries in the first submenu
    submenu1 = glutCreateMenu(processMenuEvents);
    glutAddMenuEntry("Bed", SLEEPER);
    glutAddMenuEntry("Shower", SHOWER);
    glutAddMenuEntry("Window", WINDOW);
    glutAddMenuEntry("Table", TABLE);
    glutAddMenuEntry("Toilet", WC);

    //add menu entries in the second submenu
    submenu2 = glutCreateMenu(processMenuEvents);
    glutAddMenuEntry("Low-grade apartment", LOW);
    //glutAddMenuEntry("High-grade apartment", HIGH);

    //add menu entries in main menu
    menu = glutCreateMenu(processMenuEvents);
    glutAddSubMenu("Select objects", submenu1);
    glutAddSubMenu("Select grade", submenu2);
    glutAddMenuEntry("Console", CONSOLE); //Console for deleting specific objects
    glutAddMenuEntry("New Design", NEW);
    glutAddMenuEntry("Save your design", SAVE);
    glutAddMenuEntry("Load previous design", LOAD);
    glutAddMenuEntry("Exit the program", EXIT);
}

/*
 * **********************************************************************
 * **********************************************************************
 * 							MAIN
 * **********************************************************************
 * **********************************************************************
 */
int main(int argc, char** argv)
{
    /*Welcome message*/
    cout<<"Thanks for using Martian House Designer!"<<endl;
    cout<<"Notices: "<<endl;
    cout<<"Press 'd' key to delete recently added object."<<endl;
    cout<<"Press 'r' key to redraw recently deleted object."<<endl;
    cout<<"Press 's' key to save your design."<<endl;
    cout<<"Press 'l' key to load your previous design."<<endl;

    /*GLUT Initialisation*/
    glutInit(&argc, argv);
    glutInitWindowSize(640, 480);
    glutInitWindowPosition(100, 150);
    glutCreateWindow ("Martian House Designer");
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE);

    /*Handlers*/
    glutDisplayFunc(display);
    glutKeyboardFunc(processNormalKeys);
	glutPassiveMotionFunc(passiveMove);
    glutMotionFunc(processMouseMotion);
    glutMouseFunc(processMouse);
    glutSpecialFunc(processSpecialKeys);
    createGLUTMenu();

    /*Application Initialisation*/
    init();
    initClassDiagrams();

    /*Starting main loop*/
    glutMainLoop();
    return 0;
}
