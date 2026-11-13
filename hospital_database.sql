CREATE DATABASE hospitaldb;
USE hospitaldb;
 
CREATE TABLE department (
    departmentid INT PRIMARY KEY,
    departmentname VARCHAR(50),
    phonenumber VARCHAR(20),
    location VARCHAR(50)
);
 
CREATE TABLE staff (
    staffid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    jobtitle VARCHAR(50),
    hiredate DATE,
    phone VARCHAR(20),
    email VARCHAR(150),
    departmentid INT,
    FOREIGN KEY (departmentid) REFERENCES department(departmentid)
);
 
CREATE TABLE patient (
    patientid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    dateofbirth DATE,
    address VARCHAR(200),
    phone VARCHAR(20),
    medicalhistory VARCHAR(255),
    emergencycontact VARCHAR(100)
);
 
CREATE TABLE treatment (
    treatmentid INT PRIMARY KEY,
    treatmentname VARCHAR(100),
    description VARCHAR(255),
    cost DECIMAL(10,2)
);
 
CREATE TABLE appointment (
    appointmentid INT PRIMARY KEY,
    patientid INT,
    staffid INT,
    treatmentid INT,
    appointmentdate DATE,
    appointmenttime TIME,
    notes VARCHAR(255),
    FOREIGN KEY (patientid) REFERENCES patient(patientid),
    FOREIGN KEY (staffid) REFERENCES staff(staffid),
    FOREIGN KEY (treatmentid) REFERENCES treatment(treatmentid)
);
 
CREATE TABLE staffleave (
    leaveid INT PRIMARY KEY,
    staffid INT,
    daysoff INT,
    reason VARCHAR(100),
    FOREIGN KEY (staffid) REFERENCES staff(staffid)
);
 
INSERT INTO department VALUES
(1,'cardiology','903-887-4507','chicago'),
(2,'orthopedics','187-388-0999','miami'),
(3,'pediatrics','691-806-7495','portland'),
(4,'general surgery','273-528-2428','dallas'),
(5,'oncology','960-366-3967','denver'),
(6,'radiology','364-139-7118','san diego'),
(7,'emergency care','655-355-1121','phoenix'),
(8,'dermatology','978-857-6444','seattle'),
(9,'neurology','706-629-0011','boston'),
(10,'administration','908-476-1461','houston');
 
INSERT INTO staff VALUES
(101,'Kristen','Smith','doctor','2018-01-10','0871111111','kristen.smith@hospitalmail.com',1),
(102,'Tristan','Jones','nurse','2020-03-15','0872222222','tristan.jones@hospitalmail.com',2),
(103,'Walter','Brown','doctor','2019-07-20','0873333333','walter.brown@hospitalmail.com',3),
(104,'Paige','White','surgeon','2017-11-05','0874444444','paige.white@hospitalmail.com',4),
(105,'Stavros','Clark','nurse','2021-04-18','0875555555','stavros.clark@hospitalmail.com',6),
(106,'Suzanne','Wilson','doctor','2016-12-12','0876666666','suzanne.wilson@hospitalmail.com',4),
(107,'Andy','Taylor','radiologist','2022-02-20','0877777777','andy.taylor@hospitalmail.com',7),
(108,'Wolf','Adams','support','2023-01-05','0878888888','wolf.adams@hospitalmail.com',10),
(109,'Robert','Moore','doctor','2015-05-22','0879999999','robert.moore@hospitalmail.com',1),
(110,'Reynold','Lee','office worker','2020-10-15','0871010101','reynold.lee@hospitalmail.com',10);
 
INSERT INTO patient VALUES
(5612,'John','Bob','1985-04-12','12 green road','0891111111','diabetes','Sarah Bob'),
(3456,'Alice','Reid','1990-06-20','45 long street','0892222222','asthma','Martin Reid'),
(3001,'Peter','Long','1978-08-15','8 bridge road','0893333333','hypertension','Maria Long'),
(3002,'Mary','Stone','1982-01-10','67 oak avenue','0894444444','arthritis','Paul Stone'),
(3003,'Kevin','Miles','1995-10-25','22 hill road','0895555555','none','June Miles'),
(3004,'Brian','King','1972-02-14','90 pine street','0896666666','cancer','Carol King'),
(3005,'Sophie','Grant','2001-03-03','33 elm road','0897777777','allergies','Mark Grant'),
(3006,'Daniel','Cole','1988-11-19','51 cedar road','0898888888','diabetes','Laura Cole'),
(3007,'Ella','Young','1993-07-07','28 river lane','0899999999','heart condition','Brian Young'),
(3008,'Tom','Hall','1998-09-29','14 park road','0891010101','none','Emma Hall');
 
INSERT INTO treatment VALUES
(201,'heart surgery','full heart procedure',12000.00),
(202,'knee replacement','orthopedic knee surgery',8000.00),
(203,'skin treatment','dermatology skin repair',300.00),
(204,'mri scan','magnetic imaging scan',500.00),
(205,'chemotherapy','cancer treatment therapy',15000.00),
(206,'vaccination','standard immunisation',100.00),
(207,'fracture fixation','bone fracture surgical repair',4000.00),
(208,'neuro scan','brain imaging scan',700.00),
(209,'emergency care','immediate emergency service',200.00),
(210,'appendix surgery','appendix removal surgery',6000.00);
 
INSERT INTO appointment VALUES
(501,5612,101,201,'2025-02-01','10:00:00','general check'),
(502,3456,102,207,'2025-02-03','11:30:00','follow up'),
(503,3001,103,206,'2025-01-25','09:00:00','vaccine'),
(504,3002,104,210,'2025-02-10','14:00:00','pre-op'),
(505,3003,105,209,'2025-01-30','16:00:00','emergency visit'),
(506,3004,106,205,'2025-02-15','13:00:00','chemo visit'),
(507,3005,107,204,'2025-02-08','12:00:00','scan'),
(508,3006,108,203,'2025-02-04','15:00:00','skin issue'),
(509,3007,109,201,'2025-02-12','10:30:00','heart review'),
(510,3008,110,202,'2025-02-06','09:45:00','knee consult');
 
INSERT INTO staffleave VALUES
(1,101,4,'sick'),
(2,102,2,'family'),
(3,103,6,'break'),
(4,104,1,'sick'),
(5,105,3,'training'),
(6,106,5,'personal'),
(7,107,2,'medical'),
(8,108,7,'holiday'),
(9,109,4,'travel'),
(10,110,2,'personal');

SELECT * 
FROM Department;

SELECT firstname, lastname, phone, address
FROM patient
WHERE patientid = 5612
AND firstname = 'John'
AND lastname = 'Bob';

UPDATE patient
SET phone = '0876543210',
    address = '12 Park Street'
WHERE patientid = 3456;

insert into appointment (appointmentid, patientid, staffid, treatmentid, appointmentdate, appointmenttime, notes)
values (600, 3456, 101, 203, '2025-01-20', '10:30:00', 'new appointment');

SELECT *
FROM patient
WHERE medicalhistory LIKE '%diabetes%';

SELECT p.firstname, p.lastname
FROM patient p
JOIN appointment a ON p.patientid = a.patientid
JOIN staff s ON a.staffid = s.staffid
WHERE s.firstname = 'Kristen'
AND s.lastname = 'Smith';

UPDATE department
SET departmentname = 'Orthopedic Surgery'
WHERE departmentname = 'orthopedics';

SELECT firstname, lastname, hiredate
FROM staff
WHERE jobtitle = 'doctor'
ORDER BY hiredate DESC;

SELECT COUNT(*) AS HeartSurgeryPatients
FROM appointment a
JOIN treatment t ON a.treatmentid = t.treatmentid
WHERE t.treatmentname = 'heart surgery';

INSERT INTO department VALUES (11, 'Neurology', '0123456789', 'Building C');
INSERT INTO staff VALUES (300, 'Alice', 'Moore', 'Nurse', '2021-05-10', '0872223344', 'alice.moore@hospitalmail.com', 11);
INSERT INTO patient VALUES (8000, 'Sam', 'Cole', '1990-04-12', '45 Oak Road', '0867774321', 'Asthma', 'Parent Cole');
INSERT INTO treatment VALUES (40, 'MRI Scan', 'Magnetic imaging scan', 400.00);
INSERT INTO appointment VALUES (5000, 8000, 300, 40, '2025-02-10', '09:00:00', 'new appointment');

DELETE FROM department WHERE departmentid = 20;
DELETE FROM staff WHERE staffid = 300;

select s.staffid, s.firstname, s.lastname, sl.daysoff
from staff s
join staffleave sl on s.staffid = sl.staffid
order by sl.daysoff asc;

UPDATE staff
SET jobtitle = 'Administrator'
WHERE jobtitle = 'office worker';

UPDATE department
SET phonenumber = '01-7654321'
WHERE departmentname = 'Orthopedic Surgery';

UPDATE staff
SET firstname = 'Michael',
lastname = 'Dean'
WHERE jobtitle = 'office worker';

SELECT *
FROM Staff
WHERE HireDate <= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

SELECT p.firstname, p.lastname, p.medicalhistory, a.appointmentdate, a.appointmenttime, t.treatmentname
FROM patient p
JOIN appointment a ON p.patientid = a.patientid
JOIN treatment t ON a.treatmentid = t.treatmentid;

SELECT COUNT(*) AS RoadCount
FROM patient
WHERE address LIKE '%road%';

CREATE VIEW PatientAppointments AS
SELECT p.firstname, p.lastname, a.appointmentdate, t.treatmentname
FROM patient p
JOIN appointment a ON p.patientid = a.patientid
JOIN treatment t ON a.treatmentid = t.treatmentid;

DELETE FROM appointment;
