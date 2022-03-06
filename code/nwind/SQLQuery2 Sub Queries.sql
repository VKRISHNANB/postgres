Select orderid, freight from orders 
Select orderid, freight from orders  order by Freight asc
select top 3 freight from orders order by Freight asc
Select orderid, freight from orders  order by Freight desc
select top 3 freight from orders order by Freight desc
-----------------------
--Third highest freight
select orderid, freight 
from orders order by Freight desc
Select Min(freight) from (select top 3 freight from orders order by Freight desc) a
--second highest freight
select orderid, freight from orders order by Freight desc
Select Min(freight) from (select top 2 freight from orders order by Freight desc) a
--
Select * from Orders where freight in (select top 3 freight from orders order by Freight desc)
--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and 
-- common table expressions, unless TOP, OFFSET or FOR XML is also specified.
Select * from Orders where freight in (select freight from orders order by Freight desc)

----
SELECT COALESCE(NULL, NULL, NULL, 'abcd', NULL, 'Example.com');

---
/*
Correlated subquery
===================
A correlated subquery is an inner subquery which is referenced by 
the main outer query such that the inner query is considered as 
being executed repeatedly.
*/
/*
Find the Employee who has 2 younger employees in the company
*/
Select e2.Birthdate from Employees e2 where e2.FirstName='Michael'

select FirstName, Birthdate 
FROM Employees E1 
WHERE  E1.Birthdate > 
(Select e2.Birthdate from Employees e2 where e2.FirstName='Michael' )

SELECT COUNT(*)
FROM Employees E2
WHERE E2.Birthdate > (
			Select e2.Birthdate from Employees e2 where e2.FirstName='Michael'
)

SELECT FirstName, Birthdate 
FROM Employees E1
WHERE (2) = (SELECT COUNT(*)
             FROM Employees E2
             WHERE E1.Birthdate <E2.Birthdate) 

/*
USE AdventureWorks2012;
GO
SELECT e.LoginID, e.NationalIDNumber, MONTH(e.ModifiedDate) as ModifiedDate
FROM HumanResources.Employee e
WHERE e.BusinessEntityID IN
(
	SELECT c.BusinessEntityID
	FROM Person.BusinessEntity c
	WHERE MONTH(c.ModifiedDate) = MONTH(e.ModifiedDate)
)
GO

/* non correlated*/

USE AdventureWorks2012;
GO
SELECT 'Mr.' as Title, e.LoginID, e.NationalIDNumber
FROM HumanResources.Employee e
WHERE e.BusinessEntityID IN
(
	SELECT c.BusinessEntityID
	FROM Person.Person c
	WHERE c.Title = 'Mr.'
)
GO
*/