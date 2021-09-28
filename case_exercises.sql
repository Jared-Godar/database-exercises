#Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

#1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

SELECT emp_no, dept_no,dept_emp.from_date AS start_date, dept_emp.to_date AS end_date, IF(dept_emp.to_date > now(), True, False) AS is_current_employee
FROM  employees
JOIN dept_emp USING(emp_no);
	

#2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

USE employees;

SELECT first_name, last_name,
	CASE
		WHEN last_name BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN last_name BETWEEN 'I' AND 'Q' THEN 'I-Q'
        ELSE 'R-Z'
        END AS alpha_group
FROM employees;

#3. How many employees (current or previous) were born in each decade?

-- employees birth_date
-- emp_no?birth_date

SELECT min(birth_date) FROM employees; -- 1952-02-01
SELECT max(birth_date) FROM employees; -- 1965-02-01

SELECT 
	SUM(CASE WHEN  birth_date LIKE '195%' THEN 1  ELSE 0 END) AS fifties, -- 182886
    SUM(CASE WHEN  birth_date LIKE '196%' THEN 1 ELSE 0 END) AS sixties -- 117138 Sum = 30024 equal total number of birthdates checks out
FROM employees;

select birth_date from employees; -- 300024 rows


#BONUS

# What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
/*
+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+*/

