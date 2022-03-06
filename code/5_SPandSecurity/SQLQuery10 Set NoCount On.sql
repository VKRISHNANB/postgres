CREATE PROC dbo.ProcName
AS
SET NOCOUNT ON;
--Procedure code here
SELECT FirstName FROM dbo.Employees
-- Reset SET NOCOUNT to OFF
SET NOCOUNT OFF;
GO 
--------------------------------
CREATE PROC dbo.ProcNameA
AS
--Procedure code here
SELECT FirstName FROM dbo.Employees
GO 
exec procname
exec procnameA
--- ==================================
