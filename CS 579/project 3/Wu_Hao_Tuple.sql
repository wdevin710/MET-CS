INSERT INTO BOSTON_PAPER.CUSTOMER (CName, Phone, Address)
VALUES ('Hao', '123456', '30Cambridge');
INSERT INTO BOSTON_PAPER.CUSTOMER (CName, Phone, Address)
VALUES ('Pu', '654321', '29Cambridge');
INSERT INTO BOSTON_PAPER.CUSTOMER (CName, Phone, Address)
VALUES ('Jia', '111111', '28Cambridge');

INSERT INTO BOSTON_PAPER.PAPER_ORDER
VALUES (1,'2000-01-01', '30','Hao' );
INSERT INTO BOSTON_PAPER.PAPER_ORDER
VALUES 
	(2,'2000-01-01', '100','Hao'),
	(3,'2000-01-02', '99','Pu' ),
    (4,'2000-01-01', '300','Pu'),
    (5,'2000-01-01', '500','Jia');
    
INSERT INTO BOSTON_PAPER.BRANCH
VALUES
	('Hao','10','11111','30Cambridge'),
    ('Jia','9','22222','29Cambridge'),
    ('Jia','8','33333','28Cambridge'),
    ('Jia','7','44444','27Cambridge'),
    ('Pu','6','55555','26Cambridge'),
    ('Hao','5','66666','30Cambridge'),
    ('Jia','4','77777','30Cambridge'),
    ('Jia','3','88888','30Cambridge'),
    ('Pu','2','99999','30Cambridge'),
    ('Pu','1','98765','30Cambridge'),
    ('Pu','0','56789','30Cambridge');
    
INSERT INTO BOSTON_PAPER.SUBORDER
VALUES
	(1,'Hao',11,'2000-02-02','2000-02-03','10'),
    (2,'Hao',12,'2000-02-15','2000-02-15','5'),
    (3,'Pu',13,'2000-02-08','2000-02-08','6'),
    (4,'Pu',14,'2000-02-20','2000-02-21','0'),
    (5,'Jia',15,'2000-02-02','2000-02-02','9'),
    (5,'Jia',16,'2000-02-10','2000-02-11','8'),
    (5,'Jia',17,'2000-02-28','2000-02-29','3'),
    (3,'Pu',18,'2000-02-10','2000-02-18','2'),
    (4,'Pu',19,'2000-02-02','2000-02-27','1'),
    (5,'Jia',20,'2000-02-15','2000-02-19','4'),
    (5,'Jia',21,'2000-02-15','2000-02-19','7');

INSERT INTO BOSTON_PAPER.EMPLOYEE
VALUES
	(1,'Jin','90Wash','1999-01-01','30000','manager'),
    (2,'Da','89Wash','1998-01-01','20000','associate'),
    (3,'Hong','88Wash','1997-01-01','10000','assistant'),
    (4,'Li','87Wash','1999-01-01','40000','manager'),
    (5,'Ko','86Wash','2000-01-01','60000','manager');

INSERT INTO BOSTON_PAPER.HANDLES
VALUES
	(1,1),
    (1,2),
    (1,3),
    (1,4),
    (2,1),
    (2,2),
    (3,3),
    (3,4),
    (4,4),
    (4,5),
    (5,5);
    
INSERT INTO BOSTON_PAPER.PAPER
VALUES
	(1,10, '1.1','9'),
    (2,20, '2.2','6'),
    (3,30, '3.3','8'),
    (4,40, '4.4','15');
    
INSERT INTO BOSTON_PAPER.ORDER_ITEM
VALUES
	(1,1,'11','996'),
    (2,1,'12','885'),
    (1,3,'13','994'),
    (1,4,'14','993'),
    (1,5,'15','919'),
    (1,5,'16','991'),
    (3,5,'17','799'),
    (4,3,'18','699'),
    (2,4,'19','599'),
    (1,5,'20','499'),
    (1,5,'21','399'),
    (2,1,'11','299'),
    (4,1,'11','199'),
    (2,5,'16','99'),
    (2,5,'21','99');