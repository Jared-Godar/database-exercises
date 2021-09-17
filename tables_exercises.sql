-- Use the employees database
USE employees;

-- List all the tables in the database
SHOW TABLES;

-- Explore what is in the table
DESCRIBE employees;

-- 6. What table has numeric? emp_no
-- 7. String? first_name, last_name
-- 8. Date? birth_date, hire_date
-- 9. Relationship between employees and departments? dept_emp lists what employee ids are in what deartmnet ids in given date range
-- 10. SQL that created dept_manager tables

SHOW CREATE TABLE dept_manager;
