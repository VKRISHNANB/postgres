SELECT * FROM tblEmpp
SELECT * FROM tblDEPT
SELECT * FROM tblSALGRADE

--Inner Join

SELECT tblEmpp.Empname,tblEmpp.Job,tblDEPT.Location
FROM tblEmpp
INNER JOIN tblDEPT
ON tblEmpp.DeptNo=tblDEPT.Deptid

SELECT tblEmpp.Ename,tblEmpp.Job,tblDEPT.Location
FROM tblEmpp,tblDEPT
where tblEmpp.DeptNo=tblDEPT.DeptNo

--Left outer join

SELECT tblEmpp.Ename,tblEmp.Job,tblDEPT.Location
FROM tblEmp
LEFT OUTER JOIN tblDEPT
ON tblEmp.DeptNo=tblDEPT.DeptNo

SELECT tblEmp.Ename,tblEmp.Job,tblDEPT.Location
FROM tblEmp
LEFT OUTER JOIN tblDEPT
ON tblDEPT.DeptNo=tblEmp.DeptNo

--Right outer join
SELECT tblEmp.Ename,tblEmp.Job,tblDEPT.Location
FROM tblEmp
RIGHT OUTER JOIN tblDEPT
ON tblEmp.DeptNo=tblDEPT.DeptNo

--Full outer join
SELECT tblEmp.Ename,tblEmp.Job,tblEmp.DeptNo,
tblDept.DeptNo, tblDEPT.Location
FROM tblEmp
FULL OUTER JOIN tblDEPT
ON tblEmp.DeptNo=tblDEPT.DeptNo

--Cross join

SELECT tblEmp.Ename,tblEmp.Job,tblEmp.DeptNo,
tblDept.DeptNo,tblDEPT.Location
FROM tblEmp
CROSS JOIN tblDEPT

--Self join
--Display the association of empName and manager's name 

SELECT worker.EmpNo ,worker.Ename,
Manager.EmpNo as ManagerNo,Manager.Ename as Manager
FROM tblEmp worker,tblEmp Manager
WHERE worker.Manager=Manager.EmpNo


--Display Employee Name,location,and Department Number

SELECT Ename,Location,tblEmp.DeptNo
FROM tblEmp ,tblDEPT 
WHERE tblEmp.DeptNo=tblDEPT.DeptNo

--Display employee WARD'S name and location

SELECT Ename,Location
FROM tblEmp,tblDEPT
WHERE tblEmp.DeptNo=tblDEPT.DeptNo
AND Ename='WARD'

--Display the names,department numbers,and office location of all employees.Include in that list dept numbers
--and office locations of those departments that currently have no employees. 

SELECT EName,tblDEPT.DeptNo,Location
FROM tblEmp,tblDEPT
WHERE tblEmp.DeptNo=tblDEPT.DeptNo

--Display employee name and salary for those in Grade Level 3.

SELECT Ename,Salary
FROM tblEmp,tblSALGRADE
WHERE GRADE=3 AND Salary BETWEEN LOSAL AND HISAL

--Sub Queries
--Display the name and job of all employees
-- from the same department as Jones.

SELECT Ename,Job
FROM tblEmp
WHERE tblEmp.DeptNo=(SELECT DeptNo 
              FROM tblEmp
              WHERE Ename='Jones')


--Display the name and DOJ of all employees 
--whose salary is greater than the average 
--employee salary, and who works in a department 
--with any employee named Smith

select AVG(tblEmp.Salary) from tblEmp 


SELECT Ename,DateOfJoining
FROM tblEmp  
WHERE Salary > (SELECT AVG(Salary)
				FROM tblEmp)  
AND DeptNo IN (SELECT DeptNo
				FROM tblEmp
				WHERE Ename='SMITH') 
				

select ename,dateofjoining
from tblEmp
where salary > (select avg(tblEmp.salary) from tblEmp)
and deptno =(
		select deptno 
		from tblEmp 
		where ename='Smith' and EmpNo=7369)				       