-- 1 Use join examples. Select all the records from both the users and roles tables.

use join_example_db;
SELECT
    * 
FROM
    users;
SELECT
    * 
FROM
    roles;
    
-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results., 

SELECT
    * 
FROM
    users AS a 
    JOIN
        roles AS b 
        ON a.id = role_id;
SELECT
    users.name AS user_name,
    roles.name AS role_name 
FROM
    users 
    LEFT JOIN
        roles 
        ON users.role_id = roles.id;
SELECT
    users.name AS user_name,
    roles.name AS role_name 
FROM
    users 
    RIGHT JOIN
        roles 
        ON users.role_id = roles.id;
        
-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT
    * 
FROM
    users AS a,
    COUNT(role_id) 
    JOIN
        roles AS b 
        ON a.id = role_id 
GROUP BY
    role_id;
--
use employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT
    departments.dept_name AS 'Department Name',
    concat(employees.first_name, ' ', employees.last_name) AS 'Current Manager' 
FROM
    dept_manager 
    JOIN
        employees USING(emp_no) 
    JOIN
        departments 
        ON dept_manager.dept_no = departments.dept_no 
WHERE
    dept_manager.to_date > curdate();
    
-- 3. Find the name of all departments currently managed by women.

SELECT
    departments.dept_name AS 'Department Name',
    concat(employees.first_name, ' ', employees.last_name) AS 'Current Manager' 
FROM
    dept_manager 
    JOIN
        employees USING(emp_no) 
    JOIN
        departments 
        ON dept_manager.dept_no = departments.dept_no 
WHERE
    dept_manager.to_date > curdate() 
    AND gender = 'F';
    
-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT
    titles.title AS title,
    COUNT(titles.title) AS COUNT 
FROM
    titles 
    JOIN
        dept_emp USING(emp_no) 
    JOIN
        departments 
        ON dept_emp.dept_no = departments.dept_no 
WHERE
    dept_name = 'Customer Service' 
    AND titles.to_date > curdate() 
    AND dept_emp.to_date > curdate() 
GROUP BY
    title;
    
-- 5. Find the current salary of all current managers.

SELECT
    departments.dept_name AS 'Department Name',
    concat(employees.first_name, ' ', employees.last_name) AS 'Name',
    salaries.salary AS 'Salary' 
FROM
    employees 
    JOIN
        dept_manager USING(emp_no) 
    JOIN
        salaries USING (emp_no) 
    JOIN
        departments USING (dept_no) 
WHERE
    salaries.to_date > curdate() 
    AND dept_manager.to_date > curdate();
    
-- 6. Find the number of current employees in each department.

SELECT
    departments.dept_no AS dept_no,
    departments.dept_name AS dept_name,
    COUNT(dept_emp.emp_no) AS num_employees 
FROM
    departments 
    JOIN
        dept_emp USING(dept_no) 
WHERE
    dept_emp.to_date > curdate() 
GROUP BY
    departments.dept_no,
    departments.dept_name;
    
-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT
    departments.dept_name AS dept_name,
    AVG(salaries.salary) AS average_salary 
FROM
    departments 
    JOIN
        dept_emp USING(dept_no) 
    JOIN
        salaries USING(emp_no) 
WHERE
    salaries.to_date > curdate() 
GROUP BY
    departments.dept_name 
ORDER BY
    average_salary DESC LIMIT 1;
    
-- 8. Who is the highest paid employee in the Marketing department?

SELECT
    employees.first_name AS first_name,
    employees.last_name AS last_name 
FROM
    departments 
    JOIN
        dept_emp USING(dept_no) 
    JOIN
        salaries USING(emp_no) 
    JOIN
        employees USING(emp_no) 
WHERE
    salaries.to_date > curdate() 
    AND dept_emp.to_date > curdate() 
    AND departments.dept_name = 'Marketing' 
ORDER BY
    salaries.salary DESC LIMIT 1;
    
-- 9. Which current department manager has the highest salary?

SELECT
    employees.first_name AS first_name,
    employees.last_name AS last_name,
    salaries.salary AS salary,
    departments.dept_name AS dept_name 
FROM
    departments 
    JOIN
        dept_manager USING(dept_no) 
    JOIN
        salaries USING(emp_no) 
    JOIN
        employees USING(emp_no) 
WHERE
    salaries.to_date > curdate() 
    AND dept_manager.to_date > curdate() 
ORDER BY
    salaries.salary DESC LIMIT 1;