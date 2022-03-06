SELECT * FROM tblEmp

SELECT * FROM tblDept

SELECT EmpName FROM tblEmp

SELECT DeptName FROM tblDept

SELECT DeptId,DeptName FROM tblDept

SELECT Job FROM tblEmp

SELECT DISTINCT Job 
FROM tblEmp

SELECT Job "Job_List" 
FROM tblEmp

SELECT EmpNo,EmpName,Salary 
FROM tblEmp 
WHERE DeptNo=30

SELECT EmpName,Job,Salary
FROM tblEmp
WHERE Job <> 'Analyst'

SELECT EmpName,job,DeptNo,DateOfJoining
FROM tblEmp
WHERE DateOfJoining BETWEEN '01-JAN-2000' AND '01-JAN-2011'

SELECT EmpName,Job,DeptNo
FROM tblEmp
WHERE Job IN ('Clerk','Analyst')

SELECT EmpName,Job,DeptNo,DateOfJoining
FROM tblEmp
WHERE EmpName LIKE 'S%'

SELECT EmpName,Job,DeptNo,DateOfJoining
FROM tblEmp
WHERE EmpName LIKE 'S_ITH%'

SELECT EmpName,Job
FROM tblEmp
WHERE Salary > 5000

SELECT EmpName,Job
FROM tblEmp
WHERE Salary < 10000

SELECT EmpName,Job
FROM tblEmp
WHERE Salary  IS NULL

SELECT EmpName,Salary,Job
FROM tblEmp
WHERE DeptNo=30
AND Job='SalesMan'

SELECT EmpName,Salary,Job
FROM tblEmp
WHERE DeptNo=30
OR Job='SalesMan'

SELECT EmpName,Job,Salary
FROM tblEmp
WHERE DeptNo=10
ORDER BY Salary

SELECT EmpName,Job,Salary
FROM tblEmp
WHERE DeptNo=10
ORDER BY Salary DESC

SELECT EmpName,Job,Salary
FROM tblEmp
WHERE DeptNo=30
ORDER BY Job,Salary DESC,EmpName

SELECT EmpName,Salary,Job
FROM tblEmp
WHERE DeptNo=30
ORDER BY 2

