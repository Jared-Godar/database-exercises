-- Where exercises
-- 1
USE employees;

-- 2. Current or orevious employees with specific names - 709 results

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE first_name IN ('Irena',
                     'Vidya',
                     'Maya');

-- 3. Search with OR instread of IN; also 709 records returned

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE first_name ='Irena'
  OR first_name = 'Vidya'
  OR first_name = 'Maya';

-- 4. Male with first names: 441 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE (first_name ='Irena'
       OR first_name = 'Vidya'
       OR first_name = 'Maya')
  AND gender = 'M';

-- 5. Last name starts with E - 7330 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE last_name LIKE 'E%';

-- 6. Lname starts or ends with E -- 30723 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE (last_name LIKE 'E%'
       OR last_name LIKE '%e');

-- 7. Starts and ends with e - 899 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE last_name LIKE 'E%e';

-- 8. Employees hired in the 90s -- 135214 records

SELECT emp_no,
       first_name,
       last_name,
       hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC;

-- 9. Find employees born on christmas -- 842 records

SELECT emp_no,
       first_name,
       last_name,
       birth_date
FROM employees
WHERE birth_date LIKE '%-12-25';

-- 10. Hired in the 90s and born on christmas -- 362 records

SELECT emp_no,
       first_name,
       last_name,
       birth_date,
       hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND birth_date LIKE '%-12-25'
ORDER BY hire_date ASC;

-- 11. Employees with q in their last name. 1873 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE last_name LIKE '%q%';

-- 12. q but not qu -- 572 records

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';