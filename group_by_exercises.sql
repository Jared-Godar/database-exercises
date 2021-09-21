USE employees;

-- 2 In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? 7

SELECT DISTINCT title
	FROM titles;
    
-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY last_name;

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT DISTINCT last_name, first_name
FROM employees
WHERE last_name LIKE 'E%e';


-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- Chleq, Lindqvist, Qiwen

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE('%q%')
AND last_name NOT LIKE('%qu%');

SELECT last_name
FROM employees
WHERE last_name LIKE('%q%')
AND last_name NOT LIKE('%qu%')
GROUP BY last_name;

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name, count(last_name)
FROM employees
WHERE last_name LIKE('%q%')
AND last_name NOT LIKE('%qu%')
GROUP BY last_name;

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, count(first_name)
FROM employees
WHERE first_name IN ('Irena',
                     'Vidya',
                     'Maya')
AND gender = 'M'
GROUP BY first_name;

SELECT first_name, count(first_name)
FROM employees
WHERE first_name IN ('Irena',
                     'Vidya',
                     'Maya')
AND gender = 'F'
GROUP BY first_name;

SELECT first_name AS 'First Name', count(gender)
FROM employees
WHERE first_name IN('Irena', 'Vidya','Maya')
GROUP BY first_name, gender;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT Lower(Concat(Substr(first_name, 1, 1), Substr(last_name, 1, 4), '_',
                          Substr(birth_date, 6, 2), Substr(birth_date, 3, 2)))
       AS
       username, count(username)
       first_name,
       last_name,
       birth_date
FROM   employees
GROUP BY username;

/*9. More practice with aggregate functions:

Find the historic average salary for all employees. Now determine the current average salary.
Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.
Find the current average salary for each employee.
Find the maximum salary for each current employee.
Now find the max salary for each current employee where that max salary is greater than $150,000.
Find the current average salary for each employee where that average salary is between $80k and $90k.
/*
