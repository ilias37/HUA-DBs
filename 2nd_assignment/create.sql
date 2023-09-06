ALTER SESSION SET nls_date_format='DD-MM-YYYY';

CREATE TABLE REPAIR_STATION(
Repair_Station_id NUMBER(4),
CONSTRAINT pk_Repair_Station PRIMARY KEY (Repair_Station_id) 
);

CREATE TABLE REPAIR_PLATFORM(
Platform_id NUMBER(4) NOT NULL,
Validation_Num NUMBER(10) NOT NULL,
Photo BLOB,
Head_Station NUMBER(4) NOT NULL,
Supervisor_id NUMBER(4) UNIQUE NOT NULL,
CONSTRAINT pk_Repair_Platform PRIMARY KEY (Platform_id),
CONSTRAINT fk_Repair_Platform FOREIGN KEY (Head_Station) REFERENCES REPAIR_STATION(Repair_Station_id)
);

CREATE TABLE REPAIR_PARTS(
Part_id NUMBER(4) NOT NULL,
Title VARCHAR2(20) UNIQUE NOT NULL,
IsSparePart VARCHAR2(20),
Unit_Cost NUMBER(5),
StockNum NUMBER(4),
Head_Repair_Station NUMBER(4) NOT NULL,
CONSTRAINT pk_Repair_Parts PRIMARY KEY (Part_id),
CONSTRAINT fk_Repair_Parts FOREIGN KEY (Head_Repair_Station) REFERENCES REPAIR_STATION(Repair_Station_id)
);

CREATE TABLE ENGINEER(
Engineer_id NUMBER(4) NOT NULL,
Engineer_Name VARCHAR2(50) NOT NULL,
Engineer_Surname VARCHAR2(50) NOT NULL,
ID_Card VARCHAR2(10) UNIQUE NOT NULL,
Speciality VARCHAR2(50),
HireDate DATE,
Address VARCHAR2(50),
Phonenumber NUMBER(20) UNIQUE, 
CONSTRAINT pk_Engineer PRIMARY KEY (Engineer_id),
CONSTRAINT fk_Engineer FOREIGN KEY (Engineer_id) REFERENCES REPAIR_PLATFORM(Supervisor_id)
);

CREATE TABLE REPAIR_TASK_TYPE(
Task_Type_id NUMBER(4) NOT NULL,
Title VARCHAR2(20),
Unit_Cost NUMBER(5),
Unit_Metric VARCHAR2(30),
CONSTRAINT pk_Repair_Task_Type PRIMARY KEY (Task_Type_ID)
);

CREATE TABLE VEHICLE(
Vehicle_Type VARCHAR2(10),
License_Plate VARCHAR2(10) NOT NULL,
Brand VARCHAR2(50),
Vehicle_Model VARCHAR2(50),
Release_date DATE,
Km NUMBER(6),
Engine VARCHAR2(50),
Lc_Date DATE,
Lc_Km NUMBER(6), 
Vehicle_Power NUMBER(5),
CONSTRAINT pk_Vehicle PRIMARY KEY (License_Plate)
);

CREATE TABLE WORKS_ON_TASK(
Platform_id NUMBER(4),
Engineer_id NUMBER(4), 
CONSTRAINT fk_Platform_id FOREIGN KEY (Platform_id) REFERENCES REPAIR_PLATFORM(Platform_id),
CONSTRAINT fk_Engineer_id FOREIGN KEY (Engineer_id) REFERENCES ENGINEER(Engineer_id)
);

CREATE TABLE HOSTS(
DateTime TIMESTAMP,
Hosting_Platform_id NUMBER(4) NOT NULL,
Hosted_License_plate VARCHAR2(10) NOT NULL,
CONSTRAINT fk_Hosting_Platform_id FOREIGN KEY (Hosting_Platform_id) REFERENCES REPAIR_PLATFORM(Platform_id),
CONSTRAINT fk_Hosted_License_plate FOREIGN KEY (Hosted_License_plate) REFERENCES VEHICLE(License_Plate)
);

CREATE TABLE PERFORM(
Performing_Engineer_id NUMBER(4) NOT NULL,
Performed_Task_id NUMBER(4) NOT NULL,
CONSTRAINT fk_Performing_Engineer_id FOREIGN KEY (Performing_Engineer_id) REFERENCES ENGINEER(Engineer_id),
CONSTRAINT fk_Performed_Task_id FOREIGN KEY (Performed_Task_id) REFERENCES REPAIR_TASK_TYPE(Task_Type_id)
);

CREATE TABLE EXECUTED_TASK(
UseSpareParts VARCHAR2(100),
DateTime TIMESTAMP,
TaskUnits VARCHAR2(50),
Task_Description VARCHAR2(1000),
Vehicle_plate VARCHAR2(10) NOT NULL,
Executed_Task_type_id NUMBER(4) NOT NULL,
CONSTRAINT fk_Vehicle_plate FOREIGN KEY (Vehicle_plate) REFERENCES VEHICLE(License_Plate),
CONSTRAINT fk_Executed_Task_type_id FOREIGN KEY (Executed_Task_type_id) REFERENCES REPAIR_TASK_TYPE(Task_Type_id)
);
