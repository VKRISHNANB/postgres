use northwind
select * from employees where firstname='nancy'
select * from employees where firstname='Nancy'

select * from employees where firstname='nancy'
COLLATE SQL_Latin1_General_CP1_CS_AS

------
SELECT SERVERPROPERTY('collation') SQLServerCollation
,DATABASEPROPERTYEX('master', 'Collation') AS MasterDBCollation
--------
-- The SELECT statement returns the value 1252, which is the code page identifier
SELECT COLLATIONPROPERTY('SQL_Latin1_General_CP1_CS_AS', 'CodePage');
SELECT COLLATIONPROPERTY('Modern_Spanish_100_CS_AS', 'CodePage');
-- ***********

use sample
CREATE TABLE Locations (Place varchar(15) NOT NULL); 
INSERT Locations(Place) VALUES ('Chiapas'),('Colima') , ('Cinco Rios'), ('California');

SELECT Place FROM Locations ORDER BY Place 
GO 

SELECT Place FROM Locations ORDER BY Place 
COLLATE Latin1_General_CS_AS_KS_WS ASC; 
GO 
-- Apply a Spanish collation 
SELECT Place FROM Locations ORDER BY Place 
COLLATE Traditional_Spanish_ci_ai ASC; 
GO 

use Sample
go;
select * from emptbl where   name ='Ram' 
COLLATE Latin1_General_CS_AS

select * from emptbl where   name ='ram' 
COLLATE SQL_Latin1_General_CP1_CS_AS


