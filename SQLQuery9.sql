--1
--Create a stored procedure without parameters to show the number of students per department name.[use ITI DB] 
create procedure num  as
begin 
select Dept_Name , count (st_id)
from Student s, Department d
Where s.Dept_Id=d.Dept_Id
Group by Dept_Name 
end

--TEST 
exec num ;

--2 (Check )
--Create a stored procedure that will check for the # of employees in the project p1 if they are 
--more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'”
--if they are less display a message to the user “'The following employees work for the project p1'” in addition to
--the first name and last name of each one. [Company DB] 

Create procedure Num2(@p varchar(20))
as
begin
declare @x int
set @x = (select count(ssn) from project p, employee e, Works_for w
where pno = Pnumber and ssn = ESSn and pname = @p)
if @x >= 3
select 'The number of employees in the project p1 is 3 or more'
else if @x < 3
select 'The following employees work for the project p1'
select fname, lname from project p, employee e, Works_for w
where pno = Pnumber and ssn = ESSn and pname = @p
end

--test
exec num2'Al Rowad'

--3
--Create a stored procedure that will be used in case there is an old employee has left the project 
--and a new one become instead of him. The procedure should take 3 parameters (old Emp. number, new Emp.
--number and the project number) and it will be used to update works_on table. [Company DB]

create procedure Replacee (@Ossn int ,@Nssn int ,@pno int ) as 
begin 
update Works_for 
set ESSn =@Nssn
where ESSn=@Ossn
and pno= @pno
end 
--test
exec Replacee @ossn=1 ,@nssn=2 ,@pno=3 ;



--4
--add column budget in project table and insert any draft values in it then   
--then Create an Audit table with the following structure  
--ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New 
--p2 	Dbo 	2008-01-31	95000 	200000 
--This table will be used to audit the update trials on the Budget column (Project table, Company DB)
--Example:If a user updated the budget column then the project number, user name that made that update,
--the date of the modification and the value of the old and the new budget will be inserted into the Audit table
--Note: This process will take place only if the user updated the budget column
alter table  project 
add Budget int ;

create table Auditt (ProjectNo int , UserName varchar(20) , ModifiedDate date ,	Budget_Old int ,Budget_New int )
insert into Auditt values ( 2 ,	'Dbo' ,	'2008-01-31' ,	95000 ,	200000 )

create trigger t
on project 
after update as 
begin 
if update (budget )
begin 
insert into Auditt (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
SELECT d.Pnumber, SYSTEM_USER,  GETDATE(),  d.Budget, i.Budget                      
        FROM inserted i INNER JOIN deleted d
        ON i.Pnumber = d.Pnumber
        WHERE i.Budget <> d.Budget;      
    END
end 

--test 
UPDATE Project
SET Budget = 200000
WHERE Pnumber = 2;

select* from Auditt;

--5
--Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
create trigger t1
on department 
After insert as 
begin 
RAISERROR ('You can''t insert a new record into the Department table.', 16, 1);
end 

--test 
INSERT INTO Department (Dept_Id ,Dept_Name)
VALUES (1, 'Human Resources');

--6
--Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
create trigger t2 
on employee 
after insert  as
begin 
 if month (getdate())=3
   begin 
      RAISERROR('Inserting new records in March is not allowed in the Employee table.', 16, 1);
      ROLLBACK TRANSACTION ;
	end
end 
--test 
INSERT INTO Employee (SSN, Fname, Lname, Salary, Bdate)
VALUES (1, 'John', 'Doe', 5000, '2025-03-19');


--7
--Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note)
--where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”
create table auditt
add Note varchar(255);

alter trigger t3
on student 
after insert as
begin 
insert into Company_SD.dbo.Auditt(ProjectNo ,UserName , ModifiedDate,Budget_Old ,Budget_New ,note)
select null, SYSTEM_USER,  GETDATE() ,null , null ,
CONCAT(SYSTEM_USER, ' Insert New Row with Key=', i.St_Id, ' in table Student')  
from inserted i 
end 

--test 
INSERT INTO Student (St_Id ,St_Fname ,St_Lname,St_Age)
VALUES (66, 'John', 'Doe', 22);

SELECT * FROM Company_SD.dbo.Auditt;

--8 
--Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note)
--where note will be“ try to delete Row with Key=[Key Value]”
create trigger t4
on student 
after delete  as
begin 
insert into Company_SD.dbo.Auditt (UserName , ModifiedDate ,note)
select SYSTEM_USER , GETDATE() ,
CONCAT('try to delete Row with Key=', d.St_Id)
from deleted d
end 

--test 
DELETE FROM Student WHERE St_Id = 1;
SELECT * FROM Company_SD.dbo.Auditt;
