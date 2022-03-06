-- Magic TABLES
Create table magicemp(id int,name varchar(30),salary numeric(10,0));
alter trigger t1 on magicemp 
for insert 
AS
begin
  if datename(DW,getdate()) in ( 'Tuesday','Sunday') 
    begin
	   --select current_user
       select * from inserted;
       rollback;
    end
end
insert into magicemp values(101,'a',9000)
select * from magicemp
==============================================================

--Example 1 : OUTPUT clause into Table with INSERT statement
--------Creating the table which will store permanent data
CREATE TABLE TestTable_Venkat (ID INT, TEXTVal VARCHAR(100))
----Creating temp Table Variable to store values of OUTPUT clause
DECLARE @TmpTable TABLE (ID INT, TEXTVal VARCHAR(100))
----Insert values in real table as well use OUTPUT clause to insert
----values in the temp variable.
INSERT TestTable_Venkat (ID, TEXTVal)
OUTPUT Inserted.ID, Inserted.TEXTVal INTO @TmpTable
VALUES (1,'FirstVal')
SELECT * FROM @TmpTable
select * from TestTable_Venkat

INSERT TestTable_Venkat (ID, TEXTVal)
OUTPUT Inserted.ID, Inserted.TEXTVal INTO @TmpTable
VALUES (2,'SecondVal')
----Check the values in the temp variable and real table
----The values in both the tables will be same
SELECT * FROM @TmpTable
SELECT * FROM TestTable
----Clean up time
DROP TABLE TestTable
GO
================================================================
--Example 2 : OUTPUT clause into Table with UPDATE statement
----Creating the table which will store permanent table
CREATE TABLE TestTable (ID INT, TEXTVal VARCHAR(100))
----Creating temp table to store ovalues of OUTPUT clause
DECLARE @TmpTable TABLE (ID_New INT, TEXTVal_New VARCHAR(100),
						ID_Old INT, TEXTVal_Old VARCHAR(100))
----Insert values in real table
INSERT TestTable (ID, TEXTVal)
VALUES (1,'FirstVal'), (2,'SecondVal')
----Update the table and insert values in temp table using Output clause
UPDATE TestTable
SET TEXTVal = 'NewValue'
OUTPUT Inserted.ID, Inserted.TEXTVal, Deleted.ID, Deleted.TEXTVal INTO @TmpTable
WHERE ID IN (1,2)
----Check the values in the temp table and real table
----The values in both the tables will be same
SELECT * FROM @TmpTable
SELECT * FROM TestTable

----Clean up time
DROP TABLE TestTable
GO
==============================================================
--Example 3 : OUTPUT clause into Table with DELETE statement
----Creating the table which will store permanent table
CREATE TABLE TestTable (ID INT, TEXTVal VARCHAR(100))
----Creating temp table to store ovalues of OUTPUT clause
DECLARE @TmpTable TABLE (ID INT, TEXTVal VARCHAR(100))
----Insert values in real table
INSERT TestTable (ID, TEXTVal)
VALUES (1,'FirstVal')
INSERT TestTable (ID, TEXTVal)
VALUES (2,'SecondVal')
----Delete the table rows and insert values in temp table using Output clause
DELETE
FROM TestTable
OUTPUT Deleted.ID, Deleted.TEXTVal INTO @TmpTable
WHERE ID IN (1,2)
----Check the values in the temp table and real table
SELECT * FROM @TmpTable
SELECT * FROM TestTable
----Clean up time
DROP TABLE TestTable
GO
===================================================================