
/*Rank */
------------------------------------
Create table ExamResult(name varchar(50),Subject varchar(20),Marks int)

insert into ExamResult values('Adam','Maths',70)
insert into ExamResult values ('Adam','Science',80)
insert into ExamResult values ('Adam','Social',60)

insert into ExamResult values('Rak','Maths',60)
insert into ExamResult values ('Rak','Science',50)
insert into ExamResult values ('Rak','Social',70)

insert into ExamResult values('Sam','Maths',90)
insert into ExamResult values ('Sam','Science',90)
insert into ExamResult values ('Sam','Social',80)
-- ===========================================================
--Rank()
select * from ExamResult
select Name,Subject,Marks,
RANK() over(partition by name order by Marks desc)Rank
From ExamResult
order by name,subject

-- DENSE_RANK()
select  Name,Subject,Marks,
DENSE_RANK() over(partition by name order by Marks desc)Rank
From ExamResult
order by name

-- NTILE()
--Distributes the rows in an ordered partition into a specified number of groups.
--It divides the partitioned result set into specified number of groups in an order.
select Name,Subject,Marks,
NTILE(3) over(partition by name order by Marks desc)Quartile
From ExamResult
order by name,subject
--
select Name,Subject,Marks,
NTILE(3) over(partition by name order by Marks desc)Quartile
From ExamResult
order by name,subject

-- ROW_NUMBER()
-- Returns the serial number of the row order by specified column.
select Name,Subject,Marks,
ROW_NUMBER() over(order by Name) RowNumber
From ExamResult
order by name,subject
/* ======================= */

USE AdventureWorks2012;  
GO  
SELECT p.FirstName, p.LastName  
    , ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
    ,RANK() OVER (ORDER BY a.PostalCode) AS Rank  
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS Quartile  
    ,s.SalesYTD  
    ,a.PostalCode  
FROM Sales.SalesPerson AS s   
    INNER JOIN Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    INNER JOIN Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;  


