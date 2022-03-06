-----------------------------------------------
-- Catalog (Sys) Views
-----------------------------------------------

-- Get a list of system views
SELECT * FROM Sys.System_Views ORDER BY Name

-- Get a list of Tables
SELECT * FROM Sys.Tables ORDER BY Name

-- Get a list of Views
SELECT * FROM Sys.Views ORDER BY Name

-----------------------------------------------
-- INFORMATION_SCHEMA Views
-----------------------------------------------

-- Get List of tables
SELECT * FROM Information_Schema.Tables 
WHERE Table_Type = 'BASE TABLE'
ORDER BY Table_Schema, Table_Name

-- Get View Information
SELECT * FROM Information_Schema.Views
ORDER BY Table_Schema, Table_Name

-----------------------------------------------
-- Dependencies
-----------------------------------------------

-- Get dependencies for a table
EXEC sp_depends '<viewName>'


------------------------------------------------
-- Shrinking Database Files
------------------------------------------------

-- Perform database changes
SELECT * INTO Transactions_01 FROM AdventureWorks.Production.TransactionHistory
SELECT * INTO Transactions_02 FROM AdventureWorks.Production.TransactionHistory
SELECT * INTO Transactions_03 FROM AdventureWorks.Production.TransactionHistory

-- Drop the test tables
DROP TABLE Transactions_01
DROP TABLE Transactions_02
DROP TABLE Transactions_03

-- View database storage information
EXEC sp_HelpDB 'Development'
EXEC sp_SpaceUsed
DBCC SQLPERF(LOGSPACE)

-- Enable AutoShrink for the Database
ALTER DATABASE Development
SET AUTO_SHRINK ON

-- Shrink a single database file
SELECT * FROM Sys.Database_Files

DBCC SHRINKFILE('Development', 10)
DBCC SHRINKFILE('Development_Log', 10)

-- Shrink all files in database
DBCC SHRINKDATABASE ('Development')


------------------------------------------------
-- Verifying Database Integrity
------------------------------------------------

-- Run DBCC Commands
DBCC CHECKDB ('AdventureWorks') WITH ESTIMATEONLY
DBCC CHECKDB ('AdventureWorks') WITH DATA_PURITY
DBCC CHECKDB ('AdventureWorks') 

-- Viewing current activity
SELECT * FROM Sys.DM_Exec_Requests


------------------------------------------------
-- Creating Indexes
------------------------------------------------

-- Copy test data from AdventureWorks database
SELECT ContactID, FirstName, MiddleName, LastName,
		EMailAddress, Phone
INTO dbo.Person
FROM AdventureWorks.Person.Contact

-- Create a clustered index
CREATE UNIQUE CLUSTERED INDEX pk_Contact1
ON dbo.Person
(
	[ContactID] ASC
)

-- Test query (range)
SELECT * 
FROM dbo.Person
WHERE ContactID BETWEEN 100 and 200

-- Test Query (specific IDs)
SELECT FirstName, EMailAddress
FROM dbo.Person
WHERE ContactID IN (100, 150, 1852, 11322, 14783)

-- Create a non-clustered index
CREATE INDEX index_Contact1
ON dbo.Person
(
	ContactID,
	FirstName,
	LastName
)

-- Work with covering indexes
CREATE INDEX index_Contact1
ON dbo.Person
(
	ContactID,
	FirstName,
	LastName
)
INCLUDE (EMailAddress)
WITH DROP_EXISTING

-- Test Query (covered columns only)
SELECT FirstName, LastName, EMailAddress
FROM dbo.Person

-- Perform clean-up
DROP INDEX index_Contact1 ON dbo.Person
DROP TABLE dbo.Person

------------------------------------------------
-- Maintaining Indexes
------------------------------------------------

-- Get Index-related information
SELECT * FROM Sys.Indexes

SELECT OBJECT_NAME(Object_ID) as ObjectName, *
FROM Sys.Index_Columns

-- Get index fragment-related information
SELECT OBJECT_NAME(Object_ID) as ObjectName, * 
FROM Sys.DM_DB_Index_Physical_Stats
(DB_ID(), OBJECT_ID('dbo.Person'), NULL, NULL, NULL)

-- Reorganize the index
ALTER INDEX index_Contact1 ON dbo.Person
REORGANIZE

-- Rebuild (enable) the index
ALTER INDEX index_Contact1 ON dbo.Person
REBUILD

------------------------------------------------
-- Maintaining Statistics
------------------------------------------------

-- Get list of statistics
SELECT OBJECT_NAME(Object_ID) as ObjectName, * 
FROM Sys.Stats

-- Update statistics for a specific table
UPDATE STATISTICS dbo.Person 
WITH FULLSCAN

-- Update all statistics in the database
EXEC sp_UpdateStats 

-- Get statistics details
DBCC SHOW_STATISTICS ('dbo.Person', 'index_Contact1')