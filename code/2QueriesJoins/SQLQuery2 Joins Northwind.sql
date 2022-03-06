select * from Employees
where HireDate >='07-01-93' -- mm-dd-yyyy

select OrderID,ProductName, Quantity 
from [Order Details] left outer join Products 
on  [Order Details].ProductID = Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details] left join Products 
on  [Order Details].ProductID = Products.ProductID

Select count(distinct e.Employeeid) as numOfemp, e.city ,
count(distinct c.CustomerID) as numOfCustomers, c.city 
from Employees e left join Customers c on
e.City= c.city
group by e.city, c.city
order by numOfemp

Select count(distinct e.Employeeid) as numOfemp, e.city ,
count(distinct c.CustomerID) as numOfCustomers, c.city 
from Employees e right join Customers c on
e.City= c.city
group by e.city, c.city
order by numOfemp

EXEC sp_helptext CustOrderHist

select OrderID,ProductName, Quantity 
from [Order Details] 
left outer join Products 
on  [Order Details].ProductID = Products.ProductID

select OrderID,ProductName, Quantity 
from [Order Details] 
left join Products 
on  [Order Details].ProductID = Products.ProductID

Select Current_User

exec sp_help

select * from employees

select * from Employees
where HireDate >(
				select Hiredate 
				from Employees
				where Firstname='Michael')
order by Hiredate

