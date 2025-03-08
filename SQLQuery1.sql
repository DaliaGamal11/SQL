--1
Select * 
from Employee ;

--2
select Fname , Lname ,salary , Dno
from Employee;

select * 
from Project;

--3
select Pname , Plocation , Dnum 
from Project;

--4
select Fname+Lname "Full name" , salary*.10*12 "ANNUAL COMM"
from Employee ;

--5
select SSN "ID" , Fname 
from Employee
WHERE salary > 10000;

--6
select SSN "ID" , Fname 
from Employee
WHERE salary*12 > 10000;

--7
select Fname , Salary
from Employee
WHERE Sex = 'F';


select * 
from Departments;

--8
select Dname , Dnum
FROM Departments
where MGRSSN=968574;

--9
select Pname ,pnumber ,Plocation 
from Project
where Dnum=10 ;
