select * from Employees
where HireDate >='07-01-93' -- mm-dd-yyyy
--
SELECT Employees.EmployeeID, Employees.FirstName,
	Orders.OrderID, Orders.OrderDate
FROM Employees JOIN Orders ON
	(Employees.EmployeeID = Orders.EmployeeID)
ORDER BY Employees.EmployeeID, Orders.OrderDate;
--
SELECT Employees.EmployeeID, Employees.FirstName,
	Orders.OrderID, Orders.OrderDate
FROM Employees Inner JOIN Orders ON
	(Employees.EmployeeID = Orders.EmployeeID)
ORDER BY Employees.EmployeeID, Orders.OrderDate;
--
-- Create a report showing employee orders using Aliases.
SELECT e.EmployeeID, e.FirstName, e.LastName,
	o.OrderID, o.OrderDate
FROM Employees e inner JOIN Orders o ON
	(e.EmployeeID = o.EmployeeID)
ORDER BY e.EmployeeID, o.OrderDate;
--
/*
Create a report that shows the number of employees and customers from each city 
that has employees in it. 
*/

SELECT COUNT(DISTINCT e.EmployeeID) AS numEmployees,
	COUNT(DISTINCT c.CustomerID) AS numCompanies,
	e.City, c.City
FROM Employees e JOIN Customers c ON
	(e.City = c.City)
GROUP BY e.City, c.City
ORDER BY numEmployees DESC;

Select count(distinct e.Employeeid) as numOfemp, e.city ,
count(distinct c.CustomerID) as numOfCustomers, c.city 
from Employees e 
left join Customers c 
on e.City= c.city
group by e.city, c.city
order by numOfemp

Select count(distinct e.Employeeid) as numOfemp, e.city ,
count(distinct c.CustomerID) as numOfCustomers, c.city 
from Employees e 
right join Customers c 
on e.City= c.city
group by e.city, c.city
order by numOfemp

/*	Create a report that shows the number of
	employees and customers from each city.    */
SELECT COUNT(DISTINCT e.EmployeeID) AS numEmployees, e.City,
	COUNT(DISTINCT c.CustomerID) AS numCompanies, c.City
FROM Employees e FULL JOIN Customers c ON
	(e.City = c.City)
GROUP BY e.City, c.City
ORDER BY numEmployees DESC;

--
/*  Get the phone numbers of all shippers, customers, and suppliers  */
SELECT CompanyName, Phone
FROM Shippers
	UNION
SELECT CompanyName, Phone
FROM Customers
	UNION
SELECT CompanyName, Phone
FROM Suppliers
ORDER BY CompanyName;
--
/* Create a report that shows the order ids and the associated employee names 
   for orders that shipped after the required date. 
   There should be 37 rows returned.
*/
select o.OrderID,e.FirstName , o.RequiredDate  ,o.ShippedDate  
from [Orders] as o
join Employees e 
on  o.EmployeeID  = e.EmployeeID 
where o.ShippedDate > o.RequiredDate 
--
/*
Create a report that shows the total quantity of products ordered (from the [Order Details] table). 
Only show records for products for which the quantity ordered is fewer than 200. 
The report should return the following 5 rows.
*/
select ord.ProductID, Sum(ord.Quantity) as 'total quantity'
from [Order details] ord
join Products prd on ord.ProductID=prd.ProductID 
--where ord.Quantity <200
Group by ord.ProductID
having Sum(ord.Quantity) <200
order by ord.ProductID
---
/*
Create a report that shows the total number of orders by Customer since December 31, 1996. 
The report should only return rows for which the NumOrders is greater than 15. 
The report should return the following 5 rows.
*/
select o.CustomerID, count(o.orderid) as TotalOrders
from Orders o join customers c 
on o.CustomerID=c.CustomerID 
where o.OrderDate>='31-December-1996' 
group by o.CustomerID
Having count(o.orderid)>15
order by TotalOrders

/*
Create a report that shows the company name, order id, and total price of all products 
of that has sold more than $10,000 worth. 
( There is no need for a GROUP BY clause in this report.)
*/
select o.OrderID,c.CompanyName , (ord.Quantity*ord.UnitPrice )*(1-ord.Discount ) as TotalPrice
from Orders as o
join [Order Details] ord on o.OrderID=ord.OrderID
join Customers c on o.CustomerID = c.CustomerID
-- where TotalPrice > 10000
where (ord.Quantity*ord.UnitPrice )*(1-ord.Discount ) > 10000
order by TotalPrice
-------------------------------------------------
select OrderID,ProductName, Quantity 
from [Order Details] 
left outer join Products 
on  [Order Details].ProductID = Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details] 
left join Products 
on  [Order Details].ProductID = Products.ProductID


-- ==============================
select ord.OrderID,Products.ProductName, ord.Quantity 
from [Order Details] as ord, Products 
where ord.ProductID = Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details]  
join Products on  [Order Details].ProductID = Products.ProductID
--select OrderID,ProductName, Quantity from [Order Details]  join Products using  ProductID 

--select OrderID,ProductName, Quantity from [Order Details]  using Products on  ([Order Details].ProductID = Products.ProductID)

--select ord.OrderID,Products.ProductName, ord.Quantity from [Order Details] as ord, Products 
--where ord.ProductID *= Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details] 
left outer join Products on  [Order Details].ProductID = Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details] 
left join Products on  [Order Details].ProductID = Products.ProductID

select Customers.ContactName, OrderID 
from Customers 
inner join Orders on (Customers.CustomerID=Orders.CustomerID)

select Customers.ContactName, OrderID 
from Customers 
left outer join Orders 
on (Customers.CustomerID=Orders.CustomerID) 
order by OrderID

select Customers.ContactName, OrderID 
from Customers 
left  join Orders 
on (Customers.CustomerID=Orders.CustomerID) 
order by OrderID

select count(*) from orders
