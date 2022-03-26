Select * 
from employees;
/*
DDL
  Creating
  Alter
  Deleting
DML
  insert
  update
  delete
  select

-- select statement
	from where
	what
	filter
*/
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE City = 'London'
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE City <> 'London'
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE Hire_Date >= '1-july-1993'
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE Hire_Date >= '1993-06-01'
--
SELECT Category_Name, Description FROM Categories;
SELECT Contact_Name, Company_Name, Contact_Title, Phone FROM Customers;
SELECT Employee_ID, Title, First_Name, Last_Name, Region FROM Employees;
SELECT Region_ID, Region_Description FROM Region;
SELECT Company_Name, Fax, Phone, HomePage FROM Suppliers;
--
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City  
FROM Employees 
WHERE (Hire_Date >= '1-june-1992') AND (Hire_Date <= '15-december-1993')

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM      Employees 
WHERE  Hire_Date BETWEEN '1-june-1992' AND '15-december-1993'

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM   Employees 
WHERE  Hire_Date NOT BETWEEN '1-june-1992' AND '15-december-1993'
--
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE City = 'London' OR City = 'Seattle'
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE City IN ('Seattle', 'Tacoma', 'Redmond')
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees WHERE City NOT IN ('Seattle', 'Tacoma', 'Redmond')
--
/*
	wild char 
	%
	_ underscore
*/
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name NOT LIKE 'M%') AND (First_Name NOT LIKE 'A%');

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name LIKE 'M%'); 
-- Regex
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^M'); 
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ 'M'); 
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ 'm'); 
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^m');

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ 'r');
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^r');
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^R');

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^(A|R)');
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '(a|r)'); 
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City FROM Employees 
WHERE (First_Name  ~ '^(a|r)'); 

-- Order By
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, City 
FROM Employees 
ORDER BY City

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, Country, City 
FROM Employees 
ORDER BY Country, City DESC

SELECT Employee_ID, First_Name, Last_Name, Hire_Date, Country, City FROM Employees ORDER BY Country Desc, City DESC
SELECT Employee_ID, First_Name, Last_Name, Hire_Date, Country, City FROM Employees ORDER BY Country Desc, City Asc
SELECT Title, First_Name, Last_Name FROM Employees ORDER BY 1,3;
SELECT Title, First_Name, Last_Name FROM Employees ORDER BY Title, Last_Name;
--
/*
1. List CategoryName and Description from the Categories table sorted by CategoryName.
2. Display ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted by Phone.
3. Create a query showing employees' first and last names and hire dates sorted from newest to oldest employee.
4. Create a query showing orders sorted by Freight from most expensive to cheapest. Show OrderID, OrderDate, ShippedDate, CustomerID, and Freight.
	>SELECT Order_ID, Order_Date, Shipped_Date, Customer_Id,Freight from orders Order by Freight desc; 
5. Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending order and then by CompanyName in ascending order.
6. Create a list of employees showing title, first name, and last name. Sort by Title in ascending order and then by LastName in descending order.
*/
-- Is Null
SELECT First_Name, Last_Name, Region 
FROM Employees
WHERE Region IS NULL

SELECT First_Name, Last_Name, Region 
FROM Employees
WHERE Region IS NOT NULL
--
select concat(first_name, last_name) As Full_Name
from Employees

select Order_ID, Freight, Freight * 1.1 as Net_Freight
from Orders
where freight >=500;

SELECT COUNT(*) AS NumEmployees FROM Employees;
SELECT SUM (Quantity) AS TotalUnits FROM Order_Details WHERE ProductID=3;
SELECT AVG (Unit_Price) AS AveragePrice FROM Products;
SELECT City, COUNT (Employee_ID) AS NumEmployees  FROM Employees GROUP BY City;
SELECT City, COUNT (Employee_ID) AS NumEmployees FROM Employees GROUP BY City HAVING COUNT (Employee_ID) > 1;






