CREATE TABLE CUSTOMER_venkat
(
	CustomerId int IDENTITY(1,1) PRIMARY KEY,
	CustomerNumber int NOT NULL UNIQUE,
	LastName varchar(50) NOT NULL,
	FirstName varchar(50) NOT NULL,
	AreaCode int NULL,
	[Address] varchar(50) NULL,
	Phone varchar(50) NULL,
)
Alter table CUSTOMER_venkat
WITH CHECK ADD  CONSTRAINT [ck_custNumber]  CHECK  (CustomerNumber>0) 
go
ALTER TABLE CUSTOMER_venkat
  ADD CONSTRAINT DF_address
  DEFAULT 'India' FOR [Address] ;
go
select * from CUSTOMER_venkat
go
CREATE TABLE SCHOOL_venkat
(
SchoolId int IDENTITY(1,1) PRIMARY KEY,
SchoolName varchar(50) NOT NULL UNIQUE,
Description varchar(1000) NULL,
Address varchar(50) NULL,
Phone varchar(50) NULL,
PostCode varchar(50) NULL,
PostAddress varchar(50) NULL,
)
EXEC sp_rename 'SCHOOL_venkat.Location', 'Address', 'COLUMN';

EXEC sp_rename 'old column', 'newcolumn', 'COLUMN';

CREATE TABLE CLASS_venkat
(
ClassId int IDENTITY(1,1) PRIMARY KEY,
SchoolId int NOT NULL FOREIGN KEY REFERENCES SCHOOL_venkat (SchoolId),
ClassName varchar(50) NOT NULL UNIQUE,
Description varchar(1000) NULL,
)
----
INSERT INTO CUSTOMER_venkat  VALUES (1000, 'Smith', 'John', 12, 'California',
'11111111')
Select * from CUSTOMER_venkat
INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName) VALUES (1001, 'Smith', 'John')
INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName) VALUES (1002, 'Smith', 'John')
INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName) VALUES (1003, 'Smith', 'John')
INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName) VALUES (1004, 'Smith', 'John')
INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName) VALUES (1008, 'Smith', 'John')

INSERT INTO CUSTOMER_venkat (CustomerNumber,FirstName,LastName)
select 1005, 'Smith', 'John'
union
select 1006, 'Smith', 'John'
union
select 1007, 'Smith', 'John'

-- Updates
update CUSTOMER_venkat set AreaCode=46 where CustomerId=2
-- delete
delete from CUSTOMER_venkat where CustomerId=4
--
Select * from CUSTOMER_venkat where AreaCode is null

update CUSTOMER_venkat set AreaCode=0 
where AreaCode is null