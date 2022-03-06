USE TestDB
SET NOCOUNT ON
go
Select CategoryName 
from Categories 
WHERE CategoryName in( 'Seafood', 'Oceans')
Order by CategoryName; -- fishfood
----
BEGIN TRANSACTION
	UPDATE dbo.Categories
	SET CategoryName = 'Seafood_venkat'
	WHERE CategoryName = 'Fishfood_venkat';
ROLLBACK TRANSACTION
-- commit TRANSACTION
Select CategoryName from Categories 
WHERE CategoryName in( 'Seafood', 'Oceanfood_venkat','Fishfood_venkat')
Order by CategoryName;

----
Select ProductName from products where productid=1 -- Chai
-----------------------------------------
-- Nested Transaction
BEGIN TRANSACTION
  UPDATE dbo.Categories
  SET CategoryName = 'Oceans'
  WHERE CategoryName = 'Seafood';
  BEGIN TRANSACTION
		Update products set productname='Tea' WHERE productId = 1;
		Print 'Before Rollback - ' + Cast(@@TRANCOUNT as char(5))
		--ROLLBACK TRANSACTION
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION; 
  Print  'After Rollback - ' + Cast(@@TRANCOUNT as char(5))
--ROLLBACK TRANSACTION
commit TRANSACTION

Select CategoryName from Categories WHERE CategoryName in( 'Fishfood', 'Oceans')
Order by CategoryName;
Select ProductName from products where productid=1 -- Chai
--------------------------------