create database subqueries;
use subquesries;
show tables;
SELECT DATABASE();
-- Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);

-- Department Table
CREATE TABLE Department (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);
select * from employee;
select * from Department;
select * from sales;
### Basic level
#  1 Retrieve the names of employees who earn more than the average salary of all employees.
SELECT name, salary
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);
#  2 Find the employees who belong to the department with the highest average salary.
SELECT name, department_id, salary
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) >= ALL (
        SELECT AVG(salary)
        FROM Employee
        GROUP BY department_id
    )
);
# 3 List all employees who have made at least one sale
SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
);
#Q4 Find the employee with the highest sale amount
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
    )
);
# Q5 Retrieve the names of employees whose salaries are higher than Shubham’s salary.
select name from employee
where salary >(select salary from employee
                 where name = 'Shubham');
###### intermediate level 
# Q 1 Find employees who work in the same department as Abhishek.
select name from employee
where department_id = 
(select department_id from employee
where name ='Abhishek');
# q2 List departments that have at least one employee earning more than ₹60,000
select department_name from department
where department_id in
(select department_id from employee
where salary > 60000);
# Q3 Find the department name of the employee who made the highest sale.
SELECT department_name
FROM Department
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE emp_id = (
        SELECT emp_id
        FROM Sales
        WHERE sale_amount = (
            SELECT MAX(sale_amount)
            FROM Sales
        )
    )
);

# 4 Retrieve employees who have made sales greater than the average sale 
SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount > (
        SELECT AVG(sale_amount)
        FROM Sales
    )
);
# Find the total sales made by employees who earn more than the average salary.

select sum(sale_amount) from sales
where emp_id in(select emp_id from employee
where salary>(select avg (salary) from employee));
# Advanced level
# q1 Find employees who have not made any sales

select name from employee
where emp_id  not in(
select emp_id from sales);
# 2 List departments where the average salary is above ₹55,000
select department_id,avg(salary) from employee 
group by department_id
having avg(salary) > 55000 ;
#3 Retrieve department names where the total sales exceed ₹10,000.

select department_id from employee
where department_id in (select emp_id ,sum(sale_amount) from sales
group by emp_id
having sum(sale_amount)>10000);








# 4 Find the employee who has made the second-highest sale.
select name from employee
where emp_id =
(select emp_id from sales
order by sale_amount desc
limit 1
offset 1);
#  q5 Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

SELECT name, salary
FROM Employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM Sales
);
