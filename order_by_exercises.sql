-- Order by exercises
-- 1
USE employees;

-- 2. Current or orevious employees with specific names, ordered by first name- Vidya Simmen

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE first_name IN ('Irena',
                     'Vidya',
                     'Maya')
ORDER BY first_name;

-- 3. Search with OR instread of IN; order by first then last name - Vidya Zweizig

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE first_name ='Irena'
  OR first_name = 'Vidya'
  OR first_name = 'Maya'
ORDER BY first_name,
         last_name;

-- 4. Names lname, then fname -- Irena Acton; Maya Zyda

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE first_name IN ('Irena',
                     'Vidya',
                     'Maya')
ORDER BY last_name,
         first_name;

-- 5. Starts and ends with e -899 employees, 10021 Razmi Erde, 499648 Tadahiro Erde

SELECT emp_no,
       first_name,
       last_name
FROM employees
WHERE last_name LIKE 'E%e'
ORDER BY emp_no;

-- 6. Lname starts and eds e, sord by hire date, newest first - 899 Teiji Eldridge,Sergi Erds

SELECT emp_no,
       first_name,
       last_name,
       hire_date
FROM employees
WHERE last_name LIKE 'E%e'
ORDER BY hire_date DESC;

-- 7. Hired in the 90s, born on Christmas, sort - oldest employee hired last as first result
-- 362 records Khun Bernini, Douadi Pettis

SELECT emp_no,
       first_name,
       last_name,
       birth_date,
       hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND birth_date LIKE '%-12-25'
ORDER BY birth_date,
         hire_date DESC;