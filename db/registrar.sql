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


insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('13724310', 'Jocelin', 'Horrell', 'Jocelin.Hor@northeastern.edu', 'Petronas Towers 409', '15:14');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('73943441', 'Ethe', 'Urey', 'Ethe.Ure@northeastern.edu', 'Petronas Towers 206', '13:46');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('53839483', 'Kary', 'Malinson', 'Kary.Mal@northeastern.edu', 'Petronas Towers 701', '13:57');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('19938244', 'Marybeth', 'Fink', 'Marybeth.Fin@northeastern.edu', 'Taipei 101 402', '14:04');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('59901233', 'Amie', 'Whitelaw', 'Amie.Whi@northeastern.edu', 'Taipei 101 500', '14:27');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('11369344', 'Kingsly', 'Pittaway', 'Kingsly.Pit@northeastern.edu', 'One World Trade Center 409', '10:58');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('79310642', 'Addy', 'Farquharson', 'Addy.Far@northeastern.edu', 'Abraj Al-Bait Clock Tower 801', '12:57');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('88360206', 'Hetti', 'Gerling', 'Hetti.Ger@northeastern.edu', 'Burj Khalifa 802', '10:51');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('84417763', 'Horten', 'Armstead', 'Horten.Arm@northeastern.edu', 'Tokyo Skytree 806', '11:59');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('86026455', 'Nadiya', 'Bramford', 'Nadiya.Bra@northeastern.edu', 'Burj Khalifa 207', '10:18');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('32759435', 'Salvador', 'Poppy', 'Salvador.Pop@northeastern.edu', 'CN Tower 407', '13:41');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('56548694', 'Ruthe', 'Brownstein', 'Ruthe.Bro@northeastern.edu', 'Empire State Building 001', '10:24');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('65890831', 'Rene', 'Epdell', 'Rene.Epd@northeastern.edu', 'Taipei 101 102', '13:31');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('48374151', 'Corette', 'Trumble', 'Corette.Tru@northeastern.edu', 'Petronas Towers 702', '11:03');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('46984406', 'Geoffrey', 'Poland', 'Geoffrey.Pol@northeastern.edu', 'Petronas Towers 703', '16:21');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('68480468', 'Beryle', 'Allgood', 'Beryle.All@northeastern.edu', 'Empire State Building 302', '15:57');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('34165798', 'Lorita', 'Gingle', 'Lorita.Gin@northeastern.edu', 'Taipei 101 606', '9:07');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('23256967', 'Godfree', 'Langeley', 'Godfree.Lan@northeastern.edu', 'Abraj Al-Bait Clock Tower 103', '16:53');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('43880067', 'Bronnie', 'Spracklin', 'Bronnie.Spr@northeastern.edu', 'Petronas Towers 804', '9:14');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('39809383', 'Ike', 'Castagnet', 'Ike.Cas@northeastern.edu', 'CN Tower 004', '11:47');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('89176463', 'Ted', 'Heaney', 'Ted.Hea@northeastern.edu', 'Empire State Building 609', '12:20');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('53646309', 'Silvia', 'Bagg', 'Silvia.Bag@northeastern.edu', 'Abraj Al-Bait Clock Tower 408', '12:09');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('83231498', 'Dorelia', 'Hartridge', 'Dorelia.Har@northeastern.edu', 'Shanghai Tower 400', '11:59');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('57085729', 'Carmen', 'Castelot', 'Carmen.Cas@northeastern.edu', 'Abraj Al-Bait Clock Tower 506', '14:09');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('47078860', 'Elias', 'Antonomoli', 'Elias.Ant@northeastern.edu', 'Petronas Towers 100', '13:21');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('63455560', 'Brantley', 'Lamswood', 'Brantley.Lam@northeastern.edu', 'Taipei 101 603', '12:13');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('26515678', 'Stacee', 'Von Brook', 'Stacee.Von@northeastern.edu', 'Taipei 101 209', '10:06');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('86369505', 'Hallsy', 'Hurne', 'Hallsy.Hur@northeastern.edu', 'Empire State Building 006', '13:10');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('88315318', 'Shirley', 'Downe', 'Shirley.Dow@northeastern.edu', 'Abraj Al-Bait Clock Tower 007', '9:48');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('74410000', 'Ted', 'Aizikowitz', 'Ted.Aiz@northeastern.edu', 'CN Tower 601', '16:16');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('90271100', 'Tarrah', 'Halloran', 'Tarrah.Hal@northeastern.edu', 'Petronas Towers 104', '9:51');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('74120860', 'Gaby', 'Jiri', 'Gaby.Jir@northeastern.edu', 'Taipei 101 503', '12:18');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('28704782', 'Jeffrey', 'Morsom', 'Jeffrey.Mor@northeastern.edu', 'Burj Khalifa 201', '13:29');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('50292471', 'Dory', 'Sanders', 'Dory.San@northeastern.edu', 'Empire State Building 701', '13:46');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('31897750', 'Michaeline', 'Waker', 'Michaeline.Wak@northeastern.edu', 'Taipei 101 305', '14:59');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('24972523', 'Nettle', 'Davidovitz', 'Nettle.Dav@northeastern.edu', 'Empire State Building 000', '9:28');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('82550658', 'Solly', 'Aves', 'Solly.Ave@northeastern.edu', 'Tokyo Skytree 504', '12:45');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('23609378', 'Odie', 'Stork', 'Odie.Sto@northeastern.edu', 'Tokyo Skytree 309', '16:26');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('50554512', 'Charmine', 'Davidescu', 'Charmine.Dav@northeastern.edu', 'One World Trade Center 405', '16:57');
insert into advisor (advisorID, firstName, lastName, email, officeLocation, availableTime) values ('49377409', 'Wang', 'Erwin', 'Wang.Erw@northeastern.edu', 'Willis Tower 309', '14:46');

insert into department (name, deparmentID) values ('Computer Science', 5);
insert into department (name, deparmentID) values ('Electrical Engineering', 12);
insert into department (name, deparmentID) values ('Mechanical Engineering', 6);
insert into department (name, deparmentID) values ('Chemistry', 18);
insert into department (name, deparmentID) values ('Physics', 2);
insert into department (name, deparmentID) values ('Biology', 9);
insert into department (name, deparmentID) values ('Mathematics', 13);
insert into department (name, deparmentID) values ('Psychology', 7);
insert into department (name, deparmentID) values ('English Literature', 14);
insert into department (name, deparmentID) values ('History', 2);
insert into department (name, deparmentID) values ('Sociology', 20);
insert into department (name, deparmentID) values ('Economics', 1);
insert into department (name, deparmentID) values ('Business Administration', 5);
insert into department (name, deparmentID) values ('Political Science', 9);
insert into department (name, deparmentID) values ('Art', 9);
insert into department (name, deparmentID) values ('Music', 1);
insert into department (name, deparmentID) values ('Philosophy', 11);
insert into department (name, deparmentID) values ('Geology', 10);
insert into department (name, deparmentID) values ('Anthropology', 15);
insert into department (name, deparmentID) values ('Communication Studies', 3);

insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('22753443', 'Randa', 'Simpson', 'Randa.Sim@northeastern.edu', 'Willowbrook Manor 006', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('27751718', 'Ibrahim', 'Shafier', 'Ibrahim.Sha@northeastern.edu', 'Maplewood Plaza 302', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('53109321', 'Stern', 'Corner', 'Stern.Cor@northeastern.edu', 'Cedar Ridge 209', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('90336788', 'Emilia', 'Van Arsdalen', 'Emilia.Van@northeastern.edu', 'Cedar Ridge 600', '15');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('87289737', 'Charles', 'Cursons', 'Charles.Cur@northeastern.edu', 'Cedar Ridge 700', '5');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('89577814', 'Sadella', 'Tutchings', 'Sadella.Tut@northeastern.edu', 'Cedar Ridge 205', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('81694132', 'Zeke', 'MacKibbon', 'Zeke.Mac@northeastern.edu', 'Cedar Ridge 402', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('18809686', 'Kesley', 'Durak', 'Kesley.Dur@northeastern.edu', 'Oakwood Tower 202', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('45306411', 'Galvin', 'Twinberrow', 'Galvin.Twi@northeastern.edu', 'Willowbrook Manor 702', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('14334130', 'Micky', 'Alenichicov', 'Micky.Ale@northeastern.edu', 'Oakwood Tower 501', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('77649458', 'Nettie', 'Harkins', 'Nettie.Har@northeastern.edu', 'Oakwood Tower 307', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('91581276', 'Karil', 'Udie', 'Karil.Udi@northeastern.edu', 'Oakwood Tower 803', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('94992885', 'Jaime', 'Gaskill', 'Jaime.Gas@northeastern.edu', 'Willowbrook Manor 802', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('59404927', 'Tabbie', 'Rothert', 'Tabbie.Rot@northeastern.edu', 'Pinecrest Heights 208', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('92511876', 'Clarette', 'Coleby', 'Clarette.Col@northeastern.edu', 'Willowbrook Manor 208', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('09260116', 'Velvet', 'Gier', 'Velvet.Gie@northeastern.edu', 'Pinecrest Heights 207', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('67552438', 'Cherrita', 'Lorie', 'Cherrita.Lor@northeastern.edu', 'Maplewood Plaza 705', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('71698967', 'Fredelia', 'Honywill', 'Fredelia.Hon@northeastern.edu', 'Willowbrook Manor 003', '5');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('86826396', 'Laurianne', 'Cheese', 'Laurianne.Che@northeastern.edu', 'Cedar Ridge 502', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('66871833', 'Maurizio', 'Coffey', 'Maurizio.Cof@northeastern.edu', 'Cedar Ridge 008', '13');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('48106586', 'Mortie', 'Dy', 'Mortie.Dy@northeastern.edu', 'Willowbrook Manor 004', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('73177214', 'Nevil', 'Whitehouse', 'Nevil.Whi@northeastern.edu', 'Maplewood Plaza 809', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('12204518', 'Benetta', 'Sirey', 'Benetta.Sir@northeastern.edu', 'Maplewood Plaza 301', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('94273122', 'Anselm', 'Dwyer', 'Anselm.Dwy@northeastern.edu', 'Maplewood Plaza 206', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('09032011', 'Standford', 'Pitkeathly', 'Standford.Pit@northeastern.edu', 'Cedar Ridge 302', '14');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('05953930', 'Gordan', 'Cocks', 'Gordan.Coc@northeastern.edu', 'Pinecrest Heights 402', '2');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('11868694', 'Billye', 'Kuhne', 'Billye.Kuh@northeastern.edu', 'Oakwood Tower 207', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('64268916', 'Jarrod', 'Ovesen', 'Jarrod.Ove@northeastern.edu', 'Willowbrook Manor 102', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('09121654', 'Bria', 'Abad', 'Bria.Aba@northeastern.edu', 'Oakwood Tower 204', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('29654553', 'Vernice', 'Putley', 'Vernice.Put@northeastern.edu', 'Willowbrook Manor 506', '10');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('46750384', 'Mozes', 'Aulsford', 'Mozes.Aul@northeastern.edu', 'Pinecrest Heights 801', '5');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('00081123', 'Frazier', 'Palay', 'Frazier.Pal@northeastern.edu', 'Maplewood Plaza 809', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('51085928', 'Peggi', 'Epsley', 'Peggi.Eps@northeastern.edu', 'Willowbrook Manor 401', '19');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('24318744', 'Evelyn', 'Paddy', 'Evelyn.Pad@northeastern.edu', 'Cedar Ridge 804', '16');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('96608819', 'Tiphany', 'Safhill', 'Tiphany.Saf@northeastern.edu', 'Pinecrest Heights 201', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('82553290', 'Lucy', 'Wrightson', 'Lucy.Wri@northeastern.edu', 'Pinecrest Heights 401', '5');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('47562057', 'Herta', 'Petrescu', 'Herta.Pet@northeastern.edu', 'Maplewood Plaza 904', '13');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('31628893', 'Dionne', 'Bandt', 'Dionne.Ban@northeastern.edu', 'Oakwood Tower 803', '3');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('20160806', 'Beatrice', 'Romeo', 'Beatrice.Rom@northeastern.edu', 'Pinecrest Heights 905', '6');
insert into administrator (administratorID, firstName, lastName, email, officeLocation, department) values ('09532972', 'Leigh', 'Alyokhin', 'Leigh.Aly@northeastern.edu', 'Oakwood Tower 707', '15');

insert into building (buildingID, hours, daycleaned, administrator) values (1, '10:12 AM', 'Sunday', '78420558');
insert into building (buildingID, hours, daycleaned, administrator) values (2, '4:20 PM', 'Saturday', '53491927');
insert into building (buildingID, hours, daycleaned, administrator) values (3, '4:25 PM', 'Friday', '56969566');
insert into building (buildingID, hours, daycleaned, administrator) values (4, '2:08 PM', 'Sunday', '99110445');
insert into building (buildingID, hours, daycleaned, administrator) values (5, '12:17 PM', 'Sunday', '11112780');
insert into building (buildingID, hours, daycleaned, administrator) values (6, '2:14 PM', 'Sunday', '30203710');
insert into building (buildingID, hours, daycleaned, administrator) values (7, '8:02 AM', 'Tuesday', '45320237');
insert into building (buildingID, hours, daycleaned, administrator) values (8, '1:08 PM', 'Thursday', '64235405');
insert into building (buildingID, hours, daycleaned, administrator) values (9, '2:00 PM', 'Tuesday', '52643765');
insert into building (buildingID, hours, daycleaned, administrator) values (10, '4:16 PM', 'Thursday', '42427906');
insert into building (buildingID, hours, daycleaned, administrator) values (11, '10:46 AM', 'Wednesday', '42342949');
insert into building (buildingID, hours, daycleaned, administrator) values (12, '5:45 PM', 'Wednesday', '22872463');
insert into building (buildingID, hours, daycleaned, administrator) values (13, '1:10 PM', 'Thursday', '37555655');
insert into building (buildingID, hours, daycleaned, administrator) values (14, '4:58 PM', 'Thursday', '59537408');
insert into building (buildingID, hours, daycleaned, administrator) values (15, '11:06 AM', 'Friday', '71014493');
insert into building (buildingID, hours, daycleaned, administrator) values (16, '9:01 AM', 'Friday', '05452669');
insert into building (buildingID, hours, daycleaned, administrator) values (17, '12:56 PM', 'Friday', '99608917');
insert into building (buildingID, hours, daycleaned, administrator) values (18, '4:46 PM', 'Wednesday', '27457639');
insert into building (buildingID, hours, daycleaned, administrator) values (19, '9:58 AM', 'Sunday', '24774334');
insert into building (buildingID, hours, daycleaned, administrator) values (20, '3:47 PM', 'Tuesday', '43601150');

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

insert into professor (firstName, lastName, email) values ('Abe', 'Lincoln', 'honest@abe.com');
insert into professor (firstName, lastName, email) values ('Glenn', 'Horton', 'ghort@mail.com');
insert into professor (firstName, lastName, email) values ('Lisa', 'Simpson', 'lisasimpson@fox.com');

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