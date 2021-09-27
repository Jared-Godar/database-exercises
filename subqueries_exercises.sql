USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

#subquery

SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT emp_no, last_name, first_name, hire_date
FROM employees
JOIN salaries using(emp_no)
WHERE  hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010)
AND to_date > now();

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
#Subquery

-- Question about making sure the current statement still gives old titles...

#inner

SELECT emp_no
FROM employees
WHERE first_name = 'Aamod';


SELECT title, last_name, first_name
FROM titles
JOIN employees USING(emp_no)
WHERE emp_no IN(
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
AND to_date > now();

-- 3. How many people in the employees table are no longer working for the company? 85,108

# inner

SELECT emp_no
FROM dept_emp
WHERE to_date < now();

SELECT emp_no
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM dept_emp
	WHERE to_date < now()
);


-- 4. Find all the current department managers that are female. Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

#Sub
SELECT emp_no
FROM employees
WHERE gender = 'F';


SELECT emp_no, first_name, last_name
FROM dept_manager
JOIN employees USING(emp_no)
WHERE to_date > now()
AND emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE gender = 'F');

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

#Inner
SELECT avg(salary)
FROM salaries;

SELECT emp_no, salary, first_name, last_name, gender
FROM salaries
JOIN employees using(emp_no)
	WHERE salary > (select avg(salary)
	from salaries
    WHERE to_date > now()
);

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

/*
Hint Number 1 You will likely use a combination of different kinds of subqueries.
Hint Number 2 Consider that the following code will produce the z score for current salaries.
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
*/





-- BONUS:

-- 1. Find all the department names that currently have female managers.



-- 2. Find the first and last name of the employee with the highest salary.



-- 3. Find the department name that the employee with the highest salary works in.

