IF EXISTS (
	SELECT * FROM sysobjects 
	WHERE name = 'SelectCustomers' AND user_name(uid) = 'dbo')
    DROP PROCEDURE dbo.[SelectCustomers]
GO

CREATE PROCEDURE dbo.[SelectCustomers]
AS
    SET NOCOUNT ON;
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax 
FROM dbo.Customers
GO

---------------------------------------------------------
IF EXISTS (
	SELECT * FROM sysobjects 
	WHERE name = 'InsertCustomers' AND user_name(uid) = 'dbo')
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
	INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) 
	VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax);

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