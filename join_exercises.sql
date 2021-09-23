-- 1 Use join examples. Select all the records from both the users and roles tables.

USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results., 

SELECT *
FROM users AS A
JOIN roles AS B on A.id=role_id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT *
FROM users AS A, count(role_id)
JOIN roles AS B on A.id=role_id
GROUP BY role_id;

--
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

/*
SELECT e.dept_name as 'Department Name', d.dept_manager AS 'Department Manager'
FROM employees AS e
JOIN departments AS de
	ON de.dept_no = e.dept_no
JOIN dept_manager AS d
	ON d.dept_no = de.dept_no
WHERE de.to_date > curdate();
*/

SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Current Manager'
FROM dept_manager
JOIN employees USING(emp_no)
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > CURDATE();

-- 3. Find the name of all departments currently managed by women.

SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Current Manager'
FROM dept_manager
JOIN employees USING(emp_no)
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > CURDATE() AND gender = 'F';

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title AS Title, count(titles.title) AS Count
FROM titles
JOIN dept_emp USING(emp_no)
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Customer Service'
AND  titles.to_date > curdate() 
AND dept_emp.to_date > curdate()
GROUP BY title;

-- 5. Find the current salary of all current managers.

SELECT 	departments.dept_name AS 'Department Name', 
		CONCAT(employees.first_name, ' ', employees.last_name) AS 'Name',
        salaries.salary AS 'Salary'
FROM employees
JOIN dept_manager USING(emp_no)
JOIN salaries USING (emp_no)
JOIN departments USING (dept_no)
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate();

-- 6. Find the number of current employees in each department.

SELECT 	departments.dept_no AS dept_no,
		departments.dept_name AS dept_name,
		count(dept_emp.emp_no) AS num_employees
FROM departments
JOIN dept_emp USING(dept_no)
WHERE dept_emp.to_date>curdate()
GROUP BY departments.dept_no, departments.dept_name;



