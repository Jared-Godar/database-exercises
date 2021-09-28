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
*/

select database();

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
ALTER TABLE employees_with_departments
DROP COLUMN first_name;
ALTER TABLE employees_with_departments
DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

#3. Create a temporary table based on the payment table from the sakila database. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

USE sakila;

create temporary table hopper_1545.payments AS (
	select payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
	from payment);

USE hopper_1545;
SELECT * FROM payments;
ALTER TABLE payments ADD amount_cents INT(10);
UPDATE payments
SET amount_cents = (amount * 100);


#3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

USE employees;

create temporary table hopper_1545.department_pay AS (
	select emp_no, first_name, last_name, dept_name, salary
	from employees
	join dept_emp using(emp_no)
	join departments using (dept_no)
	join salaries using(emp_no)
);

create temporary table hopper_1545.department_avg_pay AS (
	SELECT avg(salary), dept_name from salaries
    JOIN dept_emp using (emp_no)
	JOIN departments using (dept_no)
    WHERE salaries.to_date > now()
    GROUP BY dept_name);

USE hopper_1545;
SELECT * FROM department_avg_pay;
ALTER TABLE department_avg_pay ADD z_score float;
#SELECT avg(salary) FROM department_pay as avg_salary; -- $63805.40
#SELECT stddev(salary) FROM department_pay as stdev_salary;  -- 16900.85
ALTER TABLE department_avg_pay ADD avg_salary float;
ALTER TABLE department_avg_pay ADD std_salary float;
UPDATE department_avg_pay
SET avg_salary = 63805.4;
UPDATE department_avg_pay
SET std_salary = 16900.85;
#Need a GROUP BY department somewhere

UPDATE department_avg_pay
SET z_score = (`avg(salary)` - avg_salary) 
    / 
     std_salary;
     
SELECT * FROM department_avg_pay
ORDER BY z_score DESC;
