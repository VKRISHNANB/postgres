Select orderID, CustomerID,EmployeeID, OrderDate, RequiredDate
from Orders as o1
where Orderdate=
( Select Max(OrderDate) from orders as o2
 where o2.Employeeid=o1.EmployeeID)