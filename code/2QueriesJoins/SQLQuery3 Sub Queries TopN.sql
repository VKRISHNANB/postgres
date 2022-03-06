select CONCAT( 'Hi!' , (select firstname from employees where EmployeeID=1))



Select orderid, freight from orders 
Select orderid, freight from orders  order by Freight asc
select top 3 freight from orders order by Freight asc
Select orderid, freight from orders  order by Freight desc
select top 3 freight from orders order by Freight desc
-----------------------
--Third highest freight
select orderid, freight from orders order by Freight desc
Select Min(freight) from (select top 3 freight from orders order by Freight desc) a
--second highest freight
select orderid, freight from orders order by Freight desc
Select Min(freight) from (select top 2 freight from orders order by Freight desc) a
--
Select * from Orders where freight in (select top 3 freight from orders order by Freight desc)
--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.
Select * from Orders where freight in (select freight from orders order by Freight desc)
