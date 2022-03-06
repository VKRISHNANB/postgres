--use northwind
select ord.OrderID,Products.ProductName, ord.Quantity from [Order Details] as ord, Products 
where ord.ProductID = Products.ProductID

select OrderID,ProductName, Quantity from [Order Details]  join Products on  [Order Details].ProductID = Products.ProductID
--select OrderID,ProductName, Quantity from [Order Details]  join Products using  ProductID 

--select OrderID,ProductName, Quantity from [Order Details]  using Products on  ([Order Details].ProductID = Products.ProductID)

--select ord.OrderID,Products.ProductName, ord.Quantity from [Order Details] as ord, Products 
--where ord.ProductID *= Products.ProductID

select OrderID,ProductName, Quantity from [Order Details] left outer join Products on  [Order Details].ProductID = Products.ProductID
select OrderID,ProductName, Quantity from [Order Details] left join Products on  [Order Details].ProductID = Products.ProductID

select Customers.ContactName, OrderID from Customers inner join Orders on (Customers.CustomerID=Orders.CustomerID)
select Customers.ContactName, OrderID from Customers left outer join Orders on (Customers.CustomerID=Orders.CustomerID) order by OrderID
select Customers.ContactName, OrderID from Customers left  join Orders on (Customers.CustomerID=Orders.CustomerID) order by OrderID

select count(*) from orders