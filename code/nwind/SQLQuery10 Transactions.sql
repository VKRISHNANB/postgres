USE Northwind
go
Select CategoryName from Categories
GO
BEGIN TRANSACTION
UPDATE dbo.Categories
SET CategoryName = 'Oceans'
WHERE CategoryName = 'Fishfood';

--ROLLBACK TRANSACTION
commit TRANSACTION

Select CategoryName from Categories
