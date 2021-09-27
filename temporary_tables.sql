# 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

USE employees;

create temporary table hopper_1545.employees_with_departments AS (
	select first_name, last_name, dept_name
	from employees
	join dept_emp using(emp_no)
	join departments using (dept_no)
	where dept_emp.to_date > curdate()
);

USE hopper_1545;
SELECT * FROM employees_with_departments;


/*2. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
Update the table so that full name column contains the correct data
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?
Create a temporary table based on the payment table from the sakila database.*/

select database();

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name;
ALTER TABLE employees_with_departments
DROP COLUMN first_name;
ALTER TABLE employees_with_departments
DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

#3. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.



#4. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?


