USE employees;

-- 2. First ten unique last names in descneding order

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

/* Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker */


-- 3. Hired 90s & Born Christmas. First 5 sorted by hire date Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

SELECT emp_no,
       first_name,
       last_name,
       birth_date,
       hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;

-- 4. Find 10th 'page' of results

SELECT emp_no,
       first_name,
       last_name,
       birth_date,
       hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5
OFFSET 45;

/* Pranay	Narwekar
Marjo	Farrow
Ennio	Karcich
Dines	Lubachevsky	
Ipke	Fontan  */