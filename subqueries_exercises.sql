USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

#subquery

SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT emp_no, last_name, first_name, hire_date
FROM employees
JOIN dept_emp using(emp_no)
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


SELECT DISTINCT title
FROM titles
JOIN dept_emp USING(emp_no)
WHERE dept_emp.to_date > now()
AND
 emp_no IN(
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
    )
;

-- 3. How many people in the employees table are no longer working for the company? 85,108

SELECT * 
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > now())
ORDER BY emp_no;

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
FROM salaries; -- 63810.75

SELECT emp_no, salary, first_name, last_name, gender
FROM salaries
JOIN employees using(emp_no)
	WHERE salary > (select avg(salary)
	from salaries
    WHERE to_date > now()
);
/*Instead of joining to get names, can SELECT * from employees WHERE emp_no IN query*/


-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 211
# (Hint: you can use a built in function to calculate the standard deviation.) 
# What percentage of all salaries is this? = (83/240124)*100 = 0.035 % 

#S1 current highest 158,220

SELECT max(salary)
FROM salaries
WHERE to_date > now();

## Deviation 17310
SELECT stddev(salary) 
FROM  salaries
WHERE to_date > now();

/*
#S Z score
SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
*/

SELECT emp_no, salary, last_name, first_name
FROM salaries
JOIN employees USING(emp_no)
WHERE to_date > now()
AND salary > ((SELECT max(salary) FROM salaries WHERE to_date > now()) 
- 
(SELECT stddev(salary) from salaries WHERE to_date > now()))
ORDER BY salary DESC; -- returns 83 salaries should have salaries ranging from 158220 and 140910 (max - 1 SD)
 
 
SELECT count(salaries)
FROM salaries
WHERE to_date > now()
AND salary > ((SELECT max(salary) FROM salaries WHERE to_date > now()) 
- 
(SELECT stddev(salary) from salaries WHERE to_date > now()))

#total current salaries: 240,124
select emp_no, salary
from salaries
where to_date > now();

select count(*)
from salaries
where to_date > now();

SELECT (
(SELECT count(salary)
FROM salaries
WHERE to_date > now()
AND salary > ((SELECT max(salary) FROM salaries WHERE to_date > now()) 
- 
(SELECT stddev(salary) from salaries WHERE to_date > now()))
ORDER BY salary DESC)
/
(select count(*)
from salaries
where to_date > now()))*100

# Percentage



(

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

#s1
SELECT emp_no
FROM employees
WHERE gender = 'F';




-- 2. Find the first and last name of the employee with the highest salary.



-- 3. Find the department name that the employee with the highest salary works in.

