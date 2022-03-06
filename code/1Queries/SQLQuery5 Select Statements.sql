SELECT * 
FROM Employees
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE City = 'London'

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE City <> 'London'

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE HireDate >= '1-july-1993'

SELECT CategoryID, CategoryName, Description FROM Categories;
SELECT ContactName, CompanyName, ContactTitle, Phone FROM Customers;
SELECT EmployeeID, Title, FirstName, LastName, Region FROM Employees;
SELECT RegionID, RegionDescription FROM Region;
SELECT CompanyName, Fax, Phone, HomePage FROM Suppliers;
Select * from Products

SELECT CompanyName, Fax, Phone, HomePage 
FROM Suppliers
where SupplierID=1;
SELECT CategoryID, CategoryName, Description 
FROM Categories where CategoryID=1;

SELECT     EmployeeID, FirstName, LastName, HireDate, City  
FROM       Employees 
WHERE      (HireDate >= '1-june-1992') AND (HireDate <= '15-december-1993')

SELECT    EmployeeID, FirstName, LastName, HireDate, City 
FROM      Employees 
WHERE     HireDate BETWEEN '1-june-1992' AND '15-december-1993'

SELECT    EmployeeID, FirstName, LastName, HireDate, City 
FROM      Employees 
WHERE     HireDate NOT BETWEEN '1-june-1992' AND '15-december-1993'

--
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE City = 'London' OR City = 'Seattle'

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE City 
IN ('Seattle', 'Tacoma', 'Redmond')

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE City NOT IN ('Seattle', 'Tacoma', 'Redmond')
---
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE FirstName  LIKE 'M%'

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE (FirstName NOT LIKE 'M%') AND (FirstName NOT LIKE 'A%')

SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE FirstName  LIKE '[a-M]%'
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
WHERE FirstName  LIKE '[^a-M]%'
-- Order by
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
ORDER BY City

SELECT EmployeeID, FirstName, LastName, HireDate, Country, City 
FROM Employees 
ORDER BY Country, City DESC,FirstName 

SELECT EmployeeID, FirstName, LastName, HireDate, Country, City 
FROM Employees 
ORDER BY Country , City DESC
SELECT EmployeeID, FirstName, LastName, HireDate, City 
FROM Employees 
ORDER BY Country ASC, City DESC
---
SELECT Title, FirstName, LastName 
FROM Employees 
ORDER BY 1,3;

SELECT Title, FirstName, LastName 
FROM Employees 
ORDER BY Title, LastName;

SELECT * 
FROM Employees 
ORDER BY 1,3;
--
SELECT FirstName, LastName, HireDate
    FROM Employees
    ORDER BY HireDate DESC
---
SELECT FirstName, LastName , Region
   FROM Employees
   WHERE Region IS NULL;

SELECT FirstName, LastName, Region
    FROM Employees
    WHERE Region IS NOT NULL;
--
SELECT FirstName + ' ' + LastName 
FROM Employees;

SELECT OrderID, Freight, Freight * 1.1
   FROM Orders
   WHERE Freight >= 500;

SELECT OrderID, Freight, Freight * 1.1 AS FreightTotal
   FROM Orders
   WHERE Freight >= 500;
-- Functions
SELECT COUNT(*) AS NumEmployees FROM Employees;
SELECT SUM (Quantity) AS TotalUnits FROM [Order Details] WHERE ProductID=3;
SELECT AVG (UnitPrice) AS AveragePrice FROM Products;
-- Group By
SELECT City, COUNT (EmployeeID) AS NumberOfEmployeesInCity  
FROM Employees 
GROUP BY City;

SELECT City, COUNT (EmployeeID) AS NumberOfEmployeesInCity 
FROM Employees 
GROUP BY City 
HAVING COUNT (EmployeeID) > 1;
--
SELECT DISTINCT City FROM Employees ORDER BY City
SELECT COUNT(DISTINCT City) AS NumCities FROM Employees

SELECT ProductID,UnitPrice, SUM (Quantity) AS TotalUnits 
FROM [Order Details] 
GROUP BY ProductID ,UnitPrice
HAVING SUM (Quantity) < 200;
--
SELECT ProductID, AVG (UnitPrice) AS AveragePrice 
FROM Products 
GROUP BY ProductID 
HAVING AVG (UnitPrice) > 70 
ORDER BY AveragePrice;

SELECT CustomerID, COUNT (OrderID) AS NumOrders 
FROM Orders 
GROUP BY CustomerID 
HAVING COUNT (OrderID) > 15 
ORDER BY NumOrders DESC;

SELECT ProductID, UnitPrice 
FROM Products 
WHERE UnitPrice > 70 
ORDER BY UnitPrice;
---
SELECT Address FROM Customers
SELECT SUBSTRING(Address,1,10) FROM Customers
SELECT SUBSTRING(Address,(len(Address)-9),10) FROM Customers
---
select * from Employees where   firstname ='Nancy' 
select * from Employees where   firstname ='nancy' 
select * from employees where firstname='nancy'
COLLATE SQL_Latin1_General_CP1_CS_AS
----
-- Find the name of the company that placed order 10290.
SELECT CompanyName
FROM Customers
WHERE CustomerID = (SELECT CustomerID
			FROM Orders
			WHERE OrderID = 10290);

SELECT CompanyName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
			FROM Orders
			WHERE OrderDate BETWEEN '1-Jan-1997' AND '31-Dec-1997');
---
SELECT ProductName, SupplierID 
FROM Products 
WHERE SupplierID IN (
	SELECT SupplierID   
	FROM Suppliers 
	WHERE CompanyName IN ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders')
	);

SELECT ProductName 
FROM Products WHERE CategoryID = (
	SELECT CategoryID  
	FROM Categories WHERE CategoryName = 'Seafood');

SELECT CompanyName 
FROM Suppliers WHERE SupplierID IN (
	SELECT SupplierID 
	FROM Products WHERE CategoryID = 8); 

SELECT CompanyName 
FROM Suppliers WHERE SupplierID IN (
	SELECT SupplierID 
	FROM Products 
	WHERE CategoryID = (
			SELECT CategoryID 
			FROM Categories 
			WHERE CategoryName = 'Seafood')
	);