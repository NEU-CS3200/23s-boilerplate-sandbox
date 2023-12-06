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


insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (1, 'Jeanette', 'Maffia', 'Jeanette.Maf@northeastern.edu', 'Petronas Towers 703', '9:52');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (2, 'Della', 'Lown', 'Della.Low@northeastern.edu', 'Empire State Building 404', '12:46');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (3, 'Walt', 'Donovin', 'Walt.Don@northeastern.edu', 'Tokyo Skytree 900', '15:09');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (4, 'Willette', 'Milillo', 'Willette.Mil@northeastern.edu', 'CN Tower 608', '16:15');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (5, 'Ulises', 'Orris', 'Ulises.Orr@northeastern.edu', 'Burj Khalifa 401', '15:23');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (6, 'Obadias', 'Vlahos', 'Obadias.Vla@northeastern.edu', 'Petronas Towers 809', '16:57');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (7, 'Jenni', 'Maneylaws', 'Jenni.Man@northeastern.edu', 'One World Trade Center 405', '9:41');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (8, 'Fair', 'Blagdon', 'Fair.Bla@northeastern.edu', 'One World Trade Center 801', '10:09');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (9, 'Edmon', 'Sangwine', 'Edmon.San@northeastern.edu', 'Taipei 101 200', '10:25');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (10, 'Korie', 'Brockest', 'Korie.Bro@northeastern.edu', 'Tokyo Skytree 004', '16:02');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (11, 'Dewain', 'Shalcros', 'Dewain.Sha@northeastern.edu', 'Taipei 101 104', '14:38');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (12, 'Teador', 'Birkmyre', 'Teador.Bir@northeastern.edu', 'Shanghai Tower 801', '16:12');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (13, 'Bevan', 'Buist', 'Bevan.Bui@northeastern.edu', 'One World Trade Center 501', '11:24');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (14, 'Diane-marie', 'Shearme', 'Diane-marie.She@northeastern.edu', 'Taipei 101 304', '11:56');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (15, 'Yvor', 'Dack', 'Yvor.Dac@northeastern.edu', 'Burj Khalifa 302', '14:47');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (16, 'Melonie', 'Collip', 'Melonie.Col@northeastern.edu', 'Tokyo Skytree 905', '11:10');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (17, 'Harlen', 'Djurdjevic', 'Harlen.Dju@northeastern.edu', 'Shanghai Tower 002', '16:04');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (18, 'Angil', 'Champken', 'Angil.Cha@northeastern.edu', 'Tokyo Skytree 300', '11:53');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (19, 'Mordy', 'd'' Elboux', 'Mordy.d'' @northeastern.edu', 'Empire State Building 906', '10:50');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (20, 'Matti', 'Poyntz', 'Matti.Poy@northeastern.edu', 'Taipei 101 906', '16:56');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (21, 'Gianina', 'Sivior', 'Gianina.Siv@northeastern.edu', 'CN Tower 202', '10:41');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (22, 'Briano', 'Luna', 'Briano.Lun@northeastern.edu', 'CN Tower 007', '12:58');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (23, 'Borg', 'Wilbud', 'Borg.Wil@northeastern.edu', 'One World Trade Center 503', '16:46');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (24, 'Lionel', 'Fardy', 'Lionel.Far@northeastern.edu', 'Taipei 101 603', '10:56');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (25, 'Nolie', 'Kernell', 'Nolie.Ker@northeastern.edu', 'Shanghai Tower 306', '13:06');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (26, 'Arin', 'Nurse', 'Arin.Nur@northeastern.edu', 'Abraj Al-Bait Clock Tower 609', '9:37');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (27, 'Venita', 'St Angel', 'Venita.St @northeastern.edu', 'Abraj Al-Bait Clock Tower 000', '10:04');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (28, 'Nicko', 'Whithorn', 'Nicko.Whi@northeastern.edu', 'CN Tower 303', '11:46');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (29, 'Rhianon', 'Sawrey', 'Rhianon.Saw@northeastern.edu', 'Tokyo Skytree 905', '10:25');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (30, 'Sharlene', 'Grigaut', 'Sharlene.Gri@northeastern.edu', 'Petronas Towers 804', '10:58');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (31, 'Nevile', 'Van Driel', 'Nevile.Van@northeastern.edu', 'Tokyo Skytree 601', '14:52');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (32, 'Dennie', 'Goodacre', 'Dennie.Goo@northeastern.edu', 'Abraj Al-Bait Clock Tower 408', '14:11');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (33, 'Wenda', 'Rewan', 'Wenda.Rew@northeastern.edu', 'Petronas Towers 901', '11:34');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (34, 'Lucretia', 'Durak', 'Lucretia.Dur@northeastern.edu', 'Burj Khalifa 200', '14:42');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (35, 'Shepherd', 'Keighley', 'Shepherd.Kei@northeastern.edu', 'Shanghai Tower 308', '9:43');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (36, 'Garvy', 'Heeney', 'Garvy.Hee@northeastern.edu', 'Taipei 101 807', '12:06');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (37, 'Mariel', 'Goldfinch', 'Mariel.Gol@northeastern.edu', 'Tokyo Skytree 607', '10:06');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (38, 'Kacy', 'Brecon', 'Kacy.Bre@northeastern.edu', 'Empire State Building 804', '14:36');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (39, 'Holmes', 'Tamsett', 'Holmes.Tam@northeastern.edu', 'Willis Tower 904', '13:59');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values (40, 'Pauletta', 'Haskins', 'Pauletta.Has@northeastern.edu', 'Petronas Towers 904', '12:58');

insert into department (name, departmentID) values ('Computer Science', 1);
insert into department (name, departmentID) values ('Electrical Engineering', 2);
insert into department (name, departmentID) values ('Mechanical Engineering', 3);
insert into department (name, departmentID) values ('Chemistry', 4);
insert into department (name, departmentID) values ('Physics', 5);
insert into department (name, departmentID) values ('Biology', 6);
insert into department (name, departmentID) values ('Mathematics', 7);
insert into department (name, departmentID) values ('Psychology', 8);
insert into department (name, departmentID) values ('English Literature', 9);
insert into department (name, departmentID) values ('History', 10);
insert into department (name, departmentID) values ('Sociology', 11);
insert into department (name, departmentID) values ('Economics', 12);
insert into department (name, departmentID) values ('Business Administration', 13);
insert into department (name, departmentID) values ('Political Science', 14);
insert into department (name, departmentID) values ('Art', 15);
insert into department (name, departmentID) values ('Music', 16);
insert into department (name, departmentID) values ('Philosophy', 17);
insert into department (name, departmentID) values ('Geology', 18);
insert into department (name, departmentID) values ('Anthropology', 19);
insert into department (name, departmentID) values ('Communication Studies', 20);

insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (1, 'Gretna', 'Bolino', 'Gretna.Bol@northeastern.edu', 'Willowbrook Manor 305', '18');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (2, 'Eudora', 'Benedito', 'Eudora.Ben@northeastern.edu', 'Willowbrook Manor 201', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (3, 'Kiel', 'Espinos', 'Kiel.Esp@northeastern.edu', 'Maplewood Plaza 803', '7');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (4, 'Demetra', 'Garfoot', 'Demetra.Gar@northeastern.edu', 'Willowbrook Manor 505', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (5, 'Gerhard', 'Blant', 'Gerhard.Bla@northeastern.edu', 'Oakwood Tower 808', '8');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (6, 'Eldon', 'Crowdace', 'Eldon.Cro@northeastern.edu', 'Pinecrest Heights 508', '20');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (7, 'Bernadene', 'Jojic', 'Bernadene.Joj@northeastern.edu', 'Willowbrook Manor 309', '15');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (8, 'Felicity', 'Cobleigh', 'Felicity.Cob@northeastern.edu', 'Willowbrook Manor 402', '17');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (9, 'Guillaume', 'McCory', 'Guillaume.McC@northeastern.edu', 'Oakwood Tower 804', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (10, 'Lodovico', 'Creany', 'Lodovico.Cre@northeastern.edu', 'Cedar Ridge 805', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (11, 'Moritz', 'Comsty', 'Moritz.Com@northeastern.edu', 'Pinecrest Heights 904', '1');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (12, 'Dorie', 'Fifield', 'Dorie.Fif@northeastern.edu', 'Cedar Ridge 508', '11');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (13, 'Felicdad', 'Hailey', 'Felicdad.Hai@northeastern.edu', 'Maplewood Plaza 003', '12');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (14, 'Rhiamon', 'Scougall', 'Rhiamon.Sco@northeastern.edu', 'Oakwood Tower 308', '5');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (15, 'Bogey', 'Murie', 'Bogey.Mur@northeastern.edu', 'Willowbrook Manor 208', '13');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (16, 'Abbe', 'Krelle', 'Abbe.Kre@northeastern.edu', 'Maplewood Plaza 506', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (17, 'Shannon', 'Mariolle', 'Shannon.Mar@northeastern.edu', 'Willowbrook Manor 604', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (18, 'Tabbi', 'Childs', 'Tabbi.Chi@northeastern.edu', 'Oakwood Tower 405', '4');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (19, 'Dal', 'Cardiff', 'Dal.Car@northeastern.edu', 'Cedar Ridge 904', '9');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (20, 'Addie', 'Osipenko', 'Addie.Osi@northeastern.edu', 'Oakwood Tower 800', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (21, 'Violet', 'Pontain', 'Violet.Pon@northeastern.edu', 'Willowbrook Manor 204', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (22, 'Frieda', 'Buckell', 'Frieda.Buc@northeastern.edu', 'Maplewood Plaza 102', '8');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (23, 'Glyn', 'Ladbrooke', 'Glyn.Lad@northeastern.edu', 'Pinecrest Heights 807', '9');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (24, 'Thelma', 'Clemits', 'Thelma.Cle@northeastern.edu', 'Willowbrook Manor 009', '7');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (25, 'Althea', 'Mowle', 'Althea.Mow@northeastern.edu', 'Pinecrest Heights 804', '11');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (26, 'Jethro', 'Laight', 'Jethro.Lai@northeastern.edu', 'Cedar Ridge 804', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (27, 'Drew', 'Basire', 'Drew.Bas@northeastern.edu', 'Cedar Ridge 207', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (28, 'Hunfredo', 'McGruar', 'Hunfredo.McG@northeastern.edu', 'Oakwood Tower 103', '20');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (29, 'Adrian', 'Born', 'Adrian.Bor@northeastern.edu', 'Oakwood Tower 909', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (30, 'Marge', 'Yatman', 'Marge.Yat@northeastern.edu', 'Willowbrook Manor 700', '4');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (31, 'Rance', 'Mettericke', 'Rance.Met@northeastern.edu', 'Willowbrook Manor 500', '12');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (32, 'Thorsten', 'Brecknell', 'Thorsten.Bre@northeastern.edu', 'Oakwood Tower 104', '15');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (33, 'Dulciana', 'Rraundl', 'Dulciana.Rra@northeastern.edu', 'Pinecrest Heights 800', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (34, 'Wenona', 'Muge', 'Wenona.Mug@northeastern.edu', 'Willowbrook Manor 600', '13');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (35, 'Fred', 'Colliford', 'Fred.Col@northeastern.edu', 'Pinecrest Heights 304', '1');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (36, 'Clemens', 'McKellen', 'Clemens.McK@northeastern.edu', 'Maplewood Plaza 100', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (37, 'Marta', 'Giannasi', 'Marta.Gia@northeastern.edu', 'Oakwood Tower 404', '18');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (38, 'Ariel', 'Garvie', 'Ariel.Gar@northeastern.edu', 'Pinecrest Heights 101', '17');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (39, 'Mohandis', 'Girardini', 'Mohandis.Gir@northeastern.edu', 'Maplewood Plaza 604', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values (40, 'Carita', 'Tudge', 'Carita.Tud@northeastern.edu', 'Oakwood Tower 100', '5');

insert into building (buildingID, hours, daycleaned, administrator) values (1, '1:47 PM', 'Tuesday', '4');
insert into building (buildingID, hours, daycleaned, administrator) values (2, '9:45 AM', 'Tuesday', '11');
insert into building (buildingID, hours, daycleaned, administrator) values (3, '11:18 AM', 'Thursday', '1');
insert into building (buildingID, hours, daycleaned, administrator) values (4, '12:17 PM', 'Monday', '29');
insert into building (buildingID, hours, daycleaned, administrator) values (5, '8:12 AM', 'Tuesday', '26');
insert into building (buildingID, hours, daycleaned, administrator) values (6, '2:36 PM', 'Saturday', '19');
insert into building (buildingID, hours, daycleaned, administrator) values (7, '4:16 PM', 'Wednesday', '10');
insert into building (buildingID, hours, daycleaned, administrator) values (8, '4:55 PM', 'Wednesday', '15');
insert into building (buildingID, hours, daycleaned, administrator) values (9, '1:24 PM', 'Tuesday', '23');
insert into building (buildingID, hours, daycleaned, administrator) values (10, '4:33 PM', 'Wednesday', '32');
insert into building (buildingID, hours, daycleaned, administrator) values (11, '3:08 PM', 'Monday', '2');
insert into building (buildingID, hours, daycleaned, administrator) values (12, '12:32 PM', 'Sunday', '40');
insert into building (buildingID, hours, daycleaned, administrator) values (13, '1:38 PM', 'Tuesday', '39');
insert into building (buildingID, hours, daycleaned, administrator) values (14, '11:43 AM', 'Tuesday', '14');
insert into building (buildingID, hours, daycleaned, administrator) values (15, '3:01 PM', 'Thursday', '8');
insert into building (buildingID, hours, daycleaned, administrator) values (16, '3:52 PM', 'Thursday', '28');
insert into building (buildingID, hours, daycleaned, administrator) values (17, '9:44 AM', 'Thursday', '30');
insert into building (buildingID, hours, daycleaned, administrator) values (18, '9:02 AM', 'Thursday', '33');
insert into building (buildingID, hours, daycleaned, administrator) values (19, '12:45 PM', 'Thursday', '6');
insert into building (buildingID, hours, daycleaned, administrator) values (20, '2:35 PM', 'Sunday', '25');

insert into classroom (cID, seats, disabilityResources, type, building) values (1, 50, 1, 'classroom', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values (2, 50, 0, 'classroom', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values (3, 50, 0, 'classroom', '4');
insert into classroom (cID, seats, disabilityResources, type, building) values (4, 50, 1, 'classroom', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values (5, 20, 1, 'laboratory', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values (6, 200, 2, 'auditorium', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values (7, 20, 1, 'laboratory', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values (8, 50, 2, 'classroom', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values (9, 100, 0, 'lecture hall', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values (10, 100, 2, 'lecture hall', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values (11, 150, 2, 'lecture hall', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values (12, 100, 0, 'lecture hall', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values (13, 100, 2, 'lecture hall', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values (14, 100, 0, 'lecture hall', '16');
insert into classroom (cID, seats, disabilityResources, type, building) values (15, 200, 2, 'auditorium', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values (16, 50, 2, 'classroom', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values (17, 50, 0, 'classroom', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values (18, 100, 0, 'lecture hall', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values (19, 200, 0, 'auditorium', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values (20, 150, 0, 'lecture hall', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values (21, 200, 0, 'auditorium', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values (22, 200, 1, 'auditorium', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values (23, 150, 0, 'lecture hall', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values (24, 150, 0, 'lecture hall', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values (25, 50, 0, 'classroom', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values (26, 150, 1, 'lecture hall', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values (27, 20, 0, 'laboratory', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values (28, 200, 2, 'auditorium', '4');
insert into classroom (cID, seats, disabilityResources, type, building) values (29, 150, 0, 'lecture hall', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values (30, 150, 1, 'lecture hall', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values (31, 100, 0, 'lecture hall', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values (32, 50, 1, 'classroom', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values (33, 20, 0, 'laboratory', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values (34, 50, 2, 'classroom', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values (35, 50, 2, 'classroom', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values (36, 150, 1, 'lecture hall', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values (37, 200, 2, 'auditorium', '16');
insert into classroom (cID, seats, disabilityResources, type, building) values (38, 150, 1, 'lecture hall', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values (39, 150, 0, 'lecture hall', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values (40, 100, 2, 'lecture hall', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values (41, 200, 1, 'auditorium', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values (42, 50, 2, 'classroom', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values (43, 150, 2, 'lecture hall', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values (44, 200, 1, 'auditorium', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values (45, 20, 0, 'laboratory', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values (46, 100, 0, 'lecture hall', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values (47, 20, 1, 'laboratory', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values (48, 50, 0, 'classroom', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values (49, 150, 2, 'lecture hall', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values (50, 20, 1, 'laboratory', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values (51, 20, 0, 'laboratory', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values (52, 100, 0, 'lecture hall', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values (53, 100, 2, 'lecture hall', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values (54, 200, 2, 'auditorium', '4');
insert into classroom (cID, seats, disabilityResources, type, building) values (55, 20, 2, 'laboratory', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values (56, 200, 0, 'auditorium', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values (57, 100, 0, 'lecture hall', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values (58, 200, 2, 'auditorium', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values (59, 200, 0, 'auditorium', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values (60, 100, 0, 'lecture hall', '16');

insert into major (mID, name) values (1, 'Computer Science');
insert into major (mID, name) values (2, 'Business Administration');
insert into major (mID, name) values (3, 'Psychology');
insert into major (mID, name) values (4, 'English Literature');
insert into major (mID, name) values (5, 'Mechanical Engineering');
insert into major (mID, name) values (6, 'Biology');
insert into major (mID, name) values (7, 'Chemistry');
insert into major (mID, name) values (8, 'Mathematics');
insert into major (mID, name) values (9, 'History');
insert into major (mID, name) values (10, 'Sociology');
insert into major (mID, name) values (11, 'Political Science');
insert into major (mID, name) values (12, 'Economics');
insert into major (mID, name) values (13, 'Physics');
insert into major (mID, name) values (14, 'Art');
insert into major (mID, name) values (15, 'Music');
insert into major (mID, name) values (16, 'Philosophy');
insert into major (mID, name) values (17, 'Nursing');
insert into major (mID, name) values (18, 'Education');
insert into major (mID, name) values (19, 'Communications');
insert into major (mID, name) values (20, 'Environmental Science');
insert into major (mID, name) values (21, 'Anthropology');
insert into major (mID, name) values (22, 'Geology');
insert into major (mID, name) values (23, 'Foreign Languages');
insert into major (mID, name) values (24, 'Criminal Justice');
insert into major (mID, name) values (25, 'Marketing');
insert into major (mID, name) values (26, 'Graphic Design');
insert into major (mID, name) values (27, 'Architecture');
insert into major (mID, name) values (28, 'Film Studies');
insert into major (mID, name) values (29, 'Journalism');
insert into major (mID, name) values (30, 'Health Sciences');

insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (1, 'Buiron', 'Simmank', 'Buiron.Sim@northeastern.edu', 'Male', 2024, '2837 Hazelcrest Pass', '38', '2', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (2, 'Elsa', 'Thirst', 'Elsa.Thi@northeastern.edu', 'Female', 2024, '8074 Parkside Terrace', '27', '9', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (3, 'Audra', 'Casero', 'Audra.Cas@northeastern.edu', 'Female', 2026, '29 Mallard Parkway', '17', '1', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (4, 'Marrissa', 'Syrett', 'Marrissa.Syr@northeastern.edu', 'Female', 2025, '5 Onsgard Lane', '28', '5', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (5, 'Cecelia', 'Colenutt', 'Cecelia.Col@northeastern.edu', 'Female', 2025, '18 Longview Court', '12', '3', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (6, 'Tony', 'Ewart', 'Tony.Ewa@northeastern.edu', 'Male', 2025, '3 Oxford Plaza', '14', '17', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (7, 'Wallache', 'Smissen', 'Wallache.Smi@northeastern.edu', 'Male', 2026, '1002 Ramsey Court', '8', '6', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (8, 'Keeley', 'Krzyzaniak', 'Keeley.Krz@northeastern.edu', 'Female', 2026, '524 Shelley Junction', '31', '14', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (9, 'Courtenay', 'Jankiewicz', 'Courtenay.Jan@northeastern.edu', 'Female', 2026, '4218 Onsgard Drive', '37', '8', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (10, 'Abigale', 'Bengough', 'Abigale.Ben@northeastern.edu', 'Female', 2025, '4 Cambridge Hill', '22', '12', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (11, 'Ludwig', 'Wilshere', 'Ludwig.Wil@northeastern.edu', 'Male', 2026, '439 American Way', '26', '7', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (12, 'Robbin', 'Jouannot', 'Robbin.Jou@northeastern.edu', 'Female', 2023, '69 Spenser Junction', '21', '4', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (13, 'Doralyn', 'Darey', 'Doralyn.Dar@northeastern.edu', 'Female', 2025, '889 Spaight Alley', '24', '16', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (14, 'Oliver', 'Fontell', 'Oliver.Fon@northeastern.edu', 'Male', 2023, '1302 Stuart Way', '13', '20', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (15, 'Paddie', 'Spinelli', 'Paddie.Spi@northeastern.edu', 'Male', 2024, '1 La Follette Plaza', '6', '10', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (16, 'Lorant', 'Rosson', 'Lorant.Ros@northeastern.edu', 'Male', 2026, '3 Trailsway Road', '3', '18', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (17, 'Clo', 'Cowdrey', 'Clo.Cow@northeastern.edu', 'Female', 2025, '451 Evergreen Court', '34', '11', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (18, 'Millicent', 'Spinola', 'Millicent.Spi@northeastern.edu', 'Female', 2025, '445 Corben Avenue', '16', '13', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (19, 'Donia', 'Ollivierre', 'Donia.Oll@northeastern.edu', 'Female', 2024, '2515 Northridge Drive', '5', '19', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (20, 'Hiram', 'Hobson', 'Hiram.Hob@northeastern.edu', 'Male', 2024, '00236 Raven Parkway', '1', '15', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (21, 'Kamillah', 'Schroter', 'Kamillah.Sch@northeastern.edu', 'Female', 2024, '1474 Pleasure Center', '30', '5', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (22, 'Jo-anne', 'Roderham', 'Jo-anne.Rod@northeastern.edu', 'Non-binary', 2023, '5338 Merrick Street', '18', '4', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (23, 'Philippa', 'Lawey', 'Philippa.Law@northeastern.edu', 'Female', 2025, '8675 Clyde Gallagher Park', '20', '20', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (24, 'Salome', 'Wolton', 'Salome.Wol@northeastern.edu', 'Female', 2023, '02 Magdeline Junction', '40', '9', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (25, 'Paddy', 'Ciccottio', 'Paddy.Cic@northeastern.edu', 'Male', 2023, '74351 Longview Junction', '15', '6', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (26, 'Callie', 'Simnett', 'Callie.Sim@northeastern.edu', 'Female', 2024, '8 Mallory Junction', '35', '14', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (27, 'Den', 'Sykora', 'Den.Syk@northeastern.edu', 'Male', 2023, '1 Hooker Drive', '19', '7', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (28, 'Janis', 'Ordidge', 'Janis.Ord@northeastern.edu', 'Female', 2024, '087 Goodland Court', '39', '2', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (29, 'Northrop', 'MacLise', 'Northrop.Mac@northeastern.edu', 'Male', 2025, '0 Harper Center', '2', '18', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (30, 'Viviana', 'Eul', 'Viviana.Eul@northeastern.edu', 'Female', 2025, '400 Brentwood Park', '9', '15', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (31, 'Marshall', 'Lawman', 'Marshall.Law@northeastern.edu', 'Male', 2023, '02 Judy Hill', '36', '16', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (32, 'Titus', 'Rowan', 'Titus.Row@northeastern.edu', 'Male', 2024, '4413 Cardinal Trail', '23', '19', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (33, 'Simonne', 'Humberston', 'Simonne.Hum@northeastern.edu', 'Female', 2024, '90121 High Crossing Circle', '7', '13', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (34, 'Sherrie', 'Lanceter', 'Sherrie.Lan@northeastern.edu', 'Female', 2025, '31484 Manufacturers Avenue', '32', '3', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (35, 'Rosanne', 'Munby', 'Rosanne.Mun@northeastern.edu', 'Female', 2026, '73461 Elmside Junction', '25', '8', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (36, 'Camellia', 'Sanzio', 'Camellia.San@northeastern.edu', 'Female', 2023, '7475 Badeau Junction', '11', '17', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (37, 'Dougy', 'Yurtsev', 'Dougy.Yur@northeastern.edu', 'Male', 2023, '70 Kinsman Parkway', '33', '1', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (38, 'Arvie', 'Sharpless', 'Arvie.Sha@northeastern.edu', 'Genderfluid', 2024, '6059 Artisan Drive', '29', '10', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (39, 'Maible', 'Clixby', 'Maible.Cli@northeastern.edu', 'Female', 2025, '3202 Dottie Pass', '10', '11', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (40, 'Chilton', 'De Giorgio', 'Chilton.De @northeastern.edu', 'Male', 2025, '58915 High Crossing Point', '4', '12', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (41, 'Loren', 'Fones', 'Loren.Fon@northeastern.edu', 'Male', 2026, '6 Lakewood Plaza', '5', '8', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (42, 'Elden', 'O''Halloran', 'Elden.O''H@northeastern.edu', 'Male', 2025, '343 Golf View Lane', '30', '19', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (43, 'Nomi', 'Leggitt', 'Nomi.Leg@northeastern.edu', 'Female', 2023, '50 Weeping Birch Trail', '20', '13', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (44, 'Rosco', 'Prue', 'Rosco.Pru@northeastern.edu', 'Bigender', 2026, '747 Dryden Park', '35', '18', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (45, 'Babbie', 'Acklands', 'Babbie.Ack@northeastern.edu', 'Female', 2026, '904 Bultman Way', '23', '12', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (46, 'Hermina', 'Billany', 'Hermina.Bil@northeastern.edu', 'Female', 2024, '8 Hermina Terrace', '3', '15', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (47, 'Cortie', 'Bolliver', 'Cortie.Bol@northeastern.edu', 'Male', 2025, '7 Eagle Crest Parkway', '14', '11', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (48, 'Dall', 'Adin', 'Dall.Adi@northeastern.edu', 'Male', 2025, '73516 Hauk Road', '27', '7', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (49, 'Hunter', 'Walcher', 'Hunter.Wal@northeastern.edu', 'Male', 2023, '32 Sloan Pass', '4', '2', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (50, 'Rubie', 'Gittings', 'Rubie.Git@northeastern.edu', 'Female', 2026, '29 Westport Drive', '10', '6', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (51, 'Mala', 'Blaksland', 'Mala.Bla@northeastern.edu', 'Female', 2026, '9 Anzinger Trail', '7', '3', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (52, 'Janek', 'Whetland', 'Janek.Whe@northeastern.edu', 'Male', 2026, '84025 Mosinee Way', '33', '14', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (53, 'Brandy', 'Moorwood', 'Brandy.Moo@northeastern.edu', 'Female', 2024, '5 Eggendart Court', '11', '4', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (54, 'Jarrod', 'Rodolfi', 'Jarrod.Rod@northeastern.edu', 'Male', 2026, '917 Morrow Crossing', '8', '17', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (55, 'Elane', 'Dales', 'Elane.Dal@northeastern.edu', 'Female', 2026, '414 1st Point', '2', '20', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (56, 'Sid', 'O''Hoolahan', 'Sid.O''H@northeastern.edu', 'Male', 2023, '183 Superior Park', '16', '16', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (57, 'Grace', 'Doughty', 'Grace.Dou@northeastern.edu', 'Non-binary', 2023, '6447 Tennessee Junction', '21', '10', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (58, 'Evita', 'Retter', 'Evita.Ret@northeastern.edu', 'Female', 2023, '492 Monterey Hill', '26', '9', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (59, 'Sarita', 'Midner', 'Sarita.Mid@northeastern.edu', 'Bigender', 2023, '82317 Tennessee Street', '34', '5', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (60, 'Emmalee', 'Larby', 'Emmalee.Lar@northeastern.edu', 'Female', 2024, '26531 Killdeer Circle', '22', '1', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (61, 'Westley', 'Stenett', 'Westley.Ste@northeastern.edu', 'Male', 2024, '3 Farragut Center', '38', '8', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (62, 'Nahum', 'Call', 'Nahum.Cal@northeastern.edu', 'Male', 2026, '7342 Arkansas Trail', '25', '15', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (63, 'Elmore', 'Levin', 'Elmore.Lev@northeastern.edu', 'Male', 2025, '3830 Sunfield Lane', '1', '9', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (64, 'Benedict', 'Bickerdike', 'Benedict.Bic@northeastern.edu', 'Male', 2025, '96 Superior Trail', '29', '2', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (65, 'Madlin', 'Linggood', 'Madlin.Lin@northeastern.edu', 'Female', 2024, '4124 Mosinee Point', '6', '20', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (66, 'Amos', 'McClintock', 'Amos.McC@northeastern.edu', 'Male', 2023, '319 Algoma Alley', '17', '3', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (67, 'Alma', 'Govan', 'Alma.Gov@northeastern.edu', 'Female', 2025, '108 Fairview Terrace', '31', '7', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (68, 'Lyon', 'Goodsal', 'Lyon.Goo@northeastern.edu', 'Genderqueer', 2025, '622 Haas Lane', '32', '16', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (69, 'Olenka', 'Pavese', 'Olenka.Pav@northeastern.edu', 'Female', 2023, '522 Manufacturers Park', '9', '19', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (70, 'Boote', 'Teal', 'Boote.Tea@northeastern.edu', 'Male', 2023, '2059 Brickson Park Parkway', '39', '14', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (71, 'Corty', 'Jenman', 'Corty.Jen@northeastern.edu', 'Male', 2025, '07 Victoria Point', '18', '10', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (72, 'Leandra', 'Cooley', 'Leandra.Coo@northeastern.edu', 'Female', 2023, '7 Donald Road', '37', '11', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (73, 'Tracey', 'Kernan', 'Tracey.Ker@northeastern.edu', 'Female', 2023, '86481 Messerschmidt Avenue', '19', '13', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (74, 'Paige', 'Amy', 'Paige.Amy@northeastern.edu', 'Male', 2025, '5 Raven Trail', '36', '4', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (75, 'Lexine', 'Borrington', 'Lexine.Bor@northeastern.edu', 'Polygender', 2026, '696 Messerschmidt Drive', '13', '1', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (76, 'Liz', 'Ferminger', 'Liz.Fer@northeastern.edu', 'Female', 2023, '97 Messerschmidt Junction', '15', '17', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (77, 'Lotti', 'Temprell', 'Lotti.Tem@northeastern.edu', 'Female', 2026, '723 Dennis Point', '40', '5', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (78, 'Wendie', 'Bracco', 'Wendie.Bra@northeastern.edu', 'Female', 2024, '15 Sloan Terrace', '24', '6', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (79, 'Claiborne', 'Boddymead', 'Claiborne.Bod@northeastern.edu', 'Male', 2026, '3906 Buena Vista Way', '12', '18', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (80, 'Hillary', 'Wheelton', 'Hillary.Whe@northeastern.edu', 'Male', 2026, '03045 Northridge Point', '28', '12', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (81, 'Fae', 'Harriss', 'Fae.Har@northeastern.edu', 'Female', 2024, '26544 Bartillon Parkway', '12', '11', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (82, 'Austina', 'Breadmore', 'Austina.Bre@northeastern.edu', 'Female', 2026, '1 Schurz Trail', '3', '20', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (83, 'Kennett', 'Krebs', 'Kennett.Kre@northeastern.edu', 'Male', 2024, '035 Granby Center', '11', '16', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (84, 'Katie', 'Lowder', 'Katie.Low@northeastern.edu', 'Female', 2024, '67 Talmadge Road', '29', '2', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (85, 'Filippa', 'Wasselin', 'Filippa.Was@northeastern.edu', 'Female', 2026, '5580 Lindbergh Pass', '23', '3', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (86, 'Glenn', 'Dundon', 'Glenn.Dun@northeastern.edu', 'Female', 2023, '8 Namekagon Trail', '19', '19', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (87, 'Stephanus', 'Killshaw', 'Stephanus.Kil@northeastern.edu', 'Male', 2025, '44650 New Castle Road', '37', '17', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (88, 'Bryna', 'Lattie', 'Bryna.Lat@northeastern.edu', 'Female', 2025, '0629 Burning Wood Alley', '5', '14', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (89, 'Marrissa', 'Willeson', 'Marrissa.Wil@northeastern.edu', 'Female', 2024, '00604 Sommers Alley', '38', '6', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (90, 'Bennie', 'Garfit', 'Bennie.Gar@northeastern.edu', 'Male', 2026, '20 Vahlen Terrace', '25', '13', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (91, 'Issie', 'Mustill', 'Issie.Mus@northeastern.edu', 'Female', 2025, '4345 Thierer Center', '36', '18', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (92, 'Stern', 'Herculson', 'Stern.Her@northeastern.edu', 'Male', 2025, '759 Elgar Avenue', '18', '9', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (93, 'Durant', 'Hambers', 'Durant.Ham@northeastern.edu', 'Male', 2023, '82 Mifflin Place', '21', '15', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (94, 'Joann', 'Ebrall', 'Joann.Ebr@northeastern.edu', 'Polygender', 2026, '01161 Katie Place', '39', '8', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (95, 'Aeriell', 'Pegden', 'Aeriell.Peg@northeastern.edu', 'Female', 2024, '49 Steensland Drive', '24', '5', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (96, 'Inglebert', 'Patrone', 'Inglebert.Pat@northeastern.edu', 'Male', 2024, '7 Melody Hill', '13', '7', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (97, 'Debera', 'Kiloh', 'Debera.Kil@northeastern.edu', 'Female', 2024, '22281 Melrose Court', '32', '12', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (98, 'Miriam', 'Batchellor', 'Miriam.Bat@northeastern.edu', 'Female', 2023, '0 Toban Road', '30', '1', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (99, 'Editha', 'Boeter', 'Editha.Boe@northeastern.edu', 'Female', 2026, '5 4th Pass', '15', '4', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values (100, 'Doy', 'Mc Pake', 'Doy.Mc @northeastern.edu', 'Male', 2025, '18 Ridgeway Plaza', '9', '10', '4');

insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (1, 'Selene', 'Shaefer', 'Selene.Sha@northeastern.edu', 'Harborview Condos 602', '9');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (2, 'Yvon', 'Witherow', 'Yvon.Wit@northeastern.edu', 'Pinecrest Villas 607', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (3, 'Herbert', 'Von Hindenburg', 'Herbert.Von@northeastern.edu', 'Willow Creek Manor 304', '11');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (4, 'Sigmund', 'Cupper', 'Sigmund.Cup@northeastern.edu', 'Cedar Ridge Estates 200', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (5, 'Tate', 'Lorman', 'Tate.Lor@northeastern.edu', 'Sunset Towers 008', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (6, 'Zola', 'Cursons', 'Zola.Cur@northeastern.edu', 'Rosewood Gardens 906', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (7, 'Ogden', 'Dyhouse', 'Ogden.Dyh@northeastern.edu', 'Harborview Condos 005', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (8, 'Dolph', 'Ianni', 'Dolph.Ian@northeastern.edu', 'Sunset Towers 802', '20');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (9, 'Halley', 'Dissman', 'Halley.Dis@northeastern.edu', 'Maplewood Apartments 509', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (10, 'Sheree', 'Spargo', 'Sheree.Spa@northeastern.edu', 'Willow Creek Manor 204', '4');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (11, 'Belvia', 'Stocking', 'Belvia.Sto@northeastern.edu', 'Sunset Towers 009', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (12, 'Craggy', 'Le Pine', 'Craggy.Le @northeastern.edu', 'Harborview Condos 209', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (13, 'Ofilia', 'Major', 'Ofilia.Maj@northeastern.edu', 'Cedar Ridge Estates 707', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (14, 'Powell', 'Kacheler', 'Powell.Kac@northeastern.edu', 'Oakview Heights 004', '8');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (15, 'Jackqueline', 'Stivani', 'Jackqueline.Sti@northeastern.edu', 'Pinecrest Villas 607', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (16, 'Theo', 'Tromans', 'Theo.Tro@northeastern.edu', 'Willow Creek Manor 702', '1');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (17, 'Umberto', 'Wheatley', 'Umberto.Whe@northeastern.edu', 'Maplewood Apartments 203', '18');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (18, 'Cori', 'Edlestone', 'Cori.Edl@northeastern.edu', 'Harborview Condos 801', '12');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (19, 'Minni', 'Handrok', 'Minni.Han@northeastern.edu', 'Maplewood Apartments 202', '7');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (20, 'Marris', 'Todman', 'Marris.Tod@northeastern.edu', 'Rosewood Gardens 404', '17');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (21, 'Annabela', 'Beaves', 'Annabela.Bea@northeastern.edu', 'Briarwood Manor 100', '12');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (22, 'Elmira', 'Whyte', 'Elmira.Why@northeastern.edu', 'Oakview Heights 609', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (23, 'Mirabel', 'Openshaw', 'Mirabel.Ope@northeastern.edu', 'Cedar Ridge Estates 903', '9');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (24, 'Pier', 'Pechan', 'Pier.Pec@northeastern.edu', 'Cedar Ridge Estates 709', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (25, 'Dwain', 'Mimmack', 'Dwain.Mim@northeastern.edu', 'Cedar Ridge Estates 203', '20');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (26, 'Linzy', 'Corsham', 'Linzy.Cor@northeastern.edu', 'Harborview Condos 908', '7');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (27, 'Alanna', 'Morriss', 'Alanna.Mor@northeastern.edu', 'Oakview Heights 806', '1');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (28, 'Rosamund', 'Goare', 'Rosamund.Goa@northeastern.edu', 'Harborview Condos 509', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (29, 'Filmore', 'Deavall', 'Filmore.Dea@northeastern.edu', 'Maplewood Apartments 209', '8');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (30, 'Tyrone', 'Tubble', 'Tyrone.Tub@northeastern.edu', 'Oakview Heights 201', '4');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (31, 'Florencia', 'Streetley', 'Florencia.Str@northeastern.edu', 'Rosewood Gardens 107', '18');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (32, 'Susy', 'Munkton', 'Susy.Mun@northeastern.edu', 'Meadowbrook Residences 103', '11');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (33, 'Jess', 'Fayers', 'Jess.Fay@northeastern.edu', 'Maplewood Apartments 707', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (34, 'Gert', 'Ivshin', 'Gert.Ivs@northeastern.edu', 'Maplewood Apartments 806', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (35, 'Jordain', 'Plumm', 'Jordain.Plu@northeastern.edu', 'Sunset Towers 002', '17');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (36, 'Rasla', 'Clausius', 'Rasla.Cla@northeastern.edu', 'Willow Creek Manor 703', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (37, 'Dorene', 'Luquet', 'Dorene.Luq@northeastern.edu', 'Briarwood Manor 900', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (38, 'Durant', 'Warbrick', 'Durant.War@northeastern.edu', 'Willow Creek Manor 304', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (39, 'Katusha', 'Baudry', 'Katusha.Bau@northeastern.edu', 'Oakview Heights 002', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (40, 'Kaleena', 'Rodriguez', 'Kaleena.Rod@northeastern.edu', 'Meadowbrook Residences 000', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (41, 'Tisha', 'Nutton', 'Tisha.Nut@northeastern.edu', 'Willow Creek Manor 400', '20');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (42, 'Lauritz', 'Roger', 'Lauritz.Rog@northeastern.edu', 'Pinecrest Villas 807', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (43, 'Shurlock', 'Halfhide', 'Shurlock.Hal@northeastern.edu', 'Oakview Heights 606', '8');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (44, 'Marius', 'Davis', 'Marius.Dav@northeastern.edu', 'Maplewood Apartments 909', '1');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (45, 'Maddy', 'Dunning', 'Maddy.Dun@northeastern.edu', 'Meadowbrook Residences 004', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (46, 'Davis', 'Makinson', 'Davis.Mak@northeastern.edu', 'Sunset Towers 503', '12');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (47, 'Nita', 'Ortells', 'Nita.Ort@northeastern.edu', 'Meadowbrook Residences 000', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (48, 'Winonah', 'Sheivels', 'Winonah.She@northeastern.edu', 'Cedar Ridge Estates 304', '7');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (49, 'Brodie', 'Staresmeare', 'Brodie.Sta@northeastern.edu', 'Briarwood Manor 906', '17');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (50, 'Abigail', 'Harlock', 'Abigail.Har@northeastern.edu', 'Willow Creek Manor 804', '18');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (51, 'Katee', 'Akerman', 'Katee.Ake@northeastern.edu', 'Maplewood Apartments 607', '4');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (52, 'Freddy', 'Pattemore', 'Freddy.Pat@northeastern.edu', 'Sunset Towers 208', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (53, 'Vanessa', 'McCandless', 'Vanessa.McC@northeastern.edu', 'Cedar Ridge Estates 808', '11');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (54, 'Ruth', 'Frowing', 'Ruth.Fro@northeastern.edu', 'Briarwood Manor 701', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (55, 'Susanne', 'MacLachlan', 'Susanne.Mac@northeastern.edu', 'Rosewood Gardens 101', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (56, 'Nicolai', 'Middlemass', 'Nicolai.Mid@northeastern.edu', 'Willow Creek Manor 808', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (57, 'James', 'Fowle', 'James.Fow@northeastern.edu', 'Harborview Condos 201', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (58, 'Koralle', 'Fenimore', 'Koralle.Fen@northeastern.edu', 'Willow Creek Manor 901', '9');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (59, 'Daveen', 'Alden', 'Daveen.Ald@northeastern.edu', 'Sunset Towers 008', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values (60, 'Beverlie', 'Sotheron', 'Beverlie.Sot@northeastern.edu', 'Harborview Condos 200', '5');

insert into course (courseID, name, term, department, professor) values (1, 'Introduction to Computer Science', 'Fall 2023', '7', '14');
insert into course (courseID, name, term, department, professor) values (2, 'English Literature', 'Spring 2023', '13', '57');
insert into course (courseID, name, term, department, professor) values (3, 'Mathematics for Beginners', 'Fall 2023', '18', '1');
insert into course (courseID, name, term, department, professor) values (4, 'Art History', 'Summer I 2023', '6', '21');
insert into course (courseID, name, term, department, professor) values (5, 'Chemistry 101', 'Fall 2023', '15', '25');
insert into course (courseID, name, term, department, professor) values (6, 'Introduction to Psychology', 'Spring 2023', '4', '58');
insert into course (courseID, name, term, department, professor) values (7, 'World History', 'Fall 2023', '2', '2');
insert into course (courseID, name, term, department, professor) values (8, 'Introduction to Philosophy', 'Fall 2023', '3', '16');
insert into course (courseID, name, term, department, professor) values (9, 'Physics for Non-Scientists', 'Spring 2023', '5', '3');
insert into course (courseID, name, term, department, professor) values (10, 'Business Management', 'Spring 2023', '11', '47');
insert into course (courseID, name, term, department, professor) values (11, 'Introduction to Sociology', 'Spring 2023', '16', '45');
insert into course (courseID, name, term, department, professor) values (12, 'Environmental Science', 'Summer I 2023', '10', '6');
insert into course (courseID, name, term, department, professor) values (13, 'Creative Writing', 'Fall 2023', '12', '27');
insert into course (courseID, name, term, department, professor) values (14, 'Introduction to Economics', 'Spring 2023', '19', '24');
insert into course (courseID, name, term, department, professor) values (15, 'Music Appreciation', 'Spring 2023', '9', '56');
insert into course (courseID, name, term, department, professor) values (16, 'Introduction to Marketing', 'Summer I 2023', '1', '35');
insert into course (courseID, name, term, department, professor) values (17, 'Political Science', 'Spring 2023', '17', '44');
insert into course (courseID, name, term, department, professor) values (18, 'Introduction to Anthropology', 'Fall 2023', '20', '8');
insert into course (courseID, name, term, department, professor) values (19, 'Introduction to Statistics', 'Fall 2023', '8', '13');
insert into course (courseID, name, term, department, professor) values (20, 'Film Studies', 'Summer II 2023', '14', '4');
insert into course (courseID, name, term, department, professor) values (21, 'Introduction to Nutrition', 'Fall 2023', '19', '15');
insert into course (courseID, name, term, department, professor) values (22, 'Introduction to Astronomy', 'Summer I 2023', '2', '37');
insert into course (courseID, name, term, department, professor) values (23, 'Physical Education', 'Spring 2023', '15', '50');
insert into course (courseID, name, term, department, professor) values (24, 'Introduction to Linguistics', 'Spring 2023', '17', '30');
insert into course (courseID, name, term, department, professor) values (25, 'Introduction to Geology', 'Fall 2023', '3', '20');
insert into course (courseID, name, term, department, professor) values (26, 'Introduction to Ethics', 'Fall 2023', '8', '33');
insert into course (courseID, name, term, department, professor) values (27, 'Introduction to Film Production', 'Fall 2023', '18', '23');
insert into course (courseID, name, term, department, professor) values (28, 'Introduction to Photography', 'Summer II 2023', '7', '43');
insert into course (courseID, name, term, department, professor) values (29, 'Introduction to Acting', 'Summer I 2023', '11', '48');
insert into course (courseID, name, term, department, professor) values (30, 'Introduction to Dance', 'Summer I 2023', '9', '42');
insert into course (courseID, name, term, department, professor) values (31, 'Introduction to Sculpture', 'Fall 2023', '5', '55');
insert into course (courseID, name, term, department, professor) values (32, 'Introduction to Graphic Design', 'Fall 2023', '13', '54');
insert into course (courseID, name, term, department, professor) values (33, 'Introduction to Web Development', 'Spring 2023', '1', '34');
insert into course (courseID, name, term, department, professor) values (34, 'Introduction to Mobile App Development', 'Fall 2023', '20', '18');
insert into course (courseID, name, term, department, professor) values (35, 'Introduction to Artificial Intelligence', 'Fall 2023', '10', '52');
insert into course (courseID, name, term, department, professor) values (36, 'Introduction to Robotics', 'Summer I 2023', '4', '26');
insert into course (courseID, name, term, department, professor) values (37, 'Introduction to Virtual Reality', 'Fall 2023', '14', '59');
insert into course (courseID, name, term, department, professor) values (38, 'Introduction to Data Science', 'Spring 2023', '6', '60');
insert into course (courseID, name, term, department, professor) values (39, 'Introduction to Machine Learning', 'Spring 2023', '12', '11');
insert into course (courseID, name, term, department, professor) values (40, 'Introduction to Cybersecurity', 'Summer II 2023', '16', '53');
insert into course (courseID, name, term, department, professor) values (41, 'Introduction to Cryptography', 'Summer II 2023', '3', '28');
insert into course (courseID, name, term, department, professor) values (42, 'Introduction to Blockchain', 'Spring 2023', '20', '40');
insert into course (courseID, name, term, department, professor) values (43, 'Introduction to Internet of Things', 'Fall 2023', '11', '19');
insert into course (courseID, name, term, department, professor) values (44, 'Introduction to Cloud Computing', 'Summer I 2023', '2', '39');
insert into course (courseID, name, term, department, professor) values (45, 'Introduction to Big Data', 'Spring 2023', '13', '5');
insert into course (courseID, name, term, department, professor) values (46, 'Introduction to Human-Computer Interaction', 'Spring 2023', '15', '36');
insert into course (courseID, name, term, department, professor) values (47, 'Introduction to User Experience Design', 'Summer II 2023', '6', '41');
insert into course (courseID, name, term, department, professor) values (48, 'Introduction to User Interface Design', 'Summer I 2023', '7', '38');
insert into course (courseID, name, term, department, professor) values (49, 'Introduction to Game Development', 'Fall 2023', '9', '12');
insert into course (courseID, name, term, department, professor) values (50, 'Introduction to Augmented Reality', 'Summer II 2023', '4', '49');
insert into course (courseID, name, term, department, professor) values (51, 'Introduction to Virtual Reality', 'Summer I 2023', '8', '51');
insert into course (courseID, name, term, department, professor) values (52, 'Introduction to 3D Modeling', 'Summer II 2023', '10', '10');
insert into course (courseID, name, term, department, professor) values (53, 'Introduction to Fashion Design', 'Spring 2023', '17', '32');
insert into course (courseID, name, term, department, professor) values (54, 'Introduction to Interior Design', 'Fall 2023', '1', '29');
insert into course (courseID, name, term, department, professor) values (55, 'Introduction to Architecture', 'Summer II 2023', '12', '22');
insert into course (courseID, name, term, department, professor) values (56, 'Introduction to Product Design', 'Spring 2023', '14', '7');
insert into course (courseID, name, term, department, professor) values (57, 'Introduction to Industrial Engineering', 'Fall 2023', '16', '46');
insert into course (courseID, name, term, department, professor) values (58, 'Introduction to Electrical Engineering', 'Fall 2023', '18', '31');
insert into course (courseID, name, term, department, professor) values (59, 'Introduction to Mechanical Engineering', 'Fall 2023', '19', '9');
insert into course (courseID, name, term, department, professor) values (60, 'Introduction to Computer Science', 'Spring 2023', '5', '17');

insert into section (secID, classroom, course) values (1, '56', '41');
insert into section (secID, classroom, course) values (2, '53', '57');
insert into section (secID, classroom, course) values (3, '13', '53');
insert into section (secID, classroom, course) values (4, '24', '36');
insert into section (secID, classroom, course) values (5, '23', '15');
insert into section (secID, classroom, course) values (6, '55', '47');
insert into section (secID, classroom, course) values (7, '22', '30');
insert into section (secID, classroom, course) values (8, '29', '35');
insert into section (secID, classroom, course) values (9, '45', '2');
insert into section (secID, classroom, course) values (10, '36', '46');
insert into section (secID, classroom, course) values (11, '41', '45');
insert into section (secID, classroom, course) values (12, '21', '6');
insert into section (secID, classroom, course) values (13, '58', '11');
insert into section (secID, classroom, course) values (14, '4', '14');
insert into section (secID, classroom, course) values (15, '49', '38');
insert into section (secID, classroom, course) values (16, '28', '3');
insert into section (secID, classroom, course) values (17, '10', '43');
insert into section (secID, classroom, course) values (18, '48', '22');
insert into section (secID, classroom, course) values (19, '42', '10');
insert into section (secID, classroom, course) values (20, '35', '50');

insert into exam (examID, title, section) values (1, 'Mid-term I', '7');
insert into exam (examID, title, section) values (2, 'Final Exam', '1');
insert into exam (examID, title, section) values (3, 'Final Exam', '11');
insert into exam (examID, title, section) values (4, 'Final Exam', '13');
insert into exam (examID, title, section) values (5, 'Mid-term II', '6');
insert into exam (examID, title, section) values (6, 'Mid-term II', '16');
insert into exam (examID, title, section) values (7, 'Final Exam', '18');
insert into exam (examID, title, section) values (8, 'Final Exam', '8');
insert into exam (examID, title, section) values (9, 'Mid-term I', '10');
insert into exam (examID, title, section) values (10, 'Final Exam', '12');
insert into exam (examID, title, section) values (11, 'Mid-term I', '19');
insert into exam (examID, title, section) values (12, 'Final Exam', '3');
insert into exam (examID, title, section) values (13, 'Final Exam', '5');
insert into exam (examID, title, section) values (14, 'Mid-term II', '17');
insert into exam (examID, title, section) values (15, 'Mid-term I', '9');
insert into exam (examID, title, section) values (16, 'Final Exam', '4');
insert into exam (examID, title, section) values (17, 'Mid-term II', '15');
insert into exam (examID, title, section) values (18, 'Mid-term I', '14');
insert into exam (examID, title, section) values (19, 'Mid-term II', '2');
insert into exam (examID, title, section) values (20, 'Mid-term I', '20');
insert into exam (examID, title, section) values (21, 'Mid-term II', '16');
insert into exam (examID, title, section) values (22, 'Mid-term I', '18');
insert into exam (examID, title, section) values (23, 'Mid-term II', '20');
insert into exam (examID, title, section) values (24, 'Mid-term II', '1');
insert into exam (examID, title, section) values (25, 'Mid-term II', '7');
insert into exam (examID, title, section) values (26, 'Mid-term I', '10');
insert into exam (examID, title, section) values (27, 'Final Exam', '6');
insert into exam (examID, title, section) values (28, 'Mid-term II', '3');
insert into exam (examID, title, section) values (29, 'Mid-term I', '13');
insert into exam (examID, title, section) values (30, 'Final Exam', '19');
insert into exam (examID, title, section) values (31, 'Mid-term II', '11');
insert into exam (examID, title, section) values (32, 'Mid-term II', '5');
insert into exam (examID, title, section) values (33, 'Mid-term I', '17');
insert into exam (examID, title, section) values (34, 'Mid-term II', '14');
insert into exam (examID, title, section) values (35, 'Mid-term II', '12');
insert into exam (examID, title, section) values (36, 'Mid-term I', '15');
insert into exam (examID, title, section) values (37, 'Final Exam', '4');
insert into exam (examID, title, section) values (38, 'Mid-term II', '2');
insert into exam (examID, title, section) values (39, 'Final Exam', '9');
insert into exam (examID, title, section) values (40, 'Mid-term I', '8');
insert into exam (examID, title, section) values (41, 'Mid-term I', '2');
insert into exam (examID, title, section) values (42, 'Final Exam', '7');
insert into exam (examID, title, section) values (43, 'Mid-term II', '20');
insert into exam (examID, title, section) values (44, 'Mid-term II', '1');
insert into exam (examID, title, section) values (45, 'Final Exam', '14');
insert into exam (examID, title, section) values (46, 'Mid-term I', '3');
insert into exam (examID, title, section) values (47, 'Mid-term II', '8');
insert into exam (examID, title, section) values (48, 'Final Exam', '13');
insert into exam (examID, title, section) values (49, 'Mid-term I', '15');
insert into exam (examID, title, section) values (50, 'Final Exam', '5');
insert into exam (examID, title, section) values (51, 'Mid-term II', '9');
insert into exam (examID, title, section) values (52, 'Final Exam', '17');
insert into exam (examID, title, section) values (53, 'Mid-term I', '6');
insert into exam (examID, title, section) values (54, 'Mid-term I', '10');
insert into exam (examID, title, section) values (55, 'Final Exam', '4');
insert into exam (examID, title, section) values (56, 'Mid-term II', '12');
insert into exam (examID, title, section) values (57, 'Mid-term I', '19');
insert into exam (examID, title, section) values (58, 'Final Exam', '18');
insert into exam (examID, title, section) values (59, 'Mid-term I', '11');
insert into exam (examID, title, section) values (60, 'Mid-term I', '16');

insert into assignment (assignmentID, title, section) values (1, 'Essay', '7');
insert into assignment (assignmentID, title, section) values (2, 'Discussion Board', '5');
insert into assignment (assignmentID, title, section) values (3, 'HW3', '19');
insert into assignment (assignmentID, title, section) values (4, 'Discussion Board', '15');
insert into assignment (assignmentID, title, section) values (5, 'HW2', '16');
insert into assignment (assignmentID, title, section) values (6, 'HW4', '1');
insert into assignment (assignmentID, title, section) values (7, 'Discussion Board', '13');
insert into assignment (assignmentID, title, section) values (8, 'Project', '14');
insert into assignment (assignmentID, title, section) values (9, 'HW4', '20');
insert into assignment (assignmentID, title, section) values (10, 'Project', '9');
insert into assignment (assignmentID, title, section) values (11, 'HW1', '2');
insert into assignment (assignmentID, title, section) values (12, 'Essay', '8');
insert into assignment (assignmentID, title, section) values (13, 'HW4', '10');
insert into assignment (assignmentID, title, section) values (14, 'HW1', '4');
insert into assignment (assignmentID, title, section) values (15, 'HW4', '12');
insert into assignment (assignmentID, title, section) values (16, 'Project', '17');
insert into assignment (assignmentID, title, section) values (17, 'HW1', '11');
insert into assignment (assignmentID, title, section) values (18, 'Project', '6');
insert into assignment (assignmentID, title, section) values (19, 'Project', '3');
insert into assignment (assignmentID, title, section) values (20, 'HW4', '18');
insert into assignment (assignmentID, title, section) values (21, 'Discussion Board', '20');
insert into assignment (assignmentID, title, section) values (22, 'HW3', '15');
insert into assignment (assignmentID, title, section) values (23, 'Discussion Board', '4');
insert into assignment (assignmentID, title, section) values (24, 'HW2', '2');
insert into assignment (assignmentID, title, section) values (25, 'HW1', '16');
insert into assignment (assignmentID, title, section) values (26, 'Project', '10');
insert into assignment (assignmentID, title, section) values (27, 'HW4', '17');
insert into assignment (assignmentID, title, section) values (28, 'Project', '7');
insert into assignment (assignmentID, title, section) values (29, 'HW2', '5');
insert into assignment (assignmentID, title, section) values (30, 'HW2', '13');
insert into assignment (assignmentID, title, section) values (31, 'HW1', '8');
insert into assignment (assignmentID, title, section) values (32, 'Essay', '1');
insert into assignment (assignmentID, title, section) values (33, 'HW1', '6');
insert into assignment (assignmentID, title, section) values (34, 'HW1', '19');
insert into assignment (assignmentID, title, section) values (35, 'Essay', '12');
insert into assignment (assignmentID, title, section) values (36, 'Essay', '9');
insert into assignment (assignmentID, title, section) values (37, 'HW1', '11');
insert into assignment (assignmentID, title, section) values (38, 'Discussion Board', '3');
insert into assignment (assignmentID, title, section) values (39, 'Project', '18');
insert into assignment (assignmentID, title, section) values (40, 'Essay', '14');
insert into assignment (assignmentID, title, section) values (41, 'Project', '6');
insert into assignment (assignmentID, title, section) values (42, 'Essay', '19');
insert into assignment (assignmentID, title, section) values (43, 'HW3', '12');
insert into assignment (assignmentID, title, section) values (44, 'Discussion Board', '15');
insert into assignment (assignmentID, title, section) values (45, 'Essay', '20');
insert into assignment (assignmentID, title, section) values (46, 'HW1', '14');
insert into assignment (assignmentID, title, section) values (47, 'Discussion Board', '1');
insert into assignment (assignmentID, title, section) values (48, 'HW2', '10');
insert into assignment (assignmentID, title, section) values (49, 'HW3', '18');
insert into assignment (assignmentID, title, section) values (50, 'HW2', '4');
insert into assignment (assignmentID, title, section) values (51, 'HW4', '3');
insert into assignment (assignmentID, title, section) values (52, 'HW2', '11');
insert into assignment (assignmentID, title, section) values (53, 'Discussion Board', '16');
insert into assignment (assignmentID, title, section) values (54, 'HW4', '8');
insert into assignment (assignmentID, title, section) values (55, 'Project', '7');
insert into assignment (assignmentID, title, section) values (56, 'Discussion Board', '9');
insert into assignment (assignmentID, title, section) values (57, 'Discussion Board', '5');
insert into assignment (assignmentID, title, section) values (58, 'HW1', '13');
insert into assignment (assignmentID, title, section) values (59, 'Project', '17');
insert into assignment (assignmentID, title, section) values (60, 'HW3', '2');

insert into students_in_section (courseGrade, section, student) values ('B', '2', '21');
insert into students_in_section (courseGrade, section, student) values ('B', '20', '39');
insert into students_in_section (courseGrade, section, student) values ('A', '18', '77');
insert into students_in_section (courseGrade, section, student) values ('F', '10', '18');
insert into students_in_section (courseGrade, section, student) values ('F', '8', '2');
insert into students_in_section (courseGrade, section, student) values ('C', '4', '13');
insert into students_in_section (courseGrade, section, student) values ('A', '6', '85');
insert into students_in_section (courseGrade, section, student) values ('D', '17', '58');
insert into students_in_section (courseGrade, section, student) values ('D', '13', '73');
insert into students_in_section (courseGrade, section, student) values ('C', '15', '36');
insert into students_in_section (courseGrade, section, student) values ('D', '1', '8');
insert into students_in_section (courseGrade, section, student) values ('A', '3', '54');
insert into students_in_section (courseGrade, section, student) values ('B', '19', '86');
insert into students_in_section (courseGrade, section, student) values ('F', '11', '11');
insert into students_in_section (courseGrade, section, student) values ('C', '5', '34');
insert into students_in_section (courseGrade, section, student) values ('F', '14', '47');
insert into students_in_section (courseGrade, section, student) values ('F', '9', '32');
insert into students_in_section (courseGrade, section, student) values ('D', '7', '29');
insert into students_in_section (courseGrade, section, student) values ('F', '16', '30');
insert into students_in_section (courseGrade, section, student) values ('A', '12', '95');
insert into students_in_section (courseGrade, section, student) values ('C', '12', '63');
insert into students_in_section (courseGrade, section, student) values ('C', '4', '71');
insert into students_in_section (courseGrade, section, student) values ('D', '1', '83');
insert into students_in_section (courseGrade, section, student) values ('F', '5', '78');
insert into students_in_section (courseGrade, section, student) values ('D', '10', '5');
insert into students_in_section (courseGrade, section, student) values ('F', '7', '80');
insert into students_in_section (courseGrade, section, student) values ('A', '6', '98');
insert into students_in_section (courseGrade, section, student) values ('F', '19', '25');
insert into students_in_section (courseGrade, section, student) values ('C', '2', '76');
insert into students_in_section (courseGrade, section, student) values ('D', '20', '42');
insert into students_in_section (courseGrade, section, student) values ('F', '13', '66');
insert into students_in_section (courseGrade, section, student) values ('D', '18', '3');
insert into students_in_section (courseGrade, section, student) values ('B', '3', '15');
insert into students_in_section (courseGrade, section, student) values ('D', '17', '37');
insert into students_in_section (courseGrade, section, student) values ('B', '9', '89');
insert into students_in_section (courseGrade, section, student) values ('B', '16', '97');
insert into students_in_section (courseGrade, section, student) values ('D', '14', '20');
insert into students_in_section (courseGrade, section, student) values ('A', '8', '91');
insert into students_in_section (courseGrade, section, student) values ('C', '11', '69');
insert into students_in_section (courseGrade, section, student) values ('A', '15', '43');
insert into students_in_section (courseGrade, section, student) values ('C', '14', '49');
insert into students_in_section (courseGrade, section, student) values ('C', '11', '14');
insert into students_in_section (courseGrade, section, student) values ('B', '2', '72');
insert into students_in_section (courseGrade, section, student) values ('C', '3', '94');
insert into students_in_section (courseGrade, section, student) values ('A', '15', '12');
insert into students_in_section (courseGrade, section, student) values ('D', '10', '48');
insert into students_in_section (courseGrade, section, student) values ('B', '6', '60');
insert into students_in_section (courseGrade, section, student) values ('C', '5', '23');
insert into students_in_section (courseGrade, section, student) values ('D', '13', '65');
insert into students_in_section (courseGrade, section, student) values ('D', '1', '35');
insert into students_in_section (courseGrade, section, student) values ('B', '8', '1');
insert into students_in_section (courseGrade, section, student) values ('A', '7', '79');
insert into students_in_section (courseGrade, section, student) values ('C', '16', '19');
insert into students_in_section (courseGrade, section, student) values ('B', '17', '7');
insert into students_in_section (courseGrade, section, student) values ('F', '4', '64');
insert into students_in_section (courseGrade, section, student) values ('D', '18', '75');
insert into students_in_section (courseGrade, section, student) values ('C', '20', '56');
insert into students_in_section (courseGrade, section, student) values ('D', '9', '9');
insert into students_in_section (courseGrade, section, student) values ('F', '12', '24');
insert into students_in_section (courseGrade, section, student) values ('A', '19', '59');
insert into students_in_section (courseGrade, section, student) values ('D', '17', '61');
insert into students_in_section (courseGrade, section, student) values ('C', '20', '51');
insert into students_in_section (courseGrade, section, student) values ('B', '8', '62');
insert into students_in_section (courseGrade, section, student) values ('F', '16', '93');
insert into students_in_section (courseGrade, section, student) values ('C', '3', '33');
insert into students_in_section (courseGrade, section, student) values ('D', '11', '40');
insert into students_in_section (courseGrade, section, student) values ('F', '6', '45');
insert into students_in_section (courseGrade, section, student) values ('C', '2', '55');
insert into students_in_section (courseGrade, section, student) values ('F', '9', '10');
insert into students_in_section (courseGrade, section, student) values ('B', '13', '41');
insert into students_in_section (courseGrade, section, student) values ('C', '15', '99');
insert into students_in_section (courseGrade, section, student) values ('F', '1', '88');
insert into students_in_section (courseGrade, section, student) values ('C', '5', '22');
insert into students_in_section (courseGrade, section, student) values ('A', '10', '100');
insert into students_in_section (courseGrade, section, student) values ('F', '7', '26');
insert into students_in_section (courseGrade, section, student) values ('C', '12', '4');
insert into students_in_section (courseGrade, section, student) values ('A', '18', '38');
insert into students_in_section (courseGrade, section, student) values ('F', '4', '81');
insert into students_in_section (courseGrade, section, student) values ('C', '19', '70');
insert into students_in_section (courseGrade, section, student) values ('C', '14', '6');
insert into students_in_section (courseGrade, section, student) values ('B', '14', '52');
insert into students_in_section (courseGrade, section, student) values ('D', '3', '50');
insert into students_in_section (courseGrade, section, student) values ('F', '8', '96');
insert into students_in_section (courseGrade, section, student) values ('F', '12', '17');
insert into students_in_section (courseGrade, section, student) values ('C', '4', '16');
insert into students_in_section (courseGrade, section, student) values ('A', '17', '28');
insert into students_in_section (courseGrade, section, student) values ('C', '20', '82');
insert into students_in_section (courseGrade, section, student) values ('A', '6', '68');
insert into students_in_section (courseGrade, section, student) values ('B', '9', '92');
insert into students_in_section (courseGrade, section, student) values ('D', '16', '57');
insert into students_in_section (courseGrade, section, student) values ('D', '2', '31');
insert into students_in_section (courseGrade, section, student) values ('D', '19', '67');
insert into students_in_section (courseGrade, section, student) values ('D', '1', '87');
insert into students_in_section (courseGrade, section, student) values ('F', '18', '27');
insert into students_in_section (courseGrade, section, student) values ('F', '7', '44');
insert into students_in_section (courseGrade, section, student) values ('C', '11', '53');
insert into students_in_section (courseGrade, section, student) values ('C', '15', '46');
insert into students_in_section (courseGrade, section, student) values ('A', '5', '74');
insert into students_in_section (courseGrade, section, student) values ('C', '10', '90');
insert into students_in_section (courseGrade, section, student) values ('C', '13', '31');

insert into exam_grades (examGrade, exam, student) values (94, '55', '59');
insert into exam_grades (examGrade, exam, student) values (24, '50', '56');
insert into exam_grades (examGrade, exam, student) values (24, '49', '5');
insert into exam_grades (examGrade, exam, student) values (2, '44', '61');
insert into exam_grades (examGrade, exam, student) values (95, '40', '57');
insert into exam_grades (examGrade, exam, student) values (54, '47', '52');
insert into exam_grades (examGrade, exam, student) values (32, '16', '54');
insert into exam_grades (examGrade, exam, student) values (24, '25', '86');
insert into exam_grades (examGrade, exam, student) values (45, '56', '38');
insert into exam_grades (examGrade, exam, student) values (34, '20', '28');
insert into exam_grades (examGrade, exam, student) values (45, '24', '80');
insert into exam_grades (examGrade, exam, student) values (98, '31', '63');
insert into exam_grades (examGrade, exam, student) values (25, '18', '100');
insert into exam_grades (examGrade, exam, student) values (6, '37', '9');
insert into exam_grades (examGrade, exam, student) values (24, '11', '78');
insert into exam_grades (examGrade, exam, student) values (39, '2', '49');
insert into exam_grades (examGrade, exam, student) values (3, '7', '82');
insert into exam_grades (examGrade, exam, student) values (90, '58', '84');
insert into exam_grades (examGrade, exam, student) values (48, '43', '16');
insert into exam_grades (examGrade, exam, student) values (66, '34', '66');
insert into exam_grades (examGrade, exam, student) values (52, '57', '26');
insert into exam_grades (examGrade, exam, student) values (36, '33', '91');
insert into exam_grades (examGrade, exam, student) values (9, '51', '77');
insert into exam_grades (examGrade, exam, student) values (95, '54', '4');
insert into exam_grades (examGrade, exam, student) values (94, '23', '17');
insert into exam_grades (examGrade, exam, student) values (19, '9', '15');
insert into exam_grades (examGrade, exam, student) values (22, '8', '87');
insert into exam_grades (examGrade, exam, student) values (62, '52', '72');
insert into exam_grades (examGrade, exam, student) values (75, '21', '90');
insert into exam_grades (examGrade, exam, student) values (20, '22', '44');
insert into exam_grades (examGrade, exam, student) values (68, '53', '88');
insert into exam_grades (examGrade, exam, student) values (88, '14', '31');
insert into exam_grades (examGrade, exam, student) values (32, '4', '67');
insert into exam_grades (examGrade, exam, student) values (86, '6', '48');
insert into exam_grades (examGrade, exam, student) values (7, '10', '42');
insert into exam_grades (examGrade, exam, student) values (70, '41', '74');
insert into exam_grades (examGrade, exam, student) values (93, '27', '18');
insert into exam_grades (examGrade, exam, student) values (36, '28', '70');
insert into exam_grades (examGrade, exam, student) values (24, '48', '92');
insert into exam_grades (examGrade, exam, student) values (0, '19', '2');
insert into exam_grades (examGrade, exam, student) values (15, '15', '68');
insert into exam_grades (examGrade, exam, student) values (66, '32', '96');
insert into exam_grades (examGrade, exam, student) values (74, '3', '53');
insert into exam_grades (examGrade, exam, student) values (48, '42', '95');
insert into exam_grades (examGrade, exam, student) values (92, '60', '81');
insert into exam_grades (examGrade, exam, student) values (59, '46', '24');
insert into exam_grades (examGrade, exam, student) values (57, '5', '46');
insert into exam_grades (examGrade, exam, student) values (66, '26', '75');
insert into exam_grades (examGrade, exam, student) values (12, '35', '19');
insert into exam_grades (examGrade, exam, student) values (79, '45', '51');
insert into exam_grades (examGrade, exam, student) values (10, '13', '89');
insert into exam_grades (examGrade, exam, student) values (25, '30', '65');
insert into exam_grades (examGrade, exam, student) values (4, '1', '43');
insert into exam_grades (examGrade, exam, student) values (11, '29', '83');
insert into exam_grades (examGrade, exam, student) values (90, '17', '7');
insert into exam_grades (examGrade, exam, student) values (11, '59', '21');
insert into exam_grades (examGrade, exam, student) values (25, '38', '37');
insert into exam_grades (examGrade, exam, student) values (55, '36', '64');
insert into exam_grades (examGrade, exam, student) values (55, '39', '14');
insert into exam_grades (examGrade, exam, student) values (80, '12', '33');
insert into exam_grades (examGrade, exam, student) values (97, '21', '55');
insert into exam_grades (examGrade, exam, student) values (12, '53', '6');
insert into exam_grades (examGrade, exam, student) values (67, '5', '98');
insert into exam_grades (examGrade, exam, student) values (23, '45', '23');
insert into exam_grades (examGrade, exam, student) values (74, '44', '29');
insert into exam_grades (examGrade, exam, student) values (49, '2', '35');
insert into exam_grades (examGrade, exam, student) values (81, '26', '11');
insert into exam_grades (examGrade, exam, student) values (83, '17', '32');
insert into exam_grades (examGrade, exam, student) values (78, '47', '22');
insert into exam_grades (examGrade, exam, student) values (1, '51', '45');
insert into exam_grades (examGrade, exam, student) values (10, '8', '71');
insert into exam_grades (examGrade, exam, student) values (80, '4', '69');
insert into exam_grades (examGrade, exam, student) values (82, '46', '20');
insert into exam_grades (examGrade, exam, student) values (42, '24', '8');
insert into exam_grades (examGrade, exam, student) values (60, '42', '30');
insert into exam_grades (examGrade, exam, student) values (66, '32', '62');
insert into exam_grades (examGrade, exam, student) values (28, '48', '47');
insert into exam_grades (examGrade, exam, student) values (29, '33', '39');
insert into exam_grades (examGrade, exam, student) values (58, '36', '97');
insert into exam_grades (examGrade, exam, student) values (78, '27', '36');
insert into exam_grades (examGrade, exam, student) values (88, '25', '85');
insert into exam_grades (examGrade, exam, student) values (95, '13', '73');
insert into exam_grades (examGrade, exam, student) values (88, '16', '12');
insert into exam_grades (examGrade, exam, student) values (3, '14', '93');
insert into exam_grades (examGrade, exam, student) values (19, '30', '13');
insert into exam_grades (examGrade, exam, student) values (19, '12', '60');
insert into exam_grades (examGrade, exam, student) values (39, '18', '34');
insert into exam_grades (examGrade, exam, student) values (38, '57', '3');
insert into exam_grades (examGrade, exam, student) values (14, '7', '10');
insert into exam_grades (examGrade, exam, student) values (58, '35', '41');
insert into exam_grades (examGrade, exam, student) values (37, '9', '79');
insert into exam_grades (examGrade, exam, student) values (38, '38', '99');
insert into exam_grades (examGrade, exam, student) values (34, '58', '76');
insert into exam_grades (examGrade, exam, student) values (79, '6', '94');
insert into exam_grades (examGrade, exam, student) values (12, '28', '40');
insert into exam_grades (examGrade, exam, student) values (3, '19', '50');
insert into exam_grades (examGrade, exam, student) values (7, '39', '1');
insert into exam_grades (examGrade, exam, student) values (25, '59', '25');
insert into exam_grades (examGrade, exam, student) values (99, '52', '27');
insert into exam_grades (examGrade, exam, student) values (8, '29', '58');

insert into assignment_grades (assignmentGrade, assignment, student) values (9, '49', '87');
insert into assignment_grades (assignmentGrade, assignment, student) values (82, '5', '37');
insert into assignment_grades (assignmentGrade, assignment, student) values (0, '54', '89');
insert into assignment_grades (assignmentGrade, assignment, student) values (89, '56', '63');
insert into assignment_grades (assignmentGrade, assignment, student) values (18, '13', '33');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '30', '35');
insert into assignment_grades (assignmentGrade, assignment, student) values (39, '29', '1');
insert into assignment_grades (assignmentGrade, assignment, student) values (56, '47', '92');
insert into assignment_grades (assignmentGrade, assignment, student) values (86, '55', '46');
insert into assignment_grades (assignmentGrade, assignment, student) values (50, '26', '39');
insert into assignment_grades (assignmentGrade, assignment, student) values (29, '48', '88');
insert into assignment_grades (assignmentGrade, assignment, student) values (77, '10', '72');
insert into assignment_grades (assignmentGrade, assignment, student) values (56, '36', '78');
insert into assignment_grades (assignmentGrade, assignment, student) values (65, '12', '93');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '50', '100');
insert into assignment_grades (assignmentGrade, assignment, student) values (86, '32', '56');
insert into assignment_grades (assignmentGrade, assignment, student) values (55, '15', '18');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '39', '20');
insert into assignment_grades (assignmentGrade, assignment, student) values (12, '3', '64');
insert into assignment_grades (assignmentGrade, assignment, student) values (12, '43', '4');
insert into assignment_grades (assignmentGrade, assignment, student) values (48, '40', '84');
insert into assignment_grades (assignmentGrade, assignment, student) values (77, '52', '76');
insert into assignment_grades (assignmentGrade, assignment, student) values (63, '33', '55');
insert into assignment_grades (assignmentGrade, assignment, student) values (49, '24', '96');
insert into assignment_grades (assignmentGrade, assignment, student) values (72, '45', '99');
insert into assignment_grades (assignmentGrade, assignment, student) values (94, '14', '12');
insert into assignment_grades (assignmentGrade, assignment, student) values (73, '22', '79');
insert into assignment_grades (assignmentGrade, assignment, student) values (10, '6', '91');
insert into assignment_grades (assignmentGrade, assignment, student) values (59, '27', '26');
insert into assignment_grades (assignmentGrade, assignment, student) values (83, '51', '51');
insert into assignment_grades (assignmentGrade, assignment, student) values (94, '20', '36');
insert into assignment_grades (assignmentGrade, assignment, student) values (55, '8', '73');
insert into assignment_grades (assignmentGrade, assignment, student) values (18, '57', '53');
insert into assignment_grades (assignmentGrade, assignment, student) values (61, '28', '67');
insert into assignment_grades (assignmentGrade, assignment, student) values (42, '9', '71');
insert into assignment_grades (assignmentGrade, assignment, student) values (19, '11', '59');
insert into assignment_grades (assignmentGrade, assignment, student) values (74, '38', '66');
insert into assignment_grades (assignmentGrade, assignment, student) values (19, '21', '21');
insert into assignment_grades (assignmentGrade, assignment, student) values (99, '16', '95');
insert into assignment_grades (assignmentGrade, assignment, student) values (65, '4', '13');
insert into assignment_grades (assignmentGrade, assignment, student) values (22, '7', '75');
insert into assignment_grades (assignmentGrade, assignment, student) values (13, '53', '98');
insert into assignment_grades (assignmentGrade, assignment, student) values (97, '46', '43');
insert into assignment_grades (assignmentGrade, assignment, student) values (39, '25', '14');
insert into assignment_grades (assignmentGrade, assignment, student) values (30, '23', '83');
insert into assignment_grades (assignmentGrade, assignment, student) values (93, '31', '38');
insert into assignment_grades (assignmentGrade, assignment, student) values (36, '35', '62');
insert into assignment_grades (assignmentGrade, assignment, student) values (46, '59', '7');
insert into assignment_grades (assignmentGrade, assignment, student) values (70, '44', '57');
insert into assignment_grades (assignmentGrade, assignment, student) values (14, '34', '80');
insert into assignment_grades (assignmentGrade, assignment, student) values (28, '1', '32');
insert into assignment_grades (assignmentGrade, assignment, student) values (8, '60', '6');
insert into assignment_grades (assignmentGrade, assignment, student) values (82, '42', '2');
insert into assignment_grades (assignmentGrade, assignment, student) values (14, '19', '28');
insert into assignment_grades (assignmentGrade, assignment, student) values (64, '58', '27');
insert into assignment_grades (assignmentGrade, assignment, student) values (91, '17', '49');
insert into assignment_grades (assignmentGrade, assignment, student) values (35, '2', '60');
insert into assignment_grades (assignmentGrade, assignment, student) values (58, '18', '58');
insert into assignment_grades (assignmentGrade, assignment, student) values (25, '37', '81');
insert into assignment_grades (assignmentGrade, assignment, student) values (50, '41', '86');
insert into assignment_grades (assignmentGrade, assignment, student) values (33, '24', '70');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '42', '15');
insert into assignment_grades (assignmentGrade, assignment, student) values (42, '6', '90');
insert into assignment_grades (assignmentGrade, assignment, student) values (31, '36', '11');
insert into assignment_grades (assignmentGrade, assignment, student) values (65, '56', '19');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '35', '29');
insert into assignment_grades (assignmentGrade, assignment, student) values (82, '28', '30');
insert into assignment_grades (assignmentGrade, assignment, student) values (33, '15', '5');
insert into assignment_grades (assignmentGrade, assignment, student) values (44, '13', '10');
insert into assignment_grades (assignmentGrade, assignment, student) values (89, '30', '42');
insert into assignment_grades (assignmentGrade, assignment, student) values (8, '50', '77');
insert into assignment_grades (assignmentGrade, assignment, student) values (46, '58', '45');
insert into assignment_grades (assignmentGrade, assignment, student) values (53, '57', '48');
insert into assignment_grades (assignmentGrade, assignment, student) values (85, '47', '65');
insert into assignment_grades (assignmentGrade, assignment, student) values (55, '32', '61');
insert into assignment_grades (assignmentGrade, assignment, student) values (51, '31', '68');
insert into assignment_grades (assignmentGrade, assignment, student) values (48, '45', '52');
insert into assignment_grades (assignmentGrade, assignment, student) values (76, '53', '23');
insert into assignment_grades (assignmentGrade, assignment, student) values (33, '44', '82');
insert into assignment_grades (assignmentGrade, assignment, student) values (20, '59', '74');
insert into assignment_grades (assignmentGrade, assignment, student) values (23, '22', '47');
insert into assignment_grades (assignmentGrade, assignment, student) values (69, '29', '94');
insert into assignment_grades (assignmentGrade, assignment, student) values (86, '2', '25');
insert into assignment_grades (assignmentGrade, assignment, student) values (46, '21', '31');
insert into assignment_grades (assignmentGrade, assignment, student) values (15, '43', '9');
insert into assignment_grades (assignmentGrade, assignment, student) values (87, '38', '24');
insert into assignment_grades (assignmentGrade, assignment, student) values (3, '9', '8');
insert into assignment_grades (assignmentGrade, assignment, student) values (32, '7', '69');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '26', '54');
insert into assignment_grades (assignmentGrade, assignment, student) values (11, '37', '50');
insert into assignment_grades (assignmentGrade, assignment, student) values (84, '46', '97');
insert into assignment_grades (assignmentGrade, assignment, student) values (51, '23', '41');
insert into assignment_grades (assignmentGrade, assignment, student) values (80, '25', '16');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '27', '3');
insert into assignment_grades (assignmentGrade, assignment, student) values (12, '40', '34');
insert into assignment_grades (assignmentGrade, assignment, student) values (74, '55', '44');
insert into assignment_grades (assignmentGrade, assignment, student) values (31, '11', '17');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '16', '22');
insert into assignment_grades (assignmentGrade, assignment, student) values (16, '12', '40');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '5', '85');

insert into major_courses (major, course) values ('21', '52');
insert into major_courses (major, course) values ('26', '49');
insert into major_courses (major, course) values ('19', '41');
insert into major_courses (major, course) values ('25', '8');
insert into major_courses (major, course) values ('18', '38');
insert into major_courses (major, course) values ('14', '57');
insert into major_courses (major, course) values ('9', '48');
insert into major_courses (major, course) values ('7', '36');
insert into major_courses (major, course) values ('1', '59');
insert into major_courses (major, course) values ('16', '31');
insert into major_courses (major, course) values ('4', '29');
insert into major_courses (major, course) values ('22', '33');
insert into major_courses (major, course) values ('5', '25');
insert into major_courses (major, course) values ('3', '32');
insert into major_courses (major, course) values ('13', '55');
insert into major_courses (major, course) values ('17', '26');
insert into major_courses (major, course) values ('27', '6');
insert into major_courses (major, course) values ('29', '54');
insert into major_courses (major, course) values ('10', '39');
insert into major_courses (major, course) values ('28', '12');
insert into major_courses (major, course) values ('23', '53');
insert into major_courses (major, course) values ('20', '37');
insert into major_courses (major, course) values ('11', '42');
insert into major_courses (major, course) values ('12', '44');
insert into major_courses (major, course) values ('30', '35');
insert into major_courses (major, course) values ('2', '10');
insert into major_courses (major, course) values ('8', '24');
insert into major_courses (major, course) values ('15', '15');
insert into major_courses (major, course) values ('6', '14');
insert into major_courses (major, course) values ('24', '27');
insert into major_courses (major, course) values ('2', '3');
insert into major_courses (major, course) values ('3', '50');
insert into major_courses (major, course) values ('28', '5');
insert into major_courses (major, course) values ('14', '56');
insert into major_courses (major, course) values ('1', '20');
insert into major_courses (major, course) values ('11', '2');
insert into major_courses (major, course) values ('18', '17');
insert into major_courses (major, course) values ('22', '21');
insert into major_courses (major, course) values ('26', '34');
insert into major_courses (major, course) values ('21', '13');
insert into major_courses (major, course) values ('25', '40');
insert into major_courses (major, course) values ('10', '4');
insert into major_courses (major, course) values ('17', '1');
insert into major_courses (major, course) values ('4', '45');
insert into major_courses (major, course) values ('7', '16');
insert into major_courses (major, course) values ('13', '60');
insert into major_courses (major, course) values ('30', '7');
insert into major_courses (major, course) values ('12', '11');
insert into major_courses (major, course) values ('29', '22');
insert into major_courses (major, course) values ('19', '30');
insert into major_courses (major, course) values ('27', '47');
insert into major_courses (major, course) values ('15', '58');
insert into major_courses (major, course) values ('6', '46');
insert into major_courses (major, course) values ('5', '28');
insert into major_courses (major, course) values ('8', '51');
insert into major_courses (major, course) values ('23', '9');
insert into major_courses (major, course) values ('20', '23');
insert into major_courses (major, course) values ('24', '18');
insert into major_courses (major, course) values ('9', '43');
insert into major_courses (major, course) values ('16', '19');
insert into major_courses (major, course) values ('1', '27');
insert into major_courses (major, course) values ('10', '7');
insert into major_courses (major, course) values ('15', '18');
insert into major_courses (major, course) values ('4', '23');
insert into major_courses (major, course) values ('2', '4');
insert into major_courses (major, course) values ('28', '12');
insert into major_courses (major, course) values ('20', '33');
insert into major_courses (major, course) values ('25', '37');
insert into major_courses (major, course) values ('13', '54');
insert into major_courses (major, course) values ('8', '38');
insert into major_courses (major, course) values ('27', '6');
insert into major_courses (major, course) values ('18', '15');
insert into major_courses (major, course) values ('9', '13');
insert into major_courses (major, course) values ('19', '10');
insert into major_courses (major, course) values ('21', '17');
insert into major_courses (major, course) values ('6', '24');
insert into major_courses (major, course) values ('26', '40');
insert into major_courses (major, course) values ('11', '20');
insert into major_courses (major, course) values ('14', '35');
insert into major_courses (major, course) values ('7', '25');
insert into major_courses (major, course) values ('29', '5');
insert into major_courses (major, course) values ('5', '11');
insert into major_courses (major, course) values ('30', '29');
insert into major_courses (major, course) values ('22', '46');
insert into major_courses (major, course) values ('3', '28');
insert into major_courses (major, course) values ('23', '34');
insert into major_courses (major, course) values ('12', '26');
insert into major_courses (major, course) values ('16', '42');
insert into major_courses (major, course) values ('17', '52');
insert into major_courses (major, course) values ('24', '2');
insert into major_courses (major, course) values ('17', '22');
insert into major_courses (major, course) values ('15', '47');
insert into major_courses (major, course) values ('2', '8');
insert into major_courses (major, course) values ('16', '14');
insert into major_courses (major, course) values ('13', '60');
insert into major_courses (major, course) values ('11', '19');
insert into major_courses (major, course) values ('8', '36');
insert into major_courses (major, course) values ('27', '50');
insert into major_courses (major, course) values ('26', '48');
insert into major_courses (major, course) values ('30', '16');
