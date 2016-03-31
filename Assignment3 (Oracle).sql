/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     1/10/2012 21:09:52                           */
/*==============================================================*/


alter table "Academic_Rec"
   drop constraint FK_ACADEMIC_ACADEMIC__STUDENT;

alter table "Academic_Rec"
   drop constraint FK_ACADEMIC_ACADEMIC__COURSE;

alter table "Course"
   drop constraint FK_COURSE_OFFERS_DEPARTME;

alter table "Enrols"
   drop constraint FK_ENROLS_ENROLS_STUDENT;

alter table "Enrols"
   drop constraint FK_ENROLS_ENROLS2_TUTE_PRA;

alter table "Staff"
   drop constraint FK_STAFF_WORKS_FOR_DEPARTME;

alter table "Teaching_Information"
   drop constraint FK_TEACHING_COURSE_TA_COURSE;

alter table "Tute_Prac"
   drop constraint FK_TUTE_PRA_IN_CLASSROO;

alter table "Tute_Prac"
   drop constraint FK_TUTE_PRA_HAS_COURSE;

alter table "Tute_Prac"
   drop constraint FK_TUTE_PRA_TAKES_STAFF;

alter table "assigned_lecturer"
   drop constraint FK_ASSIGNED_ASSIGNED__STAFF;

alter table "has_prerequisite"
   drop constraint FK_HAS_PRER_HAS_PRERE_COURSE2;

alter table "has_prerequisite"
   drop constraint FK_HAS_PRER_HAS_PRERE_COURSE;

drop index "Academic_Rec2_FK";

drop index "Academic_Rec_FK";

drop table "Academic_Rec" cascade constraints;

drop table "Classroom" cascade constraints;

drop index "offers_FK";

drop table "Course" cascade constraints;

drop table "Department" cascade constraints;

drop index "Enrols2_FK";

drop index "Enrols_FK";

drop table "Enrols" cascade constraints;

drop index "Works_for_FK";

drop table "Staff" cascade constraints;

drop table "Student" cascade constraints;

drop index "Course_taught_FK";

drop table "Teaching_Information" cascade constraints;

drop index "has_FK";

drop index IN_FK;

drop index "takes_FK";

drop table "Tute_Prac" cascade constraints;

drop table "assigned_lecturer" cascade constraints;

drop index "has_prerequisite2_FK";

drop index "has_prerequisite_FK";

drop table "has_prerequisite" cascade constraints;

/*==============================================================*/
/* Table: "Academic_Rec"                                        */
/*==============================================================*/
create table "Academic_Rec"  (
   "PersonID"           INTEGER                         not null,
   "CourseNo"           VARCHAR2(10)                    not null,
   "Status"             VARCHAR2(10),
   "Year"               INTEGER,
   "Semester"           VARCHAR2(50),
   "Mark"               INTEGER,
   constraint PK_ACADEMIC_REC primary key ("PersonID", "CourseNo")
);

/*==============================================================*/
/* Index: "Academic_Rec_FK"                                     */
/*==============================================================*/
create index "Academic_Rec_FK" on "Academic_Rec" (
   "PersonID" ASC
);

/*==============================================================*/
/* Index: "Academic_Rec2_FK"                                    */
/*==============================================================*/
create index "Academic_Rec2_FK" on "Academic_Rec" (
   "CourseNo" ASC
);

/*==============================================================*/
/* Table: "Classroom"                                           */
/*==============================================================*/
create table "Classroom"  (
   "RoomID"             VARCHAR2(20)                    not null,
   "NoOfSeat"           INTEGER,
   constraint PK_CLASSROOM primary key ("RoomID")
);

/*==============================================================*/
/* Table: "Course"                                              */
/*==============================================================*/
create table "Course"  (
   "CourseNo"           VARCHAR2(10)                    not null,
   "DepartmentNo"       VARCHAR2(20)                    not null,
   "CourseName"         VARCHAR2(100),
   "TextBook"           VARCHAR2(100),
   "CreditHour"         INTEGER,
   "Max_enrol"          INTEGER,
   "Availability"       INTEGER,
   constraint PK_COURSE primary key ("CourseNo")
);

/*==============================================================*/
/* Index: "offers_FK"                                           */
/*==============================================================*/
create index "offers_FK" on "Course" (
   "DepartmentNo" ASC
);

/*==============================================================*/
/* Table: "Department"                                          */
/*==============================================================*/
create table "Department"  (
   "DepartmentNo"       VARCHAR2(20)                    not null,
   "ContactNo"          VARCHAR2(20),
   "Building"           VARCHAR2(20),
   constraint PK_DEPARTMENT primary key ("DepartmentNo")
);

/*==============================================================*/
/* Table: "Enrols"                                              */
/*==============================================================*/
create table "Enrols"  (
   "PersonID"           INTEGER                         not null,
   "ClassID"            VARCHAR2(20)                    not null,
   "NoOfSeat"           INTEGER,
   constraint PK_ENROLS primary key ("PersonID", "ClassID")
);

/*==============================================================*/
/* Index: "Enrols_FK"                                           */
/*==============================================================*/
create index "Enrols_FK" on "Enrols" (
   "PersonID" ASC
);

/*==============================================================*/
/* Index: "Enrols2_FK"                                          */
/*==============================================================*/
create index "Enrols2_FK" on "Enrols" (
   "ClassID" ASC
);

/*==============================================================*/
/* Table: "Staff"                                               */
/*==============================================================*/
create table "Staff"  (
   "PersonID"           INTEGER                         not null,
   "DepartmentNo"       VARCHAR2(20)                    not null,
   "Name"               VARCHAR2(20),
   "Address"            VARCHAR2(50),
   "ContactNo"          VARCHAR2(20),
   "Email"              VARCHAR2(50),
   "OfficeNo"           VARCHAR2(20),
   "Role"               VARCHAR2(30),
   constraint PK_STAFF primary key ("PersonID")
);

/*==============================================================*/
/* Index: "Works_for_FK"                                        */
/*==============================================================*/
create index "Works_for_FK" on "Staff" (
   "DepartmentNo" ASC
);

/*==============================================================*/
/* Table: "Student"                                             */
/*==============================================================*/
create table "Student"  (
   "PersonID"           INTEGER                         not null,
   "Degree"             VARCHAR2(50),
   "Major"              VARCHAR2(50),
   "Name"               VARCHAR2(20),
   "Address"            VARCHAR2(50),
   "ContactNo"          VARCHAR2(20),
   "Email"              VARCHAR2(50),
   constraint PK_STUDENT primary key ("PersonID")
);

/*==============================================================*/
/* Table: "Teaching_Information"                                */
/*==============================================================*/
create table "Teaching_Information"  (
   "CourseNo"           VARCHAR2(10)                    not null,
   "Semester"           VARCHAR2(50),
   "Year"               INTEGER
);

/*==============================================================*/
/* Index: "Course_taught_FK"                                    */
/*==============================================================*/
create index "Course_taught_FK" on "Teaching_Information" (
   "CourseNo" ASC
);

/*==============================================================*/
/* Table: "Tute_Prac"                                           */
/*==============================================================*/
create table "Tute_Prac"  (
   "ClassID"            VARCHAR2(20)                    not null,
   "CourseNo"           VARCHAR2(10)                    not null,
   "RoomID"             VARCHAR2(20)                    not null,
   "PersonID"           INTEGER                         not null,
   "Type"               VARCHAR2(10),
   "Day"                VARCHAR2(10),
   "Time"               VARCHAR2(10),
   "NoofStudents"		INTEGER,
   constraint PK_TUTE_PRAC primary key ("ClassID")
);

/*==============================================================*/
/* Index: "takes_FK"                                            */
/*==============================================================*/
create index "takes_FK" on "Tute_Prac" (
   "PersonID" ASC
);

/*==============================================================*/
/* Index: IN_FK                                                 */
/*==============================================================*/
create index IN_FK on "Tute_Prac" (
   "RoomID" ASC
);

/*==============================================================*/
/* Index: "has_FK"                                              */
/*==============================================================*/
create index "has_FK" on "Tute_Prac" (
   "CourseNo" ASC
);

/*==============================================================*/
/* Table: "assigned_lecturer"                                   */
/*==============================================================*/
create table "assigned_lecturer"  (
   "PersonID"           INTEGER                         not null,
   constraint PK_ASSIGNED_LECTURER primary key ("PersonID")
);

/*==============================================================*/
/* Table: "has_prerequisite"                                    */
/*==============================================================*/
create table "has_prerequisite"  (
   "CourseNo"           VARCHAR2(10)                    not null,
   "Cou_CourseNo"       VARCHAR2(10)                    not null,
   constraint PK_HAS_PREREQUISITE primary key ("CourseNo", "Cou_CourseNo")
);

/*==============================================================*/
/* Index: "has_prerequisite_FK"                                 */
/*==============================================================*/
create index "has_prerequisite_FK" on "has_prerequisite" (
   "CourseNo" ASC
);

/*==============================================================*/
/* Index: "has_prerequisite2_FK"                                */
/*==============================================================*/
create index "has_prerequisite2_FK" on "has_prerequisite" (
   "Cou_CourseNo" ASC
);

alter table "Academic_Rec"
   add constraint FK_ACADEMIC_ACADEMIC__STUDENT foreign key ("PersonID")
      references "Student" ("PersonID");

alter table "Academic_Rec"
   add constraint FK_ACADEMIC_ACADEMIC__COURSE foreign key ("CourseNo")
      references "Course" ("CourseNo");

alter table "Course"
   add constraint FK_COURSE_OFFERS_DEPARTME foreign key ("DepartmentNo")
      references "Department" ("DepartmentNo");

alter table "Enrols"
   add constraint FK_ENROLS_ENROLS_STUDENT foreign key ("PersonID")
      references "Student" ("PersonID");

alter table "Enrols"
   add constraint FK_ENROLS_ENROLS2_TUTE_PRA foreign key ("ClassID")
      references "Tute_Prac" ("ClassID");

alter table "Staff"
   add constraint FK_STAFF_WORKS_FOR_DEPARTME foreign key ("DepartmentNo")
      references "Department" ("DepartmentNo");

alter table "Teaching_Information"
   add constraint FK_TEACHING_COURSE_TA_COURSE foreign key ("CourseNo")
      references "Course" ("CourseNo");

alter table "Tute_Prac"
   add constraint FK_TUTE_PRA_IN_CLASSROO foreign key ("RoomID")
      references "Classroom" ("RoomID");

alter table "Tute_Prac"
   add constraint FK_TUTE_PRA_HAS_COURSE foreign key ("CourseNo")
      references "Course" ("CourseNo");

alter table "Tute_Prac"
   add constraint FK_TUTE_PRA_TAKES_STAFF foreign key ("PersonID")
      references "Staff" ("PersonID");

alter table "assigned_lecturer"
   add constraint FK_ASSIGNED_ASSIGNED__STAFF foreign key ("PersonID")
      references "Staff" ("PersonID");

alter table "has_prerequisite"
   add constraint FK_HAS_PRER_HAS_PRERE_COURSE2 foreign key ("CourseNo")
      references "Course" ("CourseNo");

alter table "has_prerequisite"
   add constraint FK_HAS_PRER_HAS_PRERE_COURSE foreign key ("Cou_CourseNo")
      references "Course" ("CourseNo");

/*1. Insert data into the table "Student"*/
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111111, 'Bachelor of Information Technology', 'Business Information System', 'Jason Wong', '2 Welby St, Eastwood', '0424495256', 'jasonkwh@gmail.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111112, 'Bachelor of Information Technology', 'Business Information System', 'Sam Lee', '3 George St', '1928372819', 'sam.lee@gmail.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111113, 'Bachelor of Information Technology', 'Business Information System', 'Keith Liew', '3 Blaxland Rd', '1929182819', 'keith.liew@gmail.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111114, 'Bachelor of Information Technology', 'Business Information System', 'David Wei', '4 Balaclava Rd', '3918294828', 'david.wei@students.mq.edu.au');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111115, 'Bachelor of Information Technology', 'Software Technology', 'Ken Jia', '19 Queen St, Libcombe', '3929182939', 'ken.jia@gmail.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111117, 'Bachelor of Arts', 'Media Studies', 'Kate Winslet', '7 Shab St', '0392837328', 'kate.winslet@hollywood.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111119, 'Bachelor of Engineering', 'Telecommunication Engineering', 'Bryan Zhao', '29 Hay St, Haymarket', '0291839828', 'bryan.zhao@gmail.com');
INSERT INTO "Student" ("PersonID", "Degree", "Major", "Name", "Address", "ContactNo", "Email") VALUES (11111120, 'Bachelor of Engineering', 'Electronics Engineering', 'Steven Ho', '8 University Rd, Marsfield', '0495824928', 'steven.ho@students.mq.edu.au');

/*2. Insert data into the table "Department"*/
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTANHI', '0928172837', 'W6A');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTARTS', '0938272748', 'W6D');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTCOPT', '0928178378', 'E6B');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTECOM', '0928273828', 'E4B');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTLING', '0938274637', 'X6A');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTMATH', '0938274827', 'X5B');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTPSYC', '0928372843', 'E7B');
INSERT INTO "Department" ("DepartmentNo", "ContactNo", "Building") VALUES ('DEPTSOGY', '0985058078', 'W5B');

/*3. Insert data into the table "Staff"*/
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222220, 'DEPTCOPT', 'Matthew Mansour', '3 Macquarie St', '0219382748', 'matthew.mansour@staffs.mq.edu.au', 'E6B321', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222221, 'DEPTARTS', 'Jackie Chen', '28 Canton Rd, Kowloon, Hong Kong', '+85293827182', 'jackie.chen@stuffs.mq.edu.au', 'E3B119', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222222, 'DEPTMATH', 'Peter Josh', '9 University Rd, Marsfield', '0928182718', 'peteryeah1234@gmail.com', 'X5B102', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222223, 'DEPTARTS', 'Andy Lau', '29 Pitts St', '+8529382718', 'andy.lau@stuffs.mq.edu.au', 'W6A123', 'Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222224, 'DEPTANHI', 'Jet Li', '5 Carlingford Rd, Carlingford', '+8613920382718', 'jet.li@yahoo.com.au', 'E4B333', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222225, 'DEPTECOM', 'Julia Gillard', '43 Noideas Rd, Canberra', '0283728192', 'julia.gillardaus@australia.gov.au', 'E3A129', 'Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222226, 'DEPTLING', 'Leonardo DiCaprio', '32 Sussex St, Haymarket', '0492837389', 'dicaprio@theking.com', 'E5A102', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222227, 'DEPTSOGY', 'Tom Cruise', '10 Hawking Rd, Newcastle', '0456745638', 'tomcruise9@hotmail.com', 'X3A302', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222228, 'DEPTPSYC', 'Sigmund Freud', '11 Dontknow St, Austria', '0413928472', 'freud@doesntexist.com', 'E6B322', 'Lecturer and Tutor');
INSERT INTO "Staff" ("PersonID", "DepartmentNo", "Name", "Address", "ContactNo", "Email", "OfficeNo", "Role") VALUES (22222229, 'DEPTCOPT', 'Leonardo da Vinci', '19 DaVinci Rd, Italy', '0492849382', 'davinci@arts.com', 'E3B120', 'Lecturer and Tutor');

/*4. Insert data into the table "assigned_lecturer"*/
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222220);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222221);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222222);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222224);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222226);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222227);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222228);
INSERT INTO "assigned_lecturer" ("PersonID") VALUES (22222229);

/*5. Insert data into the table "Course"*/
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('ACST101', 'DEPTECOM', 'Techniques and Elements of Finance', 'Introduction to Finance Techniques', 3, 150, 0);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('AHIS249', 'DEPTANHI', 'Ancient History Special Topic A', 'Interesting Things of Ancient History', 3, 200, 30);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('COMP115', 'DEPTCOPT', 'Introduction to Computer Science', 'Learning Processing', 3, 250, 2);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('DANC200', 'DEPTARTS', 'Music Theatre', 'The Way to Listen Music', 3, 250, 60);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('DMTH137', 'DEPTMATH', 'Discrete Mathematics I', 'Introduction to DMTHS', 3, 150, 6);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('ISYS114', 'DEPTCOPT', 'Introduction to Systems Design and Data Management', 'Systems Design and Data Management', 3, 150, 10);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('ISYS224', 'DEPTCOPT', 'Database Systems', 'Database and SQL', 3, 200, 10);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('ISYS254', 'DEPTCOPT', 'Applications Modelling and Development', 'ASP Stuffs with SQL', 3, 250, 5);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('PSY104', 'DEPTPSYC', 'Introduction to Psychology I', 'Be a Psychologist', 3, 240, 13);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('PSY105', 'DEPTPSYC', 'Introduction to Psychology II', 'Be a Genius Psychologist', 3, 250, 14);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('PSY224', 'DEPTPSYC', 'Psychology, Health and Wellbeing', 'Be a Advanced Genius Psychologist', 3, 160, 11);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SOC175', 'DEPTSOGY', 'Australia and Global Societies: An Introduction to Sociology', 'Australia Societies', 3, 140, 2);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SOC220', 'DEPTSOGY', 'Objects of Passion: Topics in Cultural Sociology', 'Cultural Sociology', 3, 140, 3);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SPN101', 'DEPTLING', 'Introductory Spanish I', 'I love Spanish Level 1 - for Beginners', 4, 200, 9);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SPN102', 'DEPTLING', 'Introductory Spanish II', 'I love Spanish Level 2 - for Genius Beginners', 3, 160, 0);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SPN103', 'DEPTLING', 'Introductory Spanish III', 'I love Spanish Level 3 - for Advanced Genius Beginners', 3, 150, 0);
INSERT INTO "Course" ("CourseNo", "DepartmentNo", "CourseName", "TextBook", "CreditHour", "Max_enrol", "Availability") VALUES ('SPN201', 'DEPTLING', 'Intermediate Spanish I', 'I love Spanish Level 4 - for Genius', 3, 100, 9);

/*6. Insert data into the table "Academic_Rec"*/
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111111, 'ACST101', 'HD', 2012, 'D2', 90);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111111, 'COMP115', 'HD', 2011, 'D2', 86);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111114, 'COMP115', 'D', 2011, 'D1', 78);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111115, 'COMP115', 'F', 2011, 'D2', 34);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111119, 'COMP115', 'P', 2012, 'D1', 52);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111120, 'COMP115', 'D', 2011, 'E2', 89);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111117, 'DANC200', 'P', 2012, 'D1', 64);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111119, 'DANC200', 'F', 2010, 'D1', 29);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111113, 'DMTH137', 'CR', 2011, 'D2', 66);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111114, 'ISYS114', 'CR', 2011, 'D1', 74);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111111, 'ISYS224', 'HD', 2012, 'D2', 89);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111112, 'PSY104', 'P', 2010, 'E1', 60);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111112, 'PSY105', 'F', 2011, 'D1', 49);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111117, 'SPN101', 'HD', 2011, 'D2', 92);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111117, 'SPN102', 'D', 2012, 'D1', 84);
INSERT INTO "Academic_Rec" ("PersonID", "CourseNo", "Status", "Year", "Semester", "Mark") VALUES (11111117, 'SPN103', 'CR', 2012, 'D2', 72);

/*7. Insert data into the table "has_prerequisite"*/
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('ISYS224', 'ISYS114');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('ISYS254', 'ISYS114');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('PSY224', 'PSY104');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('PSY224', 'PSY105');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('SOC220', 'SOC175');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('SPN201', 'SPN101');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('SPN201', 'SPN102');
INSERT INTO "has_prerequisite" ("CourseNo", "Cou_CourseNo") VALUES ('SPN201', 'SPN103');

/*8. Insert data into the table "Classroom"*/
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('C5CT1', 60);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E3A166', 25);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E3A174', 25);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E3B111', 30);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E6A102', 50);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E7BT2', 50);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('E7BT3', 50);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('Mason Theatre', 80);
INSERT INTO "Classroom" ("RoomID", "NoOfSeat") VALUES ('W5AT1', 30);

/*9. Insert data into the table "Tute_Prac"*/
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('ACST101_LEC', 'ACST101', 'E3A166', 22222222, 'Lecture', 'Thursday', '3:00pm', 24);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('ACST101_PRAC', 'ACST101', 'W5AT1', 22222225, 'Practical ', 'Monday', '4:00pm', 29);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('ACST101_TUT', 'ACST101', 'E3A174', 22222222, 'Tutorial', 'Friday', '2:00pm', 20);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('AHIS249_PRAC', 'AHIS249', 'E7BT2', 22222224, 'Practical', 'Friday', '6:00pm', 10);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('COMP115_LEC', 'COMP115', 'Mason Theatre', 22222220, 'Lecture', 'Monday', '12:00pm', 60);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('DANC200_LEC', 'DANC200', 'C5CT1', 22222221, 'Lecture', 'Friday', '5:00pm', 35);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('DANC200_TUT', 'DANC200', 'E3B111', 22222223, 'Tutorial', 'Wednesday', '1:00pm', 28);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('PSY104_LEC', 'PSY104', 'W5AT1', 22222228, 'Lecture', 'Thursday', '10:00am', 25);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('SOC175_TUT', 'SOC175', 'E7BT3', 22222227, 'Tutorial', 'Wednesday', '9:00am', 45);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('SPN101_LEC', 'SPN101', 'C5CT1', 22222226, 'Lecture', 'Tuesday', '9:00am', 27);
INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ('ISYS254_LEC', 'ISYS254', 'C5CT1', 22222220, 'Lecture', 'Monday', '10:00am', 30);

/*10. Insert data into the table "Enrols"*/
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111111, 'ACST101_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111111, 'ACST101_PRAC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111111, 'ACST101_TUT');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111111, 'COMP115_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111114, 'COMP115_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111115, 'COMP115_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111119, 'COMP115_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111117, 'DANC200_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111117, 'DANC200_TUT');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111112, 'PSY104_LEC');
INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES (11111117, 'SPN101_LEC');

/*11. Insert data into the table "Teaching_Information"*/
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('ISYS224', 'D2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('ISYS254', 'D1', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('ACST101', 'D1, D2, E1', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('AHIS249', 'D1, X1', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('COMP115', 'D1, E1, Session 3 Internal', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('DANC200', 'D2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('DMTH137', 'D2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('ISYS114', 'D2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('PSY104', 'D1, Session 3 Internal', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('PSY105', 'D2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('PSY224', 'D1', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SOC175', 'D1, E1, X1, Session 3 External', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SOC220', 'NONE', 2013);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SPN101', 'D1, E1, X1', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SPN102', 'D2, E2, X2', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SPN103', 'Session 3 Internal', 2012);
INSERT INTO "Teaching_Information" ("CourseNo", "Semester", "Year") VALUES ('SPN201', 'D1, X1', 2012);

SET SERVEROUTPUT ON

/* TRIGGER */
CREATE OR REPLACE TRIGGER SeatNumbers BEFORE INSERT OR UPDATE ON "Enrols" FOR EACH ROW
DECLARE
	"v_noofseats" INTEGER;
	"count_seats" INTEGER;
BEGIN
	SELECT COUNT(*) INTO "count_seats" FROM "Enrols" WHERE "Enrols"."ClassID" = NEW."ClassID";
	SELECT "Classroom"."NoOfSeat" INTO "v_noofseats" FROM "Classroom","Tute_Prac" WHERE ("Classroom"."RoomID" = "Tute_Prac"."RoomID") AND ("Tute_Prac"."ClassID" = "Classroom"."ClassID");
	IF "count_seats" >= "v_noofseats" THEN
		DBMS_OUTPUT.PUT_LINE('Class full.');
	ELSIF "count_seats" < "v_noofseats" THEN
		UPDATE "Tute_Prac" SET "NoofStudents" = "count_seats" + 1 WHERE "Tute_Prac"."ClassID" = NEW."ClassID";
	END IF;
END SeatNumbers;
	
CREATE OR REPLACE PACKAGE assignment3 AS
	/*Q2 a) */
	PROCEDURE open_class("Class_Info" IN "Tute_Prac"%ROWTYPE) IS
		"v_classid" VARCHAR2(20);
		"v_courseno" VARCHAR2(10);
		"v_roomid" VARCHAR2(20);
		"v_personid" INTEGER;
		"v_type" VARCHAR2(10);
		"v_day" VARCHAR2(10);
		"v_time" DATE;
		"v_noofstudents" INTEGER;
		"count_cid" INTEGER;
		"e" EXCEPTION;
	BEGIN
		"v_classid" := "Class_Info"."ClassID";
		"v_courseno" := "Class_Info"."CourseNo";
		"v_roomid" := "Class_Info"."RoomID";
		"v_personid" := "Class_Info"."PersonID";
		"v_type" := "Class_Info"."Type";
		"v_day" := "Class_Info"."Day";
		"v_time" := "Class_Info"."Time";
		"v_noofstudents" := "Class_Info"."NoofStudents";
		SELECT COUNT("ClassID") INTO "count_cid" FROM "Tute_Prac" WHERE ("v_day" LIKE "Tute_Prac"."Day") AND ("v_time" LIKE "Tute_Prac"."Time") AND ("v_personid" LIKE "Tute_Prac"."PersonID");
		IF "count_cid" > 0 THEN
			RAISE "e";
		END IF;
		INSERT INTO "Tute_Prac" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ("v_classid", "v_courseno", "v_roomid", "v_personid", "v_type", "v_day", "v_time", "v_noofstudents");
		COMMIT;
	EXCEPTION
		WHEN "e" THEN
			DBMS_OUTPUT.PUT_LINE('There is already a class with a same staff in this day and time.');
	END open_class;
	
	/*Q2 b) */
	PROCEDURE enrol_student("SID" IN "Enrols"."PersonID"%TYPE, "CID" IN "Enrols"."ClassID"%TYPE) IS
		"v_id" INTEGER;
		"v_cid" VARCHAR2(20);
		"count_id" INTEGER;
		"e" EXCEPTION;
	BEGIN
		SELECT COUNT("ClassID") INTO "count_id" FROM "Enrols" WHERE ("Enrols"."PersonID" LIKE "SID");
		IF "count_id" > 0 THEN
			RAISE "e";
		END IF;
		"v_id" := "SID";
		"v_cid" := "CID";
		INSERT INTO "Enrols" ("PersonID", "ClassID") VALUES ("v_id", "v_cid");
		COMMIT;
	EXCEPTION
		WHEN "e" THEN
			DBMS_OUTPUT.PUT_LINE('You cannot enrol more than one pratical or more than one tutorial session for any given unit.');
	END enrol_student;
	
	/*Q2 c) */
	FUNCTION compute_wam("SID" IN "Academic_Rec"."PersonID"%TYPE) RETURN NUMBER IS
		"result_mark" NUMBER;
		"result_credits" NUMBER;
		"temp_credits" NUMBER;
		"total" NUMBER;
		CURSOR "c1" IS
			SELECT "Academic_Rec"."Mark" FROM "Academic_Rec" WHERE "SID" LIKE "Academic_Rec"."PersonID";
			"temp" "c1"%ROWTYPE;
	BEGIN
		"result_mark" := 0;
		"result_credits" := 0;
		FOR "temp" IN "c1"
		LOOP
			SELECT "Course"."CreditHour" INTO "temp_credits" FROM "Course" WHERE "Course"."CourseNo" LIKE "temp"."CourseNo";
			"result_mark" := "result_mark" + ("temp_credits" * "temp"."Mark");
			"result_credits" := "result_credits" + "temp_credits";
		END LOOP;
		"total" := "result_mark" / "result_credits";
		RETURN "total";
		COMMIT;
	END compute_wam; 
	
	/*Q2 d) */
	PROCEDURE unit_dependencies("CNo" IN "has_prerequisite"."Cou_CourseNo"%TYPE) IS
		"v_courseno" "has_prerequisite"."CourseNo"%TYPE;
		CURSOR "c1" IS
			SELECT "CourseNo" FROM "has_prerequisite" WHERE ("CNo" LIKE "has_prerequisite"."Cou_CourseNo");
			"temp" "c1"%ROWTYPE;
	BEGIN
		FOR "temp" IN "c1"
		LOOP
			"v_courseno" := "temp"."CourseNo";
			DBMS_OUTPUT.PUT_LINE(TO_CHAR("v_courseno") || ' is the prerequisite of ' || TO_CHAR("CNo"));
			unit_dependencies("v_courseno");
		END LOOP;
	COMMIT;	
	END unit_dependencies;
END assignment3;

/* test Q2 a) */
DECLARE
	"test_classid" VARCHAR2(20);
	"test_courseno" VARCHAR2(10);
	"test_roomid" VARCHAR2(20);
	"test_personid" INTEGER;
	"test_type" VARCHAR2(10);
	"test_day" VARCHAR2(10);
	"test_time" DATE;
	"test_noofstudents" INTEGER;
	"Class_Info" "Tute_Prac"%ROWTYPE;
BEGIN
	"test_classid" := 'TEST100_TST';
	"test_courseno" := 'TEST100';
	"test_roomid" := 'C5CT1';
	"test_personid" := 22222222;
	"test_type" := 'Practical';
	"test_day" := 'Monday';
	"test_time" := '12:00pm';
	"test_noofstudents" := 15;
	INSERT INTO "Class_Info" ("ClassID", "CourseNo", "RoomID", "PersonID", "Type", "Day", "Time", "NoofStudents") VALUES ("test_classid", "test_courseno", "test_roomid", "test_personid", "test_type", "test_day", "test_time", "test_noofstudents");
	open_class("Class_Info" => "Class_Info");
END;

/* test Q2 b) */
DECLARE
	"SID" INTEGER;
	"CID" VARCHAR2(20);
BEGIN
	"SID" := 11111111;
	"CID" := 'PSY104_LEC';
	enrol_student("SID" => "SID", "CID" => "CID");
END;

/* test Q2 d) */
DECLARE
	"CNo" VARCHAR2(10);
BEGIN
	"CNo" := 'ISYS114';
	unit_dependencies("CNo" => "CNo");
END;

/*OUTPUT TABLES*/
SELECT * FROM "Tute_Prac";
SELECT * FROM "Enrols";