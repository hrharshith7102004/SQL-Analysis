								--case study 2
create table locations
(
location_id int primary key,
city varchar(50)

)
insert into locations values
(122,' New York'),
(123, 'Dallas'),
(124,'Chicago'),
(167,'Boston')
select * from locations

create table department
(
Department_Id int primary key,
Name varchar(50),
Location_Id int Foreign key references locations(location_id)
)

insert into department values
(10,' Accounting', 122),
(20, 'Sales', 124),
(30,' Research',123),
(40, 'Operations', 167)

select * from department

create table job
(
Job_ID int primary key,
Designation varchar(50)
)

insert into job values
(667,' Clerk'),
(668 ,'Staff'),
(669, 'Analyst'),
(670 ,'Sales Person'),
(671, 'Manager'),
(672, 'President')

select * from job


create table employee
(
Employee_Id int ,
Last_Name varchar(50),
First_Name varchar(50),
Middle_Name varchar(50),
Job_Id int foreign key references job(job_id),
Hire_Date date,
Salary int,
Commission int,
Department_Id int foreign key references department(department_id)
)

select * from employee

insert into employee values
(7369, 'Smith', 'John', 'Q', 667, '17-Dec-84', 800, Null, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '20-Feb-85', 1600, 300 ,30),
(755, 'Doyle', 'Jean', 'K', '671', '04-Apr-85', 2850, Null, 30),
(756,' Dennis', 'Lynn',' S', 671 ,'15-May-85', 2750, Null, 30),
(757,'Baker ','Leslie',' D', 671 ,'10-Jun-85 ',2200, Null, 40),
(7521,' Wark', 'Cynthia',' D', 670,' 22-Feb-85', 1250, 50, 30)


Simple Queries:

--1. List all the employee details.
  select * from employee

--2. List all the department details.
select * from department

--3. List all job details.
  select * from job

--4. List all the locations.
   select * from locations

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
 
    select First_Name, Last_Name, Salary, Commission from employee

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"

select employee_id,last_name ,department_id from employee


--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"

select employee_id as ID_of_the_employee,last_name as Name_of_the_employee, department_id as Dep_id
from employee 


--7. List out the annual salary of the employees with their names only.
select first_name,middle_name,last_name, (salary*12) as annual_salary from employee


--WHERE Condition:
--1. List the details about "Smith".
  select * from employee where last_name='smith'

--2. List out the employees who are working in department 20.

select * from employee where Department_Id=20

--3. List out the employees who are earning salary between 2000 and 3000.

select * from employee where salary between 2000 and 3000

--4. List out the employees who are working in department 10 or 20.

select * from employee where department_id in  (10 , 20)

--5. Find out the employees who are not working in department 10 or 30.

 SELECT * from employee where Department_Id not in (10,30)


--6. List out the employees whose name starts with 'L'.

select * from employee where first_name like 'L%'



--7. List out the employees whose name starts with 'L' and ends with 'E'.

select * from employee where first_name like 'L%'and last_name like'%E'


--8. List out the employees whose name length is 4 and start with 'J'.

select * from employee where first_name like 'J%___'


--9. List out the employees who are working in department 30 and draw the salaries more than 2500.

select * from employee where Department_Id=30 and Salary>2500


--10. List out the employees who are not receiving commission.

select * from employee where Commission is null


--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

select employee_id,last_name from  employee order by Employee_Id asc

--2. List out the Employee ID and Name in descending order based on salary.

select employee_id,first_name+middle_name+last_name as Name from  employee order by salary desc


--3. List out the employee details according to their Last Name in ascending-order.

select * from employee order by last_name asc


--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

select * from employee order by last_name asc,Department_Id desc



--GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.

select max(salary)as max_salary,min(salary)as min_salary,avg(salary) as avg_salary from employee
use happy

--2. List out the job wise maximum salary, minimum salary and average salary of the employees.

select designation,max(salary)as max_salary,min(salary)as min_salary,avg(salary) as avg_salary
from employee
join job as J
on employee.job_id=J.job_id
group by designation

--3. List out the number of employees who joined each month in ascending order.

select month(Hire_Date)as month,count(employee_id)as no_of_emp from employee
group by Hire_Date

--4. List out the number of employees for each month and year in ascending order based on the year and month.

   select year(Hire_Date)AS year,month(Hire_Date)as month,count(employee_id)as no_of_emp from employee
group by year(Hire_Date), month(Hire_Date)
order by year(Hire_Date),month(Hire_Date) asc



--5. List out the Department ID having at least four employees.

 select Department_Id  from employee 
 group by Department_Id 
 having count(department_id)=4

--6. How many employees joined in February month.

select count(employee_id) as no_of_employee 
from employee
where   month(hire_date)=2

--7. How many employees joined in May or June month.

select count(employee_id) as no_of_employee 
from employee
where   month(hire_date)in (5,6)

--8. How many employees joined in 1985?

select count(employee_id) as no_of_employee 
from employee
where   year (hire_date)=1985

--9. How many employees joined each month in 1985?

select count(employee_id) as no_of_employee,
month(hire_date) as month,
year(hire_date) as year
from employee
group by month(hire_date),year(hire_date)
having year(hire_date)=1985

--10. How many employees were joined in April 1985?

select count(employee_id) as no_of_employee 
from employee
where   month(hire_date)=4

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

select department_id,month(hire_date) as month,
year(hire_date) as year
from employee
group by department_id,month(hire_date),year(hire_date)
having month(hire_date)=4 and year(hire_date)=1985 and count(*)>=3

--Joins:
--1. List out employees with their department names.
select * from employee
select * from department

select E.first_name+E.middle_name+E.last_name as employee_name,D.Name
from employee as E
join department as D
on e.department_id=D.Department_Id

--2. Display employees with their designations.
select * from employee
select * from job

select E.first_name+E.middle_name+E.last_name as employee_name,J.designation
from employee as E
join job as J
on E.job_id=J.job_id

--3. Display the employees with their department names and city.
select * from employee
select * from department
select * from locations

select E.first_name+E.middle_name+E.last_name as employee_name,D.name as department_name,
L.city
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
inner join locations as L
on D.Location_Id=D.Location_Id

--4. How many employees are working in different departments? Display with department names.
select * from employee
select * from department

select  count(E.employee_id) as no_of_employee,D.name as department_name
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
group by D.name


--5. How many employees are working in the sales department?

select  count(E.employee_id) as no_of_employee,D.name as department_name
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
group by D.name
having D.name='sales'


--6. Which is the department having greater than or equal to 3 employees and
--display the department names in ascending order.

select * from employee
select * from department

select count(E.department_id) as no_of_employee,D.name as department_name
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
group by E.Department_Id,D.name
having  count(E.department_id)>=3

--7. How many employees are working in 'Dallas'?
select * from employee
select * from locations
select * from department

select count(D.location_id)as no_of_employee,L.city,D.location_id
from employee as E
inner join department as D
on E.Department_Id=d.Department_Id
inner join locations as L
on D.Location_Id=L.location_id
group by D.Location_Id,L.city,D.Location_Id
having L.city='dallas'


--8. Display all employees in sales or operation departments.

select  count(E.employee_id) as no_of_employee,D.name as department_name
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
group by D.name
having D.name in ('sales','operation')


--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
select * from employee


select 
first_name+middle_name+last_name as employee_name,
salary,
case 
when salary between 0 and 800 then 'Grade1'
when salary between 801 and 1400 then 'Grade2'
when salary between 1401 and 2100 then 'Grade3'
when salary between 2101 and 2700 then 'Grade4'
else 'Grade5'
end as Salary_Grade
from employee



--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
select * from employee

select 
first_name+middle_name+last_name as employee_name,
salary,
case 
when salary between 0 and 800 then 'Grade1'
when salary between 801 and 1400 then 'Grade2'
when salary between 1401 and 2100 then 'Grade3'
when salary between 2101 and 2700 then 'Grade4'
else 'Grade5'
end as Salary_Grade,count(*) as employee_grade
from employee
group by first_name+middle_name+last_name,salary


--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.\

select 
first_name+middle_name+last_name as employee_name,
salary,
case 
when salary between 0 and 800 then 'Grade1'
when salary between 801 and 1400 then 'Grade2'
when salary between 1401 and 2100 then 'Grade3'
when salary between 2101 and 2700 then 'Grade4'
else 'Grade5'
end as Salary_Grade,count(*) as employee_grade
from employee
where salary between 2000 and 5000
group by first_name+middle_name+last_name,salary

--Subqueries:
--1. Display the employees list who got the maximum salary.

select employee_id,salary from employee where Salary=(select max(salary) as max_salary from employee)

--2.Display the employees who are working in the sales department.

select E.employee_id,D.name
from employee as E
inner join  department as D
on E.Department_Id=D.Department_Id
where D.name='Sales'

--3. Display the employees who are working as 'Clerk'.
select * from employee
select * from job where Designation=' Clerk'

select E.Job_Id,J.designation
from employee as E
inner join job as J
on E.Job_Id=J.Job_ID
where J.Designation=' Clerk '

--4. Display the list of employees who are living in 'Boston'.
select * from employee
select * from locations


select E.employee_id,L.location_id,D.department_id,L.city
from employee as E
inner join department as D
on E.Department_Id=D.Department_Id
inner join locations as L
on D.Location_Id=L.location_id
group by E.Employee_Id,L.location_id,L.city,D.Department_Id
having city='boston'


--5. Find out the number of employees working in the sales department.

select E.employee_id,D.name
from employee as E
inner join  department as D
on E.Department_Id=D.Department_Id
group by E.Employee_Id,D.name
having D.name='Sales'




--6. Update the salaries of employees who are working as clerks on the basis of 10%.

update E set E.salary=E.salary*1.10
from employee as E
inner join job as J
on E.Job_Id=J.Job_ID
where Designation=' Clerk'

--7. Display the second highest salary drawing employee details.

select * from (select *,DENSE_RANK() over (order by salary desc) as highest_salary 
from employee) as Rank_employees where highest_salary=1

--8. List out the employees who earn more than every employee in department 30.

select * from employee 
where Salary > (select max(salary) from employee where Department_Id = 30)


select * from employee where Department_Id=30
--9. Find out which department has no employees.

select * from department
where department_id not in (select department_id from employee)

--10. Find out the employees who earn greater than the average salary for their department.

select Employee_Id,salary from employee where Salary>(select AVG(salary) from employee)
group by employee_id,salary
