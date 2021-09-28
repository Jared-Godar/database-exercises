USE employees;

SELECT dept_name,
	CASE dept_name
    WHEN 'research' THEN 'Development'
    WHEN 'marketing' THEN 'Sales'
    ELSE dept_name
    END AS dept_group
FROM departments;

-- Quick swap of values, but restrictive - only looking for match

SELECT dept_name,
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
        WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('production', 'quality management') THEN 'Prod & QM'
        ELSE dept_name
        END AS dept_group
FROM departments;

SELECT dept_name,
	IF(dept_name = 'research', True, False) AS is_research
FROM employees.departments;

# Nested CASE / IF SQL typically has more depth in features

SELECT dept_name,
	CASE
		WHEN dept_name IN ('research, `development')
		THEN
			CASE
				WHEN dept_name = 'research' THEN 'BigBrains'
                ELSE 'BigSpend'
			END
		ELSE 'Sales & Marketing'
        END AS dept_group
FROM departments;

# Create pivot table

-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.

SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);


-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)

SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;

# pivot table looks at intersectionality of two fields here department name and title
# quick analysis of data

#can add when or other clauses to look at current employees or male or female
# Pivot tables loved by stakeholders - good skill to be able to do within SQL
