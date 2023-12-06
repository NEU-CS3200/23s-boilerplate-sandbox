CREATE DATABASE IF NOT EXISTS registrar;

USE registrar;

CREATE TABLE IF NOT EXISTS advisor (
    advisorID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    firstName varchar(50) NOT NULL,
    lastName varchar(50) NOT NULL,
    email varchar(75) UNIQUE NOT NULL,
    officeLocation text,
    availableTime text
);

CREATE TABLE IF NOT EXISTS department (
    departmentID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS administrator (
    administratorID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    firstName varchar(50) NOT NULL,
    lastName varchar(50) NOT NULL,
    email varchar(75) UNIQUE NOT NULL,
    officeLocation text,
    department int NOT NULL,
    FOREIGN KEY (department) references department (departmentID) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS building (
    buildingID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    hours text,
    dayCleaned varchar(20),
    administrator int,
    FOREIGN KEY (administrator) references administrator (administratorID) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS classroom (
    cID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    seats int NOT NULL,
    disabilityResources text,
    type varchar(50),
    building int NOT NULL,
    FOREIGN KEY (building) references building (buildingID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS major (
    mID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    name varchar(50)
);

CREATE TABLE IF NOT EXISTS student (
    firstName varchar(50) NOT NULL,
    lastName varchar(50) NOT NULL,
    email varchar(75) UNIQUE NOT NULL,
    gradYear int,
    address text,
    gender varchar(50),
    studentID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    advisor int,
    department int,
    major int,
    FOREIGN KEY (major) references major (mID),
    FOREIGN KEY (advisor) references advisor (advisorID),
    FOREIGN KEY (department) references department (departmentID)
);

CREATE TABLE IF NOT EXISTS professor (
    professorID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    firstName varchar(50) NOT NULL,
    lastName varchar(50) NOT NULL,
    email varchar(75) UNIQUE NOT NULL,
    officeLocation text,
    department int,
    FOREIGN KEY (department) references department (departmentID) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS course (
    courseID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NOT NULL,
    term varchar(6) NOT NULL,
    department int,
    FOREIGN KEY (department) references department (departmentID) ON UPDATE CASCADE,
    professor int,
    FOREIGN KEY (professor) references professor (professorID) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS section (
    secID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    classroom int,
    FOREIGN KEY (classroom) references classroom (cID) ON UPDATE CASCADE,
    course int NOT NULL,
    FOREIGN KEY (course) references course (courseID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exam (
    examID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    title varchar(50) NOT NULL,
    section int NOT NULL,
    FOREIGN KEY (section) references section (secID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS assignment (
    assignmentID int NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    title varchar(50) NOT NULL,
    section int NOT NULL,
    FOREIGN KEY (section) references section (secID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS students_in_section (
    section int NOT NULL,
    student int NOT NULL,
    courseGrade varchar(2),
    PRIMARY KEY (section, student),
    FOREIGN KEY (section) references section (secID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (student) references student (studentID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exam_grades (
    exam int NOT NULL,
    student int NOT NULL,
    examGrade tinyint(3),
    PRIMARY KEY (exam, student),
    FOREIGN KEY (exam) references exam (examID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (student) references student (studentID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS assignment_grades (
    assignment int NOT NULL,
    student int NOT NULL,
    assignmentGrade tinyint(3),
    PRIMARY KEY (assignment, student),
    FOREIGN KEY (assignment) references assignment (assignmentID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (student) references student (studentID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS major_courses (
    major int NOT NULL,
    course int NOT NULL,
    PRIMARY KEY (major, course),
    FOREIGN KEY (major) references major (mID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (course) references course (courseID) ON UPDATE CASCADE ON DELETE CASCADE
);


insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Yulma', 'Gormally', 'ygormally0@theguardian.com', 'PO Box 6598', '4:53 PM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Ruperta', 'Brothers', 'rbrothers1@google.cn', 'Apt 1732', '2:52 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Jessika', 'Cannam', 'jcannam2@smh.com.au', '12th Floor', '4:25 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Dov', 'Snooks', 'dsnooks3@telegraph.co.uk', 'PO Box 67399', '11:23 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Corine', 'Sigmund', 'csigmund4@people.com.cn', 'Suite 64', '7:08 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Hollie', 'Stranahan', 'hstranahan5@sbwire.com', '14th Floor', '4:31 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Nell', 'Joscelyne', 'njoscelyne6@google.com', 'Suite 92', '1:08 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Johny', 'Yarr', 'jyarr7@bloglovin.com', 'Apt 1652', '5:18 AM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Sybila', 'Bassham', 'sbassham8@opera.com', '11th Floor', '12:44 PM');
insert into advisor (firstName, lastName, email, officeLocation, availableTime) values ('Ansley', 'Sams', 'asams9@weather.com', '7th Floor', '3:13 PM');

insert into department (name) values ('Engineering');
insert into department (name) values ('Math');
insert into department (name) values ('Science');
insert into department (name) values ('Arts');
insert into department (name) values ('Language');

insert into administrator (firstName, lastName, email, officeLocation, department) values ('Ronica', 'LLelweln', 'rllelweln0@t-online.de', 'Apt 1789', 1);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Pernell', 'Eric', 'peric1@chron.com', 'Suite 51', 2);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Thibaud', 'O''Beirne', 'tobeirne2@google.it', 'Apt 383', 3);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Corri', 'Kerley', 'ckerley3@time.com', 'PO Box 13903', 4);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Lance', 'Richens', 'lrichens4@ucoz.ru', 'PO Box 7569', 3);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Blondy', 'Origin', 'borigin5@wordpress.com', 'PO Box 20482', 1);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Verge', 'Braney', 'vbraney6@bbb.org', '16th Floor', 2);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Virgie', 'Melia', 'vmelia7@clickbank.net', 'Apt 1105', 3);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Jorge', 'Doward', 'jdoward8@skype.com', 'Suite 86', 4);
insert into administrator (firstName, lastName, email, officeLocation, department) values ('Claybourne', 'Zorzetti', 'czorzetti9@columbia.edu', 'Suite 86', 1);

insert into building (hours, dayCleaned, administrator) values ('4:49 AM', 'Sunday', 1);
insert into building (hours, dayCleaned, administrator) values ('11:27 PM', 'Sunday', 2);
insert into building (hours, dayCleaned, administrator) values ('1:43 PM', 'Sunday', 3);
insert into building (hours, dayCleaned, administrator) values ('3:18 AM', 'Monday', 4);
insert into building (hours, dayCleaned, administrator) values ('1:17 PM', 'Sunday', 5);
insert into building (hours, dayCleaned, administrator) values ('9:56 PM', 'Sunday', 6);
insert into building (hours, dayCleaned, administrator) values ('3:28 PM', 'Friday', 7);
insert into building (hours, dayCleaned, administrator) values ('1:31 AM', 'Sunday', 8);
insert into building (hours, dayCleaned, administrator) values ('1:45 AM', 'Saturday', 9);
insert into building (hours, dayCleaned, administrator) values ('9:11 AM', 'Sunday', 9);

insert into classroom (seats, disabilityResources, type, building) values (30, 'Wheelchair Accessible', 'Lecture Hall', 1);
insert into classroom (seats, disabilityResources, type, building) values (300, 'Wheelchair Accessible', 'Stadium', 2);
insert into classroom (seats, disabilityResources, type, building) values (30, 'Wheelchair Accessible', 'Lecture Hall', 3);
insert into classroom (seats, disabilityResources, type, building) values (3, 'AED', 'Study Room', 4);
insert into classroom (seats, disabilityResources, type, building) values (30, 'AED', 'Lecture Hall', 5);
insert into classroom (seats, disabilityResources, type, building) values (84, 'No elevator', 'Lecture Hall', 5);
insert into classroom (seats, disabilityResources, type, building) values (40, 'Wheelchair Accessible', 'Lecture Hall', 6);
insert into classroom (seats, disabilityResources, type, building) values (20, 'ASL Interpreter', 'Lecture Hall', 7);
insert into classroom (seats, disabilityResources, type, building) values (55, 'Wheelchair Accessible', 'Lecture Hall', 8);
insert into classroom (seats, disabilityResources, type, building) values (30, 'Wheelchair Accessible', 'Lecture Hall', 9);
insert into classroom (seats, disabilityResources, type, building) values (10, 'ASL Interpreter', 'Classroom', 2);
insert into classroom (seats, disabilityResources, type, building) values (82, 'Wheelchair Accessible', 'Lecture Hall', 6);

insert into major (name) values ('BS in Computer Science');
insert into major (name) values ('BS in Mechanical Engineering');
insert into major (name) values ('BS in General Studies');
insert into major (name) values ('BS in Mechatronics');
insert into major (name) values ('BS in Political Science');
insert into major (name) values ('MS in Computer Science');
insert into major (name) values ('MS in Mechanical Engineering');
insert into major (name) values ('MS in General Studies');
insert into major (name) values ('MS in Mechatronics');
insert into major (name) values ('MS in Political Science');

insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('John', 'Smith', 'jsmith@theguardian.com', 2026, '133 Door St', 'Male', 2, 1, 4);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Ann', 'Smith', 'asmith@theguardian.com', 2026, '133 Door St', 'Female', 1, 2, 2);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Jeff', 'Kingsley', 'jk44@mail.com', 2024, '2204 Apt 3', 'Male', 4, 4, 5);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Ramona', 'Flowers', 'rflowers@netflix.com', 2028, '122 Door St', 'Female', 5, 5, 3);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Alec', 'Nine', 'minecraft@thewayhome.com', 2029, '930 Alpha Way', 'Non-binary', 3, 2, 1);

insert into professor (firstName, lastName, email, officeLocation, department) values ('Abe', 'Lincoln', 'honest@abe.com', '303 Snell', 1);
insert into professor (firstName, lastName, email, officeLocation, department) values ('Glenn', 'Horton', 'ghort@mail.com', '212 Richards', 4);
insert into professor (firstName, lastName, email, officeLocation, department) values ('Lisa', 'Simpson', 'lisasimpson@fox.com', '150 Smothers', 2);

insert into course (name, term, department, professor) values ('Introduction to Classes', '2024SP', 1, 2);
insert into course (name, term, department, professor) values ('Secondary Classes', '2025SP', 3, 3);
insert into course (name, term, department, professor) values ('Final Classes', '2024FL', 2, 1);

insert into section (classroom, course) values (1, 1);
insert into section (classroom, course) values (2, 1);
insert into section (classroom, course) values (3, 1);
insert into section (classroom, course) values (4, 2);

insert into exam (title, section) values ('midterm 1', 1);
insert into exam (title, section) values ('midterm 2', 1);
insert into exam (title, section) values ('midterm 1', 2);
insert into exam (title, section) values ('final', 2);

insert into assignment (title, section) values ('hw1', 1);
insert into assignment (title, section) values ('hw22', 1);
insert into assignment (title, section) values ('hw3', 2);
insert into assignment (title, section) values ('project', 2);

insert into students_in_section (section, student, courseGrade) values (1, 2, 'A');
insert into students_in_section (section, student) values (2, 3);
insert into students_in_section (section, student, courseGrade) values (3, 1, 'C');

insert into exam_grades (exam, student, examGrade) values (1, 1, 90);
insert into exam_grades (exam, student, examGrade) values (2, 4, 84);
insert into exam_grades (exam, student, examGrade) values (3, 2, 100);

insert into assignment_grades (assignment, student, assignmentGrade) values (1, 1, 45);
insert into assignment_grades (assignment, student, assignmentGrade) values (3, 4, 95);
insert into assignment_grades (assignment, student, assignmentGrade) values (2, 2, 55);

insert into major_courses (major, course) values (1, 1);
insert into major_courses (major, course) values (3, 3);
insert into major_courses (major, course) values (2, 2);