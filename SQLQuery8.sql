--1
-- Create a scalar function that takes date and returns Month name of that date. 

Create Function MonthNamee (@d date) 
returns varchar (20) as 
begin 

declare @Name varchar(20)
set @Name=Datename(month ,@d)
return @Name 

end 

go 
--test 
SELECT dbo.MonthNamee('2025-03-12') ;

go
--2
--Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
create function v_BTW (@x int , @y int )
Returns @T table (C int ) as 
begin 
DEclare @count Int =1
while @x <@y
begin 
INSERT INTO @T 
        VALUES (@x)
        SET @x = @x + 1
end
return 
end 

go
--test 
select * from dbo.v_BTW (5,10 ) "numbers " ;

go 
--3
--Create inline function that takes Student No and returns Department Name with Student full name. 
Create function FN_D (@N int )
returns table as return 
select Dept_Name , CONCAT (St_fname ,'  ', St_Lname ) "Full Name "
from Student s , Department d
where s.Dept_Id=d.Dept_Id
and s.St_Id=@N

go 
--test 
select * from dbo.FN_D(1) ;

go
 
--4
--Create a scalar function that takes Student ID and returns a message to user  
--If first name and Last name are null then display 'First name & last name are null' 
--If First name is null then display 'first name is null' 
--If Last name is null then display 'last name is null' 
--Else display 'First name & last name are not null' 

Create function messagee (@ID int )
returns varchar(50) as 
begin 
declare @x varchar(20)
declare @y varchar(20)
Declare @m varchar (50)

set @x=(select St_Fname from Student where St_Id=@ID )
set @Y=(select St_Lname from Student where St_Id=@ID )

IF @x is null and @y is null 
set @m= 'First name & last name are null' 

else IF @x is null 
set @m= 'first name is null' 

else IF @y is null 
set @m= 'last name is null' 

else 
set @m= 'First name & last name are not null' 

return @m
end 

go 
--test 
SELECT dbo.messagee(14); 

go

--5
--Create inline function that takes integer which represents manager ID and displays department name,
--Manager Name and hiring date  

Create function f5(@n int )
returns table as return 
select Dname , CONCAT(fname ,' ' ,lname )" Full name " , [MGRStart Date] "Hiring date "
from Departments , employee
where MGRSSN=SSN
and MGRSSN=@n

go
--test 
select* from dbo.f5 (102672) ;
go 

--6 
--Create multi-statements table-valued function that takes a string 
--If string='first name' returns student first name 
--If string='last name' returns student last name  
--If string='full name' returns Full Name from student table  
--Note: Use “ISNULL” function 

Alter FUNCTION f6 (@s VARCHAR(50))
RETURNS @T TABLE (C VARCHAR(20))
AS
BEGIN
    DECLARE @m VARCHAR(50)

    IF @s = 'first name'
    BEGIN
        INSERT INTO @T (C)
        SELECT ISNULL(St_Fname, '0')
        FROM Student
    END
    ELSE IF @s = 'last name'
    BEGIN
        INSERT INTO @T (C)
        SELECT ISNULL(St_Lname, '0')
        FROM Student
    END
    ELSE IF @s = 'full name'
    BEGIN
        INSERT INTO @T (C)
        SELECT ISNULL(CONCAT(St_Fname, ' ', St_Lname), '0')
        FROM Student
    END

    RETURN
END

go 
--test 
select * from dbo.f6('full name') ;

