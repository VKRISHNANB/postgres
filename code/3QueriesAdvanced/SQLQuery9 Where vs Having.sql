select ProductName,UnitPrice 
from products
where UnitPrice > Avg(UnitPrice)

select ProductName,UnitPrice 
from products
having UnitPrice > Avg(UnitPrice) 

select ProductName,UnitPrice 
from products
where UnitPrice >
(select Avg(UnitPrice) from products)
-----
select CategoryID ,sum(unitprice) Sum,count(productid) Count
from products
group  by CategoryID 
having count(productid)>6
------------
select * from employees
Having city='Seattle'

select * from employees
where city='Seattle'
----------------------
select count(*) from employees
group by ReportsTo
where city='Seattle'

select count(*) from employees
where city='Seattle'
group by ReportsTo
---------------------------
