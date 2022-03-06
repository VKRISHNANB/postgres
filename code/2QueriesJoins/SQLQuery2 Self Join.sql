
SELECT worker.[EmployeeID]      
      ,worker.[FirstName]
      ,worker.ReportsTo ,manager.[FirstName] As 'Manager' 
  FROM [TestDB].[dbo].[Employees] as worker
  join [TestDB].[dbo].[Employees] as manager
  on worker.ReportsTo=manager.EmployeeID
/*
Select * from tblEmp

Select e1.EmpNo,e1.EmpName,e1.ManagerNo,e2.EmpName as Manager , e1.Salary
from tblemp e1
Left join tblemp e2
on e1.ManagerNo=e2.EmpNo
Order by Manager

select e1.employeeid.e1.lastname,e1.reportsto,e2.lastname as Manager
from employees e1
join employees e2 
on e1.reportsto=e2.employeeid
*/