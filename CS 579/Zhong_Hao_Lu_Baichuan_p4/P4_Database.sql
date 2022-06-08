-- CS579 Project Part 3
-- Create Tables
-- Baichuan Lu, Hao Zhong

DROP DATABASE IF EXISTS ordersys;
CREATE DATABASE IF NOT EXISTS `ordersys`;
USE `ordersys`;

CREATE TABLE CUSTOMER
(CName 	 VARCHAR (15)	NOT NULL,
 Phone	 char(10)		NOT NULL,
 Address VARCHAR (50),
 PRIMARY KEY (CName)
);

CREATE TABLE PAPER_ORDER
(OrderNo	INT				NOT NULL,
 OrderDate	DATE			NOT NULL,
 Amount 	INT				NOT NULL,
 CName      VARCHAR (15)	NOT NULL,
 PRIMARY KEY (OrderNo),
 FOREIGN KEY (CName) REFERENCES CUSTOMER(CName)
);  

CREATE TABLE BRANCH 
(CName 	 VARCHAR (15)	NOT NULL,
 BrNo	 char			NOT NULL,
 Address VARCHAR (50),
 Phone	 char(10)			NOT NULL,
 PRIMARY KEY (CName, BrNo),
 FOREIGN KEY (CName) REFERENCES CUSTOMER(CName) 
);

CREATE TABLE SUBORDER
(OrderNo	    INT		NOT NULL,
 SuborderNo		INT		NOT NULL,
 ReqShipDate	DATE	NOT NULL,
 ActualShipDate	 DATE	NOT NULL,
 CName 	 VARCHAR (15)	NOT NULL,
 BrNo	 char 		NOT NULL,
 PRIMARY KEY (OrderNo,SuborderNo),
 FOREIGN KEY (CName,BrNo) REFERENCES BRANCH(CName,BrNo) 
);

CREATE TABLE EMPLOYEE
(EmpNo			INT				NOT NULL,
 EmpName		VARCHAR(11)		NOT NULL,
 Address		VARCHAR(50),		
 DOB			DATE			NOT NULL,
 Class			char(10),
 Salary			INT				NOT NULL,
 PRIMARY KEY (EmpNo)
);

CREATE TABLE HANDLES
(EmpNo		INT	 NOT NULL,
OrderNo	INT	 NOT NULL,
 PRIMARY KEY (OrderNo,EmpNo),
 FOREIGN KEY (OrderNo) REFERENCES `PAPER_ORDER`(OrderNo),
 FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE(EmpNo)
);

CREATE TABLE PAPER
(TypeNo		INT		NOT NULL,
 Size		INT 	NOT NULL,
 Weight		INT		NOT NULL,
 UnitPrice	INT		NOT NULL,
 PRIMARY KEY (TypeNo)
);

CREATE TABLE ORDER_ITEM
(OrderNo		INT		NOT NULL,
 SuborderNo		INT		NOT NULL,
 TypeNo			INT		NOT NULL,
 Quantity	 	INT		NOT NULL,
FOREIGN KEY (TypeNo) REFERENCES PAPER(TypeNo),
FOREIGN KEY (OrderNo,SuborderNo) REFERENCES SUBORDER(OrderNo,SuborderNo) 
);



-- Customer Tuples:
Insert into customer
	Values 
		('Target',6178769999,'10 Apple St, Quincy, MA 02177'),
		('Walgreen', 6568787222, '1956 Banana St, Weymouth, MA 12067'),
        ('Walmart',7543236789, '1867 Pineapple St, Braintree, MA 36271' ),
        ('CVS',3217654637, '13 Orange St, Boston, MA 03261' );
-- Select * from customer;
        
-- Paper Order Tuples:
Insert Into Paper_Order
	Values
		(123, '2007-03-30', 100, 'Target'),
        (456, '2007-11-21', 100, 'Walgreen'),
        (789, '2008-02-28', 100, 'Walmart'),
        (111, '2010-05-15', 100, 'Target'),
        (222, '2010-05-20', 100, 'Target'),
        (333, '2010-05-21', 100, 'Walgreen'),
        (555, '2010-05-31', 100, 'CVS');
-- Select * from paper_order;

-- Branch Tuples:
Insert Into Branch
	Values
		('Target', 1, '11 Apple St, Quincy, MA 02177','1112223333'),
        ('Target', 2, '13 Strawberry St, Boston, MA 03261','1111111111'),
        ('Target', 3, '1958 Avocado St, Weymouth, MA 12067','3847102399'),
        ('Walmart',1, '11 Biscut St, Quincy, MA 02177','1236578390'),
		('Walmart',2, '13 Cake St, Boston, MA 03261','6472819426'),
		('Walmart',3, '1958 Sugar St, Weymouth, MA 12067','4523281937'),
        ('Walgreen',1, '13 Superman St, Boston, MA 03261','7283920384'),
		('Walgreen',2, '11 Spiderman St, Quincy, MA 02177','547389173'),
		('CVS',1, '1958 Husky St, Weymouth, MA 12067','7583210239'),
        ('CVS',2, '11 GoldenRetriver St, Quincy, MA 02177','7823452032');
-- Select * from branch;

-- SUBORDER Tuples:
Insert Into suborder
	Values
		(123, '001', '2007-04-01', '2007-04-01', 'Target', 1),
        (123, '002', '2007-04-01', '2007-04-02', 'Target', 2),
        (555, '001', '2010-06-01', '2010-06-01', 'CVS', 1),
        (555, '002', '2010-06-01', '2010-06-01', 'CVS', 2),
        -- (123, '003', '2007-04-01', '2007-04-01', 'Target', 3),
        (456, '001', '2007-11-30', '2007-12-01', 'Walgreen', 1),
        (456, '002', '2007-11-30', '2007-12-01', 'Walgreen', 2),
        (789, '001', '2008-03-05', '2008-03-05', 'Walmart', 1),
        -- (789, '003', '2008-03-09', '2008-03-09', 'Walmart', 3),
        (789, '002', '2008-03-07', '2008-03-07', 'Walmart', 2);
-- Select * from Suborder;

-- EMPLOYEE TUPLES:
Insert Into Employee
	Values
		(112233, 'Justin', '23 Happy St, Quincy, MA 02133', '1987-04-27', 'Manager', 100000),
        (778899, 'Caroline', '23 Happy St, Quincy, MA 02133', '1989-11-03', 'Manager', 100000),
        (445566, 'John', '34 Pen St, Bostonm MA 03421', '1975-02-03', 'Assistant', 80000),
        (113344, 'Anna', '45 Computer St, Dorchester, MA 23489', '1999-01-30', 'Associate', 50000),
        (224455, 'Bob', '57 Hancock St, Braintree, MA, 12356', '1991-12-06', 'Associate', 50000);
        
-- Select * from employee;

-- HANDLES Tuple:
Insert into handles
	Values
		(112233, 123),
        (224455, 123),
        (778899, 555),
        (445566, 555),
        (445566, 456),
        (113344, 456),
        (113344, 789);
-- Select * from handles;


-- PAPER Tuples:
Insert into Paper
	Values
		(1, 10, 20, 15),
        (2, 12, 22, 20),
        (3, 13, 25, 25),
        (4, 15, 26, 30),
        (5, 16, 30, 35);
-- Select * from paper;

-- ORDER ITEM TUPLES:
Insert into Order_Item
	Values
		(123, '001',1,30),
        (123, '001', 2, 20),
        (123, '002', 5, 35),
        -- (123, '003', 3, 15),
        (555, '001', 3, 150),
        (555, '001', 2, 20),
        (555, '002', 5, 30),
        (789, '001', 2, 20),
        (789, '001', 3, 50),
        (789, '002', 1, 30),
        (789, '002', 4, 40),
        -- (789, '003', 5, 60),
        (456, '002',1,50),
        (456, '002', 2, 30),
        (456, '001',3,70);
-- Select * from order_item;
