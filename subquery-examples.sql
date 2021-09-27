USE employees;

-- Current average salary

SELECT avg(salary)
FROM salaries
WHERE to_date > now();

-- Find employees with higher than average salaries

SELECT emp_no, salary, first_name, last_name, gender
FROM salaries
JOIN employees using(emp_no)
	WHERE salary > (select avg(salary)
	from salaries
    WHERE to_date > now()
);

-- Find all department managers names and birthdates

# get emp_no for manager

SELECT emp_no
FROM dept_manager
WHERE to_date > now();

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN (SELECT emp_no
FROM dept_manager
WHERE to_date > now());

-- Find all empyees with first names starting with georg - join salary table and list first_name_last_name & salary

# Inner query

SELECT emp_no
FROM employees
WHERE first_name LIKE 'geor%';


SELECT first_name, last_name, salary
FROM 
	(
	SELECT *
	FROM employees
	WHERE first_name LIKE 'geor%'
	) as g
JOIN salaries using(emp_no);