--1
--Display the Department id, name and id and the name of its manager.
select Dname ,Dnum ,Fname+Lname "ManagerName "
from Departments ,Employee
where MGRSSN=SSN;

--2
--Display the name of the departments and the name of the projects under its control.
Select Dname ,pname
from Departments d, Project p
where d.Dnum=p.Dnum;

--3
--Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select Fname+Lname "Employee name " ,ESSN,Dependent_name ,d.Sex ,d.Bdate
from Employee e ,Dependent d
where SSN=ESSN;

--4
-- Display the Id, name and location of the projects in Cairo or Alex city.
select Pnumber ,Pname ,Plocation
from Project
where City in ('Cairo' ,'Alex' );

--5
-- Display the Projects full data of the projects with a name starts with "a" letter.
select Pnumber ,Pname ,Plocation ,City,Dnum
from Project
where pname like 'a%';

--6
--display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select Fname ,Lname
from Employee
WHERE Dno=30
and Salary between 1000 and 2000;

--7(recheck)
--Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select Fname ,Lname
from Employee e ,Works_for w ,Project p
WHERE e.SSN=w.ESSn
and  p.Pnumber=w.Pno
and e.Dno=10 
and w.Hours>=10
and p.Pname='AL Rabwah';

--8
--Find the names of the employees who directly supervised with Kamel Mohamed.
select e.Fname , e.Lname ,s.Fname ,s.Lname
from Employee e , Employee s
where s.Superssn=e.ssn
and e.Fname='kamel'
and e.Lname='Mohamed';

--9 (REcheck)
--Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select Fname ,Lname ,Pname
from Employee e ,Works_for w ,Project p
WHERE e.SSN=w.ESSn
and  p.Pnumber=w.Pno 
order by Pname;

--10
--For each project located in Cairo City , find the project number, the controlling department name ,
--the department manager last name ,address and birthdate.
select p.Pnumber ,d.Dname ,e.Fname ,e.Lname ,e.Address ,e.Bdate
from employee e,Project p, Departments d
where d.Dnum=p.Dnum
and e.SSN=d.MGRSSN
and City='cairo';



--11
--Display All Data of the managers
Select *
from Employee , Departments
where SSN=MGRSSN ;


--12
--Display All Employees data and the data of their dependents even if they have no dependents
select *
from Employee e left join Dependent d
on SSN=ESSN;

--13
--Insert your personal data to the employee table as a new employee in department number 30, 
--SSN = 102672, Superssn = 112233,salary=3000.

insert into Employee
values ('Dalia' ,'Gamal' ,102672,'11-26-2002','Faisal,Giza','F',3000,112233,10);

--14
--Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, 
--but don’t enter any value for salary or supervisor number to him.

insert into Employee (Fname ,Lname ,SSN,Bdate,Address,Sex ,Dno )
values ('lara' ,'Gamal' ,1102660,'11-26-2002','Faisal,Giza','F',10);

--15 
--Upgrade your salary by 20 % of its last value
update Employee
set Salary=Salary*1.2 
where SSN=102672;
