-- CTE
SELECT * 
FROM ( 
   SELECT Employeeid SalesPersonID, 
    Count(*) NoOfOrders
   FROM Orders GROUP BY EmployeeID ) a
WHERE SalesPersonID > 5
ORDER BY NoOfOrders DESC
----------------------------------
WITH TopOrders (Employeeid, NumSales) AS
( SELECT Employeeid SalesPersonID, Count(*) 
  FROM Orders GROUP BY EmployeeID )
  ---------------------------------
SELECT * FROM TopOrders 
WHERE Employeeid IS NOT NULL
ORDER BY NumSales DESC

------------------------

