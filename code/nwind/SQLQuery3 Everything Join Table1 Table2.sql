USE <SampleDB>
GO
CREATE TABLE table1
(ID INT, Value VARCHAR(10))
INSERT INTO Table1 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 4,'Fourth'
UNION ALL
SELECT 5,'Fifth'
GO
select * from table1
CREATE TABLE table2
(ID INT, Value VARCHAR(10))
INSERT INTO Table2 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 6,'Sixth'
UNION ALL
SELECT 7,'Seventh'
UNION ALL
SELECT 8,'Eighth'
GO
SELECT *
FROM Table1
SELECT *
FROM Table2
GO

-- USE AdventureWorks
GO
/* INNER JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
INNER JOIN Table2 t2 ON t1.ID = t2.ID

SELECT t1.*,t2.*
FROM Table1 t1, Table2 t2
where t1.ID = t2.ID
GO
/* LEFT JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* RIGHT JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* OUTER JOIN */
SELECT *
FROM Table1
SELECT *
FROM Table2
GO
SELECT t1.*,t2.*
FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* Full Join */
SELECT *
FROM Table1
SELECT *
FROM Table2
GO

SELECT t1.*,t2.*
FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* LEFT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t2.ID IS NULL
GO
/* RIGHT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL
GO
/* OUTER JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL OR t2.ID IS NULL
GO
/* CROSS JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
CROSS JOIN Table2 t2
GO
-----------------
Working with null

Use sample
go
select * from Customers where IP is null 
select c1.ID ,c1.Name, ISNULL(c1.ip,'NA') as IP  from Customers c1 where IP is null 
select c1.ID ,c1.Name, 
	case 
		when c1.ip is null then 'NA' else c1.IP
	end   
from Customers c1 --where IP is null 
select c1.ID ,c1.Name, Coalesce(c1.ip,'NA') as IP  from Customers c1  
--
USE AdventureWorks2012 ;
GO
SELECT Name, Class, Color, ProductNumber,
COALESCE(Class, Color, ProductNumber) AS FirstNotNull
FROM Production.Product ;
GO

-----------------
/*
DROP TABLE table1
DROP TABLE table2
GO
*/
use Northwind
-- Self Join
	select e1.EmployeeID, e1.FirstName, e2.FirstName as Manager, e1.City
	from Employees e1, Employees e2
	where e1.ReportsTo = e2.EmployeeID
	order By Manager, e1.EmployeeID
-- inner join
	select e1.EmployeeID, e1.FirstName, e2.FirstName as Manager, e1.City
	from Employees e1 inner join Employees e2 on
	e1.ReportsTo = e2.EmployeeID
	order By Manager, e1.EmployeeID
--
SELECT * FROM orders a INNER JOIN customers b ON a.customerid <> b.customerid
order by a.OrderID;

SELECT * FROM orders a , customers b where a.customerid <> b.customerid
order by a.OrderID;
---