CREATE TABLE table1
(ID INT, Value VARCHAR(10))

INSERT INTO Table1 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 4,'Fourth'
UNION ALL
SELECT 5,'Fifth'
GO

CREATE TABLE table2
(ID INT, Value VARCHAR(10))

INSERT INTO Table2 (ID, Value)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 6,'Sixth'
UNION ALL
SELECT 7,'Seventh'
UNION ALL
SELECT 8,'Eighth'
GO

SELECT * FROM Table1

SELECT * FROM Table2
GO


GO
/* INNER JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
INNER JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* LEFT JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* RIGHT JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* OUTER JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID
GO
/* LEFT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t2.ID IS NULL
GO
/* RIGHT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL
GO
/* OUTER JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL OR t2.ID IS NULL
GO
/* CROSS JOIN */
SELECT t1.*,t2.*
FROM Table1 t1
CROSS JOIN Table2 t2
GO


DROP TABLE table1
DROP TABLE table2
GO