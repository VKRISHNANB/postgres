SELECT * 
FROM Employees;

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE City = 'London'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE City <> 'London'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE Hire_Date >= '1-july-1993'

SELECT Category_ID, Category_Name, Description FROM Categories;
SELECT Contact_Name, Company_Name, Contact_Title, Phone FROM Customers;
SELECT Employee_id, Title, First_Name, Last_Name, Region FROM Employees;
SELECT Region_ID, Region_Description FROM Region;
SELECT Company_Name, Fax, Phone, HomePage FROM Suppliers;
Select * from Products

SELECT Company_Name, Fax, Phone, HomePage 
FROM Suppliers
where Supplier_ID=1;

SELECT Category_ID, Category_Name, Description 
FROM Categories where Category_ID=1;

SELECT     Employee_ID, First_Name, Last_Name, Hire_Date, City , '1' 
FROM       Employees 
WHERE      (Hire_Date >= '1-june-1992') AND (Hire_Date <= '15-december-1993');

SELECT     Employee_ID, First_Name, Last_Name, Hire_Date, City , '2' 
FROM       Employees 
WHERE      (Hire_Date >= '1992-06-1') AND (Hire_Date <= '1993-12-15');

select Employee_id, '1' from employees
UNION
select supplier_id, '2' from suppliers;

SELECT    Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM      Employees 
WHERE     Hire_Date BETWEEN '1-june-1992' AND '15-december-1993'

SELECT    Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM      Employees 
WHERE     Hire_Date NOT BETWEEN '1-june-1992' AND '15-december-1993'

--
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE City = 'London' OR City = 'Seattle'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE City 
IN ('Seattle', 'Tacoma', 'Redmond')

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE City NOT IN ('Seattle', 'Tacoma', 'Redmond')
---
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE First_Name  LIKE 'M%'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE (First_Name NOT LIKE 'M%') AND (First_Name NOT LIKE 'A%')

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE First_Name  LIKE '[a-M]%'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
WHERE First_Name  LIKE '[^a-M]%'

-- Order by
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
ORDER BY City

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, Country, City 
FROM Employees 
ORDER BY Country, City DESC,First_Name 

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, Country, City 
FROM Employees 
ORDER BY Country , City DESC

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
ORDER BY Country ASC, City DESC
---
SELECT Title, First_Name, Last_Name 
FROM Employees 
ORDER BY 1,3;

SELECT Title, First_Name, Last_Name 
FROM Employees 
ORDER BY Title, Last_Name;

SELECT * 
FROM Employees 
ORDER BY 1,3;
--
SELECT First_Name, Last_Name, Hire_Date
    FROM Employees
    ORDER BY Hire_Date DESC
---
SELECT First_Name, Last_Name , Region
   FROM Employees
   WHERE Region IS NULL;

SELECT First_Name, Last_Name, Region
    FROM Employees
    WHERE Region IS NOT NULL;
--
SELECT First_Name + ' ' + Last_Name 
FROM Employees;

SELECT Order_ID, Freight, Freight * 1.1
   FROM Orders
   WHERE Freight >= 500;

SELECT Order_ID, Freight, Freight * 1.1 AS FreightTotal
   FROM Orders
   WHERE Freight >= 500;
   
-- Functions
SELECT COUNT(*) AS NumEmployees FROM Employees;
SELECT SUM (Quantity) AS TotalUnits FROM [Order Details] WHERE Product_ID=3;
SELECT AVG (Unit_Price) AS AveragePrice FROM Products;

-- Group By
SELECT City, COUNT (Employee_id) AS NumberOfEmployeesInCity  
FROM Employees 
GROUP BY City;

SELECT City, COUNT (Employee_id) AS NumberOfEmployeesInCity 
FROM Employees 
GROUP BY City 
HAVING COUNT (Employee_id) > 1;

--
SELECT DISTINCT City FROM Employees ORDER BY City
SELECT COUNT(DISTINCT City) AS NumCities FROM Employees

SELECT Product_ID,Unit_Price, SUM (Quantity) AS TotalUnits 
FROM [Order Details] 
GROUP BY Product_ID ,Unit_Price
HAVING SUM (Quantity) < 200;
--
SELECT Product_ID, AVG (Unit_Price) AS AveragePrice 
FROM Products 
GROUP BY Product_ID 
HAVING AVG (Unit_Price) > 70 
ORDER BY AveragePrice;

SELECT Customer_ID, COUNT (Order_ID) AS NumOrders 
FROM Orders 
GROUP BY Customer_ID 
HAVING COUNT (Order_ID) > 15 
ORDER BY NumOrders DESC;

SELECT Product_ID, Unit_Price 
FROM Products 
WHERE Unit_Price > 70 
ORDER BY Unit_Price;
---
SELECT Address FROM Customers
SELECT SUBSTRING(Address,1,10) FROM Customers
SELECT SUBSTRING(Address,(len(Address)-9),10) FROM Customers
---
select * from Employees where   first_name ='Nancy' 
select * from Employees where   first_name ='nancy' 
select * from employees where first_name='nancy'
COLLATE SQL_Latin1_General_CP1_CS_AS
----
-- Find the name of the company that placed order 10290.
SELECT Company_Name
FROM Customers
WHERE Customer_ID = (SELECT Customer_ID
			FROM Orders
			WHERE Order_ID = 10290);

SELECT Company_Name
FROM Customers
WHERE Customer_ID IN (SELECT Customer_ID
			FROM Orders
			WHERE Order_Date BETWEEN '1-Jan-1997' AND '31-Dec-1997');
---
SELECT Product_Name, Supplier_ID 
FROM Products 
WHERE Supplier_ID IN (
	SELECT Supplier_ID   
	FROM Suppliers 
	WHERE Company_Name IN ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders')
	);

SELECT Product_Name 
FROM Products WHERE Category_ID = (
	SELECT Category_ID  
	FROM Categories WHERE Category_Name = 'Seafood');

SELECT Company_Name 
FROM Suppliers WHERE Supplier_ID IN (
	SELECT Supplier_ID 
	FROM Products WHERE Category_ID = 8); 

SELECT Company_Name 
FROM Suppliers WHERE Supplier_ID IN (
	SELECT Supplier_ID 
	FROM Products 
	WHERE Category_ID = (
			SELECT Category_ID 
			FROM Categories 
			WHERE Category_Name = 'Seafood')
	);