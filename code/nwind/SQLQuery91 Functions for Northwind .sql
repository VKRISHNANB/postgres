CREATE FUNCTION dbo.ufnGetTotalSales(@ProductID int)  
RETURNS int   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret int;  
    SELECT @ret = SUM(ord.Quantity*ord.UnitPrice)   
    FROM [Order Details] ord	
    WHERE ord.ProductID = @ProductID   
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END; 

select p.ProductId,ProductName, [dbo].[ufnGetTotalSales](p.ProductId) as 'Total Sales'
from products p

 SELECT SUM(ord.Quantity*ord.UnitPrice)   
    FROM [Order Details] ord	
    WHERE ord.ProductID = 1 
-------------
/*
CREATE FUNCTION fn_listAnualAmounts(@country NVARCHAR)
RETURNS TABLE
AS
BEGIN
    RETURN (SELECT e.LastName,
				   SUM(CASE WHEN YEAR(o.OrderDate) = 1996
							THEN (od.UnitPrice - od.Discount)*od.quantity
					   END) as total_1996
				   SUM(CASE WHEN YEAR(o.OrderDate) = 1997
							THEN (od.UnitPrice - od.Discount)*od.quantity
					   END) as total_1997,
				   SUM(CASE WHEN YEAR(o.OrderDate) = 1998
							THEN (od.UnitPrice - od.Discount)*od.quantity
					   END) as total_1998
			FROM [Order Details] od LEFT JOIN
				 Orders o 
				 ON o.OrderID = od.OrderID LEFT JOIN
				 Employees e 
				 ON e.EmployeeID = o.EmployeeID
			GROUP BY e.EmployeeId, e.LastName;)
END
GO
*/
/*
CREATE FUNCTION fn_listAnualAmounts(@country NVARCHAR)
RETURNS TABLE
AS
BEGIN
    DECLARE @anio96 MONEY, @anio97 MONEY, @anio98 MONEY 

    SET @anio96 = (SELECT SUM((od.UnitPrice - od.Discount)*od.quantity) as [Año 1996]
                    FROM [Order Details] od 
                        left join Orders o on o.OrderID = od.OrderID
                        left join Employees e on e.EmployeeID = o.EmployeeID
                    GROUP BY YEAR(o.OrderDate),e.EmployeeID
                    HAVING YEAR(o.OrderDate) = '1996')
    SET @anio97 = (SELECT SUM((od.UnitPrice - od.Discount)*od.quantity) as [Año 1997]
                    FROM [Order Details] od 
                        left join Orders o on o.OrderID = od.OrderID
                        left join Employees e on e.EmployeeID = o.EmployeeID
                    GROUP BY YEAR(o.OrderDate),e.EmployeeID
                    HAVING YEAR(o.OrderDate) = '1997')
    SET @anio98 = (SELECT SUM((od.UnitPrice - od.Discount)*od.quantity) as [Año 1998]
                    FROM [Order Details] od 
                        left join Orders o on o.OrderID = od.OrderID
                        left join Employees e on e.EmployeeID = o.EmployeeID
                    GROUP BY YEAR(o.OrderDate),e.EmployeeID
                    HAVING YEAR(o.OrderDate) = '1998')

    RETURN (SELECT e.LastName, @anio96, @anio97, @anio98
            FROM Employees e)
END
GO
*/
/*

*/