Create table #t1(c1 integer)

insert into #t1 (c1)
select 4
union all 
select (5)
union all 
select(6)
select * from #t1

-- Get Current Session ID
SELECT @@SPID AS Current_SessionID
-- Check the space usage in page files
SELECT user_objects_alloc_page_count
FROM sys.dm_db_session_space_usage
WHERE session_id = (SELECT @@SPID )
GO
-- Create Temp Table and insert three thousand rows
CREATE TABLE #TempTable (Col1 INT)
INSERT INTO #TempTable (Col1)
SELECT TOP 3000 ROW_NUMBER() OVER(ORDER BY a.name)
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO
select col1 from #TempTable
GO
-- Check the space usage in page files
SELECT user_objects_alloc_page_count
FROM sys.dm_db_session_space_usage
WHERE session_id = (SELECT @@SPID )
GO
-- Clean up
DROP TABLE #TempTable
GO
-- Check the space usage in page files
SELECT user_objects_alloc_page_count
FROM sys.dm_db_session_space_usage
WHERE session_id = (SELECT @@SPID )
GO

-- Create Table Variable and insert three thousand rows
DECLARE @temp TABLE(Col1 INT)
INSERT INTO @temp (Col1)
SELECT TOP 3000 ROW_NUMBER() OVER(ORDER BY a.name)
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO
-- Check the space usage in page files
SELECT user_objects_alloc_page_count
FROM sys.dm_db_session_space_usage
WHERE session_id = (SELECT @@SPID )
GO
-- Clean up
DROP TABLE #TempTable
GO
-- Effect on Transaction
DECLARE @intVar INT
SET @intVar = 1
SELECT @intVar BeforeTransaction
BEGIN TRAN
SET @intVar = 2
ROLLBACK
SELECT @intVar AfterRollBackTran
--
USE Sample

-- Create Temp Table and insert single row
CREATE TABLE #TempTable (Col1 VARCHAR(100))
INSERT INTO #TempTable (Col1)
VALUES('Temp Table - Outside Tran');
-- Create Table Variable and insert single row
DECLARE @TableVar TABLE(Col1 VARCHAR(100))
INSERT INTO @TableVar (Col1)
VALUES('Table Var - Outside Tran');
-- Check the Values in tables
SELECT Col1 AS TempTable_BeforeTransaction
FROM #TempTable;
SELECT Col1 AS TableVar_BeforeTransaction
FROM @TableVar;
/*
Insert additional row in trans
Rollback Transaction at the end
*/
BEGIN TRAN
-- Insert single row
INSERT INTO #TempTable (Col1)
VALUES('Temp Table - Inside Tran');
-- Insert single row
INSERT INTO @TableVar (Col1)
VALUES('Table Var - Inside Tran');
ROLLBACK
-- Check the Values in tables
SELECT Col1 AS TempTable_AfterTransaction
FROM #TempTable;
SELECT Col1 AS TableVar_AfterTransaction
FROM @TableVar;
-- Clean up
DROP TABLE #TempTable;