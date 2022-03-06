-- ==========================
-- Create SQL Server Logins
-- ==========================

-- Create a SQL Server Login
CREATE LOGIN EngineeringUser
	WITH PASSWORD = N'j7k5XUqv0L' 
	MUST_CHANGE,
	CHECK_EXPIRATION = ON,
	CHECK_POLICY = ON

-- Create a Windows-Based Login
CREATE LOGIN [ZOOMIE\Anil] 
FROM WINDOWS 
WITH DEFAULT_DATABASE = AdventureWorks
 
DROP LOGIN EngineeringUser 

DROP LOGIN MarketingUser

--===========================================
-- Security-Related Functions and Procedures
--===========================================
USE AdventureWorks
GO

-- Get current user information
SELECT CURRENT_USER as [Current User],

-- Get a list of built-in permissons
SELECT * FROM sys.fn_BuiltIn_Permissions (default)

-- Check for permissions
SELECT has_perms_by_name(NULL, NULL, 'SHUTDOWN')
SELECT has_perms_by_name('HumanResources.Employee', 'OBJECT', 'SELECT')
SELECT has_perms_by_name('Person.Contact', 'OBJECT', 'UPDATE')

-- Query Security Catalog Views
SELECT * FROM Sys.Database_Permissions
SELECT * FROM Sys.Database_Principals
SELECT * FROM Sys.Database_Role_Members

SELECT * FROM Sys.Server_Permissions
SELECT * FROM Sys.Server_Principals

-- Encrypt object definitions
EXEC sp_HelpText 'HumanResources.vEmployee'

  
CREATE VIEW [HumanResources].[vEmployee-Encrypted]
WITH ENCRYPTION
AS   
SELECT   
    e.[EmployeeID]  
    ,c.[Title]  
    ,c.[FirstName]  
    ,c.[MiddleName]  
    ,c.[LastName]  
    ,c.[Suffix]  
    ,e.[Title] AS [JobTitle]   
    ,c.[Phone]  
    ,c.[EmailAddress]  
    ,c.[EmailPromotion]  
    ,a.[AddressLine1]  
    ,a.[AddressLine2]  
    ,a.[City]  
    ,sp.[Name] AS [StateProvinceName]   
    ,a.[PostalCode]  
    ,cr.[Name] AS [CountryRegionName]   
    ,c.[AdditionalContactInfo]  
FROM [HumanResources].[Employee] e  
    INNER JOIN [Person].[Contact] c   
    ON c.[ContactID] = e.[ContactID]  
    INNER JOIN [HumanResources].[EmployeeAddress] ea   
    ON e.[EmployeeID] = ea.[EmployeeID]   
    INNER JOIN [Person].[Address] a   
    ON ea.[AddressID] = a.[AddressID]  
    INNER JOIN [Person].[StateProvince] sp   
    ON sp.[StateProvinceID] = a.[StateProvinceID]  
    INNER JOIN [Person].[CountryRegion] cr   
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode];  
GO

EXEC sp_HelpText 'HumanResources.vEmployee-Encrypted'

--=====================================
-- Manage Certificates and Encryption
--=====================================

-- Create a database master key
CREATE MASTER KEY ENCRYPTION 
BY PASSWORD = '1$9*XE18RD8@^DiB5p!Q'
GO

-- Create a certificate based on the Database Master Key
CREATE CERTIFICATE cert_HumanResources
	--ENCRYPTION BY PASSWORD = 'd%m7Zw9t3&PMn!I*fdJj'
	WITH SUBJECT = 'Human Resources Sensitive Data Certificate';

-- Get certificate / key-related information
SELECT * FROM Sys.Symmetric_Keys
SELECT * FROM Sys.Certificates ORDER BY NAME

-- Get the Certificate ID
PRINT Cert_ID('cert_HumanResources')

-- Print the Certificate's Subject property
PRINT Convert(nvarchar,	CertProperty(256, 'Subject'))

-- Generate encrypted data
DECLARE @Data varbinary(150)
SELECT @Data = EncryptByCert(256, N'Super-Secret Data')
PRINT @Data

--Decrypt Data
SELECT CONVERT(nvarchar, DecryptByCert(256, @Data))

-- Perform clean-up
DROP CERTIFICATE cert_HumanResources
DROP MASTER KEY

--======================================
--  Create a DDL Auditing Trigger
--======================================

-- Create a table to store auditing information
CREATE TABLE dbo.AuditLog
(
	ID				int			IDENTITY(1,1) NOT NULL,
	ActionDateTime	datetime	NOT NULL,
	ActionType		varchar(20)	NOT NULL,
	ObjectType		varchar(20)	NOT NULL
)

CREATE TRIGGER Audit_CreateTable
ON DATABASE 
FOR CREATE_TABLE
AS 
   INSERT INTO dbo.AuditLog (ActionDateTime, ActionType, ObjectType)
   VALUES (GetDate(), 'CREATE', 'TABLE')

-- Create a new table
CREATE TABLE dbo.Employee
(
	ID				int			IDENTITY(1,1) NOT NULL,
	EmployeeNumber	int			NOT NULL,
	FirstName		varchar(20),
	LastName		varchar(20),
	LastUpdate		datetime	NULL
)

-- View auditing information
SELECT * FROM dbo.AuditLog
