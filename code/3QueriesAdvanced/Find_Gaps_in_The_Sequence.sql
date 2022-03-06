/*
Problem Defined by Enrico
Let’s say I have the following records:

INV0096
INV0097
INV0099
INV0100
INV0102
INV0103

How can I generate a SQL Script that will show me the gaps in the sequence?

In such a way that the results will give me INV0098 and INV0101.
Or even just the number 98, and 101.

*/
-- ************************************************************************
/*
Brian Tkatch Solution 1
*/
WITH
Data(Datum)
AS
(
SELECT 'INV0096' UNION ALL
SELECT 'INV0097' UNION ALL
SELECT 'INV0099' UNION ALL
SELECT 'INV0100' UNION ALL
SELECT 'INV0102' UNION ALL
SELECT 'INV0103'
),
CTE
AS
(
SELECT
CAST(SUBSTRING(MIN(Datum), 4, 4) AS INT) Start,
CAST(SUBSTRING(MAX(Datum), 4, 4) AS INT) Finish
FROM
Data
UNION ALL
SELECT
Start + 1,
Finish
FROM
CTE
WHERE
Start < Finish
)
SELECT
Common.Formatted
FROM
CTE
CROSS APPLY(SELECT 'INV' + RIGHT('0000' + CAST(Start AS VARCHAR(4)), 4)) Common(Formatted)
WHERE
NOT EXISTS
(
SELECT
*
FROM
Data
WHERE
Data.Datum = Common.Formatted
)
OPTION
(MAXRECURSION 0);

/*
Brian Tkatch Solution 2
The CROSS APPLY is just nice, but not required. Without it, the query is very similar:
*/
WITH
Data(Datum)
AS
(
SELECT 'INV0096' UNION ALL
SELECT 'INV0097' UNION ALL
SELECT 'INV0099' UNION ALL
SELECT 'INV0100' UNION ALL
SELECT 'INV0102' UNION ALL
SELECT 'INV0103'
),
CTE
AS
(
SELECT
CAST(SUBSTRING(MIN(Datum), 4, 4) AS INT) Start,
CAST(SUBSTRING(MAX(Datum), 4, 4) AS INT) Finish
FROM
Data
UNION ALL
SELECT
Start + 1,
Finish
FROM
CTE
WHERE
Start < Finish
)
SELECT
'INV' + RIGHT('0000' + CAST(Start AS VARCHAR(4)), 4)
FROM
CTE
WHERE
NOT EXISTS
(
SELECT
*
FROM
Data
WHERE
Data.Datum = 'INV' + RIGHT('0000' + CAST(Start AS VARCHAR(4)), 4)
)
OPTION
(MAXRECURSION 0);

/*
Tejas Shah Solution 3
*/
DECLARE @Test TABLE (Data VARCHAR(10))
INSERT INTO @test
SELECT 'INV0096'
UNION ALL
SELECT 'INV0097'
UNION ALL
SELECT 'INV0099'
UNION ALL
SELECT 'INV0100'
UNION ALL
SELECT 'INV0102'
UNION ALL
SELECT 'INV0103'
UNION ALL
SELECT 'INV0106'
UNION ALL
SELECT 'INV0110'
;WITH cte1 as(
SELECT CAST(RIGHT(Data,4) AS INT) As RowID
FROM @Test
), Missing as(
SELECT MIN(RowID) AS MissNum,
MAX(RowID) AS MaxID
FROM Cte1
UNION ALL
SELECT MissNum + 1,
MaxID
FROM Missing
WHERE MissNum < MaxID
)
SELECT missnum
FROM Missing
LEFT JOIN cte1 tt on tt.Rowid = Missing.MissNum
WHERE tt.Rowid is NULL
OPTION (MAXRECURSION 0); 
