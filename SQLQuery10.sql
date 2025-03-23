--1
--Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% 
--if Salary >=3000. Use company DB
declare @x int , @y int
Declare c1 cursor 
for select ssn ,salary from Employee ;

open c1 ;
fetch next from c1 into  @x ,@y

while @@FETCH_STATUS=0
begin
if @x <3000
begin
update Employee
set @x=@x * 1.10

end

else if @x >=3000
begin 
update Employee
set @x=@x * 1.20
where ssn=@y
select @x ,@y
end
fetch next from c1 into  @x ,@y
end 

close c1 ;
deallocate c1 ;

--2
--Display Department name with its manager name using cursor. Use ITI DB
declare @n varchar(30) ,@m varchar(30)
declare c2 cursor
for select Dept_Name, ins_name from Department ,Instructor
where Dept_Manager=Ins_Id  ;

open c2 ;
fetch next from c2 into @n ,@m 
begin
while @@FETCH_STATUS=0 
begin 
select  @n , @M 
fetch next from c2 into @n ,@m 
end 
end
close c2 ;
deallocate c2 ;

--3
--Try to display all students first name in one cell separated by comma. Using Cursor 
declare @name varchar(20) ,@all varchar(max)=' '
declare c3 cursor 
for select st_fname from Student ;
open c3;
fetch next from c3 into @name ;
while @@FETCH_STATUS=0 
begin 
if @name = ' '
   set @all=@name 

else 
set @all=@all+','+@name

fetch next from c3 into @name ;

end 
print @all
close c3;
deallocate c3 ;

--4
--Create full, differential Backup for SD30_Company DB.


