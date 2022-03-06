--------------------------------------------
-- Creating and Managing Partitions
--------------------------------------------

-- Create a partition function
CREATE PARTITION FUNCTION fn_partition_Transaction (datetime)
AS RANGE RIGHT FOR VALUES ('01/01/2003', '01/01/2004')

-- View partition function details
SELECT * FROM Sys.Partition_Parameters
SELECT * FROM Sys.Partition_Range_Values

-- Test the partition function
SELECT $PARTITION.fn_partition_Transaction ('01/17/2001')
SELECT $PARTITION.fn_partition_Transaction ('02/22/2003')
SELECT $PARTITION.fn_partition_Transaction ('03/31/2006')

-- Add a new filegroup and file to the Development database
ALTER DATABASE [Development] ADD FILEGROUP [FileGroup2]
ALTER DATABASE [Development] ADD FILE ( NAME = N'Development_2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.2\MSSQL\DATA\Development_2.ndf' , SIZE = 3072KB , FILEGROWTH = 1024KB ) TO FILEGROUP [FileGroup2]

-- Create a partition scheme
CREATE PARTITION SCHEME partition_Transaction_1
AS PARTITION fn_partition_Transaction
TO ([PRIMARY], [FileGroup2], [FileGroup2])

SELECT * FROM Sys.Partition_Schemes

-- Create a new table on the partition
CREATE TABLE Transactions
(
	ID				int		IDENTITY(1,1),
	TransactionDate	datetime NOT NULL,
	ActualCost		money	NOT NULL	
)
ON partition_Transaction_1 (TransactionDate)

-- Load data into the partitioned table
INSERT INTO Transactions (TransactionDate, ActualCost)
SELECT TransactionDate, ActualCost
FROM AdventureWorks.Production.TransactionHistory

-- View Database, Table, and Partition Information
EXEC sp_helpdb 'Development'
EXEC sp_SpaceUsed 'Transactions'
SELECT * FROM Sys.Database_Files

SELECT OBJECT_NAME(Object_ID) as ObjectName, *
FROM Sys.Partitions
WHERE OBJECT_NAME(Object_ID) = 'Transactions'

-- Create an aligned index
CREATE INDEX index_Transactions
ON Transactions (TransactionDate, ActualCost)
ON partition_Transaction_1 (TransactionDate)

SELECT OBJECT_NAME(Object_ID) as ObjectName, *
FROM Sys.Indexes
WHERE OBJECT_NAME(Object_ID) = 'Transactions'

-- Perform a test query
SELECT TransactionDate, ActualCost
FROM Transactions
WHERE TransactionDate IN ('05/01/2004', '09/01/2003', '03/31/2006')

-- Perform clean-up
DROP TABLE Transactions
DROP PARTITION SCHEME partition_Transaction_1
DROP PARTITION FUNCTION fn_partition_Transaction
