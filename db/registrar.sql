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

insert into classroom (cID, seats, disabilityResources, type, building) values ('608', 20, 2, 'laboratory', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values ('606', 200, 2, 'auditorium', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values ('107', 50, 1, 'classroom', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values ('005', 200, 1, 'auditorium', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values ('402', 100, 1, 'lecture hall', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values ('700', 50, 0, 'classroom', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values ('004', 20, 2, 'laboratory', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values ('305', 200, 1, 'auditorium', '16');
insert into classroom (cID, seats, disabilityResources, type, building) values ('405', 100, 1, 'lecture hall', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values ('500', 50, 0, 'classroom', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values ('602', 20, 1, 'laboratory', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values ('804', 100, 1, 'lecture hall', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values ('804', 100, 0, 'lecture hall', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values ('004', 150, 2, 'lecture hall', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values ('407', 20, 2, 'laboratory', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values ('408', 100, 0, 'lecture hall', '4');
insert into classroom (cID, seats, disabilityResources, type, building) values ('101', 100, 1, 'lecture hall', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values ('000', 100, 1, 'lecture hall', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values ('101', 150, 1, 'lecture hall', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values ('309', 20, 0, 'laboratory', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values ('005', 200, 0, 'auditorium', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values ('904', 200, 1, 'auditorium', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values ('709', 100, 1, 'lecture hall', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values ('402', 200, 1, 'auditorium', '16');
insert into classroom (cID, seats, disabilityResources, type, building) values ('603', 50, 2, 'classroom', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values ('101', 20, 2, 'laboratory', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values ('906', 200, 2, 'auditorium', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values ('004', 200, 1, 'auditorium', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values ('701', 150, 0, 'lecture hall', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values ('605', 100, 2, 'lecture hall', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values ('503', 50, 0, 'classroom', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values ('707', 50, 2, 'classroom', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values ('507', 20, 1, 'laboratory', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values ('207', 150, 2, 'lecture hall', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values ('209', 50, 1, 'classroom', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values ('403', 50, 1, 'classroom', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values ('909', 150, 0, 'lecture hall', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values ('207', 50, 1, 'classroom', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values ('008', 50, 2, 'classroom', '4');
insert into classroom (cID, seats, disabilityResources, type, building) values ('203', 150, 0, 'lecture hall', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values ('204', 50, 2, 'classroom', '3');
insert into classroom (cID, seats, disabilityResources, type, building) values ('108', 50, 1, 'classroom', '17');
insert into classroom (cID, seats, disabilityResources, type, building) values ('504', 100, 0, 'lecture hall', '12');
insert into classroom (cID, seats, disabilityResources, type, building) values ('501', 100, 2, 'lecture hall', '14');
insert into classroom (cID, seats, disabilityResources, type, building) values ('409', 200, 2, 'auditorium', '18');
insert into classroom (cID, seats, disabilityResources, type, building) values ('905', 200, 2, 'auditorium', '6');
insert into classroom (cID, seats, disabilityResources, type, building) values ('407', 20, 1, 'laboratory', '10');
insert into classroom (cID, seats, disabilityResources, type, building) values ('502', 20, 0, 'laboratory', '11');
insert into classroom (cID, seats, disabilityResources, type, building) values ('000', 100, 0, 'lecture hall', '19');
insert into classroom (cID, seats, disabilityResources, type, building) values ('609', 100, 0, 'lecture hall', '5');
insert into classroom (cID, seats, disabilityResources, type, building) values ('101', 200, 0, 'auditorium', '2');
insert into classroom (cID, seats, disabilityResources, type, building) values ('405', 150, 1, 'lecture hall', '13');
insert into classroom (cID, seats, disabilityResources, type, building) values ('806', 100, 2, 'lecture hall', '1');
insert into classroom (cID, seats, disabilityResources, type, building) values ('904', 20, 0, 'laboratory', '9');
insert into classroom (cID, seats, disabilityResources, type, building) values ('000', 100, 2, 'lecture hall', '15');
insert into classroom (cID, seats, disabilityResources, type, building) values ('507', 100, 0, 'lecture hall', '7');
insert into classroom (cID, seats, disabilityResources, type, building) values ('800', 50, 2, 'classroom', '8');
insert into classroom (cID, seats, disabilityResources, type, building) values ('904', 150, 0, 'lecture hall', '20');
insert into classroom (cID, seats, disabilityResources, type, building) values ('503', 100, 2, 'lecture hall', '16');
insert into classroom (cID, seats, disabilityResources, type, building) values ('509', 50, 0, 'classroom', '4');


<<<<<<< HEAD
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

insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('109781467', 'Roch', 'Klimpke', 'Roch.Kli@northeastern.edu', 'Female', 2025, '1 Union Way', '35962238', '14', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('194778088', 'Bree', 'Woolis', 'Bree.Woo@northeastern.edu', 'Female', 2023, '4 Tony Court', '10662393', '10', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('929884326', 'Marlow', 'Dockreay', 'Marlow.Doc@northeastern.edu', 'Male', 2026, '9 Aberg Hill', '30641406', '6', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('010593123', 'Xaviera', 'Whiteland', 'Xaviera.Whi@northeastern.edu', 'Female', 2024, '6727 Arkansas Center', '87362905', '5', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('681011237', 'Armstrong', 'Deplacido', 'Armstrong.Dep@northeastern.edu', 'Genderqueer', 2026, '8 Meadow Ridge Crossing', '13203814', '14', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('136333962', 'Kat', 'Diggons', 'Kat.Dig@northeastern.edu', 'Bigender', 2023, '68 Bluestem Center', '30860469', '19', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('220535778', 'Edythe', 'Tarply', 'Edythe.Tar@northeastern.edu', 'Female', 2025, '620 Northfield Road', '53040036', '5', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('406865093', 'Broderic', 'McCraine', 'Broderic.McC@northeastern.edu', 'Male', 2023, '9018 Mesta Way', '07245036', '3', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('075277173', 'Beau', 'Kneel', 'Beau.Kne@northeastern.edu', 'Male', 2023, '74 Eggendart Junction', '13146390', '19', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('403836332', 'Eddy', 'Kenwell', 'Eddy.Ken@northeastern.edu', 'Female', 2024, '3 Arizona Pass', '33955590', '16', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('319286252', 'Arlie', 'D''Almeida', 'Arlie.D''A@northeastern.edu', 'Female', 2023, '81622 Petterle Way', '09151339', '6', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('357956190', 'Zenia', 'Vinton', 'Zenia.Vin@northeastern.edu', 'Female', 2023, '63 Arapahoe Lane', '22859994', '3', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('748486658', 'Belia', 'Dalrymple', 'Belia.Dal@northeastern.edu', 'Polygender', 2023, '7 Brickson Park Street', '74538517', '10', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('959901850', 'Sidney', 'Ransome', 'Sidney.Ran@northeastern.edu', 'Male', 2024, '52 Ohio Crossing', '66400944', '16', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('893949976', 'Giselle', 'Bohman', 'Giselle.Boh@northeastern.edu', 'Female', 2023, '66460 Butterfield Circle', '49163701', '2', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('449813801', 'Trudi', 'Bresson', 'Trudi.Bre@northeastern.edu', 'Female', 2025, '153 Sundown Road', '31844788', '13', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('650846322', 'Nanci', 'Ekless', 'Nanci.Ekl@northeastern.edu', 'Female', 2025, '42925 Maple Wood Park', '69746608', '2', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('555148841', 'Felizio', 'Comellini', 'Felizio.Com@northeastern.edu', 'Male', 2024, '1714 Mockingbird Terrace', '74979240', '14', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('117220734', 'Dorie', 'Bartram', 'Dorie.Bar@northeastern.edu', 'Female', 2026, '787 Starling Junction', '33972078', '15', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('380211153', 'Willem', 'Mustoo', 'Willem.Mus@northeastern.edu', 'Male', 2026, '2927 Banding Terrace', '18655170', '2', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('867541742', 'Osmond', 'Bettis', 'Osmond.Bet@northeastern.edu', 'Male', 2023, '9 Hanson Terrace', '27288338', '3', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('586316762', 'Amandi', 'Redfearn', 'Amandi.Red@northeastern.edu', 'Female', 2024, '86 Ohio Road', '39186322', '16', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('075589667', 'Adler', 'Schimank', 'Adler.Sch@northeastern.edu', 'Male', 2025, '088 Mcguire Junction', '18160711', '19', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('658725011', 'Wilfrid', 'Layton', 'Wilfrid.Lay@northeastern.edu', 'Male', 2026, '226 Granby Avenue', '40783956', '10', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('993197019', 'Staffard', 'Postan', 'Staffard.Pos@northeastern.edu', 'Male', 2024, '223 Johnson Plaza', '05523964', '5', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('776636036', 'Ollie', 'Twycross', 'Ollie.Twy@northeastern.edu', 'Male', 2023, '9201 Monument Trail', '32937660', '6', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('847724554', 'Fredrick', 'Klein', 'Fredrick.Kle@northeastern.edu', 'Male', 2026, '683 Parkside Center', '96833815', '5', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('614308702', 'Delcina', 'Mintoff', 'Delcina.Min@northeastern.edu', 'Female', 2024, '707 Declaration Hill', '48713437', '16', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('219353441', 'Lida', 'Oldershaw', 'Lida.Old@northeastern.edu', 'Female', 2026, '58130 Village Green Hill', '02039243', '15', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('866168616', 'Cullen', 'Figiovanni', 'Cullen.Fig@northeastern.edu', 'Male', 2025, '34355 Morning Way', '85755833', '10', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('798426340', 'Zabrina', 'Feasey', 'Zabrina.Fea@northeastern.edu', 'Female', 2025, '3 Waxwing Place', '02040404', '19', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('712500971', 'Karylin', 'Taig', 'Karylin.Tai@northeastern.edu', 'Female', 2023, '1 Golden Leaf Parkway', '93808126', '14', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('427902778', 'Addie', 'O''Hannay', 'Addie.O''H@northeastern.edu', 'Male', 2025, '27290 Forest Run Court', '86773202', '2', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('364270605', 'Nerissa', 'Artinstall', 'Nerissa.Art@northeastern.edu', 'Female', 2024, '06439 Fuller Way', '80687938', '14', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('122052479', 'Adelaide', 'Gornall', 'Adelaide.Gor@northeastern.edu', 'Female', 2023, '75 Dahle Place', '78851126', '3', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('309898485', 'Donella', 'Lannin', 'Donella.Lan@northeastern.edu', 'Female', 2026, '74 5th Street', '25610798', '2', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('851861274', 'Reggie', 'Adger', 'Reggie.Adg@northeastern.edu', 'Female', 2026, '43237 Daystar Terrace', '67639550', '13', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('135951369', 'Heida', 'Hymor', 'Heida.Hym@northeastern.edu', 'Female', 2023, '72 Clemons Park', '96770218', '6', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('474838276', 'Ray', 'Sherland', 'Ray.She@northeastern.edu', 'Non-binary', 2023, '29 Eagan Terrace', '94212752', '14', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('922221598', 'Lou', 'Pellington', 'Lou.Pel@northeastern.edu', 'Male', 2023, '36 Lunder Trail', '53575005', '2', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('959307654', 'Alair', 'Tapping', 'Alair.Tap@northeastern.edu', 'Male', 2024, '3396 Division Street', '96770218', '14', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('670047704', 'Marv', 'Chene', 'Marv.Che@northeastern.edu', 'Polygender', 2026, '090 Amoth Alley', '40783956', '14', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('332640992', 'Orland', 'Larkin', 'Orland.Lar@northeastern.edu', 'Male', 2024, '74 Mockingbird Crossing', '74538517', '6', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('072186967', 'Eduino', 'Geere', 'Eduino.Gee@northeastern.edu', 'Agender', 2023, '0 Washington Avenue', '33955590', '10', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('395625370', 'Nappy', 'McCoy', 'Nappy.McC@northeastern.edu', 'Male', 2025, '4 Superior Junction', '30641406', '13', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('363982687', 'Kleon', 'Chastagnier', 'Kleon.Cha@northeastern.edu', 'Male', 2025, '0 Express Way', '30860469', '2', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('718072275', 'Mathe', 'Houseley', 'Mathe.Hou@northeastern.edu', 'Male', 2026, '4 Kedzie Junction', '05523964', '16', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('329789045', 'Aeriela', 'Cockshot', 'Aeriela.Coc@northeastern.edu', 'Female', 2026, '408 Upham Alley', '48713437', '16', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('581078717', 'Biron', 'Tilly', 'Biron.Til@northeastern.edu', 'Male', 2025, '73 Barnett Crossing', '10662393', '10', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('863560969', 'Maynord', 'Duffyn', 'Maynord.Duf@northeastern.edu', 'Male', 2025, '048 Nova Lane', '53040036', '2', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('503924845', 'Mathian', 'Heys', 'Mathian.Hey@northeastern.edu', 'Agender', 2025, '5797 Kensington Junction', '78851126', '6', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('235443867', 'Merilyn', 'Farrer', 'Merilyn.Far@northeastern.edu', 'Female', 2024, '74 Larry Park', '85755833', '14', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('271382041', 'Jolyn', 'De Lacey', 'Jolyn.De @northeastern.edu', 'Female', 2026, '296 Hoepker Avenue', '67639550', '3', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('410008487', 'Cristiano', 'MacCaughey', 'Cristiano.Mac@northeastern.edu', 'Agender', 2026, '309 Barby Avenue', '94212752', '15', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('136119716', 'Cointon', 'Casely', 'Cointon.Cas@northeastern.edu', 'Male', 2023, '0 Surrey Alley', '80687938', '5', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('089120697', 'Lay', 'Pirri', 'Lay.Pir@northeastern.edu', 'Male', 2026, '5 Northwestern Terrace', '27288338', '3', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('501306346', 'Randa', 'Tofpik', 'Randa.Tof@northeastern.edu', 'Female', 2025, '809 Claremont Place', '93808126', '5', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('764287442', 'Myrwyn', 'Romayn', 'Myrwyn.Rom@northeastern.edu', 'Male', 2024, '96534 Eliot Trail', '13203814', '2', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('032720172', 'Glori', 'Pideon', 'Glori.Pid@northeastern.edu', 'Female', 2025, '72486 Grasskamp Terrace', '09151339', '19', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('575471949', 'Theobald', 'Navarro', 'Theobald.Nav@northeastern.edu', 'Bigender', 2024, '95 Arrowood Pass', '69746608', '19', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('556869828', 'Hall', 'Sproule', 'Hall.Spr@northeastern.edu', 'Genderqueer', 2023, '65174 Warner Center', '35962238', '19', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('377633868', 'Krysta', 'Greenlies', 'Krysta.Gre@northeastern.edu', 'Agender', 2023, '861 Marquette Court', '25610798', '3', '9');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('119521083', 'Wanda', 'Fowlston', 'Wanda.Fow@northeastern.edu', 'Female', 2024, '8492 Bunker Hill Street', '02039243', '5', '30');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('853417998', 'Bobinette', 'Avramovitz', 'Bobinette.Avr@northeastern.edu', 'Female', 2023, '75275 Chive Circle', '49163701', '10', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('282934578', 'Gerty', 'Lackington', 'Gerty.Lac@northeastern.edu', 'Female', 2023, '3 Welch Circle', '07245036', '16', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('455003766', 'Haydon', 'Babinski', 'Haydon.Bab@northeastern.edu', 'Male', 2026, '15 Union Avenue', '87362905', '15', '29');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('487459386', 'Sydney', 'Aleksankov', 'Sydney.Ale@northeastern.edu', 'Male', 2025, '1 Pierstorff Circle', '13146390', '14', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('657059341', 'Gregoire', 'Sefton', 'Gregoire.Sef@northeastern.edu', 'Male', 2026, '794 Hayes Terrace', '86773202', '2', '12');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('501837600', 'Nanni', 'Di Claudio', 'Nanni.Di @northeastern.edu', 'Female', 2024, '2 Green Plaza', '33972078', '6', '16');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('570400876', 'Malinda', 'Jagiello', 'Malinda.Jag@northeastern.edu', 'Female', 2024, '3 Helena Trail', '18655170', '19', '24');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('253178189', 'Kristoffer', 'Zylberdik', 'Kristoffer.Zyl@northeastern.edu', 'Male', 2025, '4 Moose Circle', '53575005', '10', '8');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('394264516', 'Dewie', 'Aim', 'Dewie.Aim@northeastern.edu', 'Male', 2025, '930 Amoth Junction', '32937660', '13', '5');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('710114095', 'Dorolice', 'Whayman', 'Dorolice.Wha@northeastern.edu', 'Female', 2025, '943 Eagan Way', '31844788', '14', '17');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('260512201', 'Thaddus', 'Cockshot', 'Thaddus.Coc@northeastern.edu', 'Male', 2023, '9 Maple Wood Trail', '96833815', '16', '13');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('301710634', 'Cornelle', 'Tofano', 'Cornelle.Tof@northeastern.edu', 'Female', 2024, '36739 Artisan Parkway', '74979240', '2', '15');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('320099991', 'Latrina', 'Crickmore', 'Latrina.Cri@northeastern.edu', 'Female', 2026, '0 Shasta Court', '18160711', '14', '11');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('667986745', 'Oswald', 'Guerre', 'Oswald.Gue@northeastern.edu', 'Male', 2024, '571 Gina Lane', '22859994', '3', '18');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('106260593', 'Tuckie', 'Purcell', 'Tuckie.Pur@northeastern.edu', 'Male', 2026, '48 Troy Terrace', '39186322', '5', '7');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('612089238', 'Rowney', 'Bottjer', 'Rowney.Bot@northeastern.edu', 'Male', 2026, '7682 Milwaukee Place', '02040404', '6', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('473173131', 'Hazlett', 'Impett', 'Hazlett.Imp@northeastern.edu', 'Male', 2024, '0764 Pleasure Alley', '66400944', '2', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('920563863', 'Shaylynn', 'Hoggan', 'Shaylynn.Hog@northeastern.edu', 'Female', 2026, '86 Bultman Alley', '48713437', '13', '1');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('459849130', 'Felicity', 'Draycott', 'Felicity.Dra@northeastern.edu', 'Female', 2023, '23673 Raven Street', '94212752', '19', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('453086899', 'Egor', 'Nannini', 'Egor.Nan@northeastern.edu', 'Male', 2026, '5960 Larry Junction', '18655170', '2', '2');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('787913405', 'Becca', 'MacNeil', 'Becca.Mac@northeastern.edu', 'Non-binary', 2024, '53 Evergreen Point', '39186322', '19', '23');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('873206646', 'Stesha', 'Bartunek', 'Stesha.Bar@northeastern.edu', 'Female', 2025, '55 Ridgeway Pass', '33972078', '6', '22');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('322284118', 'Warner', 'Worts', 'Warner.Wor@northeastern.edu', 'Male', 2024, '18 Alpine Trail', '31844788', '10', '20');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('014886961', 'Vania', 'Douglass', 'Vania.Dou@northeastern.edu', 'Female', 2025, '317 Tennyson Road', '13146390', '14', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('377949028', 'Padget', 'Gillyett', 'Padget.Gil@northeastern.edu', 'Male', 2023, '29 Sauthoff Junction', '66400944', '14', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('801865035', 'Benito', 'Henrionot', 'Benito.Hen@northeastern.edu', 'Male', 2025, '8 Michigan Street', '74979240', '5', '27');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('882080079', 'Clark', 'Pimlock', 'Clark.Pim@northeastern.edu', 'Male', 2024, '9525 Sutherland Junction', '86773202', '15', '28');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('508116723', 'Anton', 'Attew', 'Anton.Att@northeastern.edu', 'Male', 2023, '542 Golden Leaf Court', '02039243', '14', '19');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('130518196', 'Angeline', 'Embleton', 'Angeline.Emb@northeastern.edu', 'Female', 2023, '027 Farragut Parkway', '25610798', '5', '4');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('000604947', 'Pierette', 'Crayton', 'Pierette.Cra@northeastern.edu', 'Female', 2026, '9359 Dorton Circle', '69746608', '2', '21');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('426857614', 'Moise', 'Roser', 'Moise.Ros@northeastern.edu', 'Male', 2025, '19 Warner Hill', '53575005', '10', '25');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('736291149', 'Patton', 'Brant', 'Patton.Bra@northeastern.edu', 'Male', 2023, '51 Shasta Court', '74538517', '16', '10');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('352651748', 'Hardy', 'Livermore', 'Hardy.Liv@northeastern.edu', 'Male', 2024, '972 Gerald Place', '32937660', '16', '26');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('447673240', 'Yvor', 'Prenty', 'Yvor.Pre@northeastern.edu', 'Male', 2025, '7186 Tomscot Park', '85755833', '3', '3');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('778415546', 'Eugine', 'Brockwell', 'Eugine.Bro@northeastern.edu', 'Female', 2026, '34 Golf Street', '18160711', '2', '14');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('920600678', 'Alica', 'Spire', 'Alica.Spi@northeastern.edu', 'Female', 2024, '95449 Donald Avenue', '49163701', '3', '6');
insert into student (studentID, firstName, lastName, email, gender, gradYear, address, advisor, department, major) values ('863959535', 'Dorie', 'Redihough', 'Dorie.Red@northeastern.edu', 'Polygender', 2023, '32685 Brentwood Lane', '33955590', '6', '17');
=======
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('John', 'Smith', 'jsmith@theguardian.com', 2026, '133 Door St', 'Male', 2, 1, 4);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Ann', 'Smith', 'asmith@theguardian.com', 2026, '133 Door St', 'Female', 1, 2, 2);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Jeff', 'Kingsley', 'jk44@mail.com', 2024, '2204 Apt 3', 'Male', 4, 4, 5);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Ramona', 'Flowers', 'rflowers@netflix.com', 2028, '122 Door St', 'Female', 5, 5, 3);
insert into student (firstName, lastName, email, gradYear, address, gender, advisor, department, major) values ('Alec', 'Nine', 'minecraft@thewayhome.com', 2029, '930 Alpha Way', 'Non-binary', 3, 2, 1);

insert into professor (firstName, lastName, email) values ('Abe', 'Lincoln', 'honest@abe.com');
insert into professor (firstName, lastName, email) values ('Glenn', 'Horton', 'ghort@mail.com');
insert into professor (firstName, lastName, email) values ('Lisa', 'Simpson', 'lisasimpson@fox.com');
>>>>>>> main

insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('61168425', 'Elvin', 'McMyler', 'Elvin.McM@northeastern.edu', 'Maplewood Apartments 604', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('14860109', 'Tamar', 'Sarah', 'Tamar.Sar@northeastern.edu', 'Cedar Ridge Estates 507', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('89627991', 'Keelby', 'Keyse', 'Keelby.Key@northeastern.edu', 'Willow Creek Manor 900', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('48476148', 'Fons', 'Depper', 'Fons.Dep@northeastern.edu', 'Harborview Condos 401', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('01624312', 'Chrisy', 'Conybear', 'Chrisy.Con@northeastern.edu', 'Harborview Condos 000', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('46353783', 'Hardy', 'Bierman', 'Hardy.Bie@northeastern.edu', 'Harborview Condos 801', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('64152491', 'Cindi', 'Egdal', 'Cindi.Egd@northeastern.edu', 'Cedar Ridge Estates 807', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('02273261', 'Jocelin', 'Reeson', 'Jocelin.Ree@northeastern.edu', 'Pinecrest Villas 609', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('77502005', 'Alex', 'Ells', 'Alex.Ell@northeastern.edu', 'Sunset Towers 906', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('28186614', 'Silvan', 'Gooms', 'Silvan.Goo@northeastern.edu', 'Cedar Ridge Estates 704', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('70681982', 'Ailina', 'Truelove', 'Ailina.Tru@northeastern.edu', 'Briarwood Manor 300', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('46827231', 'Roth', 'Scarth', 'Roth.Sca@northeastern.edu', 'Oakview Heights 905', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('58098848', 'Jannel', 'Guinery', 'Jannel.Gui@northeastern.edu', 'Harborview Condos 302', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('96967587', 'Witty', 'Haslewood', 'Witty.Has@northeastern.edu', 'Pinecrest Villas 805', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('51566238', 'Dov', 'Behninck', 'Dov.Beh@northeastern.edu', 'Rosewood Gardens 200', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('82585276', 'Lay', 'Eshmade', 'Lay.Esh@northeastern.edu', 'Cedar Ridge Estates 806', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('40208803', 'Gail', 'Brandts', 'Gail.Bra@northeastern.edu', 'Briarwood Manor 603', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('90829175', 'Thorndike', 'Abdon', 'Thorndike.Abd@northeastern.edu', 'Rosewood Gardens 507', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('61101202', 'Andre', 'Jozwicki', 'Andre.Joz@northeastern.edu', 'Rosewood Gardens 509', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('48710225', 'Perla', 'Goodswen', 'Perla.Goo@northeastern.edu', 'Willow Creek Manor 001', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('89229226', 'Dotti', 'Wilgar', 'Dotti.Wil@northeastern.edu', 'Willow Creek Manor 300', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('16223963', 'Rosene', 'Pirrie', 'Rosene.Pir@northeastern.edu', 'Oakview Heights 109', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('51913331', 'Chadd', 'Maghull', 'Chadd.Mag@northeastern.edu', 'Sunset Towers 407', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('82725933', 'Tessa', 'Morritt', 'Tessa.Mor@northeastern.edu', 'Oakview Heights 109', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('53598318', 'Caryl', 'Joder', 'Caryl.Jod@northeastern.edu', 'Sunset Towers 101', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('92126893', 'Vaclav', 'Benditt', 'Vaclav.Ben@northeastern.edu', 'Willow Creek Manor 506', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('64758478', 'Cosetta', 'Howorth', 'Cosetta.How@northeastern.edu', 'Maplewood Apartments 902', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('79648537', 'Rebecca', 'Tungate', 'Rebecca.Tun@northeastern.edu', 'Cedar Ridge Estates 506', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('35049590', 'Emmery', 'Miko', 'Emmery.Mik@northeastern.edu', 'Pinecrest Villas 600', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('78934212', 'Danyelle', 'Sands', 'Danyelle.San@northeastern.edu', 'Oakview Heights 700', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('01626320', 'Marilyn', 'Sola', 'Marilyn.Sol@northeastern.edu', 'Pinecrest Villas 406', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('27321993', 'Wanda', 'Thew', 'Wanda.The@northeastern.edu', 'Pinecrest Villas 202', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('78276678', 'Brendis', 'Kinnoch', 'Brendis.Kin@northeastern.edu', 'Sunset Towers 404', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('21202231', 'Pearla', 'Renehan', 'Pearla.Ren@northeastern.edu', 'Pinecrest Villas 203', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('13260541', 'Noach', 'Elsay', 'Noach.Els@northeastern.edu', 'Willow Creek Manor 902', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('95421920', 'Kaleb', 'Branscombe', 'Kaleb.Bra@northeastern.edu', 'Meadowbrook Residences 608', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('95960010', 'Tamara', 'Bickell', 'Tamara.Bic@northeastern.edu', 'Oakview Heights 704', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('05464096', 'Jacinta', 'Porkiss', 'Jacinta.Por@northeastern.edu', 'Cedar Ridge Estates 409', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('90471103', 'Corliss', 'Birtwisle', 'Corliss.Bir@northeastern.edu', 'Willow Creek Manor 709', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('00090043', 'Jasmina', 'Stitt', 'Jasmina.Sti@northeastern.edu', 'Harborview Condos 007', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('96330982', 'Harcourt', 'Rickhuss', 'Harcourt.Ric@northeastern.edu', 'Sunset Towers 504', '16');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('36704243', 'Friederike', 'Hargess', 'Friederike.Har@northeastern.edu', 'Rosewood Gardens 603', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('55751345', 'Emmy', 'Shafe', 'Emmy.Sha@northeastern.edu', 'Cedar Ridge Estates 605', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('05415698', 'Carline', 'Lifton', 'Carline.Lif@northeastern.edu', 'Maplewood Apartments 505', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('73035997', 'Maire', 'Reyburn', 'Maire.Rey@northeastern.edu', 'Willow Creek Manor 204', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('77511516', 'Mirna', 'Wynrehame', 'Mirna.Wyn@northeastern.edu', 'Sunset Towers 708', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('01456094', 'Tabby', 'Yeldon', 'Tabby.Yel@northeastern.edu', 'Briarwood Manor 800', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('85062618', 'Sindee', 'Barthel', 'Sindee.Bar@northeastern.edu', 'Rosewood Gardens 806', '13');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('61787497', 'Courtnay', 'Tavernor', 'Courtnay.Tav@northeastern.edu', 'Willow Creek Manor 806', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('33299307', 'Zea', 'Dearnaley', 'Zea.Dea@northeastern.edu', 'Pinecrest Villas 003', '3');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('43656252', 'Doroteya', 'Alessandone', 'Doroteya.Ale@northeastern.edu', 'Maplewood Apartments 700', '5');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('99997881', 'Sherilyn', 'Lewsam', 'Sherilyn.Lew@northeastern.edu', 'Oakview Heights 307', '6');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('65999389', 'Datha', 'Marvell', 'Datha.Mar@northeastern.edu', 'Oakview Heights 305', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('79211618', 'Fanny', 'Diggar', 'Fanny.Dig@northeastern.edu', 'Maplewood Apartments 109', '2');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('25397769', 'Ignacius', 'Cheatle', 'Ignacius.Che@northeastern.edu', 'Maplewood Apartments 602', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('76624831', 'Darrick', 'Cuttelar', 'Darrick.Cut@northeastern.edu', 'Maplewood Apartments 001', '15');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('83623218', 'Carolann', 'Murden', 'Carolann.Mur@northeastern.edu', 'Harborview Condos 509', '10');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('00881804', 'Blakelee', 'Petyanin', 'Blakelee.Pet@northeastern.edu', 'Oakview Heights 000', '14');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('62648817', 'Therese', 'Gammon', 'Therese.Gam@northeastern.edu', 'Rosewood Gardens 600', '19');
insert into professor (professorID, firstName, lastName, email, officeLocation, department) values ('93467577', 'Ker', 'Coslitt', 'Ker.Cos@northeastern.edu', 'Meadowbrook Residences 704', '16');

insert into course (courseID, name, term, department, professor) values ('0906', 'Introduction to Computer Science', 'Fall 2023', '2', '71531889');
insert into course (courseID, name, term, department, professor) values ('1824', 'English Literature', 'Spring 2023', '2', '35185507');
insert into course (courseID, name, term, department, professor) values ('5066', 'Mathematics for Beginners', 'Summer II 2023', '16', '15198388');
insert into course (courseID, name, term, department, professor) values ('7123', 'Art History', 'Spring 2023', '3', '18899034');
insert into course (courseID, name, term, department, professor) values ('9298', 'Chemistry 101', 'Spring 2023', '10', '98950459');
insert into course (courseID, name, term, department, professor) values ('3136', 'Introduction to Psychology', 'Spring 2023', '14', '14611645');
insert into course (courseID, name, term, department, professor) values ('6364', 'World History', 'Spring 2023', '3', '43594361');
insert into course (courseID, name, term, department, professor) values ('7165', 'Introduction to Philosophy', 'Spring 2023', '5', '29907274');
insert into course (courseID, name, term, department, professor) values ('0617', 'Physics for Non-Scientists', 'Summer II 2023', '10', '40419272');
insert into course (courseID, name, term, department, professor) values ('3442', 'Business Management', 'Fall 2023', '14', '37951230');
insert into course (courseID, name, term, department, professor) values ('9744', 'Introduction to Sociology', 'Fall 2023', '13', '92458309');
insert into course (courseID, name, term, department, professor) values ('9146', 'Environmental Science', 'Fall 2023', '19', '13457537');
insert into course (courseID, name, term, department, professor) values ('4439', 'Creative Writing', 'Summer II 2023', '5', '75324109');
insert into course (courseID, name, term, department, professor) values ('4406', 'Introduction to Economics', 'Spring 2023', '19', '66601735');
insert into course (courseID, name, term, department, professor) values ('3500', 'Music Appreciation', 'Spring 2023', '2', '67762885');
insert into course (courseID, name, term, department, professor) values ('4443', 'Introduction to Marketing', 'Fall 2023', '6', '40955581');
insert into course (courseID, name, term, department, professor) values ('3345', 'Political Science', 'Fall 2023', '6', '71877648');
insert into course (courseID, name, term, department, professor) values ('8432', 'Introduction to Anthropology', 'Spring 2023', '15', '46632951');
insert into course (courseID, name, term, department, professor) values ('8419', 'Introduction to Statistics', 'Spring 2023', '16', '55234630');
insert into course (courseID, name, term, department, professor) values ('4610', 'Film Studies', 'Summer II 2023', '14', '74688068');
insert into course (courseID, name, term, department, professor) values ('8120', 'Introduction to Nutrition', 'Summer I 2023', '19', '46378423');
insert into course (courseID, name, term, department, professor) values ('5900', 'Introduction to Astronomy', 'Fall 2023', '6', '97703688');
insert into course (courseID, name, term, department, professor) values ('2782', 'Physical Education', 'Fall 2023', '3', '75067070');
insert into course (courseID, name, term, department, professor) values ('6561', 'Introduction to Linguistics', 'Summer II 2023', '6', '40945335');
insert into course (courseID, name, term, department, professor) values ('2394', 'Introduction to Geology', 'Summer I 2023', '14', '88009228');
insert into course (courseID, name, term, department, professor) values ('1483', 'Introduction to Ethics', 'Spring 2023', '5', '45058078');
insert into course (courseID, name, term, department, professor) values ('1659', 'Introduction to Film Production', 'Fall 2023', '19', '48334268');
insert into course (courseID, name, term, department, professor) values ('2206', 'Introduction to Photography', 'Fall 2023', '5', '63837392');
insert into course (courseID, name, term, department, professor) values ('8783', 'Introduction to Acting', 'Spring 2023', '16', '14300088');
insert into course (courseID, name, term, department, professor) values ('5392', 'Introduction to Dance', 'Summer I 2023', '14', '58495804');
insert into course (courseID, name, term, department, professor) values ('7979', 'Introduction to Sculpture', 'Spring 2023', '2', '23155974');
insert into course (courseID, name, term, department, professor) values ('7547', 'Introduction to Graphic Design', 'Fall 2023', '2', '08314763');
insert into course (courseID, name, term, department, professor) values ('1693', 'Introduction to Web Development', 'Fall 2023', '3', '53957469');
insert into course (courseID, name, term, department, professor) values ('3457', 'Introduction to Mobile App Development', 'Spring 2023', '10', '50809196');
insert into course (courseID, name, term, department, professor) values ('7953', 'Introduction to Artificial Intelligence', 'Fall 2023', '14', '07244183');
insert into course (courseID, name, term, department, professor) values ('3412', 'Introduction to Robotics', 'Spring 2023', '10', '10972183');
insert into course (courseID, name, term, department, professor) values ('0537', 'Introduction to Virtual Reality', 'Fall 2023', '2', '39070142');
insert into course (courseID, name, term, department, professor) values ('6199', 'Introduction to Data Science', 'Summer II 2023', '13', '50754623');
insert into course (courseID, name, term, department, professor) values ('1308', 'Introduction to Machine Learning', 'Spring 2023', '15', '84452718');
insert into course (courseID, name, term, department, professor) values ('9727', 'Introduction to Cybersecurity', 'Fall 2023', '16', '12323625');
insert into course (courseID, name, term, department, professor) values ('5821', 'Introduction to Cryptography', 'Summer II 2023', '3', '58958291');
insert into course (courseID, name, term, department, professor) values ('9269', 'Introduction to Blockchain', 'Fall 2023', '14', '84918487');
insert into course (courseID, name, term, department, professor) values ('7516', 'Introduction to Internet of Things', 'Fall 2023', '16', '96765495');
insert into course (courseID, name, term, department, professor) values ('3903', 'Introduction to Cloud Computing', 'Fall 2023', '6', '30324379');
insert into course (courseID, name, term, department, professor) values ('9552', 'Introduction to Big Data', 'Summer I 2023', '5', '41967813');
insert into course (courseID, name, term, department, professor) values ('6698', 'Introduction to Human-Computer Interaction', 'Spring 2023', '15', '62991081');
insert into course (courseID, name, term, department, professor) values ('8207', 'Introduction to User Experience Design', 'Spring 2023', '10', '14104011');
insert into course (courseID, name, term, department, professor) values ('7785', 'Introduction to User Interface Design', 'Summer I 2023', '6', '62702242');
insert into course (courseID, name, term, department, professor) values ('2629', 'Introduction to Game Development', 'Summer I 2023', '16', '57326266');
insert into course (courseID, name, term, department, professor) values ('4810', 'Introduction to Augmented Reality', 'Spring 2023', '19', '83682269');
insert into course (courseID, name, term, department, professor) values ('1254', 'Introduction to Virtual Reality', 'Spring 2023', '14', '80850332');
insert into course (courseID, name, term, department, professor) values ('1202', 'Introduction to 3D Modeling', 'Spring 2023', '5', '31343124');
insert into course (courseID, name, term, department, professor) values ('6448', 'Introduction to Fashion Design', 'Spring 2023', '2', '59393322');
insert into course (courseID, name, term, department, professor) values ('5514', 'Introduction to Interior Design', 'Spring 2023', '13', '63132843');
insert into course (courseID, name, term, department, professor) values ('4393', 'Introduction to Architecture', 'Summer II 2023', '10', '80283654');
insert into course (courseID, name, term, department, professor) values ('6639', 'Introduction to Product Design', 'Fall 2023', '19', '29226338');
insert into course (courseID, name, term, department, professor) values ('4596', 'Introduction to Industrial Engineering', 'Fall 2023', '14', '19496567');
insert into course (courseID, name, term, department, professor) values ('5576', 'Introduction to Electrical Engineering', 'Spring 2023', '3', '25610948');
insert into course (courseID, name, term, department, professor) values ('4475', 'Introduction to Mechanical Engineering', 'Fall 2023', '2', '14062456');
insert into course (courseID, name, term, department, professor) values ('7276', 'Introduction to Computer Science', 'Fall 2023', '2', '97019493');


insert into section (secID, classroom, course) values (1, null, '2880');
insert into section (secID, classroom, course) values (2, null, '3477');
insert into section (secID, classroom, course) values (3, null, '1034');
insert into section (secID, classroom, course) values (4, null, '5560');
insert into section (secID, classroom, course) values (5, null, '0264');
insert into section (secID, classroom, course) values (6, null, '4134');
insert into section (secID, classroom, course) values (7, null, '4863');
insert into section (secID, classroom, course) values (8, null, '6519');
insert into section (secID, classroom, course) values (9, null, '8747');
insert into section (secID, classroom, course) values (10, null, '1140');
insert into section (secID, classroom, course) values (11, null, '6139');
insert into section (secID, classroom, course) values (12, null, '2399');
insert into section (secID, classroom, course) values (13, null, '9072');
insert into section (secID, classroom, course) values (14, null, '9792');
insert into section (secID, classroom, course) values (15, null, '7306');
insert into section (secID, classroom, course) values (16, null, '3931');
insert into section (secID, classroom, course) values (17, null, '7399');
insert into section (secID, classroom, course) values (18, null, '9732');
insert into section (secID, classroom, course) values (19, null, '6196');
insert into section (secID, classroom, course) values (20, null, '8511');

insert into exam (examID, title, section) values (1, 'Mid-term II', '18');
insert into exam (examID, title, section) values (2, 'Final Exam', '1');
insert into exam (examID, title, section) values (3, 'Final Exam', '20');
insert into exam (examID, title, section) values (4, 'Final Exam', '13');
insert into exam (examID, title, section) values (5, 'Mid-term I', '8');
insert into exam (examID, title, section) values (6, 'Final Exam', '3');
insert into exam (examID, title, section) values (7, 'Final Exam', '4');
insert into exam (examID, title, section) values (8, 'Final Exam', '2');
insert into exam (examID, title, section) values (9, 'Mid-term I', '5');
insert into exam (examID, title, section) values (10, 'Mid-term I', '6');
insert into exam (examID, title, section) values (11, 'Final Exam', '12');
insert into exam (examID, title, section) values (12, 'Mid-term II', '7');
insert into exam (examID, title, section) values (13, 'Final Exam', '14');
insert into exam (examID, title, section) values (14, 'Mid-term I', '10');
insert into exam (examID, title, section) values (15, 'Final Exam', '16');
insert into exam (examID, title, section) values (16, 'Mid-term II', '11');
insert into exam (examID, title, section) values (17, 'Mid-term I', '15');
insert into exam (examID, title, section) values (18, 'Mid-term I', '19');
insert into exam (examID, title, section) values (19, 'Mid-term I', '17');
insert into exam (examID, title, section) values (20, 'Mid-term II', '9');
insert into exam (examID, title, section) values (21, 'Mid-term II', '8');
insert into exam (examID, title, section) values (22, 'Final Exam', '5');
insert into exam (examID, title, section) values (23, 'Mid-term I', '14');
insert into exam (examID, title, section) values (24, 'Mid-term I', '17');
insert into exam (examID, title, section) values (25, 'Final Exam', '20');
insert into exam (examID, title, section) values (26, 'Mid-term I', '7');
insert into exam (examID, title, section) values (27, 'Mid-term II', '10');
insert into exam (examID, title, section) values (28, 'Mid-term I', '18');
insert into exam (examID, title, section) values (29, 'Mid-term II', '9');
insert into exam (examID, title, section) values (30, 'Mid-term II', '6');
insert into exam (examID, title, section) values (31, 'Final Exam', '15');
insert into exam (examID, title, section) values (32, 'Final Exam', '1');
insert into exam (examID, title, section) values (33, 'Final Exam', '3');
insert into exam (examID, title, section) values (34, 'Final Exam', '13');
insert into exam (examID, title, section) values (35, 'Mid-term II', '2');
insert into exam (examID, title, section) values (36, 'Mid-term II', '11');
insert into exam (examID, title, section) values (37, 'Mid-term II', '19');
insert into exam (examID, title, section) values (38, 'Mid-term II', '16');
insert into exam (examID, title, section) values (39, 'Mid-term II', '12');
insert into exam (examID, title, section) values (40, 'Final Exam', '4');
insert into exam (examID, title, section) values (41, 'Final Exam', '1');
insert into exam (examID, title, section) values (42, 'Final Exam', '5');
insert into exam (examID, title, section) values (43, 'Final Exam', '18');
insert into exam (examID, title, section) values (44, 'Mid-term II', '4');
insert into exam (examID, title, section) values (45, 'Mid-term I', '3');
insert into exam (examID, title, section) values (46, 'Mid-term I', '10');
insert into exam (examID, title, section) values (47, 'Final Exam', '13');
insert into exam (examID, title, section) values (48, 'Mid-term II', '12');
insert into exam (examID, title, section) values (49, 'Mid-term I', '17');
insert into exam (examID, title, section) values (50, 'Mid-term I', '8');
insert into exam (examID, title, section) values (51, 'Final Exam', '9');
insert into exam (examID, title, section) values (52, 'Final Exam', '15');
insert into exam (examID, title, section) values (53, 'Mid-term II', '2');
insert into exam (examID, title, section) values (54, 'Mid-term I', '11');
insert into exam (examID, title, section) values (55, 'Mid-term I', '20');
insert into exam (examID, title, section) values (56, 'Mid-term I', '19');
insert into exam (examID, title, section) values (57, 'Mid-term I', '7');
insert into exam (examID, title, section) values (58, 'Mid-term II', '16');
insert into exam (examID, title, section) values (59, 'Final Exam', '6');
insert into exam (examID, title, section) values (60, 'Mid-term II', '14');

insert into assignment (assignmentID, title, section) values (1, 'Discussion Board', '17');
insert into assignment (assignmentID, title, section) values (2, 'HW2', '7');
insert into assignment (assignmentID, title, section) values (3, 'Essay', '5');
insert into assignment (assignmentID, title, section) values (4, 'Discussion Board', '1');
insert into assignment (assignmentID, title, section) values (5, 'Discussion Board', '6');
insert into assignment (assignmentID, title, section) values (6, 'Essay', '10');
insert into assignment (assignmentID, title, section) values (7, 'HW1', '13');
insert into assignment (assignmentID, title, section) values (8, 'Project', '4');
insert into assignment (assignmentID, title, section) values (9, 'Discussion Board', '14');
insert into assignment (assignmentID, title, section) values (10, 'Project', '8');
insert into assignment (assignmentID, title, section) values (11, 'HW3', '11');
insert into assignment (assignmentID, title, section) values (12, 'HW1', '9');
insert into assignment (assignmentID, title, section) values (13, 'Project', '18');
insert into assignment (assignmentID, title, section) values (14, 'Essay', '20');
insert into assignment (assignmentID, title, section) values (15, 'Essay', '2');
insert into assignment (assignmentID, title, section) values (16, 'Discussion Board', '19');
insert into assignment (assignmentID, title, section) values (17, 'Project', '16');
insert into assignment (assignmentID, title, section) values (18, 'Project', '3');
insert into assignment (assignmentID, title, section) values (19, 'HW4', '15');
insert into assignment (assignmentID, title, section) values (20, 'HW4', '12');
insert into assignment (assignmentID, title, section) values (21, 'Essay', '17');
insert into assignment (assignmentID, title, section) values (22, 'HW1', '10');
insert into assignment (assignmentID, title, section) values (23, 'Essay', '15');
insert into assignment (assignmentID, title, section) values (24, 'HW3', '5');
insert into assignment (assignmentID, title, section) values (25, 'HW4', '4');
insert into assignment (assignmentID, title, section) values (26, 'HW4', '9');
insert into assignment (assignmentID, title, section) values (27, 'HW1', '20');
insert into assignment (assignmentID, title, section) values (28, 'Essay', '1');
insert into assignment (assignmentID, title, section) values (29, 'HW1', '13');
insert into assignment (assignmentID, title, section) values (30, 'Project', '12');
insert into assignment (assignmentID, title, section) values (31, 'Discussion Board', '8');
insert into assignment (assignmentID, title, section) values (32, 'HW3', '14');
insert into assignment (assignmentID, title, section) values (33, 'Essay', '11');
insert into assignment (assignmentID, title, section) values (34, 'HW1', '16');
insert into assignment (assignmentID, title, section) values (35, 'HW4', '2');
insert into assignment (assignmentID, title, section) values (36, 'HW4', '18');
insert into assignment (assignmentID, title, section) values (37, 'Discussion Board', '7');
insert into assignment (assignmentID, title, section) values (38, 'Project', '6');
insert into assignment (assignmentID, title, section) values (39, 'HW3', '3');
insert into assignment (assignmentID, title, section) values (40, 'Project', '19');
insert into assignment (assignmentID, title, section) values (41, 'HW2', '5');
insert into assignment (assignmentID, title, section) values (42, 'Project', '4');
insert into assignment (assignmentID, title, section) values (43, 'HW3', '17');
insert into assignment (assignmentID, title, section) values (44, 'Discussion Board', '7');
insert into assignment (assignmentID, title, section) values (45, 'HW3', '19');
insert into assignment (assignmentID, title, section) values (46, 'HW4', '10');
insert into assignment (assignmentID, title, section) values (47, 'HW2', '9');
insert into assignment (assignmentID, title, section) values (48, 'HW1', '6');
insert into assignment (assignmentID, title, section) values (49, 'HW3', '3');
insert into assignment (assignmentID, title, section) values (50, 'HW1', '2');
insert into assignment (assignmentID, title, section) values (51, 'HW2', '15');
insert into assignment (assignmentID, title, section) values (52, 'Essay', '13');
insert into assignment (assignmentID, title, section) values (53, 'Essay', '18');
insert into assignment (assignmentID, title, section) values (54, 'Discussion Board', '16');
insert into assignment (assignmentID, title, section) values (55, 'Project', '12');
insert into assignment (assignmentID, title, section) values (56, 'HW2', '1');
insert into assignment (assignmentID, title, section) values (57, 'HW3', '14');
insert into assignment (assignmentID, title, section) values (58, 'HW1', '20');
insert into assignment (assignmentID, title, section) values (59, 'Essay', '8');
insert into assignment (assignmentID, title, section) values (60, 'HW3', '11');


insert into student_in_section (courseGrade, section, student) values ('C', '5', '709911459');
insert into student_in_section (courseGrade, section, student) values ('F', '16', '430137621');
insert into student_in_section (courseGrade, section, student) values ('F', '6', '736975408');
insert into student_in_section (courseGrade, section, student) values ('A', '9', '309241968');
insert into student_in_section (courseGrade, section, student) values ('D', '12', '066103042');
insert into student_in_section (courseGrade, section, student) values ('B', '3', '864921979');
insert into student_in_section (courseGrade, section, student) values ('D', '13', '885287610');
insert into student_in_section (courseGrade, section, student) values ('B', '18', '847293915');
insert into student_in_section (courseGrade, section, student) values ('F', '4', '101550030');
insert into student_in_section (courseGrade, section, student) values ('A', '7', '668912915');
insert into student_in_section (courseGrade, section, student) values ('D', '1', '208824366');
insert into student_in_section (courseGrade, section, student) values ('C', '20', '646540446');
insert into student_in_section (courseGrade, section, student) values ('B', '2', '144967911');
insert into student_in_section (courseGrade, section, student) values ('D', '10', '351722198');
insert into student_in_section (courseGrade, section, student) values ('D', '8', '344002314');
insert into student_in_section (courseGrade, section, student) values ('C', '15', '408247039');
insert into student_in_section (courseGrade, section, student) values ('A', '11', '471046761');
insert into student_in_section (courseGrade, section, student) values ('A', '17', '353922438');
insert into student_in_section (courseGrade, section, student) values ('B', '14', '170603864');
insert into student_in_section (courseGrade, section, student) values ('C', '19', '286492868');
insert into student_in_section (courseGrade, section, student) values ('D', '7', '662812808');
insert into student_in_section (courseGrade, section, student) values ('A', '20', '213010296');
insert into student_in_section (courseGrade, section, student) values ('C', '16', '969568580');
insert into student_in_section (courseGrade, section, student) values ('F', '6', '910730881');
insert into student_in_section (courseGrade, section, student) values ('C', '1', '876728620');
insert into student_in_section (courseGrade, section, student) values ('C', '9', '262783120');
insert into student_in_section (courseGrade, section, student) values ('A', '10', '385372533');
insert into student_in_section (courseGrade, section, student) values ('F', '12', '576868893');
insert into student_in_section (courseGrade, section, student) values ('B', '13', '417310536');
insert into student_in_section (courseGrade, section, student) values ('B', '5', '728332948');
insert into student_in_section (courseGrade, section, student) values ('D', '15', '781328454');
insert into student_in_section (courseGrade, section, student) values ('C', '14', '127729284');
insert into student_in_section (courseGrade, section, student) values ('A', '19', '311503673');
insert into student_in_section (courseGrade, section, student) values ('C', '3', '654586019');
insert into student_in_section (courseGrade, section, student) values ('A', '2', '781407056');
insert into student_in_section (courseGrade, section, student) values ('A', '11', '882554518');
insert into student_in_section (courseGrade, section, student) values ('D', '18', '079201413');
insert into student_in_section (courseGrade, section, student) values ('F', '4', '822187199');
insert into student_in_section (courseGrade, section, student) values ('F', '17', '975959388');
insert into student_in_section (courseGrade, section, student) values ('B', '8', '936440240');
insert into student_in_section (courseGrade, section, student) values ('B', '18', '915542531');
insert into student_in_section (courseGrade, section, student) values ('D', '15', '952601307');
insert into student_in_section (courseGrade, section, student) values ('C', '19', '410173101');
insert into student_in_section (courseGrade, section, student) values ('C', '5', '671912866');
insert into student_in_section (courseGrade, section, student) values ('C', '13', '167708818');
insert into student_in_section (courseGrade, section, student) values ('F', '11', '232297641');
insert into student_in_section (courseGrade, section, student) values ('D', '1', '712216352');
insert into student_in_section (courseGrade, section, student) values ('C', '20', '994100873');
insert into student_in_section (courseGrade, section, student) values ('B', '14', '929465938');
insert into student_in_section (courseGrade, section, student) values ('D', '9', '433908013');
insert into student_in_section (courseGrade, section, student) values ('C', '7', '354060512');
insert into student_in_section (courseGrade, section, student) values ('B', '4', '406039340');
insert into student_in_section (courseGrade, section, student) values ('D', '12', '784635679');
insert into student_in_section (courseGrade, section, student) values ('C', '2', '920071541');
insert into student_in_section (courseGrade, section, student) values ('F', '3', '061637638');
insert into student_in_section (courseGrade, section, student) values ('D', '17', '560104095');
insert into student_in_section (courseGrade, section, student) values ('F', '10', '650037988');
insert into student_in_section (courseGrade, section, student) values ('C', '16', '267316743');
insert into student_in_section (courseGrade, section, student) values ('C', '8', '390409604');
insert into student_in_section (courseGrade, section, student) values ('C', '6', '937257308');
insert into student_in_section (courseGrade, section, student) values ('A', '3', '636886853');
insert into student_in_section (courseGrade, section, student) values ('D', '6', '767583463');
insert into student_in_section (courseGrade, section, student) values ('F', '4', '371732583');
insert into student_in_section (courseGrade, section, student) values ('C', '19', '499298617');
insert into student_in_section (courseGrade, section, student) values ('F', '15', '523690103');
insert into student_in_section (courseGrade, section, student) values ('D', '16', '678029520');
insert into student_in_section (courseGrade, section, student) values ('D', '1', '546772574');
insert into student_in_section (courseGrade, section, student) values ('F', '8', '576802979');
insert into student_in_section (courseGrade, section, student) values ('D', '14', '806098124');
insert into student_in_section (courseGrade, section, student) values ('D', '17', '318011696');
insert into student_in_section (courseGrade, section, student) values ('D', '9', '503531198');
insert into student_in_section (courseGrade, section, student) values ('D', '7', '935368794');
insert into student_in_section (courseGrade, section, student) values ('C', '12', '291078568');
insert into student_in_section (courseGrade, section, student) values ('A', '5', '405244403');
insert into student_in_section (courseGrade, section, student) values ('C', '13', '212502033');
insert into student_in_section (courseGrade, section, student) values ('C', '2', '638452263');
insert into student_in_section (courseGrade, section, student) values ('B', '10', '697701360');
insert into student_in_section (courseGrade, section, student) values ('D', '18', '948455752');
insert into student_in_section (courseGrade, section, student) values ('B', '20', '870403205');
insert into student_in_section (courseGrade, section, student) values ('B', '11', '050621150');
insert into student_in_section (courseGrade, section, student) values ('A', '13', '384691397');
insert into student_in_section (courseGrade, section, student) values ('C', '4', '305084979');
insert into student_in_section (courseGrade, section, student) values ('D', '3', '340840798');
insert into student_in_section (courseGrade, section, student) values ('C', '11', '703230495');
insert into student_in_section (courseGrade, section, student) values ('A', '10', '843089960');
insert into student_in_section (courseGrade, section, student) values ('A', '1', '456036684');
insert into student_in_section (courseGrade, section, student) values ('A', '12', '211588155');
insert into student_in_section (courseGrade, section, student) values ('F', '20', '845949921');
insert into student_in_section (courseGrade, section, student) values ('C', '9', '648932300');
insert into student_in_section (courseGrade, section, student) values ('C', '7', '746867997');
insert into student_in_section (courseGrade, section, student) values ('F', '2', '129800446');
insert into student_in_section (courseGrade, section, student) values ('A', '5', '136699651');
insert into student_in_section (courseGrade, section, student) values ('F', '18', '706537309');
insert into student_in_section (courseGrade, section, student) values ('D', '15', '188651535');
insert into student_in_section (courseGrade, section, student) values ('D', '16', '993134023');
insert into student_in_section (courseGrade, section, student) values ('C', '17', '289554569');
insert into student_in_section (courseGrade, section, student) values ('D', '19', '501079354');
insert into student_in_section (courseGrade, section, student) values ('C', '8', '191432472');
insert into student_in_section (courseGrade, section, student) values ('A', '14', '411966960');
insert into student_in_section (courseGrade, section, student) values ('A', '6', '789751664');

insert into exam_grades (examGrade, exam, student) values (7, '55', '542795148');
insert into exam_grades (examGrade, exam, student) values (81, '20', '218772864');
insert into exam_grades (examGrade, exam, student) values (2, '22', '340840798');
insert into exam_grades (examGrade, exam, student) values (94, '59', '002467295');
insert into exam_grades (examGrade, exam, student) values (17, '35', '816546443');
insert into exam_grades (examGrade, exam, student) values (42, '21', '191432472');
insert into exam_grades (examGrade, exam, student) values (97, '29', '196030806');
insert into exam_grades (examGrade, exam, student) values (69, '19', '354060512');
insert into exam_grades (examGrade, exam, student) values (2, '52', '286492868');
insert into exam_grades (examGrade, exam, student) values (45, '33', '926482350');
insert into exam_grades (examGrade, exam, student) values (51, '57', '870403205');
insert into exam_grades (examGrade, exam, student) values (99, '13', '576802979');
insert into exam_grades (examGrade, exam, student) values (50, '27', '289554569');
insert into exam_grades (examGrade, exam, student) values (51, '5', '208101928');
insert into exam_grades (examGrade, exam, student) values (96, '16', '845949921');
insert into exam_grades (examGrade, exam, student) values (90, '38', '501079354');
insert into exam_grades (examGrade, exam, student) values (59, '36', '483645469');
insert into exam_grades (examGrade, exam, student) values (32, '7', '778752380');
insert into exam_grades (examGrade, exam, student) values (50, '17', '011864162');
insert into exam_grades (examGrade, exam, student) values (39, '6', '313423715');
insert into exam_grades (examGrade, exam, student) values (30, '53', '433908013');
insert into exam_grades (examGrade, exam, student) values (79, '40', '929465938');
insert into exam_grades (examGrade, exam, student) values (24, '23', '885287610');
insert into exam_grades (examGrade, exam, student) values (29, '46', '796104744');
insert into exam_grades (examGrade, exam, student) values (86, '56', '793856359');
insert into exam_grades (examGrade, exam, student) values (98, '37', '478125790');
insert into exam_grades (examGrade, exam, student) values (99, '44', '136699651');
insert into exam_grades (examGrade, exam, student) values (37, '14', '969568580');
insert into exam_grades (examGrade, exam, student) values (75, '15', '641827574');
insert into exam_grades (examGrade, exam, student) values (99, '24', '932440761');
insert into exam_grades (examGrade, exam, student) values (49, '18', '981101673');
insert into exam_grades (examGrade, exam, student) values (86, '11', '406039340');
insert into exam_grades (examGrade, exam, student) values (91, '4', '890830071');
insert into exam_grades (examGrade, exam, student) values (16, '2', '581628584');
insert into exam_grades (examGrade, exam, student) values (43, '9', '330729929');
insert into exam_grades (examGrade, exam, student) values (70, '39', '833226485');
insert into exam_grades (examGrade, exam, student) values (45, '60', '767583463');
insert into exam_grades (examGrade, exam, student) values (8, '10', '362571883');
insert into exam_grades (examGrade, exam, student) values (90, '49', '668912915');
insert into exam_grades (examGrade, exam, student) values (50, '54', '341939155');
insert into exam_grades (examGrade, exam, student) values (71, '41', '066103042');
insert into exam_grades (examGrade, exam, student) values (93, '43', '101550030');
insert into exam_grades (examGrade, exam, student) values (11, '45', '493204195');
insert into exam_grades (examGrade, exam, student) values (66, '48', '371732583');
insert into exam_grades (examGrade, exam, student) values (4, '58', '898505692');
insert into exam_grades (examGrade, exam, student) values (25, '51', '917332305');
insert into exam_grades (examGrade, exam, student) values (2, '12', '853071659');
insert into exam_grades (examGrade, exam, student) values (66, '30', '729368246');
insert into exam_grades (examGrade, exam, student) values (13, '31', '127729284');
insert into exam_grades (examGrade, exam, student) values (25, '26', '215294487');
insert into exam_grades (examGrade, exam, student) values (73, '34', '317492386');
insert into exam_grades (examGrade, exam, student) values (44, '32', '769017786');
insert into exam_grades (examGrade, exam, student) values (87, '50', '496297874');
insert into exam_grades (examGrade, exam, student) values (44, '42', '289206777');
insert into exam_grades (examGrade, exam, student) values (20, '28', '948455752');
insert into exam_grades (examGrade, exam, student) values (20, '3', '948083124');
insert into exam_grades (examGrade, exam, student) values (99, '8', '703230495');
insert into exam_grades (examGrade, exam, student) values (71, '1', '728332948');
insert into exam_grades (examGrade, exam, student) values (34, '47', '159563092');
insert into exam_grades (examGrade, exam, student) values (44, '25', '170603864');
insert into exam_grades (examGrade, exam, student) values (35, '40', '262783120');
insert into exam_grades (examGrade, exam, student) values (85, '58', '067657332');
insert into exam_grades (examGrade, exam, student) values (81, '41', '384691397');
insert into exam_grades (examGrade, exam, student) values (56, '13', '546772574');
insert into exam_grades (examGrade, exam, student) values (28, '47', '083387211');
insert into exam_grades (examGrade, exam, student) values (5, '45', '232297641');
insert into exam_grades (examGrade, exam, student) values (26, '54', '503531198');
insert into exam_grades (examGrade, exam, student) values (83, '10', '678029520');
insert into exam_grades (examGrade, exam, student) values (25, '37', '937257308');
insert into exam_grades (examGrade, exam, student) values (13, '9', '479649698');
insert into exam_grades (examGrade, exam, student) values (2, '3', '662812808');
insert into exam_grades (examGrade, exam, student) values (29, '49', '434717031');
insert into exam_grades (examGrade, exam, student) values (62, '32', '697701360');
insert into exam_grades (examGrade, exam, student) values (26, '20', '213010296');
insert into exam_grades (examGrade, exam, student) values (75, '31', '712216352');
insert into exam_grades (examGrade, exam, student) values (0, '42', '913396442');
insert into exam_grades (examGrade, exam, student) values (11, '26', '501903245');
insert into exam_grades (examGrade, exam, student) values (30, '44', '144967911');
insert into exam_grades (examGrade, exam, student) values (45, '15', '305084979');
insert into exam_grades (examGrade, exam, student) values (46, '36', '961248815');
insert into exam_grades (examGrade, exam, student) values (67, '33', '210264915');
insert into exam_grades (examGrade, exam, student) values (13, '2', '649678085');
insert into exam_grades (examGrade, exam, student) values (23, '1', '646540446');
insert into exam_grades (examGrade, exam, student) values (11, '29', '876728620');
insert into exam_grades (examGrade, exam, student) values (9, '28', '855636894');
insert into exam_grades (examGrade, exam, student) values (99, '59', '309241968');
insert into exam_grades (examGrade, exam, student) values (7, '23', '833755859');
insert into exam_grades (examGrade, exam, student) values (80, '52', '706537309');
insert into exam_grades (examGrade, exam, student) values (34, '16', '167708818');
insert into exam_grades (examGrade, exam, student) values (62, '55', '789751664');
insert into exam_grades (examGrade, exam, student) values (78, '57', '129800446');
insert into exam_grades (examGrade, exam, student) values (67, '5', '636886853');
insert into exam_grades (examGrade, exam, student) values (96, '24', '456036684');
insert into exam_grades (examGrade, exam, student) values (61, '30', '499298617');
insert into exam_grades (examGrade, exam, student) values (70, '17', '576868893');
insert into exam_grades (examGrade, exam, student) values (52, '43', '696712685');
insert into exam_grades (examGrade, exam, student) values (64, '56', '777133284');
insert into exam_grades (examGrade, exam, student) values (86, '7', '696432556');
insert into exam_grades (examGrade, exam, student) values (93, '38', '367716873');
insert into exam_grades (examGrade, exam, student) values (81, '22', '837751144');

insert into assignment_grades (assignmentGrade, assignment, student) values (24, '11', '392346038');
insert into assignment_grades (assignmentGrade, assignment, student) values (44, '19', '344002314');
insert into assignment_grades (assignmentGrade, assignment, student) values (2, '26', '696432556');
insert into assignment_grades (assignmentGrade, assignment, student) values (36, '8', '208824366');
insert into assignment_grades (assignmentGrade, assignment, student) values (89, '38', '353922438');
insert into assignment_grades (assignmentGrade, assignment, student) values (91, '3', '576321081');
insert into assignment_grades (assignmentGrade, assignment, student) values (95, '2', '471046761');
insert into assignment_grades (assignmentGrade, assignment, student) values (37, '53', '232297641');
insert into assignment_grades (assignmentGrade, assignment, student) values (20, '55', '501903245');
insert into assignment_grades (assignmentGrade, assignment, student) values (53, '40', '142921912');
insert into assignment_grades (assignmentGrade, assignment, student) values (96, '52', '769417989');
insert into assignment_grades (assignmentGrade, assignment, student) values (0, '23', '638452263');
insert into assignment_grades (assignmentGrade, assignment, student) values (62, '25', '581628584');
insert into assignment_grades (assignmentGrade, assignment, student) values (9, '37', '784635679');
insert into assignment_grades (assignmentGrade, assignment, student) values (81, '13', '777133284');
insert into assignment_grades (assignmentGrade, assignment, student) values (13, '41', '167708818');
insert into assignment_grades (assignmentGrade, assignment, student) values (22, '60', '011864162');
insert into assignment_grades (assignmentGrade, assignment, student) values (96, '7', '196030806');
insert into assignment_grades (assignmentGrade, assignment, student) values (58, '50', '614491662');
insert into assignment_grades (assignmentGrade, assignment, student) values (24, '14', '778752380');
insert into assignment_grades (assignmentGrade, assignment, student) values (55, '1', '233432422');
insert into assignment_grades (assignmentGrade, assignment, student) values (59, '22', '885287610');
insert into assignment_grades (assignmentGrade, assignment, student) values (37, '28', '430137621');
insert into assignment_grades (assignmentGrade, assignment, student) values (45, '42', '413096594');
insert into assignment_grades (assignmentGrade, assignment, student) values (48, '6', '354060512');
insert into assignment_grades (assignmentGrade, assignment, student) values (1, '44', '210264915');
insert into assignment_grades (assignmentGrade, assignment, student) values (18, '5', '191432472');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '45', '714186647');
insert into assignment_grades (assignmentGrade, assignment, student) values (75, '51', '816546443');
insert into assignment_grades (assignmentGrade, assignment, student) values (19, '58', '853071659');
insert into assignment_grades (assignmentGrade, assignment, student) values (95, '18', '678029520');
insert into assignment_grades (assignmentGrade, assignment, student) values (94, '16', '981101673');
insert into assignment_grades (assignmentGrade, assignment, student) values (74, '36', '953688719');
insert into assignment_grades (assignmentGrade, assignment, student) values (3, '20', '710666380');
insert into assignment_grades (assignmentGrade, assignment, student) values (35, '47', '668912915');
insert into assignment_grades (assignmentGrade, assignment, student) values (29, '46', '137246310');
insert into assignment_grades (assignmentGrade, assignment, student) values (81, '48', '699337120');
insert into assignment_grades (assignmentGrade, assignment, student) values (99, '12', '439424440');
insert into assignment_grades (assignmentGrade, assignment, student) values (72, '32', '515041103');
insert into assignment_grades (assignmentGrade, assignment, student) values (83, '59', '703230495');
insert into assignment_grades (assignmentGrade, assignment, student) values (42, '9', '493204195');
insert into assignment_grades (assignmentGrade, assignment, student) values (23, '34', '604969197');
insert into assignment_grades (assignmentGrade, assignment, student) values (92, '21', '920071541');
insert into assignment_grades (assignmentGrade, assignment, student) values (76, '39', '129800446');
insert into assignment_grades (assignmentGrade, assignment, student) values (17, '29', '546772574');
insert into assignment_grades (assignmentGrade, assignment, student) values (22, '17', '852550683');
insert into assignment_grades (assignmentGrade, assignment, student) values (71, '35', '479018338');
insert into assignment_grades (assignmentGrade, assignment, student) values (74, '49', '050621150');
insert into assignment_grades (assignmentGrade, assignment, student) values (22, '54', '709911459');
insert into assignment_grades (assignmentGrade, assignment, student) values (73, '27', '503531198');
insert into assignment_grades (assignmentGrade, assignment, student) values (60, '57', '662812808');
insert into assignment_grades (assignmentGrade, assignment, student) values (85, '24', '975959388');
insert into assignment_grades (assignmentGrade, assignment, student) values (73, '10', '317492386');
insert into assignment_grades (assignmentGrade, assignment, student) values (13, '43', '883519657');
insert into assignment_grades (assignmentGrade, assignment, student) values (38, '31', '456036684');
insert into assignment_grades (assignmentGrade, assignment, student) values (72, '4', '961248815');
insert into assignment_grades (assignmentGrade, assignment, student) values (94, '15', '575402803');
insert into assignment_grades (assignmentGrade, assignment, student) values (38, '33', '969568580');
insert into assignment_grades (assignmentGrade, assignment, student) values (7, '30', '882554518');
insert into assignment_grades (assignmentGrade, assignment, student) values (74, '56', '305084979');
insert into assignment_grades (assignmentGrade, assignment, student) values (62, '21', '371732583');
insert into assignment_grades (assignmentGrade, assignment, student) values (94, '35', '781328454');
insert into assignment_grades (assignmentGrade, assignment, student) values (17, '14', '305906891');
insert into assignment_grades (assignmentGrade, assignment, student) values (37, '4', '929465938');
insert into assignment_grades (assignmentGrade, assignment, student) values (12, '28', '079201413');
insert into assignment_grades (assignmentGrade, assignment, student) values (16, '40', '729368246');
insert into assignment_grades (assignmentGrade, assignment, student) values (6, '53', '865315111');
insert into assignment_grades (assignmentGrade, assignment, student) values (1, '11', '433908013');
insert into assignment_grades (assignmentGrade, assignment, student) values (18, '23', '671912866');
insert into assignment_grades (assignmentGrade, assignment, student) values (87, '20', '898505692');
insert into assignment_grades (assignmentGrade, assignment, student) values (85, '9', '915542531');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '59', '917332305');
insert into assignment_grades (assignmentGrade, assignment, student) values (43, '27', '948083124');
insert into assignment_grades (assignmentGrade, assignment, student) values (61, '6', '067657332');
insert into assignment_grades (assignmentGrade, assignment, student) values (54, '29', '291078568');
insert into assignment_grades (assignmentGrade, assignment, student) values (14, '1', '417310536');
insert into assignment_grades (assignmentGrade, assignment, student) values (11, '37', '411966960');
insert into assignment_grades (assignmentGrade, assignment, student) values (48, '32', '385372533');
insert into assignment_grades (assignmentGrade, assignment, student) values (6, '33', '222920019');
insert into assignment_grades (assignmentGrade, assignment, student) values (76, '49', '650037988');
insert into assignment_grades (assignmentGrade, assignment, student) values (25, '24', '390409604');
insert into assignment_grades (assignmentGrade, assignment, student) values (91, '34', '353235303');
insert into assignment_grades (assignmentGrade, assignment, student) values (13, '19', '935368794');
insert into assignment_grades (assignmentGrade, assignment, student) values (44, '42', '636886853');
insert into assignment_grades (assignmentGrade, assignment, student) values (33, '25', '696712685');
insert into assignment_grades (assignmentGrade, assignment, student) values (91, '10', '159563092');
insert into assignment_grades (assignmentGrade, assignment, student) values (57, '55', '289554569');
insert into assignment_grades (assignmentGrade, assignment, student) values (97, '12', '367716873');
insert into assignment_grades (assignmentGrade, assignment, student) values (37, '50', '822187199');
insert into assignment_grades (assignmentGrade, assignment, student) values (65, '57', '806098124');
insert into assignment_grades (assignmentGrade, assignment, student) values (49, '47', '262783120');
insert into assignment_grades (assignmentGrade, assignment, student) values (48, '13', '083387211');
insert into assignment_grades (assignmentGrade, assignment, student) values (63, '16', '351722198');
insert into assignment_grades (assignmentGrade, assignment, student) values (23, '38', '330729929');
insert into assignment_grades (assignmentGrade, assignment, student) values (63, '44', '496241754');
insert into assignment_grades (assignmentGrade, assignment, student) values (96, '2', '136699651');
insert into assignment_grades (assignmentGrade, assignment, student) values (37, '22', '501079354');
insert into assignment_grades (assignmentGrade, assignment, student) values (7, '30', '127729284');
insert into assignment_grades (assignmentGrade, assignment, student) values (40, '48', '781407056');
insert into assignment_grades (assignmentGrade, assignment, student) values (65, '7', '855636894');


insert into major_courses (major, course) values ('21', '4750');
insert into major_courses (major, course) values ('6', '3952');
insert into major_courses (major, course) values ('19', '1140');
insert into major_courses (major, course) values ('4', '4891');
insert into major_courses (major, course) values ('1', '1302');
insert into major_courses (major, course) values ('5', '7959');
insert into major_courses (major, course) values ('26', '8511');
insert into major_courses (major, course) values ('16', '6724');
insert into major_courses (major, course) values ('9', '6288');
insert into major_courses (major, course) values ('28', '0264');
insert into major_courses (major, course) values ('17', '2275');
insert into major_courses (major, course) values ('20', '7399');
insert into major_courses (major, course) values ('7', '0274');
insert into major_courses (major, course) values ('24', '6139');
insert into major_courses (major, course) values ('18', '1133');
insert into major_courses (major, course) values ('14', '9732');
insert into major_courses (major, course) values ('8', '6760');
insert into major_courses (major, course) values ('12', '2377');
insert into major_courses (major, course) values ('25', '9072');
insert into major_courses (major, course) values ('10', '9792');
insert into major_courses (major, course) values ('29', '1600');
insert into major_courses (major, course) values ('27', '1828');
insert into major_courses (major, course) values ('3', '2148');
insert into major_courses (major, course) values ('30', '6092');
insert into major_courses (major, course) values ('23', '2880');
insert into major_courses (major, course) values ('13', '2399');
insert into major_courses (major, course) values ('11', '6141');
insert into major_courses (major, course) values ('15', '8679');
insert into major_courses (major, course) values ('2', '9050');
insert into major_courses (major, course) values ('22', '9243');
insert into major_courses (major, course) values ('17', '8066');
insert into major_courses (major, course) values ('18', '8688');
insert into major_courses (major, course) values ('12', '5642');
insert into major_courses (major, course) values ('20', '7306');
insert into major_courses (major, course) values ('28', '4447');
insert into major_courses (major, course) values ('10', '1034');
insert into major_courses (major, course) values ('25', '0635');
insert into major_courses (major, course) values ('4', '4568');
insert into major_courses (major, course) values ('9', '4134');
insert into major_courses (major, course) values ('5', '5560');
insert into major_courses (major, course) values ('30', '5818');
insert into major_courses (major, course) values ('22', '4399');
insert into major_courses (major, course) values ('16', '4475');
insert into major_courses (major, course) values ('27', '4863');
insert into major_courses (major, course) values ('3', '7825');
insert into major_courses (major, course) values ('14', '7975');
insert into major_courses (major, course) values ('8', '6479');
insert into major_courses (major, course) values ('21', '5280');
insert into major_courses (major, course) values ('19', '8747');
insert into major_courses (major, course) values ('13', '3931');
insert into major_courses (major, course) values ('23', '1568');
insert into major_courses (major, course) values ('26', '0772');
insert into major_courses (major, course) values ('6', '2819');
insert into major_courses (major, course) values ('15', '1225');
insert into major_courses (major, course) values ('1', '6196');
insert into major_courses (major, course) values ('11', '3154');
insert into major_courses (major, course) values ('2', '3477');
insert into major_courses (major, course) values ('29', '8536');
insert into major_courses (major, course) values ('24', '7858');
insert into major_courses (major, course) values ('7', '6519');
insert into major_courses (major, course) values ('20', '2880');
insert into major_courses (major, course) values ('25', '4134');
insert into major_courses (major, course) values ('21', '2377');
insert into major_courses (major, course) values ('27', '7306');
insert into major_courses (major, course) values ('7', '6724');
insert into major_courses (major, course) values ('5', '9072');
insert into major_courses (major, course) values ('19', '6196');
insert into major_courses (major, course) values ('13', '8747');
insert into major_courses (major, course) values ('26', '9243');
insert into major_courses (major, course) values ('8', '4891');
insert into major_courses (major, course) values ('2', '4568');
insert into major_courses (major, course) values ('10', '1225');
insert into major_courses (major, course) values ('29', '1828');
insert into major_courses (major, course) values ('6', '1600');
insert into major_courses (major, course) values ('14', '1133');
insert into major_courses (major, course) values ('9', '4399');
insert into major_courses (major, course) values ('15', '7959');
insert into major_courses (major, course) values ('17', '6760');
insert into major_courses (major, course) values ('23', '8511');
insert into major_courses (major, course) values ('22', '9050');
insert into major_courses (major, course) values ('11', '7825');
insert into major_courses (major, course) values ('16', '6139');
insert into major_courses (major, course) values ('3', '0264');
insert into major_courses (major, course) values ('1', '5642');
insert into major_courses (major, course) values ('30', '1568');
insert into major_courses (major, course) values ('28', '4863');
insert into major_courses (major, course) values ('18', '3952');
insert into major_courses (major, course) values ('24', '8066');
insert into major_courses (major, course) values ('4', '7975');
insert into major_courses (major, course) values ('12', '9792');
insert into major_courses (major, course) values ('17', '8679');
insert into major_courses (major, course) values ('24', '9732');
insert into major_courses (major, course) values ('5', '2148');
insert into major_courses (major, course) values ('10', '6141');
insert into major_courses (major, course) values ('20', '1034');
insert into major_courses (major, course) values ('21', '8688');
insert into major_courses (major, course) values ('6', '8536');
insert into major_courses (major, course) values ('8', '0635');
insert into major_courses (major, course) values ('29', '4447');
insert into major_courses (major, course) values ('23', '1140');
showing first 100 rows
