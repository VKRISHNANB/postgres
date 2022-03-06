--------Creating the table which will store permanent table
CREATE TABLE TestTable (ID INT, TEXTVal VARCHAR(100))
----Creating temp table to store ovalues of OUTPUT clause
DECLARE @TmpTable TABLE (ID INT, TEXTVal VARCHAR(100))
----Insert values in real table as well use OUTPUT clause to insert
----values in the temp table.
INSERT TestTable (ID, TEXTVal)
OUTPUT Inserted.ID, Inserted.TEXTVal INTO @TmpTable
VALUES (1,'FirstVal')
INSERT TestTable (ID, TEXTVal)
OUTPUT Inserted.ID, Inserted.TEXTVal INTO @TmpTable
VALUES (2,'SecondVal')
----Check the values in the temp table and real table
----The values in both the tables will be same
SELECT * FROM @TmpTable
SELECT * FROM TestTable
----Clean up time
DROP TABLE TestTable
GO