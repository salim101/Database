DROP TABLE Delivery CASCADE CONSTRAINTS PURGE;		-- Drop Delivery Table --
DROP TABLE OnSite CASCADE CONSTRAINTS PURGE;		-- Drop OnSite Table --
DROP TABLE OffSite CASCADE CONSTRAINTS PURGE;		-- Drop OffSite Table --
DROP TABLE ServiceCenter CASCADE CONSTRAINTS PURGE;	-- Drop ServiceCenter Table --
DROP TABLE Fault CASCADE CONSTRAINTS PURGE;			-- Drop Fault Table --
DROP TABLE Sale CASCADE CONSTRAINTS PURGE;			-- Drop Sale Table --
DROP TABLE Customer CASCADE CONSTRAINTS PURGE;		-- Drop Customer Table --
DROP TABLE Appliance CASCADE CONSTRAINTS PURGE;		-- Drop Appliance Table --
DROP TABLE Manufacturer CASCADE CONSTRAINTS PURGE;	-- Drop Manufacturer Table --

CREATE TABLE Manufacturer -- Create Manufacturer Table with the below fields and data type --
(
	Manufacture_ID       NUMBER(6) NOT NULL ,
	Manufacture_Name     VARCHAR2(30) NULL ,
	Gurantee_Length      NUMBER(2) NULL ,
CONSTRAINT  Manufacturer_ID_PK PRIMARY KEY (Manufacture_ID)
);

CREATE TABLE Appliance -- Create Appliance Table with the below fields and data type --
(
	Serial_No            NUMBER(6) NOT NULL ,
	Brand                VARCHAR2(30) NULL ,
	Price                NUMBER(6,2) NULL ,
	Quantity             NUMBER(6) NULL ,
	Manufacture_ID       NUMBER(6) NULL ,
CONSTRAINT  Appliance_Serail_No_PK PRIMARY KEY (Serial_No),
CONSTRAINT Manufacturer_Appliance_FK FOREIGN KEY (Manufacture_ID) REFERENCES Manufacturer (Manufacture_ID)
);

CREATE TABLE Customer -- Create Customer Table with the below fields and data type --
(
	Customer_ID          NUMBER(6) NOT NULL ,
	Customer_Name        VARCHAR2(30) NULL ,
	Customer_Address     VARCHAR2(50) NULL ,
	Customer_PhoneNo     VARCHAR2(20) NULL ,
CONSTRAINT  Customer_ID_PK PRIMARY KEY (Customer_ID)
);

CREATE TABLE Sale -- Create Sale Table with the below fields and data type --
(
	Receipt_ID           NUMBER(6) NOT NULL ,
	Date_of_Purchased    DATE NULL ,
	Serial_No            NUMBER(6) NULL ,
	Customer_ID          NUMBER(6) NULL ,
CONSTRAINT  Sale_Receipt_ID_PK PRIMARY KEY (Receipt_ID),
CONSTRAINT Appliance_Sale_FK FOREIGN KEY (Serial_No) REFERENCES Appliance (Serial_No),
CONSTRAINT Customer_Sale_FK FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID)
);

CREATE TABLE Fault -- Create Fault Table with the below fields and data type --
(
	Fault_ID             NUMBER(6) NOT NULL ,
	Description          VARCHAR2(50) NULL ,
	Condition            VARCHAR2(30) NULL ,
	Date_Submit          DATE NULL ,
	Replaced_Before      VARCHAR2(3) NULL ,
	Repairable_onSite    VARCHAR2(3) NULL ,
	Receipt_ID           NUMBER(6) NULL ,
	Manufacture_ID       NUMBER(6) NULL ,
CONSTRAINT  Fault_ID_PK PRIMARY KEY (Fault_ID),
CONSTRAINT Sale_Fault_FK FOREIGN KEY (Receipt_ID) REFERENCES Sale (Receipt_ID),
CONSTRAINT Manufacturer_Fault_FK FOREIGN KEY (Manufacture_ID) REFERENCES Manufacturer (Manufacture_ID)
);

CREATE TABLE ServiceCenter -- Create ServiceCenter Table with the below fields and data type --
(
	ServiceCenter_ID     NUMBER(6) NOT NULL ,
	Name                 VARCHAR2(30) NULL ,
	Address              VARCHAR2(50) NULL ,
	Contact_No           VARCHAR2(20) NULL ,
	Manufacture_ID       NUMBER(6) NULL ,
CONSTRAINT  ServiceCenter_ID_PK PRIMARY KEY (ServiceCenter_ID),
CONSTRAINT Manufacturer_ServiceCenter_FK FOREIGN KEY (Manufacture_ID) REFERENCES Manufacturer (Manufacture_ID)
);

CREATE TABLE OffSite -- Create OffSite Table with the below fields and data type --
(
	Date_Repaired        DATE NOT NULL ,
	Fault_ID             NUMBER(6) NOT NULL ,
	ServiceCenter_ID     NUMBER(6) NOT NULL ,
	Part_Replaced        VARCHAR2(50) NULL ,
	Duration             VARCHAR2(30) NULL ,
	Date_Returned        DATE NULL ,
CONSTRAINT  OffSite_Date_Repaired_PK PRIMARY KEY (Date_Repaired,Fault_ID,ServiceCenter_ID),
CONSTRAINT Fault_OffSite_FK FOREIGN KEY (Fault_ID) REFERENCES Fault (Fault_ID),
CONSTRAINT ServiceCenter_OffSite_FK FOREIGN KEY (ServiceCenter_ID) REFERENCES ServiceCenter (ServiceCenter_ID)
);

CREATE TABLE OnSite -- Create OnSite Table with the below fields and data type --
(
	Date_Repaired        DATE NOT NULL ,
	Fault_ID             NUMBER(6) NOT NULL ,
	Part_Replaced        VARCHAR2(50) NULL ,
	Duration             VARCHAR2(30) NULL ,
CONSTRAINT  OnSite_Date_Repaired_PK PRIMARY KEY (Date_Repaired,Fault_ID),
CONSTRAINT Fault_OnSite_FK FOREIGN KEY (Fault_ID) REFERENCES Fault (Fault_ID)
);

CREATE TABLE Delivery -- Create Delivery Table with the below fields and data type --
(
	Delivery_ID          NUMBER(6) NOT NULL ,
	Delivery_Date        DATE NULL ,
	Serial_No            NUMBER(6) NULL ,
CONSTRAINT  Delivery_ID_PK PRIMARY KEY (Delivery_ID),
CONSTRAINT Appliance_Delivery_FK FOREIGN KEY (Serial_No) REFERENCES Appliance (Serial_No)
);

-- insert below data into Manufacturer table --
Insert INTO Manufacturer values (1, 'Phillips',1);
Insert INTO Manufacturer values (2, 'Panasonic',2);
Insert INTO Manufacturer values (3, 'Kenwood',1);
Insert INTO Manufacturer values (4, 'Amica',2);
Insert INTO Manufacturer values (5, 'Glen Dimplex',2);
Insert INTO Manufacturer values (6, 'LG',1);
Insert INTO Manufacturer values (7, 'Vistel',2);
Insert INTO Manufacturer values (8, 'Samsung',1);
Insert INTO Manufacturer values (9, 'Zanussi',2);
Insert INTO Manufacturer values (10, 'Dell',2);


-- insert below data into Appliance table --
Insert INTO Appliance values (1, 'DVD Player',49.99,15,1);
Insert INTO Appliance values (2, 'HD TV',1239.99,9,2);
Insert INTO Appliance values (3, 'Food Processor',63.79,13,3);
Insert INTO Appliance values (4, 'Cooker',499.49,5,4);
Insert INTO Appliance values (5, 'Dishwasher',399.99,15,5);
Insert INTO Appliance values (6, 'Dryer',299.49,11,6);
Insert INTO Appliance values (7, 'Fridge',799.99,15,7);
Insert INTO Appliance values (8, 'Microwave',79.49,23,8);
Insert INTO Appliance values (9, 'Oven',159.99,16,9);
Insert INTO Appliance values (10, 'Laptop',499.79,19,10);


-- insert below data into Customer table --
Insert INTO Customer values (1, 'D.Smith','11 The Hool,Dublin','01 237230');
Insert INTO Customer values (2, 'B.Byrne','1 Rock Road,Dublin','01 256985');
Insert INTO Customer values (3, 'X.Dobbs','13 Beech Wood,Dublin','01 265986');
Insert INTO Customer values (4, 'K.John','79 Eustace Park,Dublin','01 874596');
Insert INTO Customer values (5, 'B.Ben','5 Ann Road,Dublin','01 695632');
Insert INTO Customer values (6, 'A.Mary','51 Prussia Street,Dublin','01 845696');
Insert INTO Customer values (7, 'M.Sinead','19 Glencullen Road,Wicklow','01 365412');
Insert INTO Customer values (8, 'H.Dale','1 Mount Garret Park,Kildare','01 302698');
Insert INTO Customer values (9, 'A.Usman','6 York Road,Galway','01 102546');
Insert INTO Customer values (10, 'U.Salim','2 Main Road,Dublin','01 102360');


-- insert below data into Sale table --
Insert INTO Sale values (1, '04 MAR 2014',1,1);
Insert INTO Sale values (2, '04 MAR 2012',2,2);
Insert INTO Sale values (3, '01 JAN 2014',3,1);
Insert INTO Sale values (4, '15 AUG 2014',5,7);
Insert INTO Sale values (5, '07 DEC 2013',10,10);
Insert INTO Sale values (6, '23 JUN 2014',10,6);
Insert INTO Sale values (7, '17 FEB 2012',6,4);
Insert INTO Sale values (8, '21 FEB 2012',10,1);
Insert INTO Sale values (9, '18 MAR 2013',4,7);
Insert INTO Sale values (10, '05 AUG 2013',2,5);
Insert INTO Sale values (11, '11 JUL 2014',8,2);
Insert INTO Sale values (12, '02 NOV 2014',3,8);
Insert INTO Sale values (13, '14 SEP 2013',8,3);
Insert INTO Sale values (14, '19 NOV 2014',4,3);
Insert INTO Sale values (15, '18 MAR 2013',1,3);
Insert INTO Sale values (16, '05 AUG 2013',4,9);
Insert INTO Sale values (17, '11 JUL 2014',10,1);
Insert INTO Sale values (18, '02 NOV 2014',3,7);
Insert INTO Sale values (19, '14 SEP 2013',5,6);
Insert INTO Sale values (20, '19 NOV 2014',1,5);


-- insert below data into Fault table --
Insert INTO Fault values (1, 'Not displaying anything','Good','19 SEP 2014','N','Y',1,1);
Insert INTO Fault values (2, 'Over Heating','some scratches on screen','01 DEC 2014','N','N',5,10);
Insert INTO Fault values (3, 'Flickering Lines appear on screen','used but looks new','6 JUN 2013','N','N',2,2);
Insert INTO Fault values (4, 'Does not blend','used','23 AUG 2014','N','Y',3,3);
Insert INTO Fault values (5, 'No power','Used','19 SEP 2014','N','N',9,4);
Insert INTO Fault values (6, 'Buttons not working','Good Condition','26 NOV 2014','N','Y',11,8);
Insert INTO Fault values (7, 'Not Booting Up','New','18 JUL 2014','N','Y',6,10);
Insert INTO Fault values (8, 'Not Draining','New','27 AUG 2014','N','N',4,5);
Insert INTO Fault values (9, 'Keyboard not functioning','New','19 OCT 2014','N','Y',17,10);
Insert INTO Fault values (10, 'Damage Screen','used','23 AUG 2014','N','N',10,2);


-- insert below data into ServiceCenter table --
Insert INTO ServiceCenter values (1, 'Phillips Repair Centre','22 Dame St,Dublin','1800 855 589',1);
Insert INTO ServiceCenter values (2, 'Panasonic Repair Centre','Unit 4 Kinsealy Business Park,Co.Dublin','018456986',2);
Insert INTO ServiceCenter values (3, 'Kenwood Repair Centre','253 Harolds Cross Road, Terenure,Dublin 6','014968036',3);
Insert INTO ServiceCenter values (4, 'Amica Repair Centre',' Newlands Cross, Naas Road, Dublin','0818 46 46 46',4);
Insert INTO ServiceCenter values (5, 'Glen Dimplex Repair Centre','Glen Dimplex Ireland-Dunleer,County Louth','018424833',5);
Insert INTO ServiceCenter values (6, 'LG Repair Centre','Unit 55 Block 50,Greenogue Business,Co.Dublin','014018103',6);
Insert INTO ServiceCenter values (7, 'Vistel Repair Centre','43 Orion Business Campus Ballycoolin,Dublin','016205618',7);
Insert INTO ServiceCenter values (8, 'Samsung Repair Centre','The Grange Offices Stillorgan Road,Dublin','0818 717100',8);
Insert INTO ServiceCenter values (9, 'Zanussi Repair Centre','Tallaght Enterprise Centre Main Road Dublin 24','014526062',9);
Insert INTO ServiceCenter values (10, 'Dell Repair Centre','Cherrywood Science & Technology Park,Dublin 18','1800 351 856',10);



-- insert below data into OffSite table --
Insert INTO OffSite values ('04 DEC 2014',2,10,'Replaced Fan','2 Hours','05 DEC 2014');
Insert INTO OffSite values ('15 JUN 2013',3,2,'Replaced with new screen','1 day','17 JUN 2013');
Insert INTO OffSite values ('27 SEP 2014',5,4,'Replaced Timer','5 Hours','29 SEP 2014');
Insert INTO OffSite values ('01 SEP 2014',8,5,'Replaced Drain Pump and Motor','2 days','13 SEP 2014');
Insert INTO OffSite values ('28 AUG 2014',10,2,'Replaced with new screen','4 Hours','29 AUG 2014');



-- insert below data into OnSite table --
Insert INTO OnSite values ('25 SEP 2014',1,'New Graphic Card','1 Hour');
Insert INTO OnSite values ('01 SEP 2014',4,'New Motor','50 Mins');
Insert INTO OnSite values ('29 NOV 2014',6,'Replaced Touchpad','3 Hours');
Insert INTO OnSite values ('21 JUL 2014',7,'Replaced Hard Drive','2 Hours');
Insert INTO OnSite values ('20 OCT 2014',9,'Replaced new Keyboard','2 Hours');



-- insert below data into Delivery table --
Insert INTO Delivery values (1, '17 FEB 2012',6);
Insert INTO Delivery values (2, '1 MAR 2014',1);
Insert INTO Delivery values (3, '11 SEP 2013',5);
Insert INTO Delivery values (4, '7 DEC 2011',7);
Insert INTO Delivery values (5, '3 JUL 2014',2);
Insert INTO Delivery values (6, '19 APR 2012',10);
Insert INTO Delivery values (7, '25 NOV 2013',4);
Insert INTO Delivery values (8, '3 OCT 2014',9);
Insert INTO Delivery values (9, '15 JAN 2012',3);
Insert INTO Delivery values (10, '30 MAY 2014',8);

commit;



--			Details of queries to be created 		--

--The use of  a SINGLE ROW function
		-- show fault description in upper case from Fault Table --
SELECT FAULT_ID,DESCRIPTION,DATE_SUBMIT,UPPER(Description) AS Description FROM Fault;

--The use of an AGGREGATE function
		-- find appliance that has a highest price --
SELECT 'Max Price',MAX(Price) AS Highest_Price FROM Appliance;

--An INNER JOIN on two tables
		-- find the manufacture of each appliance --
SELECT A.SERIAL_NO,A.BRAND,A.PRICE, M.MANUFACTURE_NAME  FROM APPLIANCE A JOIN MANUFACTURER M ON A.MANUFACTURE_ID=M.MANUFACTURE_ID;
    
--An INNER JOIN on three tables
		-- find a customer with an appliance that they have purchased --
 SELECT C.CUSTOMER_NAME,S.DATE_OF_PURCHASED, A.BRAND, A.PRICE FROM CUSTOMER C JOIN SALE S ON C.CUSTOMER_ID=S.CUSTOMER_ID JOIN APPLIANCE A ON S.SERIAL_NO=S.SERIAL_NO;
    
    
--A LEFT OUTER JOIN
    --find appliance that hasn't been sold yet
 SELECT * FROM appliance a LEFT OUTER JOIN sale s ON a.serial_no=s.serial_no;
    
--A RIGHT OUTER JOIN
    --find appliances sold that hasn't been returned for repair. 
SELECT f.fault_id,f.description,f.date_submit,s.date_of_purchased,s.serial_no,s.customer_id FROM fault f RIGHT OUTER JOIN sale s  ON s.receipt_id=f.receipt_id;



--			Details of alterations to be made 		--

--UPDATE selected data.
		-- update Glen Dimplex Repair Centre to Dimplex Repair Centre and contact no from 018424833 to 1800 698 107 in ServiceCenter Table --
UPDATE ServiceCenter SET Name = 'Dimplex Repair Centre', Contact_No = '1800 698 107' WHERE ServiceCenter_ID = '5';

--ADD a column to a table. 
		-- Add column called Delivery_From to Delivery Table
ALTER TABLE Delivery ADD Delivery_From VARCHAR2(30);

--ADD a value constraint to a table.
		-- 1) Add a value constraint on the Manufacturer Name to be unique
ALTER TABLE Manufacturer ADD CONSTRAINT unique_Man_Name UNIQUE (Manufacture_Name);

--MODIFY a column on a table.

		-- Modify Gurantee_Length column from NUMBER to VARCHAR2(7)in Manufacturer Table
ALTER TABLE Manufacturer MODIFY Gurantee_Length VARCHAR2(7);

--DROP a column on a table.
		-- Drop Delivery_From column in Delivery Table
ALTER TABLE Delivery DROP COLUMN Delivery_From;

--DROP  a constraint on a table.
		-- Drop a unique_Man_Name constraint on the Manufacture_Name in Manufacturer table
ALTER TABLE Manufacturer DROP CONSTRAINT unique_Man_Name;


