CREATE PROCEDURE sp_FetchAllOrderDetails_venkat 
AS 
BEGIN     
	SELECT O.OrderID,MONTH(O.OrderDate) Order_Month,
	P.ProductName,P.UnitPrice,P.UnitsInStock, S.CompanyName 
	FROM Orders O     
	INNER JOIN [Order Details] OD 
	ON O.OrderID=OD.OrderID     
	INNER JOIN Products P 
	ON OD.ProductID=P.ProductID     
	INNER JOIN Suppliers S 
	ON P.SupplierID=S.SupplierID 
END

EXEC sp_FetchAllOrderDetails_venkat 
---

CREATE PROCEDURE CustomerProductDetails_venkat(@p_CustomerID NVARCHAR(10))
AS 
BEGIN     
	SELECT CAT.CategoryName,CAT.[Description], P.ProductName,P.UnitPrice,P.UnitsInStock     
	FROM Customers C 
	INNER JOIN Orders O  ON C.CustomerID=O.CustomerID     
	INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID     
	INNER JOIN Products P ON OD.ProductID=P.ProductID     
	INNER JOIN Categories CAT ON P.CategoryID=CAT.CategoryID     
	WHERE C.CustomerID=@p_CustomerID 
END

EXEC CustomerProductDetails_venkat 'ALFKI' 

alter procedure CustomerProductDetails_venkat(@p_CustomerID NVARCHAR(10))
AS 
BEGIN 
     Select * from customers 
	 where customerid=@p_Customerid    
end
EXEC CustomerProductDetails_venkat 'ALFKI' 
----
CREATE PROCEDURE FetchSupplierProducts_venkat (     @p_SupplierID INT,
						@p_SupplierName NVARCHAR(30) OUTPUT,     
						@p_CompanyName NVARCHAR(30) OUTPUT ) 
AS
BEGIN
	SELECT @p_SupplierName=ContactName,@p_CompanyName=CompanyName 
    FROM Suppliers     
	WHERE SupplierID=@p_SupplierID 
END

alter PROCEDURE FetchSupplierProducts_venkat (     @p_SupplierID INT,
						@p_SupplierName NVARCHAR(30) OUTPUT,     
						@p_CompanyName NVARCHAR(30) OUTPUT ) 
AS
BEGIN   
	SELECT @p_SupplierName=ContactName,@p_CompanyName=CompanyName 
    FROM Suppliers     
	WHERE SupplierID=@p_SupplierID 
END
DECLARE @v_ConName NVARCHAR(30) 
DECLARE @v_ComName NVARCHAR(30) 
EXEC FetchSupplierProducts_venkat 1, @v_ConName OUTPUT, @v_ComName OUTPUT 
SELECT @v_ComName CompanyName,@v_ConName SupplierName 

---


IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SelectCustomers' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.[SelectCustomers]
GO

CREATE PROCEDURE dbo.[SelectCustomers_venkat]
AS
Begin
	SET NOCOUNT ON;
		SELECT *
		FROM dbo.Customers
	SET NOCOUNT OFF;
end
GO
exec SelectCustomers_venkat










---------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'InsertCustomers' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.InsertCustomers
GO
CREATE PROCEDURE dbo.InsertCustomers
(
    @CustomerID nchar(5),
    @CompanyName nvarchar(40),
    @ContactName nvarchar(30),
    @ContactTitle nvarchar(30),
    @Address nvarchar(60),
    @City nvarchar(15),
    @Region nvarchar(15),
    @PostalCode nvarchar(10),
    @Country nvarchar(15),
    @Phone nvarchar(24),
    @Fax nvarchar(24)
)
AS
    SET NOCOUNT OFF;
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax);

SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax FROM Customers WHERE (CustomerID = @CustomerID)
GO
-------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpdateCustomers' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.UpdateCustomers
GO

CREATE PROCEDURE dbo.UpdateCustomers
(
    @CustomerID nchar(5),
    @CompanyName nvarchar(40),
    @ContactName nvarchar(30),
    @ContactTitle nvarchar(30),
    @Address nvarchar(60),
    @City nvarchar(15),
    @Region nvarchar(15),
    @PostalCode nvarchar(10),
    @Country nvarchar(15),
    @Phone nvarchar(24),
    @Fax nvarchar(24),
    @Original_CustomerID nchar(5)
)
AS
    SET NOCOUNT OFF;
UPDATE [dbo].[Customers] SET [CustomerID] = @CustomerID, [CompanyName] = @CompanyName, [ContactName] = @ContactName, [ContactTitle] = @ContactTitle, [Address] = @Address, [City] = @City, [Region] = @Region, [PostalCode] = @PostalCode, [Country] = @Country, [Phone] = @Phone, [Fax] = @Fax WHERE (([CustomerID] = @Original_CustomerID));

SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax FROM Customers WHERE (CustomerID = @CustomerID)
GO
-----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DeleteCustomers' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.DeleteCustomers
GO

CREATE PROCEDURE dbo.DeleteCustomers
(
    @Original_CustomerID nchar(5)
)
AS
    SET NOCOUNT OFF;
DELETE FROM [dbo].[Customers] WHERE (([CustomerID] = @Original_CustomerID))
GO